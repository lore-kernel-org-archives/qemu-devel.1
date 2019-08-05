Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98AFC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89DB20B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="sKhOZ5Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DB20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXII-000473-03
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huXAZ-0007Sq-2M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huXAX-0002aj-CZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:12:34 -0400
Received: from mail-eopbgr750091.outbound.protection.outlook.com
 ([40.107.75.91]:14606 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huXAV-0002a4-Ir
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT7/9451Jgm3r39hdpHlMyrlU0YELKbROQk+rvpoV2Ic6Op+7UilEbjmqYqQ6YfjBTvgvDh5/FjEbLCZjdfxVaNuRiwG/m8Sh6LN79TN1EmC3MnqSz/rn5MdlZOmsBXpEp5983DwV01PRgU4D1w8WfTn6KgC5RSB4AXXxn+lRA3UOayQdl+3NM8D7tS7SZnSH1W/V2HregwrsX/8bYAvDx087oilq/rf9cHXSNcNd2eg4preh9zVcjpjQsMuTCxaMLQ0+1EtGYv8ETwb3G3SxM30lOh42O4qwxaynpW5fpF/RVL10aWYhCnDluX+HCnvC2xswTKPHt9owtBDfX5UFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXBoJ/2boPdAckZVsXJWuTKahsb340wHgGz7170mIY8=;
 b=nqfK0tAYbs684E+CjTNqH1Wmn+dOMcVIT5JxqfR5eBMSBCgMe5szvhKkUqNE+ypdv0nU/NR82zZUxd5WGh90H3M2mI/wstVm9X1M1jB0wEU5ythoyT93Nc+FsYs5Kh0yxbgNPduQU9e9T96wltXUmlT9e6mffjoJzmM3Qf3xIxC72ic7yfzyjgDAMKE+476uzYCIEbDvq+3tb3iSha9XxVcKTnGjpgDNm5tPheQw2uA1XjqBHYnZQ16T/jE2Ssi9V4N/b//R63bXlyDI8Zg5xw6Fr4FPx2NHl/TWn3GcHPsKlPCb2SIOtnwwOtGXz/2WR9ydYZ4IDyNuYUZysgfzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXBoJ/2boPdAckZVsXJWuTKahsb340wHgGz7170mIY8=;
 b=sKhOZ5Wh/nVPT3wwecu4uc/A9uFv4RGPowaz3W9h8N+mgmooTBGr3hWXdnMTMUE5pi0u7REfzKNHLPgqUMaWX3o626BBFYR2R0sUsa9kPky/EM+IDwKOlj1MGgEwReY9Dm5+wgto1F3yuwh2NQmygziJT6xnc+XsFDIA1DYxEyQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4SPR00MB250.namprd03.prod.outlook.com (10.171.171.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.11; Mon, 5 Aug 2019 07:12:30 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:12:30 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] libqos: Account for the ctrl queue in virtio-net
Thread-Index: AQHVSz1CUgha89H44UiBTNnaIEmg0absI8mA
Date: Mon, 5 Aug 2019 07:12:30 +0000
Message-ID: <063d4c612ef876bdbefd190cb07de11dd306d061.camel@bu.edu>
References: <20190805032400.8054-1-alxndr@bu.edu>
In-Reply-To: <20190805032400.8054-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [71.162.119.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d24732f6-b808-40ab-1678-08d71974479d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4SPR00MB250; 
x-ms-traffictypediagnostic: CY4SPR00MB250:
x-microsoft-antispam-prvs: <CY4SPR00MB250081F9771BCFA84B790D1BADA0@CY4SPR00MB250.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(189003)(199004)(2906002)(54906003)(2351001)(14454004)(229853002)(14444005)(256004)(53936002)(486006)(4326008)(36756003)(118296001)(66066001)(11346002)(316002)(25786009)(6116002)(786003)(71190400001)(71200400001)(3846002)(305945005)(476003)(446003)(2616005)(76176011)(6246003)(102836004)(6486002)(5660300002)(26005)(86362001)(66476007)(66556008)(6916009)(8936002)(478600001)(6506007)(7736002)(66946007)(2501003)(66446008)(64756008)(75432002)(91956017)(76116006)(68736007)(88552002)(99286004)(81156014)(15650500001)(8676002)(186003)(81166006)(5640700003)(6436002)(6512007)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4SPR00MB250;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E0sGcsFc8RNLRHQS+eRu8r8prt3Ko0UD26EPVPVzb8E45iGDo82dVMol2tc/j3H3WQrP2iujxWTvzV5S7rg4tUCdZGjyYaqiOOuc8VeKlBYxTYJI5HykOaOx83M/GbHR+xaHmQ7zZS7V2T2f0YFqwmy/o0/oUFE3xMw9H22aPY3yAKFF5kwai0/1jl0/evRW0bImvr1bUB2zNcHvq2XpY8/Y8sysOeLUnljwFPbZ2/+mNM8+9bvSxw6UmL2Z6xIugmSTancj7DUkTFBEtTN7+Q8IujTcp28ATNz4pJ93tiCxOgHA6wXkIcO9ranPbQvCd/FPkv5QfhUO6r+dOum/GNEKtGLG7q/lgn8RsmJKip9m7iwI5U7RWkjXBLMjgyS0AE25VJNKsMl9dMZS1JHh+rNRrm4rEMYoZupuFGra/wA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCE8D5C07C286A468B32FEA91DAC3394@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d24732f6-b808-40ab-1678-08d71974479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:12:30.3343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB250
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.91
Subject: Re: [Qemu-devel] [PATCH] libqos: Account for the ctrl queue in
 virtio-net
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA4LTA1IGF0IDAzOjI0ICswMDAwLCBPbGVpbmlrLCBBbGV4YW5kZXIgd3Jv
dGU6DQo+IFRoZSBudW1iZXIgb2YgcXVldWVzIGlzIDJuKzEsIHdoZXJlIG4gPT0gMSB3aGVuIG11
bHRpcXVldWUgaXMNCj4gZGlzYWJsZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBP
bGVpbmlrIDxhbHhuZHJAYnUuZWR1Pg0KPiAtLS0NCj4gDQo+IEkgc3BsaXQgdGhpcyBjb21taXQg
b3V0IG9mIHRoZSBmdXp6IHBhdGNoLXNlcmllcy4NCj4gDQo+ICB0ZXN0cy9saWJxb3MvdmlydGlv
LW5ldC5jIHwgMSArDQo+ICB0ZXN0cy9saWJxb3MvdmlydGlvLW5ldC5oIHwgMiArLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90ZXN0cy9saWJxb3MvdmlydGlvLW5ldC5jIGIvdGVzdHMvbGlicW9zL3ZpcnRpby1u
ZXQuYw0KPiBpbmRleCA2NjQwNWI2NDZlLi5iOGI1YmM1ZGZjIDEwMDY0NA0KPiAtLS0gYS90ZXN0
cy9saWJxb3MvdmlydGlvLW5ldC5jDQo+ICsrKyBiL3Rlc3RzL2xpYnFvcy92aXJ0aW8tbmV0LmMN
Cj4gQEAgLTUzLDYgKzUzLDcgQEAgc3RhdGljIHZvaWQgdmlydGlvX25ldF9zZXR1cChRVmlydGlv
TmV0ICppbnRlcmZhY2UpDQo+ICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgaW50ZXJmYWNlLT5u
X3F1ZXVlcyA9IDI7DQo+ICAgICAgfQ0KPiArICAgIGludGVyZmFjZS0+bl9xdWV1ZXMrKzsgLyog
QWNjb3VudCBmb3IgdGhlIGN0cmwgcXVldWUgKi8NCj4gIA0KPiAgICAgIGludGVyZmFjZS0+cXVl
dWVzID0gZ19uZXcoUVZpcnRRdWV1ZSAqLCBpbnRlcmZhY2UtPm5fcXVldWVzKTsNCj4gICAgICBm
b3IgKGkgPSAwOyBpIDwgaW50ZXJmYWNlLT5uX3F1ZXVlczsgaSsrKSB7DQo+IGRpZmYgLS1naXQg
YS90ZXN0cy9saWJxb3MvdmlydGlvLW5ldC5oIGIvdGVzdHMvbGlicW9zL3ZpcnRpby1uZXQuaA0K
PiBpbmRleCBhNTY5N2Q3MzI2Li44NTVjNjdkMDBmIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9saWJx
b3MvdmlydGlvLW5ldC5oDQo+ICsrKyBiL3Rlc3RzL2xpYnFvcy92aXJ0aW8tbmV0LmgNCj4gQEAg
LTI5LDcgKzI5LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgUVZpcnRpb05ldERldmljZSBRVmlydGlvTmV0
RGV2aWNlOw0KPiAgDQo+ICBzdHJ1Y3QgUVZpcnRpb05ldCB7DQo+ICAgICAgUVZpcnRpb0Rldmlj
ZSAqdmRldjsNCj4gLSAgICBpbnQgbl9xdWV1ZXM7DQo+ICsgICAgaW50IG5fcXVldWVzOyAvKiB0
b3RhbCBudW1iZXIgb2YgdmlydHF1ZXVlcyAocngsIHR4LCBjdHJsKSAqLw0KPiAgICAgIFFWaXJ0
UXVldWUgKipxdWV1ZXM7DQo+ICB9Ow0KPiAgDQpTb3JyeSBhYm91dCB0aGUgdHlwby4NCg==

