Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86FBC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72F320651
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0DGbZyLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72F320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1QU-0001cz-Ox
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hr1QI-00016r-G2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hr1QH-0005KD-Gx
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:42:18 -0400
Received: from mail-eopbgr780100.outbound.protection.outlook.com
 ([40.107.78.100]:49184 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hr1QH-0005H0-6P
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:42:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSdLKdwL6aVbbGex6zm6/MbhGu3LA6aFLbtte4fBx388hSL9vMJYtRdnMn6Pqnsho1qVkgt+JbleBUymWNVIuFGkx+4w1CvycDq9DmUWt8UPWvQxbfjRpEX8LHVnHRDkNwzhFSBnIDFpZRl86kjUHVeDdkP6exFJEd3HK3WvzfwtfEPFTrb1Qc0jhA4sMcGkMW2MhQt0WvlesNohN6CdSQyWg5UY4klijMKERzh8FCYDGVzChqsgnF+DspI9FOyoIrHap46bruxn0afUUyoZRkRM9/iBfi3F5gmOig7psv+De53TXGwtbNrLkSvGFzVPe7RaODdAE6LDYfuP11krDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwnDtuVzFr+NcQLqoHAOYncAV4smY1NcOB7dl4yM28g=;
 b=GggKtZAgBg9jICrcvlw0pWmcV+oLwy7mBFDjiRHOrkfP4nLhxEO3zgSTqxyuEqs2ngzejFa6pzPicYa5pxLflIiBo8JfZlj89kw5DqLVWKt7fYqqHoLu3gNohSRwW6+vHSq4FuAbjW0uV9IGbs+RwjxnPu11zJFH0T/zjtsrtl1UXQnXSCccMDiiwu9zIZkZfFeQ9kAFBlBuNV5Pdq6A0n3ItKHrw3zi/GBdhv2+f1ndfHvLRctOB8h9SyEyn+BZogxV5+f9x6F9lfILRs2qOcDfn6mxdQfoJ3dN1Rf/5Us1Av9xWtco+eE5sKlg4qkCqKFdcZ4yn9QVSAAhNP/PoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwnDtuVzFr+NcQLqoHAOYncAV4smY1NcOB7dl4yM28g=;
 b=0DGbZyLCMyM94WZk/t9zQumvWFpnM9JRyfOmElzglAtnFOzVy57HXYlB4RICAJoBRzVUTYYeAcPR+T+hLszdxOtKI8GerLgMhk5ehuF8HAD8e1n+EitNZ7V9nsBnWgswyOgFd6Ch2tixoZEDBuCClHfjwFx2Ue7CB0/7rVR2Wl4=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3351.namprd03.prod.outlook.com (10.171.244.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Fri, 26 Jul 2019 14:42:13 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 14:42:13 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Thread-Topic: [PATCH 1/2] net: assert that tx packets have nonzero size
Thread-Index: AQHVPmMaGztodEr+U0+u+pXte5FK9KbXk12AgAVwdgA=
Date: Fri, 26 Jul 2019 14:42:13 +0000
Message-ID: <cf1a6dba5a749cdc3a306268407b71dedf80c5ba.camel@bu.edu>
References: <20190719185158.20316-1-alxndr@bu.edu>
 <20190719185158.20316-2-alxndr@bu.edu>
 <6342b3c5-0cb2-74ba-89f0-6d28ef859c70@redhat.com>
In-Reply-To: <6342b3c5-0cb2-74ba-89f0-6d28ef859c70@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [192.54.222.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8349555c-b38a-4d8c-c201-08d711d772c0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB3351; 
x-ms-traffictypediagnostic: CY4PR03MB3351:
x-microsoft-antispam-prvs: <CY4PR03MB33510D81EE9A3D6480B23C05BAC00@CY4PR03MB3351.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(6246003)(2501003)(6512007)(53936002)(118296001)(26005)(71200400001)(316002)(786003)(71190400001)(66066001)(6436002)(186003)(36756003)(66946007)(5660300002)(64756008)(110136005)(54906003)(229853002)(11346002)(446003)(2616005)(476003)(6486002)(99286004)(486006)(76176011)(256004)(66446008)(3846002)(6116002)(6506007)(102836004)(305945005)(68736007)(7736002)(8676002)(86362001)(8936002)(66476007)(66556008)(81156014)(25786009)(88552002)(14454004)(2906002)(91956017)(81166006)(4326008)(75432002)(76116006)(478600001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3351;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SVs3XQzeSl7vj0rvy0xhCmKwQnax1YrOYTfQw4+mpsU7209S43UOTeMYwFHCOYWMajIPnIzTOYgm1sXwFRDs0ZZvoi5M8hxV6shQ0spssefloYshHzIJrvIzcxexJXMcID08e/ra0MqwvrMzU+sli9fgCmwrfXhQblG/KOj430PEXt2Z47A4IFLuL7WL2HZBEz6qhAoAly1YdUVf/Lszy/sOsgEDbfFtFwpxEZT4duSkF6gaUigVq7dgD3IWrlIQct2m/A3Htg9wTJaMKJ9eD6/14gPwFu542djQA6mVwgBaKBgpcXHrCMZ44KvVINnM/uGMi4ubodxVdkcJnfa4pXxGtSdsWv08+XLuyGhnZJLiXN7TZSH3L0NEs1TyZ9evVTArejLoCgfzUOzQ36GJdmxOnVgkTgLM9WBJguuzjcA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEFFA846E46A514796B5655075FCCB0F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8349555c-b38a-4d8c-c201-08d711d772c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 14:42:13.6530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3351
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.100
Subject: Re: [Qemu-devel] [PATCH 1/2] net: assert that tx packets have
 nonzero size
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVHVlLCAyMDE5LTA3LTIzIGF0IDExOjM4ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBP
biAyMDE5LzcvMjAg5LiK5Y2IMjo1MiwgT2xlaW5paywgQWxleGFuZGVyIHdyb3RlOg0KPiA+IFZp
cnR1YWwgZGV2aWNlcyBzaG91bGQgbm90IHRyeSB0byBzZW5kIHplcm8tc2l6ZWQgcGFja2V0cy4g
VGhlDQo+ID4gY2FsbGVyDQo+ID4gc2hvdWxkIGNoZWNrIHRoZSBzaXplIHByaW9yIHRvIGNhbGxp
bmcgcWVtdV9zZW5kdl9wYWNrZXRfYXN5bmMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZGVyIE9sZWluaWsgPGFseG5kckBidS5lZHU+DQo+ID4gLS0tDQo+ID4gICBuZXQvbmV0LmMg
fCAzICsrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9uZXQvbmV0LmMgYi9uZXQvbmV0LmMNCj4gPiBpbmRleCA3ZDQwOTgyNTRm
Li5mYWQyMGJjNjExIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9uZXQuYw0KPiA+ICsrKyBiL25ldC9u
ZXQuYw0KPiA+IEBAIC03NDEsNiArNzQxLDkgQEAgc3NpemVfdCBxZW11X3NlbmR2X3BhY2tldF9h
c3luYyhOZXRDbGllbnRTdGF0ZQ0KPiA+ICpzZW5kZXIsDQo+ID4gICAgICAgc2l6ZV90IHNpemUg
PSBpb3Zfc2l6ZShpb3YsIGlvdmNudCk7DQo+ID4gICAgICAgaW50IHJldDsNCj4gPiAgIA0KPiA+
ICsgICAgLyogMC1zaXplZCBwYWNrZXRzIGFyZSB1bnN1cHBvcnRlZC4gQ2hlY2sgc2l6ZSBpbiB0
aGUgY2FsbGVyDQo+ID4gKi8NCj4gPiArICAgIGFzc2VydChzaXplKTsNCj4gDQo+IENhbiB0aGlz
IGJlIHRyaWdnZXJlZCB0aHJvdWdoIGEgYnVnZ3kgZGV2aWNlIGJ5IGd1ZXN0PyBJZiB5ZXMsIHdl
DQo+IG5lZWQgDQo+IGF2b2lkIHVzaW5nIGFzc2VydCgpIGhlcmUuDQoNClllcyAtIGZvciBleGFt
cGxlLCB2aXJ0aW8tbmV0IGNvdWxkIHRyaWdnZXIgdHJpZ2dlciBpdCBiZWNhdXNlIHRoZXJlIGlz
DQpubyBzaXplIGNoZWNrIHByaW9yIHRvIHFlbXVfc2VuZHZfcGFja2V0X2FzeW5jLCBhbHRob3Vn
aCBQQVRDSCAyLzINCnNob3VsZCBmaXggdGhpcy4NCkluc3RlYWQgb2YgdGhlIGFzc2VydGlvbiwg
c2hvdWxkIHdlIHJldHVybiBhIG5lZ2F0aXZlIHZhbHVlPyAgDQoNCj4gVGhhbmtzDQo+IA0KPiAN
Cj4gPiArDQo+ID4gICAgICAgaWYgKHNpemUgPiBORVRfQlVGU0laRSkgew0KPiA+ICAgICAgICAg
ICByZXR1cm4gc2l6ZTsNCj4gPiAgICAgICB9DQoNCg==

