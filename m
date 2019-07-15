Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F52C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C396B206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fgaDC+Np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C396B206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn4Cs-00044F-U8
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 12:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <juterry@microsoft.com>) id 1hn4Cf-0003fd-GK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <juterry@microsoft.com>) id 1hn4Ce-0002pb-0y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:51:53 -0400
Received: from mail-eopbgr820098.outbound.protection.outlook.com
 ([40.107.82.98]:53870 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <juterry@microsoft.com>)
 id 1hn4Cd-0002o5-LT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKOL3WgN2/+szrpfaqFTk8H+ZpEaESqkJ4y8CV/jCMl/L4LxhB0rauD3fm+iZSvublpPUCxlCSOUfq3Fcd03lcf56+2bkdLNtmEW7rrCOJqZRxPWP7xTlnvrM9QRrI+a/sh2am4HxXaI2ud+0oYkI2CvjEvtTHZIH6tKtdFwAlVTAoCRb/jeiw/MXTkxfdWTHHi+ykWphAtDJgr3upe/5RykBI9V/sN7cDRLdKXbrFN6dwPNCxNq2GD9e73C0We0H189M6e/Fm9m9+Y643N1ptsZfyPcgXK/zjs3EKoXA4s3inTajb92a8hMVLvvbEn5doE+PYDPD6w/o/tQusuleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I86rH/acro2jbO5atASVNIac5qvWGAAL0iTCj+bFMg=;
 b=FBQKLuG4lMmUnmcKIu3Jpmvdw4tA1gs0l8FrXJ5rO7sEDnmsf+XbcyGrqEDHe6lfD4s2uKkdFBKGa+jLcQC0X/INygy2GDDESCTD7xsN7K7WSoiDnBrVNfcfdu3aELErienlrq/YHZLxhz2P4TOx4eLLO9gKMdP1pDO4gti3ITrJnCByD7+lYwvqUkUGJEo5s2imfd7RaPaoAJUm3JLPLNoI1aQi8SKjfTafej9KYs2CFm0y5eNqUoruBIzJ9ktAEhFagENJqZ+2WEtvfU8nEA57O0ljO2eyDgzuMdLV46mcHWV2/n4tpmuaVMJHNYMpDIG+/9cg3DxbiPIpAUDxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I86rH/acro2jbO5atASVNIac5qvWGAAL0iTCj+bFMg=;
 b=fgaDC+Npk/oaltLu5awyK84BSfNtKbfq7wpoJ2fRNgskwbFfn3uxZ3HwWz2CkPFDDcXlDNONec0o6XDfyVq3GrVDzjdJnHJidvQ+uPFXKf5bvb5h508Pn5n/9W6E6DrG0Z3fn4BcrOWFEnqXDNgzEC+bSZH5BeOz7RkOHO4IHwo=
Received: from DM6PR21MB1338.namprd21.prod.outlook.com (20.179.53.81) by
 DM6PR21MB1289.namprd21.prod.outlook.com (20.179.52.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.1; Mon, 15 Jul 2019 16:51:49 +0000
Received: from DM6PR21MB1338.namprd21.prod.outlook.com
 ([fe80::458f:b6ae:760:6aee]) by DM6PR21MB1338.namprd21.prod.outlook.com
 ([fe80::458f:b6ae:760:6aee%8]) with mapi id 15.20.2115.002; Mon, 15 Jul 2019
 16:51:49 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan
 Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH for 4.1] Fix broken build with WHPX enabled
Thread-Index: AQHVOL79QWfQTu/SX0W4RT6+1s91aabL6JWA
Date: Mon, 15 Jul 2019 16:51:49 +0000
Message-ID: <DM6PR21MB13389BE38D68C2FD770CDA39B6CF0@DM6PR21MB1338.namprd21.prod.outlook.com>
References: <20190712132611.20411-1-sw@weilnetz.de>
 <056e4dd6-70b7-395a-2062-913ddcea0028@redhat.com>
In-Reply-To: <056e4dd6-70b7-395a-2062-913ddcea0028@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=juterry@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-15T16:51:47.1216454Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70451216-8018-4512-a10c-512c5d45c880;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juterry@microsoft.com; 
x-originating-ip: [67.185.128.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8291687-2d6f-4728-e111-08d70944babf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR21MB1289; 
x-ms-traffictypediagnostic: DM6PR21MB1289:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DM6PR21MB12897F2DCC04995B42C763CAB6CF0@DM6PR21MB1289.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(13464003)(8676002)(3846002)(66946007)(68736007)(76176011)(64756008)(81156014)(186003)(7696005)(6116002)(81166006)(66556008)(66476007)(26005)(2501003)(33656002)(86362001)(76116006)(102836004)(6506007)(53546011)(10090500001)(53936002)(22452003)(446003)(316002)(11346002)(74316002)(476003)(486006)(2906002)(256004)(99286004)(10290500003)(8990500004)(966005)(110136005)(54906003)(305945005)(66446008)(8936002)(66066001)(229853002)(7736002)(6436002)(14454004)(77540400001)(71190400001)(4326008)(71200400001)(9686003)(6306002)(55016002)(6246003)(25786009)(52536014)(478600001)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR21MB1289;
 H:DM6PR21MB1338.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QSzBxDs4T+Wrb+3tCM8VsnmdS9NsrxcA9o5S5fDS70L9Oma5gn1LQXoqAYu5O0+k3dL51wKenZh9aszRMAN4o58WQTWuVO7eN3FHZ5QDkSseRlWb0UOo/qLidLos+cftXUEOuIZlGVWMdMltUrZMNOOnimeMl1rrlD32KWzws2VzDnxtSS8RHeyQAeIIbr+AZ6YvGT8qb3VPdjI81ySnEAL8IuCdlaNarOzDSdXFjxk8RkdHZnG0FU160OCotLbiHySdg6NpgHx8oi2MMvXckUhwuHRLvy/WZIPaCflJ2XY5sy6stE/yNFaux3i5usRYE0Jz/iXr3z/wVDlG96wZWxDyvn6jJKy3FjqwJDmt2onwEHf7tv0Z17EhL7CdBc0ssldaM1MYAbab98l0KlgIMz8ntuCv4ex7XrFRnY96QNk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8291687-2d6f-4728-e111-08d70944babf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 16:51:49.1240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juterry@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1289
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.98
Subject: Re: [Qemu-devel] [PATCH for 4.1] Fix broken build with WHPX enabled
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
From: "Justin Terry \(VM\) via Qemu-devel" <qemu-devel@nongnu.org>
Reply-To: "Justin Terry \(VM\)" <juterry@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIFBoaWxpcHBlLCBMR1RNIChub3QgYSBtYWludGFpbmVyKQ0KDQpGWUkgaGVyZSBhcmUg
c29tZSBkb2NzIG9uIFdIdlNldFBhcnRpdGlvblByb3BlcnR5IG1ldGhvZC4gSSBrbm93IHRoZXkg
YXJlbuKAmXQgY29tcHJlaGVuc2l2ZSBidXQgdGhleSBoZWxwOiBodHRwczovL2RvY3MubWljcm9z
b2Z0LmNvbS9lbi11cy92aXJ0dWFsaXphdGlvbi9hcGkvaHlwZXJ2aXNvci1wbGF0Zm9ybS9mdW5j
cy93aHZzZXRwYXJ0aXRpb25wcm9wZXJ0eQ0KDQpOb3Qgc3VyZSBpZiB5b3UgYXJlIGFza2luZyBm
b3Igc29tZXRoaW5nIHdpdGggdGhlIGxpbmsgdG8gdGhlIFZpcnR1YWxCb3ggY29tbWVudCBidXQg
dGhlIEFQSSBhbGxvd3MgZm9yIHNldHRpbmcgYW55IG9mIFdIVl9QQVJUSVRJT05fUFJPUEVSVFkg
Zm91bmQgYXQ6IGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2VuLXVzL3ZpcnR1YWxpemF0aW9u
L2FwaS9oeXBlcnZpc29yLXBsYXRmb3JtL2Z1bmNzL3dodnBhcnRpdGlvbnByb3BlcnR5ZGF0YXR5
cGVzIChyZWZlciB0byAuaCBmaWxlIGZvciBtb3N0IHVwIHRvIGRhdGUgaW4gdGhlIHNkayBtYXRj
aGluZyB5b3VyIGJ1aWxkKS4gVGhpcyBpcyB3aHkgaXRzIG5vdCBhIHNpbXBsZSAiOSBieXRlcyIg
YXMgaW5kaWNhdGVkIGJlbG93Lg0KDQpUaGFua3MsDQpKdXN0aW4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxMiwgMjAxOSA3OjM1IEFNDQo+IFRvOiBT
dGVmYW4gV2VpbCA8c3dAd2VpbG5ldHouZGU+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBFZHVhcmRvIEhhYmtvc3QNCj4g
PGVoYWJrb3N0QHJlZGhhdC5jb20+OyBMaWtlIFh1IDxsaWtlLnh1QGxpbnV4LmludGVsLmNvbT47
IFJpY2hhcmQNCj4gSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+OyBKdXN0aW4gVGVycnkgKFZN
KSA8anV0ZXJyeUBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQ
QVRDSCBmb3IgNC4xXSBGaXggYnJva2VuIGJ1aWxkIHdpdGggV0hQWA0KPiBlbmFibGVkDQo+IA0K
PiBDYydpbmcgSnVzdGluDQo+IA0KPiBNYXliZSB3ZSBzaG91bGQgYWRkIGEgTUFJTlRBSU5FUlMg
c2VjdGlvbiBmb3IgdGhlIFdIUFggZmlsZXMuDQo+IA0KPiBPbiA3LzEyLzE5IDM6MjYgUE0sIFN0
ZWZhbiBXZWlsIHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBXZWlsIDxzd0B3ZWls
bmV0ei5kZT4NCj4gPiAtLS0NCj4gPiAgdGFyZ2V0L2kzODYvd2hweC1hbGwuYyB8IDQgKystLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L3docHgtYWxsLmMgYi90YXJnZXQvaTM4Ni93
aHB4LWFsbC5jIGluZGV4DQo+ID4gMzFkNDczMjBlNC4uZWQ5NTEwNWVhZSAxMDA2NDQNCj4gPiAt
LS0gYS90YXJnZXQvaTM4Ni93aHB4LWFsbC5jDQo+ID4gKysrIGIvdGFyZ2V0L2kzODYvd2hweC1h
bGwuYw0KPiA+IEBAIC0xMzk2LDcgKzEzOTYsNyBAQCBzdGF0aWMgaW50IHdocHhfYWNjZWxfaW5p
dChNYWNoaW5lU3RhdGUgKm1zKQ0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gICAgICBtZW1zZXQoJnBy
b3AsIDAsIHNpemVvZihXSFZfUEFSVElUSU9OX1BST1BFUlRZKSk7DQo+ID4gLSAgICBwcm9wLlBy
b2Nlc3NvckNvdW50ID0gc21wX2NwdXM7DQo+ID4gKyAgICBwcm9wLlByb2Nlc3NvckNvdW50ID0g
bXMtPnNtcC5jcHVzOw0KPiANCj4gSSB0cmllZCB0byB1bmRlcnN0YW5kIGhvdyB0aGUgV2luZG93
cyBIeXBlcnZpc29yIHdvdWxkIGFuc3dlciB0byBhbg0KPiBpbnZhbGlkIG9yIHplcm9lZCBwcm9w
ZXJ0eSwgYnV0IEkgY2FuJ3QgZmluZCBkb2MgZm9yDQo+IFdIdlBhcnRpdGlvblByb3BlcnR5Q29k
ZVByb2Nlc3NvckNvdW50Lg0KPiANCj4gVGhlcmUgaXMgYSBmdW5ueSBjb21tZW50IGluIFZpcnR1
YWxCb3ggYWx0aG91Z2g6DQo+IA0KPiAgLyoqDQo+ICAgKiBAdG9kbyBTb21lb25lIGF0IE1pY3Jv
c29mdCBwbGVhc2UgZXhwbGFpbiBhbm90aGVyIHdlaXJkIEFQSToNCj4gICAqICAtIFdoeSB0aGlz
IEFQSSBkb2Vzbid0IHRha2UgdGhlIFdIVl9QQVJUSVRJT05fUFJPUEVSVFlfQ09ERSB2YWx1ZQ0K
PiBhcyBhbg0KPiAgICogICAgYXJndW1lbnQgcmF0aGVyIHRoYW4gYXMgcGFydCBvZiB0aGUgc3Ry
dWN0LiAgVGhhdCBpcyBzbyB3ZWlyZCBpZg0KPiB5b3UndmUNCj4gICAqICAgIHVzZWQgYW55IG90
aGVyIE5UIG9yIHdpbmRvd3MgQVBJLCAgaW5jbHVkaW5nIFdIdkdldENhcGFiaWxpdHkoKS4NCj4g
ICAqICAtIFdoeSB1c2UgUFZPSUQgd2hlbiBXSFZfUEFSVElUSU9OX1BST1BFUlRZIGlzIHdoYXQn
cyBleHBlY3RlZC4NCj4gV2UNCj4gICAqICAgIHRlY2huaWNhbGx5IG9ubHkgbmVlZCA5IGJ5dGVz
IGZvciBzZXR0aW5nL2dldHRpbmcNCj4gICAqICAgIFdIVlBhcnRpdGlvblByb3BlcnR5Q29kZVBy
b2Nlc3NvckNsRmx1c2hTaXplLCBidXQgdGhlIEFQSSBpbnNpc3RzDQo+IG9uIDE2LiAqLw0KPiAN
Cj4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGd3cNCj4gdy52aXJ0dWFsYm94Lm9yZyUyRnN2biUyRnZib3glMkZ0cnVuayUy
RnNyYyUyRlZCb3glMkZWTU0lMkZWTQ0KPiBNUjMlMkZORU1SM05hdGl2ZS0NCj4gd2luLmNwcCZh
bXA7ZGF0YT0wMiU3QzAxJTdDanV0ZXJyeSU0MG1pY3Jvc29mdC5jb20lN0M3OTJjNTBkZjAzYTgN
Cj4gNGIwMzQzY2QwOGQ3MDZkNjFmMjQlN0M3MmY5ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0
NyU3QzElN0MxJQ0KPiA3QzYzNjk4NTM4OTAyNjI3MzQ5MyZhbXA7c2RhdGE9RGZ0UUdieSUyQmhq
b2paa1h0aGp4amEwekxSZnVlUnppJTINCj4gRjJEVUUlMkZzSThtNXMlM0QmYW1wO3Jlc2VydmVk
PTANCj4gDQo+ID4gICAgICBociA9IHdocF9kaXNwYXRjaC5XSHZTZXRQYXJ0aXRpb25Qcm9wZXJ0
eSgNCj4gPiAgICAgICAgICB3aHB4LT5wYXJ0aXRpb24sDQo+ID4gICAgICAgICAgV0h2UGFydGl0
aW9uUHJvcGVydHlDb2RlUHJvY2Vzc29yQ291bnQsDQo+ID4gQEAgLTE0MDUsNyArMTQwNSw3IEBA
IHN0YXRpYyBpbnQgd2hweF9hY2NlbF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpDQo+ID4NCj4gPiAg
ICAgIGlmIChGQUlMRUQoaHIpKSB7DQo+ID4gICAgICAgICAgZXJyb3JfcmVwb3J0KCJXSFBYOiBG
YWlsZWQgdG8gc2V0IHBhcnRpdGlvbiBjb3JlIGNvdW50IHRvICVkLCINCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgIiBocj0lMDhseCIsIHNtcF9jb3JlcywgaHIpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAiIGhyPSUwOGx4IiwgbXMtPnNtcC5jb3JlcywgaHIpOw0KPiA+ICAgICAgICAg
IHJldCA9IC1FSU5WQUw7DQo+ID4gICAgICAgICAgZ290byBlcnJvcjsNCj4gPiAgICAgIH0NCj4g
Pg0K

