Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C5C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB07B2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z3uosDBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB07B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ABG-0007ls-0k
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 04:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j6AA8-00075c-GA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j6AA6-0002ys-UV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:36:28 -0500
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com
 ([40.107.93.86]:61888 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j6AA3-0002vL-Gt; Mon, 24 Feb 2020 04:36:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1H4csAwAOvG8JfMNxsCDufNwbeM/Mv6IX3wYmyLsxqauzmJNAMPqxl6UzMERKuGS7NvAaxKgR3c1ndziWxqZ0ljptJgaxR6KRqVKscZ8CS1stdAcx9eDl+mGO9PfydYuStHVY5jg6QtLC6w8RDtACsomjCUc840aFmukan8UUWAdtoQhY0lOkxp0tJP2KbA9m+/QnngziBvW0BSpM50E8n767ebmC87jPsqH0lNFtvuZcanNWKc6MRwEKSbcwf5R3O5ThxxT7BEtNhIpEwV5mPrNbTKRhiahSi6PTC98EwfVHECOFZJW0O3OA5hxcnavPTeCBgqD0Nqs4TAWAA/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE1F+tEzjJPCjd6egndwVlbSHt7tDekBeaUTbsGSbsU=;
 b=i4vpE/jo5aIyIsqsqmxy+uUds7GyGrP27QEp+cMEH0emaMfrZSAOT7nvJPnVLIMGJiJjvtByuESKzY4WKqZIl1z2hzYl7HLQAjmMnttO/sU2ufDIAJMuT96YILutgonUycsFlBCu0qN945krlvvm4abjcoJ2bJq9gQJBSuuLxi7y6qYkfDmho3+cb2FA2rkTNA8702vDRJOtwW+StCwEvzcfldD5YEjA23L2++iX1XD1k0w1Wg7G/YvJKJ3fCBhhafNT7yEiOxvx0DimXKejejIadMjiYsoZpGkok/ggqiKaIhNnLwGqHHKFH3n/V0HaVP5fWDASWhi7IWRzg08ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE1F+tEzjJPCjd6egndwVlbSHt7tDekBeaUTbsGSbsU=;
 b=Z3uosDBXO3cCSYM/7tDb0zQNSEL7La3cIOH3A7gxpgmSc2fGUCOABko+kmSgkiuoHhT7YFMwgpyJWF59tKaBu0jc2bHXDRPOI/IRxnZi/QALFIIfDpA4sQKh2c/yGGWi+PMM1drVS3TtMzXua5KpQ7xPQbARZDLa8ZAqzBRZxdk=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (2603:10b6:208:111::23)
 by MN2PR02MB6094.namprd02.prod.outlook.com (2603:10b6:208:1b7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 09:36:19 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 09:36:19 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v2 1/3] arm_gic: Mask the un-supported priority bits
Thread-Topic: [PATCH v2 1/3] arm_gic: Mask the un-supported priority bits
Thread-Index: AQHV6MvW5OVOjUky5kS8GDicr+iv86gqGXvQ
Date: Mon, 24 Feb 2020 09:36:19 +0000
Message-ID: <MN2PR02MB5935A5AFB306C8B5D513CBD2CAEC0@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1582270927-2568-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA-NYkaQuJq=0Ft7j0XEPqJQz=G=wwKTWTxdbCmSRUh6uA@mail.gmail.com>
In-Reply-To: <CAFEAcA-NYkaQuJq=0Ft7j0XEPqJQz=G=wwKTWTxdbCmSRUh6uA@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: a5577e2f-71fe-49cf-f720-08d7b90d00e5
x-ms-traffictypediagnostic: MN2PR02MB6094:
x-microsoft-antispam-prvs: <MN2PR02MB6094902B1D0D61F05DB88927CAEC0@MN2PR02MB6094.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(33656002)(55016002)(71200400001)(478600001)(66446008)(76116006)(64756008)(66556008)(66476007)(66946007)(6916009)(7696005)(9686003)(86362001)(5660300002)(2906002)(52536014)(316002)(8936002)(53546011)(54906003)(26005)(6506007)(186003)(4326008)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6094;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lCxcuqIPZ6kz4ABpCV1sfOMiFvH1dIdMp47sh3UTFqfEpf82s3LDbuhBWrGnfkvkFlvLWQs4laJ4tFmHu5nPI9882/at6fOdPIqViFE8p7TfcWjTvrL+nesXtMiE51NyZhGTu6WbFIrUpii2o+9tHTg+zHkzpbNl9zx9pPgSYwaKFUaSh8owKZahZvfXS02cFdRBbQy8ovOKaPMbPaq+S7cMTTybm8ho/97+LHnByZmQ6geklP9wCDnhq5++nZsBGHeNUwXJ6LEro57hhrROLK8qfvos8OSA+w2x+4hAYNxxCADv7JzbE6ilBthOCufr5K6Wrwl+Gn0XImaq7QySPWneZU4EMdKNcNovdPadWgoCR0ZqjIn6wmYXdlioPF9AnnX46Ze5ojWAZBbSN0UFvx6OVt12p6pV8gHkxZlVsX/F50h94eODzIIyJXGFe7oQ
x-ms-exchange-antispam-messagedata: 8YRAD0OVPdIYDnDvjZUXkKqbvGgoTFsudTUv7od9H7FhjFX9F9arGMx74mawJFASRsAbgZoFPl2rf9MjD6G3musjRbrdI5+1Iwf+TdNThp1LfXp/bN0W1c/UZCrxVVTRmricQGspqkLaRJueUQFwaQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5577e2f-71fe-49cf-f720-08d7b90d00e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 09:36:19.4650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mi4Q7b8LqdQii+3o8mhY5iU1n4/b1pBFRqnr90RsmV6Lqie2PgOfrQbgCIAnbs0riGZBL754Er6jUZiKMvJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6094
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.86
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

SGkgUGV0ZXIsDQoNCldpbGwgc2VuZCBWMyBmb3IgYmVsb3cgY29tbWVudHMuDQpJbiB2MiBJIG1h
eSBoYXZlIGNvbmZ1c2VkIHdpdGggZnVuY3Rpb25hbGl0eSBvZiBncm91cCBwcmlvcml0eSBpbnRl
cnJ1cHQgYml0cy4gTm93IHRoaW5ncyBsb29rIGNsZWFyLiBUaGFua3MuDQoNClJlZ2FyZHMsDQpT
YWkgUGF2YW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBN
YXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVh
cnkgMjEsIDIwMjAgOTowMCBQTQ0KPiBUbzogU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlu
eC5jb20+DQo+IENjOiBFZGdhciBFIC4gSWdsZXNpYXMgPGVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNv
bT47IEFsaXN0YWlyIEZyYW5jaXMNCj4gPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBBbnRob255
IExpZ3VvcmkgPGFudGhvbnlAY29kZW1vbmtleS53cz47DQo+IEFuZHJlYXMgRsOkcmJlciA8YWZh
ZXJiZXJAc3VzZS5kZT47IHFlbXUtYXJtIDxxZW11LWFybUBub25nbnUub3JnPjsNCj4gUUVNVSBE
ZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMS8zXSBhcm1fZ2ljOiBNYXNrIHRoZSB1bi1zdXBwb3J0ZWQgcHJpb3JpdHkgYml0cw0KPiAN
Cj4gT24gRnJpLCAyMSBGZWIgMjAyMCBhdCAwNzo0NiwgU2FpIFBhdmFuIEJvZGR1DQo+IDxzYWku
cGF2YW4uYm9kZHVAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBQcmlvcml0eSBiaXRzIGlt
cGxlbWVudGVkIGluIGFybS1naWMgY2FuIGJlIDggdG8gNCwgdW4taW1wbGVtZW50ZWQNCj4gPiBi
aXRzIGFyZSByZWFkIGFzIHplcm9zKFJBWikuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWkg
UGF2YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+ICBo
dy9pbnRjL2FybV9naWMuYyAgICAgICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4gIGh3L2ludGMvYXJtX2dpY19jb21tb24uYyAgICAgICAgIHwgIDEgKw0KPiA+
ICBpbmNsdWRlL2h3L2ludGMvYXJtX2dpY19jb21tb24uaCB8ICAxICsNCj4gPiAgMyBmaWxlcyBj
aGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2h3L2ludGMvYXJtX2dpYy5jIGIvaHcvaW50Yy9hcm1fZ2ljLmMgaW5kZXgNCj4gPiAx
ZDdkYTdiLi5kZWM4NzY3IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2ludGMvYXJtX2dpYy5jDQo+ID4g
KysrIGIvaHcvaW50Yy9hcm1fZ2ljLmMNCj4gPiBAQCAtNjQxLDYgKzY0MSwyMyBAQCB1aW50MzJf
dCBnaWNfYWNrbm93bGVkZ2VfaXJxKEdJQ1N0YXRlICpzLCBpbnQNCj4gY3B1LCBNZW1UeEF0dHJz
IGF0dHJzKQ0KPiA+ICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB1
aW50MzJfdCBnaWNfZnVsbHByaW9fbWFzayhHSUNTdGF0ZSAqcywgaW50IGNwdSkgew0KPiA+ICsg
ICAgLyoNCj4gPiArICAgICAqIFJldHVybiBhIG1hc2sgd29yZCB3aGljaCBjbGVhcnMgdGhlIHVu
aW1wbGVtZW50ZWQgcHJpb3JpdHkNCj4gPiArICAgICAqIGJpdHMgZnJvbSBhIHByaW9yaXR5IHZh
bHVlIGZvciBhbiBpbnRlcnJ1cHQuIChOb3QgdG8gYmUNCj4gPiArICAgICAqIGNvbmZ1c2VkIHdp
dGggdGhlIGdyb3VwIHByaW9yaXR5LCB3aG9zZSBtYXNrIGRlcGVuZHMgb24gQlBSLikNCj4gPiAr
ICAgICAqLw0KPiA+ICsgICAgaW50IHVuaW1wQml0czsNCj4gPiArDQo+ID4gKyAgICBpZiAoZ2lj
X2lzX3ZjcHUoY3B1KSkgew0KPiA+ICsgICAgICAgIHVuaW1wQml0cyA9IEdJQ19WSVJUX01BWF9H
Uk9VUF9QUklPX0JJVFM7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgIHVuaW1wQml0
cyA9IDggLSBzLT5uX3ByaW9fYml0czsNCj4gDQo+IFRoaXMgaXNuJ3QgcmlnaHQ7IEdJQ19WSVJU
X01BWF9HUk9VUF9QUklPX0JJVFMgc2hvdWxkIGJlIGhhbmRsZWQgdGhlDQo+IHNhbWUgd2F5IGFz
IHMtPm5fcHJpb19iaXRzLiBUaGUgZXhwcmVzc2lvbiBJIHN1Z2dlc3RlZCBpbiBteSBjb21tZW50
IG9uDQo+IHlvdXIgdjEgc2hvdWxkIHdvcms6DQo+IA0KPiAgICAgaWYgKGdpY19pc192Y3B1KGNw
dSkpIHsNCj4gICAgICAgICBwcmliaXRzID0gR0lDX1ZJUlRfTUFYX0dST1VQX1BSSU9fQklUUzsN
Cj4gICAgIH0gZWxzZSB7DQo+ICAgICAgICAgcHJpYml0cyA9IHMtPm5fcHJpb19iaXRzOw0KPiAg
ICAgfQ0KPiAgICAgcmV0dXJuIH4wVSA8PCAoOCAtIHMtPm5fcHJpb19iaXRzKTsNCj4gDQo+ID4g
KyAgICB9DQo+ID4gKyAgICByZXR1cm4gfjBVIDw8IHVuaW1wQml0czsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgdm9pZCBnaWNfZGlzdF9zZXRfcHJpb3JpdHkoR0lDU3RhdGUgKnMsIGludCBjcHUsIGlu
dCBpcnEsIHVpbnQ4X3QgdmFsLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgTWVtVHhBdHRy
cyBhdHRycykgIHsNCj4gDQo+IA0KPiBZb3Ugc2VlbSB0byBoYXZlIGxvc3QgdGhlIHBhcnQgb2Yg
dGhlIHBhdGNoIHdoaWNoIGFwcGxpZXMgdGhlIG1hc2sgaW4NCj4gZ2ljX2Rpc3Rfc2V0X3ByaW9y
aXR5KCkuIElmIHRoZSBHSUMgb25seSBoYXMgNSBiaXRzIG9mIHByaW9yaXR5IHdlIHNob3VsZCBu
b3QNCj4gYWxsb3cgdGhlIGd1ZXN0IHRvIHNldCBtb3JlIHRoYW4gdGhhdC4NCj4gDQo+ID4gQEAg
LTY2OSw3ICs2ODYsNyBAQCBzdGF0aWMgdWludDMyX3QgZ2ljX2Rpc3RfZ2V0X3ByaW9yaXR5KEdJ
Q1N0YXRlICpzLA0KPiBpbnQgY3B1LCBpbnQgaXJxLA0KPiA+ICAgICAgICAgIH0NCj4gPiAgICAg
ICAgICBwcmlvID0gKHByaW8gPDwgMSkgJiAweGZmOyAvKiBOb24tc2VjdXJlIHZpZXcgKi8NCj4g
PiAgICAgIH0NCj4gPiAtICAgIHJldHVybiBwcmlvOw0KPiA+ICsgICAgcmV0dXJuIHByaW8gJiBn
aWNfZnVsbHByaW9fbWFzayhzLCBjcHUpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQg
Z2ljX3NldF9wcmlvcml0eV9tYXNrKEdJQ1N0YXRlICpzLCBpbnQgY3B1LCB1aW50OF90DQo+ID4g
cG1hc2ssIEBAIC02ODQsNyArNzAxLDcgQEAgc3RhdGljIHZvaWQgZ2ljX3NldF9wcmlvcml0eV9t
YXNrKEdJQ1N0YXRlDQo+ICpzLCBpbnQgY3B1LCB1aW50OF90IHBtYXNrLA0KPiA+ICAgICAgICAg
ICAgICByZXR1cm47DQo+ID4gICAgICAgICAgfQ0KPiA+ICAgICAgfQ0KPiA+IC0gICAgcy0+cHJp
b3JpdHlfbWFza1tjcHVdID0gcG1hc2s7DQo+ID4gKyAgICBzLT5wcmlvcml0eV9tYXNrW2NwdV0g
PSBwbWFzayAmIGdpY19mdWxscHJpb19tYXNrKHMsIGNwdSk7DQo+ID4gIH0NCj4gPg0KPiA+ICBz
dGF0aWMgdWludDMyX3QgZ2ljX2dldF9wcmlvcml0eV9tYXNrKEdJQ1N0YXRlICpzLCBpbnQgY3B1
LA0KPiA+IE1lbVR4QXR0cnMgYXR0cnMpIEBAIC0yMDU1LDYgKzIwNzIsMTEgQEAgc3RhdGljIHZv
aWQNCj4gYXJtX2dpY19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4g
PiAgICAgICAgICByZXR1cm47DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgIGlmIChzLT5uX3By
aW9fYml0cyA+IDgpIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJudW0tcHJpb3Jp
dHktYml0cyBjYW5ub3QgYmUgZ3JlYXRlciB0aGFuIDgiKTsNCj4gPiArICAgICAgICByZXR1cm47
DQo+ID4gKyAgICB9DQo+IA0KPiBZb3UgbmVlZCB0byBhbHNvIGNoZWNrIHRoYXQgdGhlIHZhbHVl
IGlzIGF0IGxlYXN0IGFzIGxhcmdlIGFzIHRoZSBsb3dlc3QNCj4gcGVybWl0dGVkIHZhbHVlLCBh
cyBJIHN1Z2dlc3RlZCBpbiBteSB2MSBjb21tZW50Lg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K

