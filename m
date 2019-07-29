Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3656C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EB1205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EB1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsC2h-0006IC-1U
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 16:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <BROGERS@suse.com>) id 1hsC2A-0005iW-OP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 16:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hsC29-0000rb-Lt
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 16:14:14 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:45796)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>)
 id 1hsC29-0000q7-EW; Mon, 29 Jul 2019 16:14:13 -0400
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0040g.houston.softwaregrp.com WITH ESMTP; 
 Mon, 29 Jul 2019 20:14:11 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 29 Jul 2019 20:13:04 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 29 Jul 2019 20:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNGya7nJKHEXsjkXCcjUo97zlFn3msoH/usXkrizKY1aRxztkz/1cC52IGrZimwFrWLEimXtfN0Cgz0/t+56ZcFDo5J4HDNPOFGsphpaa7INcNWYrpnHKA+JSgm1GiT2tvIgdvhFFtcEPWX1VkqjoQkApZPtf900rI9fdR/fwGTvU0P1OwEk1Rj31e1YB8m+mV+Q9flz0lsrVIwe02fnFk29CHZf+PGeQS/SgASTdAZE56OxMHek0/priZN5DR+NE9BdfUkxEBQfGOqd7C5KP3doUR33MGsb/vbveNLCEtUbVB3AB1osCBrnKFJCITyl3BQ8XuzHcSO66hDeWjgzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpoHQ82ejxjNk1Oc08L0T0Z86pEGn2K1fTuUZGlC84Y=;
 b=ftFM2KBARtxRZFgaUMIkA2v9WBlQ/4cEQ4TmkQK7+Or6XzSn/ciLNlIe6NhEbZtWbbhusaMAEa42Try1f80oginhDfFsk9SCJ0IH+EbuOlwPSuoxdMrTYRc2Fs5+UwRjgrtx1qsy2PF2jHocboWjKrLlAl2srbD+h75h2ZcPqI+43Xgv69qzl7uKPWd+iew6XGYP0gwuaXKcQHBwzGdSWXZr6B/CF39ndOS6GWufNuv94HKKtkcF+2EUfIdaqOi/niCi1aNUkz3gDnuwScSAT2Q7t4LckClvGCzzX33bzZvoytrLHkvBo+REXCXdgsqLCNbmsQEdRVIaOT66loXXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (10.255.155.222) by
 CH2PR18MB3287.namprd18.prod.outlook.com (52.132.247.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 29 Jul 2019 20:13:03 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610%3]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 20:13:03 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-stable] [PATCH 00/36] Patch Round-up for stable 3.1.1,
 freeze on 2019-07-29
Thread-Index: AQHVQXh1IKVLesLW3kq0rcuKEzP+IabiERMA
Date: Mon, 29 Jul 2019 20:13:02 +0000
Message-ID: <fb0afed2248757627b7d301b058e568fc8e860cd.camel@suse.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [2620:113:8044:4009:ffff:ffff:ffff:f626]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffb8ea90-e2d0-4a59-2c09-08d714612953
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CH2PR18MB3287; 
x-ms-traffictypediagnostic: CH2PR18MB3287:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CH2PR18MB3287450C59321BA19BAD6AC1D9DD0@CH2PR18MB3287.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(189003)(199004)(486006)(6116002)(446003)(11346002)(316002)(6306002)(102836004)(68736007)(4326008)(2616005)(186003)(476003)(6436002)(966005)(2906002)(14454004)(6506007)(229853002)(110136005)(46003)(478600001)(53936002)(8936002)(6486002)(81166006)(81156014)(6512007)(99286004)(8676002)(36756003)(5660300002)(71190400001)(86362001)(118296001)(66946007)(91956017)(25786009)(76116006)(66476007)(64756008)(66446008)(14444005)(6246003)(76176011)(2501003)(66556008)(256004)(7736002)(71200400001)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3287;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EGguCgHFAVvAJdjeCYMnRpFgyLvRgCfwqEHcG2n2BxnXB5Spo2kEFuvvtkBFBJb6fqn73THdjcrlAGCk+3/rJ2JemBjWPH8j/gkbB29zUKJkuMY7EU3Kvbihz2V1G9Izqm9yHiFreO6J+0UH7L+Sg3/2yDLlQfAVIgfH0E+1RNnf1J+CtmH/lmTnHFPvY+I2gPLFjgn0zVcY1DTyr/8Z4aQk9i8ElarXOpKaxidLCO4g11U8LynGPFEEcdoFbZj2WL9zhKYjJGem3JQwzUam2H5LNlVsibsBSggH0b5rfMPMLiBu9uQx/UNexyl3yCRP/z5RePjJYQhKg8dPCVaLOv8IS3SvIf8D2ikP9cUEz398lyQeln4YzI2VAdmEsqr2WuJ/mp36m29NVCI3ah4svUtxGrQutRSwMGZ+PKDT9k0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F61564324775884783CF84B0025F0F24@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb8ea90-e2d0-4a59-2c09-08d714612953
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 20:13:03.2225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BROGERS@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3287
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.2.86
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/36] Patch Round-up for
 stable 3.1.1, freeze on 2019-07-29
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
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVHVlLCAyMDE5LTA3LTIzIGF0IDEyOjAwIC0wNTAwLCBNaWNoYWVsIFJvdGggd3JvdGU6DQo+
IEhpDQo+IGV2ZXJ5b25lLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
DQo+IA0KPiBUaGUgZm9sbG93aW5nIG5ldyBwYXRjaGVzIGFyZSBxdWV1ZWQgZm9yIFFFTVUgc3Rh
YmxlIHYzLjEuMToNCj4gDQo+ICAgaHR0cHM6Ly9naXRodWIuY29tL21kcm90aC9xZW11L2NvbW1p
dHMvc3RhYmxlLTMuMS1zdGFnaW5nDQo+IA0KPiBUaGUgcmVsZWFzZSBpcyBwbGFubmVkIGZvciAy
MDE5LTA4LTAxOg0KPiANCj4gICBodHRwczovL3dpa2kucWVtdS5vcmcvUGxhbm5pbmcvMy4xDQo+
IA0KPiBQbGVhc2UgcmVzcG9uZCBoZXJlIG9yIENDIHFlbXUtc3RhYmxlQG5vbmdudS5vcmcgb24g
YW55IHBhdGNoZXMgeW91DQo+IHRoaW5rIHNob3VsZCBiZSBpbmNsdWRlZCBpbiB0aGUgcmVsZWFz
ZS4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIHVwZGF0ZSBmYWxscyBvdXRzaWRlIHRoZSBub3JtYWwg
c3RhYmxlIHJlbGVhc2Ugc3VwcG9ydA0KPiB3aW5kb3cgKH4xIGRldmVsb3BtZW50IGN5Y2xlKSwg
YnV0IGlzIGJlaW5nIHJlbGVhc2VkIG5vdyBzaW5jZSBpdCB3YXMNCj4gZGVsYXllZCBmcm9tIGl0
cyBpbnRlbmRlZCByZWxlYXNlIGRhdGUuDQo+IA0KPiBUaGFua3MhDQo+IA0KPiANCg0KQmV5b25k
IHdoYXQgaGFzIGFscmVhZHkgYmVlbiBzdWdnZXN0ZWQsIGhlcmUgYXJlIHNvbWUgcGF0Y2hlcyB3
ZSd2ZQ0KYWRkZWQgdG8gb3VyIHYzLjEuMCBiYXNlZCBRRU1VIHJlbGVhc2VzOg0KDQpjb21taXQg
MmM4NThjZTVkYThhZTY2ODljNzUxODJiNzNiYzQ1NWEyOTFjYWQ0MQ0KQXV0aG9yOiBQcmFzYWQg
SiBQYW5kaXQgPHBqcEBmZWRvcmFwcm9qZWN0Lm9yZz4NCkRhdGU6ICAgVGh1IERlYyAxMyAwMTow
MDozNiAyMDE4ICswNTMwDQoNCiAgICBwdnJkbWE6IGNoZWNrIG51bWJlciBvZiBwYWdlcyB3aGVu
IGNyZWF0aW5nIHJpbmdzDQoNCg0KY29tbWl0IGYxZTJlMzhlZTAxMzZiNzcxMGEyY2FhMzQ3MDQ5
ODE4YWZkNTdhMWINCkF1dGhvcjogUHJhc2FkIEogUGFuZGl0IDxwanBAZmVkb3JhcHJvamVjdC5v
cmc+DQpEYXRlOiAgIFRodSBEZWMgMTMgMDE6MDA6MzkgMjAxOCArMDUzMA0KDQogICAgcHZyZG1h
OiBjaGVjayByZXR1cm4gdmFsdWUgZnJvbSBwdnJkbWFfaWR4X3JpbmdfaGFzXyByb3V0aW5lcw0K
DQoNCmNvbW1pdCA1MDlmNTdjOThlNzUzNjkwNWJiNDkwMjM2M2QwY2JhNjZjZTdlMDg5DQpBdXRo
b3I6IFByYXNhZCBKIFBhbmRpdCA8cGpwQGZlZG9yYXByb2plY3Qub3JnPg0KRGF0ZTogICBUaHUg
RGVjIDEzIDAxOjAwOjM3IDIwMTggKzA1MzANCg0KICAgIHB2cmRtYTogcmVsZWFzZSByaW5nIG9i
amVjdCBpbiBjYXNlIG9mIGFuIGVycm9yDQoNCg0KY29tbWl0IDQ3MjBjYmVlYTFmNDJmZDkwNWZj
NjkzMzhmZDQyYjE5MWU1OGI0MTINCkF1dGhvcjogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNv
bT4NCkRhdGU6ICAgTW9uIEphbiA3IDEzOjAyOjQ4IDIwMTkgKzAxMDANCg0KICAgIGJsb2NrOiBG
aXggaGFuZ3MgaW4gc3luY2hyb25vdXMgQVBJcyB3aXRoIGlvdGhyZWFkcw0KDQoNCmNvbW1pdCA2
ZjVkODY3MTIyNWRjNzcxOTA2NDdmMThhMjdhMGQxNTZkNGNhOTdhDQpBdXRob3I6IFByYXNhZCBK
IFBhbmRpdCA8cGpwQGZlZG9yYXByb2plY3Qub3JnPg0KRGF0ZTogICBUdWUgSnVsIDIzIDE2OjE3
OjUyIDIwMTkgKzA1MzANCg0KICAgIHFlbXUtYnJpZGdlLWhlbHBlcjogcmVzdHJpY3QgaW50ZXJm
YWNlIG5hbWUgdG8gSUZOQU1TSVoNCg0KDQpUaGFua3MsDQoNCkJydWNlDQo=

