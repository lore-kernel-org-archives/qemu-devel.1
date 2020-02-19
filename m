Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F1C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F52524672
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ATHJ+eJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F52524672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PpF-0007u6-Qi
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j4PoV-0007DL-87
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j4PoT-0005KP-Ph
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:54:55 -0500
Received: from mail-eopbgr680061.outbound.protection.outlook.com
 ([40.107.68.61]:26946 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j4PoQ-0005Ij-C8; Wed, 19 Feb 2020 08:54:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH3LokBiLs/Let/7f/zOt1kFMJFmYMjOIAAX6hUB6vFvayoz314djYqd7F3ficvSBzWxPpd0oghqjcpTagXGtYLt4gV4zbB86B8WgVGO5LzyIg/qGBJb+qIqNAaDxISeTGds5drcIfOI/ozCJCDBDCCOqZNf3DcdJ/4/XYeT3yPWckUW4WMa0Ture6QbPinDp2/LBeb8h+t07TK8jq2ZpswfX3iRElYk9gE6dtMOgukoglIDnWPmapOuDJjkl9xBletUQl3Zt0PcjL/lw2Q9Qc1xAG7oGIfAmQfuznXyIuIGIOkzXPSwSQ0nfXEyAMusaYvESwO0wWhFCU0JzloJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzjx5pVCvSTE6r5xHe5nCNU6lBEoVDT9R9i792K9aTU=;
 b=RIQdyUP9Zo2bL6SHTUrFtnL89kPVeDddyNB3SuIWdG3mMChSsK1IPu46cguOxiZBqFK+i12QBJv6BELs/AuXHbhNZHzYJyfobX/TE0GO3aD2rNo+w2Ee3lmqd3Bwbef8B2xqeqqpnrUnzWPqTdoclwHMjIXUSdXCgh32WDkY7HiZvNFfpMUKNMRmIgrGCLJH3rWp62i/t2DAMJ2VSZb8klbg3Fm2QYwCQbgnCJIeH+b7SSyVJWR4vxyBgTPGX3Gdfb3m/EWuSeSIiWnJf+JfEPSIwaXz+Zz0zmO80gC+oTcbwV811rfloR0x9SRLDZYBbGzIJiV1wR5xnFTXGxuL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzjx5pVCvSTE6r5xHe5nCNU6lBEoVDT9R9i792K9aTU=;
 b=ATHJ+eJT52y5PIge1HLZpousZ+pJ9u+Gl8l0wKP2atcLag8tjZvhFQT5AaEOG77X/2gEA2rV4Veu+xxYN9xbVS3ebkj+FLd9MXM550ett0MRYIn7XBIg/Bdb80/nQW9+/rS3r6cKWaBomx65vNGibrFur5CMa3ZKNr5YmQJH8h8=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6142.namprd02.prod.outlook.com (52.132.174.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 13:54:48 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd%4]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:54:47 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/3] arm_gic: Mask the un-supported priority bits
Thread-Topic: [PATCH 1/3] arm_gic: Mask the un-supported priority bits
Thread-Index: AQHV5oa4JA25he78DUKGa+ONfQfpUqgiiR+Q
Date: Wed, 19 Feb 2020 13:54:47 +0000
Message-ID: <MN2PR02MB593506391F0312562F1A2F7DCA100@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1581686212-9625-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA-+=DrPkRE1sGNSNEBhaXYsUNi=-tOy58cZ3f1OiV2QVA@mail.gmail.com>
In-Reply-To: <CAFEAcA-+=DrPkRE1sGNSNEBhaXYsUNi=-tOy58cZ3f1OiV2QVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53f3fab9-fe95-4b0b-7492-08d7b5434878
x-ms-traffictypediagnostic: MN2PR02MB6142:
x-microsoft-antispam-prvs: <MN2PR02MB6142381E1453E2A7C9B7863BCA100@MN2PR02MB6142.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(55016002)(316002)(7696005)(66574012)(6916009)(5660300002)(9686003)(86362001)(52536014)(4326008)(6506007)(53546011)(54906003)(33656002)(26005)(186003)(81156014)(478600001)(8936002)(8676002)(76116006)(71200400001)(66946007)(2906002)(64756008)(66476007)(66556008)(66446008)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6142;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4avWslQG3K67l5GB0YAHXz5yiBuAmzH1suVsoB8DsIWlp2Y3oOSRN5cyPOOfriTJFfeXBflthHmvofCNWlvukbrJu5F0j3YLF9nW+8bYUYPdvV5GPhEBSpYI4/B7kHFg6s9VPxvzMNU/Sx6hcMEw+LS5RVPa71uNqHUKnPX41XR98VHX2I4gvOIiPrj0DFFX8MBjoOnySO2KyjJGlB3qF+h8UtOaI7jpCnFblw7ejZd53mXN105tQxQBO1fkFDsI+sKTTlHlFM7F+kQFZYO7ZPAfQN4lQw+SqWw4NUSUKKk65ZIuJ5fza1n1LZf43G24hkjgzkN0glI+ZWwBm6e917gzGHASSjOFft16P7OwAbLAFQUnwMm9e4CzhJ/zwzuO9AVgzXPpsPNwe5jyJHs/JPSrYHVGRuMjkbEanVB1UeG+LDdonVKD0tyEviHNSbrP
x-ms-exchange-antispam-messagedata: 8skaWK06mPhM6LPxqbc2zjkt+fDI3zDRoSFr13YmkuDukzNptBWAGc9fXkP4LSWOqORMUL7cmI0YLHPRVXEMC0jRw8aQoMOgZofkr5kOND1LqhX1mCyRMesya36GRCvXF1cSkhV3j+HQSZHRLKB5cQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f3fab9-fe95-4b0b-7492-08d7b5434878
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 13:54:47.8065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SE0/N+zdqthCBpKW/NrK6ZGBeTED0MBE8TQtEmlMnYREx5SP/S9N7BzJT4pi7HzD1pfuHfDbXy6vWwyeJ4v90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6142
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Anthony Liguori <anthony@codemonkey.ws>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCkFsbCB5b3VyIHN1Z2dlc3Rpb25zIGxvb2sgZ29vZCwgSSB3aWxsIHNlbmQg
YXQgVjIuIEJ1dCAgSSB0aGluayBJIGhhdmUgZG9uZSBhIG1pc3Rha2UgaW4gVjEsIE1vcmUgY29t
bWVudHMgaW5saW5lIGJlbG93Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gU2VudDogVHVl
c2RheSwgRmVicnVhcnkgMTgsIDIwMjAgMTE6NDAgUE0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8
c2FpcGF2YUB4aWxpbnguY29tPg0KPiBDYzogRWRnYXIgRSAuIElnbGVzaWFzIDxlZGdhci5pZ2xl
c2lhc0BnbWFpbC5jb20+OyBBbGlzdGFpciBGcmFuY2lzDQo+IDxhbGlzdGFpckBhbGlzdGFpcjIz
Lm1lPjsgQW50aG9ueSBMaWd1b3JpIDxhbnRob255QGNvZGVtb25rZXkud3M+Ow0KPiBBbmRyZWFz
IEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+OyBxZW11LWFybSA8cWVtdS1hcm1Abm9uZ251Lm9y
Zz47DQo+IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvM10gYXJtX2dpYzogTWFzayB0aGUgdW4tc3VwcG9ydGVkIHByaW9yaXR5
IGJpdHMNCj4gDQo+IE9uIEZyaSwgMTQgRmViIDIwMjAgYXQgMTM6MjEsIFNhaSBQYXZhbiBCb2Rk
dQ0KPiA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gUHJpb3Jp
dHkgYml0cyBpbXBsZW1lbnRlZCBpbiBhcm0tZ2ljIGNhbiA4IHRvIDQsIHVuLWltcGxlbWVudGVk
IGJpdHMNCj4gPiBhcmUgcmVhZCBhcyB6ZXJvcyhSQVopLg0KPiANCj4gVGhpcyBpcyBuaWNlIHRv
IHNlZSAtLSBJJ3ZlIGtub3duIG91ciBHSUMgd2FzIGEgYml0IG91dC1vZi1zcGVjIGluIHRoaXMg
YXJlYSBidXQNCj4gaXQncyBnb29kIHRvIHNlZSBpdCdzIGxlc3MgcGFpbmZ1bCB0byByZXRyb2Zp
dCB0aGFuIEkgdGhvdWdodCBpdCBtaWdodCBiZS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2Fp
IFBhdmFuIEJvZGR1IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAg
aHcvaW50Yy9hcm1fZ2ljLmMgICAgICAgICAgICAgICAgfCA5ICsrKysrKy0tLQ0KPiA+ICBody9p
bnRjL2FybV9naWNfY29tbW9uLmMgICAgICAgICB8IDEgKw0KPiA+ICBpbmNsdWRlL2h3L2ludGMv
YXJtX2dpY19jb21tb24uaCB8IDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9pbnRjL2FybV9n
aWMuYyBiL2h3L2ludGMvYXJtX2dpYy5jIGluZGV4DQo+ID4gMWQ3ZGE3Yi4uODg3NTMzMCAxMDA2
NDQNCj4gPiAtLS0gYS9ody9pbnRjL2FybV9naWMuYw0KPiA+ICsrKyBiL2h3L2ludGMvYXJtX2dp
Yy5jDQo+ID4gQEAgLTQzLDYgKzQzLDkgQEANCj4gPiAgICAgICAgICB9ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICAg
ICAgfSB3aGlsZSAoMCkNCj4gPg0KPiA+ICsjZGVmaW5lIFVNQVNLKG4pIFwNCj4gPiArICAgICgo
KCgxIDw8IG4pIC0gMSkgPDwgKDggLSBuKSkgJiAweEZGKQ0KPiANCj4gVGhpcyBpcyBhIGJpdCBj
b25mdXNpbmdseSBuYW1lZCAodXN1YWxseSAndW1hc2snIGlzIHRoZSBmaWxlLXBlcm1pc3Npb24g
bWFzayBvbg0KPiB1bml4KS4gSSB0aGluayBpdCdzIHdvcnRoIGZvbGxvd2luZyB0aGUgcGF0dGVy
biB1c2VkIGluDQo+IGh3L2ludGMvYXJtX2dpY3YzX2NwdWlmLmMgZm9yIGljdl9mdWxscHJpb19t
YXNrKCksIGFuZCB1c2luZyBhIGZ1bmN0aW9uIHdpdGgNCj4gYSBjb21tZW50IGRlc2NyaWJpbmcg
aXQuIEFsc28sIHlvdSd2ZSBub3QgY29uc2lkZXJlZCB0aGUgdmlydHVhbGl6YXRpb24gcGFydHMN
Cj4gb2YgdGhlIEdJQywgd2hpY2ggYWxzbyB1c2UgdGhlc2UgY29kZXBhdGhzLiBJbiB0aG9zZSBj
YXNlcywgdGhlIHZhbHVlIG9mIHRoZQ0KPiBtYXNrIGlzIGFsd2F5cyBiYXNlZCBvbiBHSUNfVklS
VF9NQVhfR1JPVVBfUFJJT19CSVRTIG9mIHByaW9yaXR5IChhDQo+IEdJQ3YyIGhhcyA1IGJpdHMg
b2YgcHJpb3JpdHkgaW4gdGhlIFZHSUMsIGFsd2F5cykuIFNvOg0KPiANCj4gc3RhdGljIHVpbnQz
Ml90IGdpY19mdWxscHJpb19tYXNrKEdJQ1N0YXRlICpzLCBpbnQgY3B1KSB7DQo+ICAgICAvKg0K
PiAgICAgICogUmV0dXJuIGEgbWFzayB3b3JkIHdoaWNoIGNsZWFycyB0aGUgdW5pbXBsZW1lbnRl
ZCBwcmlvcml0eQ0KPiAgICAgICogYml0cyBmcm9tIGEgcHJpb3JpdHkgdmFsdWUgZm9yIGFuIGlu
dGVycnVwdC4gKE5vdCB0byBiZQ0KPiAgICAgICogY29uZnVzZWQgd2l0aCB0aGUgZ3JvdXAgcHJp
b3JpdHksIHdob3NlIG1hc2sgZGVwZW5kcyBvbiBCUFIuKQ0KPiAgICAgICovDQo+ICAgICBpbnQg
cHJpYml0czsNCj4gDQo+ICAgICBpZiAoZ2ljX2lzX3ZjcHUoY3B1KSkgew0KPiAgICAgICAgIHBy
aWJpdHMgPSBHSUNfVklSVF9NQVhfR1JPVVBfUFJJT19CSVRTOw0KPiAgICAgfSBlbHNlIHsNCj4g
ICAgICAgICBwcmliaXRzID0gcy0+bl9wcmlvX2JpdHM7DQo+ICAgICB9DQo+ICAgICByZXR1cm4g
fjBVIDw8ICg4IC0gcy0+bl9wcmlvX2JpdHMpOw0KPiB9DQo+IA0KPiA+ICsNCj4gPiAgc3RhdGlj
IGNvbnN0IHVpbnQ4X3QgZ2ljX2lkXzExbXBjb3JlW10gPSB7DQo+ID4gICAgICAweDAwLCAweDAw
LCAweDAwLCAweDAwLCAweDkwLCAweDEzLCAweDA0LCAweDAwLCAweDBkLCAweGYwLCAweDA1LA0K
PiA+IDB4YjEgIH07IEBAIC02NTIsOSArNjU1LDkgQEAgdm9pZCBnaWNfZGlzdF9zZXRfcHJpb3Jp
dHkoR0lDU3RhdGUgKnMsDQo+ID4gaW50IGNwdSwgaW50IGlycSwgdWludDhfdCB2YWwsDQo+ID4g
ICAgICB9DQo+ID4NCj4gPiAgICAgIGlmIChpcnEgPCBHSUNfSU5URVJOQUwpIHsNCj4gPiAtICAg
ICAgICBzLT5wcmlvcml0eTFbaXJxXVtjcHVdID0gdmFsOw0KPiA+ICsgICAgICAgIHMtPnByaW9y
aXR5MVtpcnFdW2NwdV0gPSB2YWwgJiBVTUFTSyhzLT5uX3ByaW9fYml0cykgOw0KPiA+ICAgICAg
fSBlbHNlIHsNCj4gPiAtICAgICAgICBzLT5wcmlvcml0eTJbKGlycSkgLSBHSUNfSU5URVJOQUxd
ID0gdmFsOw0KPiA+ICsgICAgICAgIHMtPnByaW9yaXR5MlsoaXJxKSAtIEdJQ19JTlRFUk5BTF0g
PSB2YWwgJg0KPiA+ICsgVU1BU0socy0+bl9wcmlvX2JpdHMpOw0KPiA+ICAgICAgfQ0KPiA+ICB9
DQo+IA0KPiBTbGlnaHRseSBjbGVhbmVyIHRvIGp1c3QgcHV0DQo+ICAgIHZhbCAmPSBnaWNfZnVs
bHByaW9fbWFzayhzKTsNCj4gYmVmb3JlIHRoZSBpZigpIHJhdGhlciB0aGFuIGRvaW5nIHRoZSBz
YW1lIHRoaW5nIGluIGJvdGggYnJhbmNoZXMuDQo+IA0KPiA+DQo+ID4gQEAgLTY4NCw3ICs2ODcs
NyBAQCBzdGF0aWMgdm9pZCBnaWNfc2V0X3ByaW9yaXR5X21hc2soR0lDU3RhdGUgKnMsIGludA0K
PiBjcHUsIHVpbnQ4X3QgcG1hc2ssDQo+ID4gICAgICAgICAgICAgIHJldHVybjsNCj4gPiAgICAg
ICAgICB9DQo+ID4gICAgICB9DQo+ID4gLSAgICBzLT5wcmlvcml0eV9tYXNrW2NwdV0gPSBwbWFz
azsNCj4gPiArICAgIHMtPnByaW9yaXR5X21hc2tbY3B1XSA9IHBtYXNrICYgVU1BU0socy0+bl9w
cmlvX2JpdHMpOw0KW1NhaSBQYXZhbiBCb2RkdV0gbWFzayBzaG91bGQgYmUgYXBwbGllZCBpbiAi
IGdpY19kaXN0X2dldF9wcmlvcml0eSAiLCAgYXMgd2UgbWlzcyBncm91cCBwcmlvcml0eSBiaXRz
IGhlcmUuDQpMZXQgbWUga25vdywgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0Lg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClJlZ2FyZHMsDQpTYWkgUGF2YW4NCj4gPiAgfQ0KPiA+
DQo+ID4gIHN0YXRpYyB1aW50MzJfdCBnaWNfZ2V0X3ByaW9yaXR5X21hc2soR0lDU3RhdGUgKnMs
IGludCBjcHUsDQo+ID4gTWVtVHhBdHRycyBhdHRycykgZGlmZiAtLWdpdCBhL2h3L2ludGMvYXJt
X2dpY19jb21tb24uYw0KPiA+IGIvaHcvaW50Yy9hcm1fZ2ljX2NvbW1vbi5jIGluZGV4IGU2YzRm
ZTcuLmU0NjY4YzcgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvaW50Yy9hcm1fZ2ljX2NvbW1vbi5jDQo+
ID4gKysrIGIvaHcvaW50Yy9hcm1fZ2ljX2NvbW1vbi5jDQo+ID4gQEAgLTM1Nyw2ICszNTcsNyBA
QCBzdGF0aWMgUHJvcGVydHkgYXJtX2dpY19jb21tb25fcHJvcGVydGllc1tdID0gew0KPiA+ICAg
ICAgREVGSU5FX1BST1BfQk9PTCgiaGFzLXNlY3VyaXR5LWV4dGVuc2lvbnMiLCBHSUNTdGF0ZSwg
c2VjdXJpdHlfZXh0biwNCj4gMCksDQo+ID4gICAgICAvKiBUcnVlIGlmIHRoZSBHSUMgc2hvdWxk
IGltcGxlbWVudCB0aGUgdmlydHVhbGl6YXRpb24gZXh0ZW5zaW9ucyAqLw0KPiA+ICAgICAgREVG
SU5FX1BST1BfQk9PTCgiaGFzLXZpcnR1YWxpemF0aW9uLWV4dGVuc2lvbnMiLCBHSUNTdGF0ZSwN
Cj4gPiB2aXJ0X2V4dG4sIDApLA0KPiA+ICsgICAgREVGSU5FX1BST1BfVUlOVDMyKCJudW0tcHJp
by1iaXRzIiwgR0lDU3RhdGUsIG5fcHJpb19iaXRzLCA4KSwNCj4gDQo+IEluIHBhdGNoIDIgeW91
IHVzZSAibnVtLXByaW9yaXR5LWJpdHMiIGZvciB0aGUgcHJvcHJldHkgbmFtZSBvbiB0aGUNCj4g
YTltcGNvcmUgb2JqZWN0LiBJIGxpa2UgdGhhdCBiZXR0ZXIsIGFuZCBJIHRoaW5rIHdlIHNob3Vs
ZCBuYW1lIHRoZSBwcm9wZXJ0eQ0KPiB0aGUgc2FtZSB0aGluZyBvbiBib3RoIGRldmljZXMuDQo+
IA0KPiBZb3Ugc2hvdWxkIGhhdmUgc29tZSBjb2RlIGluIHRoZSByZWFsaXplIG1ldGhvZCB3aGlj
aCBzYW5pdHkgY2hlY2tzIHRoZQ0KPiBuX3ByaW9fYml0cyB2YWx1ZSB3ZSBhcmUgcGFzc2VkLiBJ
dCBjYW4ndCBiZSBtb3JlIHRoYW4gOCwgYW5kIEknbSBub3Qgc3VyZQ0KPiB3aGF0IHRoZSBsb3dl
c3QgdmFsaWQgdmFsdWUgaXMuIFlvdXIgY29tbWl0IG1lc3NhZ2Ugc2F5cyA0LiBJJ20gcHJldHR5
IHN1cmUNCj4gdGhhdCBpZiB0aGUgR0lDIGhhcyB0aGUgdmlydCBleHRlbnNpb25zIHRoZW4gaXQg
Y2FuJ3QgYmUgbGVzcyB0aGFuDQo+IEdJQ19WSVJUX01BWF9HUk9VUF9QUklPX0JJVFMgKGllIDUp
Lg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K

