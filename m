Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13611C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7D321BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TYXyyGEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7D321BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCYl-00045u-3y
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hqCYY-0003fY-Ss
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hqCYX-0004Ga-OC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:23:26 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com
 ([40.107.6.97]:22498 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hqCYV-0004EZ-AG; Wed, 24 Jul 2019 04:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpMM6t4+SjaJMa/dqWyvHkndljqqMMPARI8hZfzuPj7cy3U5AR8JIedqudsJ3Du6vla+nFLdAPRP01d02e2hh67tPXyfYqa0VbDZ8X11WCImFbg4LOrav9Bui2GBb3zV8gT4h56xfMMmNeIq4JEM488ymVKIgIUgoEAJQLAcCACBI+yA8hq5BpS3XGwFZFkArshyGM7AnE9MIvE22cm5421APYxqedDWse8yHjVPFGtBOtcK2lUO60NsqB6/JrASC1ZpMx0i4hR4u4doETMEJzQLR3oxOL70G5o0E23i3bccNvC+UU3i1MNRxPySRLIYLALbgKwIO0p1kFUc8It2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoWNKuQt+LCwhfx2ZJAVYBEE7aDaAT7ZjAcb+610DYY=;
 b=iswi9DEz6u1y7MhGciBqve9PFZbRTHL77Y0UzG60dPsrqwi+YTbpWSophxbnXYfcbItfkT0+P+yw95VRFcI/o+gfVfscZBx5tM9tf7U/o0D/qxGRwbl6BX42yQWriCUUk+fvuSjN+3Pv2A9FLH/b8AFuzeys25J1uPpjAPjwpBrniZK3XLYmU6gO0RUOdLDbr8Akw+bhmPZKFiZ9uLQ9kdwtv6kFnuSOVHRSh99LKxnar+bec7ntlWmvEocqRWYDyMVXH/1XSQgQqu/IpPFBajeALmVCzZy6m9SD2SQKcsGJ+4VcYU8oYK4c/RgnKxl0wz9Re5RevVO+ltuzBMuMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoWNKuQt+LCwhfx2ZJAVYBEE7aDaAT7ZjAcb+610DYY=;
 b=TYXyyGEMcVJXo6s4+bajyxlrzKlTi+F5WnLnR2BpOh0eovLX8C9M5YYT/LkwBFIEjFBMBD3dThpzdcg8fwjAJgm0tuuJS7JgTV96HLI6mEc019cl2yhWww3/dbgIePZWvM3zzkBLz7ANjXiSu0MwTtqxTnZCj9ZmRnl3RSShGbA=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4382.eurprd08.prod.outlook.com (20.179.28.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 08:23:20 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 08:23:20 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PULL 01/13] iotests: Set read-zeroes on in null
 block driver for Valgrind
Thread-Index: AQHVPjg87/EcfJJ+aUOzlBPF8UMWHKbZY6+AgAA1a4D//8/sAIAAN8AA///PzICAAAUUgA==
Date: Wed, 24 Jul 2019 08:23:20 +0000
Message-ID: <694e630a-d3ac-0b7a-ce78-7dfc33c22515@virtuozzo.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
 <20190719134345.23526-2-kwolf@redhat.com>
 <42945b0e-8583-ba6e-16c5-2cdb7595206a@de.ibm.com>
 <351d4790-3ea3-9cd2-1c4d-6042ea35507c@virtuozzo.com>
 <20190724073805.GA4873@localhost.localdomain>
 <6149d521-1b45-c2a0-5bcc-1c8fbe0c2381@virtuozzo.com>
 <20190724080507.GB4873@localhost.localdomain>
In-Reply-To: <20190724080507.GB4873@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d40c03f-a61d-409b-9657-08d710102f7f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4382; 
x-ms-traffictypediagnostic: VI1PR08MB4382:
x-microsoft-antispam-prvs: <VI1PR08MB4382BDF3CA6A7942E86F043FF4C60@VI1PR08MB4382.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(39850400004)(376002)(396003)(189003)(199004)(186003)(229853002)(26005)(71200400001)(71190400001)(4326008)(478600001)(6436002)(81166006)(81156014)(8676002)(6246003)(6486002)(256004)(14454004)(102836004)(25786009)(68736007)(64756008)(66446008)(66556008)(66476007)(66946007)(44832011)(3846002)(66066001)(86362001)(36756003)(31686004)(6512007)(6116002)(53936002)(31696002)(8936002)(386003)(2906002)(76176011)(53546011)(99286004)(6916009)(52116002)(2616005)(476003)(305945005)(54906003)(11346002)(486006)(316002)(7736002)(6506007)(446003)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4382;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qGZP6y4TGxb5/5lHV2JFwMQZaruRKLkhEnMa93iAAoEkGUhdfor4INTmDsai0uMmtXD3FPhzD5szHrSO4/MAoLH0kx9IJuw6IP/mXVal9gR3qk5xvoT5idVJGn2JB1+rrJIfW+MZ7IfI8DpXrwtGVtkl3ho9YbMughJm4OwNMQbvzAuprt/sf78G2FR7D3JDA5j07UNy86BfabbAMkUr4RqkVSTNV86fFbRIgBQa2e57Y36C9c8zw5u9xftEG9PJrxWpBWtJRMhuW1P1I5QpOaymsV/WFPiLwFC9Cu062Cg0ixqveChm2ob+wrTAdsXoSN0m+KPyae7qrAhs21U8ecC0+umGqiEKPmRmZK9EDhgoD67kVOQCoR/Idk9AvFMaezpXPKRZKyH4DHUZ9SR/+HKY4L1k2iLk3VeQ9myxgbU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA3278E7903AF24FB2671732B83F6359@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d40c03f-a61d-409b-9657-08d710102f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 08:23:20.0375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4382
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.97
Subject: Re: [Qemu-devel] [PULL 01/13] iotests: Set read-zeroes on in null
 block driver for Valgrind
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI0LzA3LzIwMTkgMTE6MDUsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI0LjA3LjIw
MTkgdW0gMDk6NTcgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4NCj4+DQo+
PiBPbiAyNC8wNy8yMDE5IDEwOjM4LCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+IEFtIDI0LjA3LjIw
MTkgdW0gMDk6MzAgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4+Pg0KPj4+
Pg0KPj4+PiBPbiAyNC8wNy8yMDE5IDEwOjE4LCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6
DQo+Pj4+Pg0KPj4+Pj4gT24gMTkuMDcuMTkgMTU6NDMsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+
Pj4gRnJvbTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5j
b20+DQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgVmFsZ3JpbmQgdG9vbCByZXBvcnRzIGFib3V0IHRoZSB1
bmluaXRpYWxpc2VkIGJ1ZmZlciAnYnVmJw0KPj4+Pj4+IGluc3RhbnRpYXRlZCBvbiB0aGUgc3Rh
Y2sgb2YgdGhlIGZ1bmN0aW9uIGd1ZXNzX2Rpc2tfbGNocygpLg0KPj4+Pj4+IFBhc3MgJ3JlYWQt
emVyb2VzPW9uJyB0byB0aGUgbnVsbCBibG9jayBkcml2ZXIgdG8gbWFrZSBpdCBkZXRlcm1pbmlz
dGljLg0KPj4+Pj4+IFRoZSBvdXRwdXQgb2YgdGhlIHRlc3RzIDA1MSwgMTg2IGFuZCAyMjcgbm93
IGluY2x1ZGVzIHRoZSBwYXJhbWV0ZXINCj4+Pj4+PiAncmVhZC16ZXJvZXMnLiBTbywgdGhlIGJl
bmNobWFyayBvdXRwdXQgZmlsZXMgYXJlIGJlaW5nIGNoYW5nZWQgdG9vLg0KPj4+Pj4+DQo+Pj4+
Pj4gU3VnZ2VzdGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5j
b20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNTEgICAgICAg
IHwgIDEwICstLQ0KPj4+Pj4+ICAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMDUxLnBjLm91dCB8ICAx
MCArLS0NCj4+Pj4+PiAgICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA5MyAgICAgICAgfCAgIDkgKy0N
Cj4+Pj4+IFsuLi45DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IEkgbm93IGdldCB0aGUgZm9sbG93aW5n
IG9uIHMzOTAuDQo+Pj4+PiBTZWVtcyB0aGF0IHlvdSBvbmx5IGZpeGVkIDA1MS5wYy5vdXQgYnV0
IG5vdCAwNTEub3V0DQo+Pj4+Pg0KPj4+Pj4gICAgICAgIDA1MSAgICAgIC4uLiAgICAgICAgWzA5
OjAxOjQ5XSAgICAgICAgICAgICAuLi4gICAgICAgICAgICAgIDA1MSAgICAgIBtbMW0bWzMxbWZh
aWwgICAgICAbWzBtIFswOTowMTo0OV0gWzA5OjAxOjUwXSAgICAgICAgICAgICAgICAgICAgb3V0
cHV0IG1pc21hdGNoIChzZWUgMDUxLm91dC5iYWQpDQo+Pj4+PiAgICAgICAgLS0tIHRlc3RzL3Fl
bXUtaW90ZXN0cy8wNTEub3V0CTIwMTktMDctMDkgMTg6MzQ6MjYuNzM0NjU0OTMzICswMjAwDQo+
Pj4+PiAgICAgICAgKysrIGJ1aWxkL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTEub3V0LmJhZAkyMDE5
LTA3LTI0IDA5OjAxOjUwLjAxNTAyNDkwMSArMDIwMA0KPj4+Pj4gICAgICAgIEBAIC0xNDksMjMg
KzE0OSwyMyBAQA0KPj4+Pj4gICAgICAgICANCj4+Pj4+ICAgICAgICAgPT09IENhY2hlIG1vZGVz
ID09PQ0KPj4+Pj4gICAgICAgICANCj4+Pj4+ICAgICAgICAtVGVzdGluZzogLWRyaXZlIGRyaXZl
cj1udWxsLWNvLGNhY2hlPW5vbmUNCj4+Pj4+ICAgICAgICArVGVzdGluZzogLWRyaXZlIGRyaXZl
cj1udWxsLWNvLHJlYWQtemVyb2VzPW9uLGNhY2hlPW5vbmUNCj4+Pj4+ICAgICAgICAgUUVNVSBY
LlkuWiBtb25pdG9yIC0gdHlwZSAnaGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24NCj4+Pj4+ICAg
ICAgICAgKHFlbXUpIHF1aXQNCj4+Pj4+ICAgICAgICAgDQo+Pj4+PiAgICAgICAgLVRlc3Rpbmc6
IC1kcml2ZSBkcml2ZXI9bnVsbC1jbyxjYWNoZT1kaXJlY3RzeW5jDQo+Pj4+PiAgICAgICAgK1Rl
c3Rpbmc6IC1kcml2ZSBkcml2ZXI9bnVsbC1jbyxyZWFkLXplcm9lcz1vbixjYWNoZT1kaXJlY3Rz
eW5jDQo+Pj4+PiAgICAgICAgIFFFTVUgWC5ZLlogbW9uaXRvciAtIHR5cGUgJ2hlbHAnIGZvciBt
b3JlIGluZm9ybWF0aW9uDQo+Pj4+PiAgICAgICAgIChxZW11KSBxdWl0DQo+Pj4+PiAgICAgICAg
IA0KPj4+Pj4gICAgICAgIC1UZXN0aW5nOiAtZHJpdmUgZHJpdmVyPW51bGwtY28sY2FjaGU9d3Jp
dGViYWNrDQo+Pj4+PiAgICAgICAgK1Rlc3Rpbmc6IC1kcml2ZSBkcml2ZXI9bnVsbC1jbyxyZWFk
LXplcm9lcz1vbixjYWNoZT13cml0ZWJhY2sNCj4+Pj4+ICAgICAgICAgUUVNVSBYLlkuWiBtb25p
dG9yIC0gdHlwZSAnaGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24NCj4+Pj4+ICAgICAgICAgKHFl
bXUpIHF1aXQNCj4+Pj4+ICAgICAgICAgDQo+Pj4+PiAgICAgICAgLVRlc3Rpbmc6IC1kcml2ZSBk
cml2ZXI9bnVsbC1jbyxjYWNoZT13cml0ZXRocm91Z2gNCj4+Pj4+ICAgICAgICArVGVzdGluZzog
LWRyaXZlIGRyaXZlcj1udWxsLWNvLHJlYWQtemVyb2VzPW9uLGNhY2hlPXdyaXRldGhyb3VnaA0K
Pj4+Pj4gICAgICAgICBRRU1VIFguWS5aIG1vbml0b3IgLSB0eXBlICdoZWxwJyBmb3IgbW9yZSBp
bmZvcm1hdGlvbg0KPj4+Pj4gICAgICAgICAocWVtdSkgcXVpdA0KPj4+Pj4gICAgICAgICANCj4+
Pj4+ICAgICAgICAtVGVzdGluZzogLWRyaXZlIGRyaXZlcj1udWxsLWNvLGNhY2hlPXVuc2FmZQ0K
Pj4+Pj4gICAgICAgICtUZXN0aW5nOiAtZHJpdmUgZHJpdmVyPW51bGwtY28scmVhZC16ZXJvZXM9
b24sY2FjaGU9dW5zYWZlDQo+Pj4+PiAgICAgICAgIFFFTVUgWC5ZLlogbW9uaXRvciAtIHR5cGUg
J2hlbHAnIGZvciBtb3JlIGluZm9ybWF0aW9uDQo+Pj4+PiAgICAgICAgIChxZW11KSBxdWl0DQo+
Pj4+PiAgICAgICAgIA0KPj4+Pj4NCj4+Pj4NCj4+Pj4gVGhhbmsgeW91IENocmlzdGlhbiBmb3Ig
eW91ciByZXBvcnQuDQo+Pj4+IFdvdWxkIHlvdSBwbGVhc2Ugc2VuZCB0aGUgY29tbWFuZCBsaW5l
IHlvdSByYW4gdGhlIDA1MSB0ZXN0IHdpdGg/DQo+Pj4+DQo+Pj4+IEtldmluLA0KPj4+PiBIb3cg
ZG8gYWRkIHRoZSAwNTEub3V0IGZpbGUgdG8gdGhlIHBhdGNoPyBOZXcgdmVyc2lvbj8NCj4+Pg0K
Pj4+IE5vLCB3ZSBuZWVkIGEgZm9sbG93LXVwIHBhdGNoLiBUaGlzIG9uZSBpcyBhbHJlYWR5IG1l
cmdlZCwgc28gd2UgY2FuJ3QNCj4+PiBjaGFuZ2UgaXQgYW55IG1vcmUuDQo+Pj4NCj4+PiBLZXZp
bg0KPj4+DQo+Pg0KPj4gVGhhbmsgeW91IGFuZCBDaHJpc3RpYW4gYm90aC4NCj4+IEl0IGlzIG15
IGZpcnN0IHRpbWUgSSBoYXZlIGJlZW4gZG9pbmcgdGhlIGZpeCBwYXRjaC4NCj4+IFNob3VsZCBp
dCBiZSBuYW1lZCBhIHNwZWNpZmljIHdheSBsaWtlICJpb3Rlc3RzOiBGaXggZm9yLi4uIj8NCj4g
DQo+IFBlb3BsZSBzb21ldGltZXMgdXNlIGEgIkZpeGVzOiA8Y29tbWl0IG51bWJlcj4iIHRhZyBp
biB0aGUgYm9keSBvZiB0aGUNCj4gY29tbWl0IG1lc3NhZ2UsIHdoaWNoIGlzIHByb2JhYmx5IGEg
Z29vZCBpZGVhLiBUaGUgc3ViamVjdCBsaW5lIGp1c3QNCj4gZGVzY3JpYmVzIHRoZSBjaGFuZ2Ug
YXMgdXN1YWwuDQo+IA0KPiBLZXZpbg0KPiANCkdvdCBpdC4NClRoYW5rIHlvdS4NCkFuZHJleQ0K
LS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

