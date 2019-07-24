Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780CBC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4001D2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f4inIr/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4001D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqC9y-0006lj-CH
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hqC9j-0006B2-3q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hqC9i-0006vN-0D
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:57:47 -0400
Received: from mail-eopbgr00113.outbound.protection.outlook.com
 ([40.107.0.113]:11478 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hqC9f-0006sc-19; Wed, 24 Jul 2019 03:57:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRKstIAjryYjenJzN02pd7jmI4uBhwU2QcknoJAzsjQY8OI4q/4zVFCQT1OdbSAuyCRlxMNYNBOMnmFz30zMKw6JEdGbFm6RpT7fS06qBed/kpceH12/Py2U9tblT8+iNsmGy9jlAIE16w7r3PqDQeUuuypm6ITm4XoE/gj+y3qkuc1I0FMGh8wVgVM2AS7jVjTrEqHFoazneHK2Of5dV485P/R8zvR4p5u4UsffNvluINy4B+dHO86F7TPNMO58IFU7Ey/0rSQ+teRxn2tlkmqz6zWe6+mKv06S5sfAoDAuJRtpndXD+IC0lGZhyaclNRgEb7fXodLLUnPU0spmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGR6JT9+/H6EHOFOrAbAQvnFJNWZSSyFFhRRHJaTAPI=;
 b=AkUMp8xODdQPasvl8BBVQ7RLnjezAWFcvUkkEVw6jxrwtynO2gTRIzP/6gAxFTb/mgSKorreW7Vwo2FcMoQ7oUoW8thDx1vuMCPYlyWUaw3uhErTGYRqVfm6nVTnB5Fi29ULn42koeOOX9wKfbs4w91eqAKdzOEYJsVYxnbYDUKph5KIh+pW9LlzOhfEUzB9mhEHwhOBby8ESGwph11Vr2sJIQKWmp9zDrSBrgVkCLjMQ9KIbtEq9IML6SKuatGLqo+9vV6gKBmvKCnadsDaWieyddSmXJfleiuNedYsf6bMPQyd8wbsh4+spYPWR3YR3Le6/AWnuZbbdYH/S3V0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGR6JT9+/H6EHOFOrAbAQvnFJNWZSSyFFhRRHJaTAPI=;
 b=f4inIr/u7DjkqFu7YII2K0+fZAPy2p5cBXY24OiXMYFbdl3JWLwt23gBfpz67tN/JNtixRLTDIQEBDrHHzb20o96sGkKfWnT9I9d16yYBBLo3dZVGiGZ+rs9cgul4igBjqHhJWcA5G80txTqv9jTh1TKeiq5MbIZLkug/4LNfnk=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4143.eurprd08.prod.outlook.com (20.178.204.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 24 Jul 2019 07:57:40 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 07:57:40 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PULL 01/13] iotests: Set read-zeroes on in null
 block driver for Valgrind
Thread-Index: AQHVPjg87/EcfJJ+aUOzlBPF8UMWHKbZY6+AgAA1a4D//8/sAIAABXUA
Date: Wed, 24 Jul 2019 07:57:40 +0000
Message-ID: <6149d521-1b45-c2a0-5bcc-1c8fbe0c2381@virtuozzo.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
 <20190719134345.23526-2-kwolf@redhat.com>
 <42945b0e-8583-ba6e-16c5-2cdb7595206a@de.ibm.com>
 <351d4790-3ea3-9cd2-1c4d-6042ea35507c@virtuozzo.com>
 <20190724073805.GA4873@localhost.localdomain>
In-Reply-To: <20190724073805.GA4873@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::27) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b27e604-9e5f-425b-e42a-08d7100c99df
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4143; 
x-ms-traffictypediagnostic: VI1PR08MB4143:
x-microsoft-antispam-prvs: <VI1PR08MB4143F08711944B0D08545084F4C60@VI1PR08MB4143.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(11346002)(256004)(305945005)(31696002)(36756003)(6116002)(86362001)(316002)(81156014)(81166006)(446003)(476003)(7736002)(68736007)(8936002)(53546011)(478600001)(2616005)(26005)(3846002)(8676002)(66066001)(71200400001)(71190400001)(66476007)(31686004)(5660300002)(186003)(6506007)(54906003)(229853002)(2906002)(66556008)(66446008)(6436002)(66946007)(6512007)(386003)(102836004)(64756008)(4326008)(14454004)(6486002)(52116002)(6246003)(6916009)(53936002)(44832011)(486006)(25786009)(76176011)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4143;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybge9HV9OBLTmPj3CE9czB03L/KrNzlkg3GXQL7EMm/7eLlTdo8mbHnB1O26asT66FaKveaMhIFHX9fyXPbN2cPJvK4s61HNroumwvz8vAT7HaRX1nH7KH7QZw2muaA7D27p4XHkCsuNAo1X2PKRknuGHY6s87zLfAgZnyvTs4UasX8OKP2yJivobRs8BMvMFOIpaGzOhzpZ1nzOep40coyRHNUEQ6KBmQe2biWnVZzDaKswChCOsnuWpb/Q0xB/BLtgFA54PgaIwRAwuOxs2Ssyopq808+ISLMEpi2VctqO2Gk/wnQ6cypkCUHsIrwXY3K2Y2ijbr8LlGDooGwlc0P6IMO9KImssmBkK3WzQCIC9dSHXkb9ZqIxrlBRDsH1ucZgSMmOJJamq4WI8JLDkukszPODF/akjAq83+wYyNk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <501C1EDE3185FD4F999002B7CE14519B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b27e604-9e5f-425b-e42a-08d7100c99df
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 07:57:40.4992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4143
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.113
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

DQoNCk9uIDI0LzA3LzIwMTkgMTA6MzgsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI0LjA3LjIw
MTkgdW0gMDk6MzAgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4NCj4+DQo+
PiBPbiAyNC8wNy8yMDE5IDEwOjE4LCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6DQo+Pj4N
Cj4+PiBPbiAxOS4wNy4xOSAxNTo0MywgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4gRnJvbTogQW5k
cmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+Pj4+DQo+
Pj4+IFRoZSBWYWxncmluZCB0b29sIHJlcG9ydHMgYWJvdXQgdGhlIHVuaW5pdGlhbGlzZWQgYnVm
ZmVyICdidWYnDQo+Pj4+IGluc3RhbnRpYXRlZCBvbiB0aGUgc3RhY2sgb2YgdGhlIGZ1bmN0aW9u
IGd1ZXNzX2Rpc2tfbGNocygpLg0KPj4+PiBQYXNzICdyZWFkLXplcm9lcz1vbicgdG8gdGhlIG51
bGwgYmxvY2sgZHJpdmVyIHRvIG1ha2UgaXQgZGV0ZXJtaW5pc3RpYy4NCj4+Pj4gVGhlIG91dHB1
dCBvZiB0aGUgdGVzdHMgMDUxLCAxODYgYW5kIDIyNyBub3cgaW5jbHVkZXMgdGhlIHBhcmFtZXRl
cg0KPj4+PiAncmVhZC16ZXJvZXMnLiBTbywgdGhlIGJlbmNobWFyayBvdXRwdXQgZmlsZXMgYXJl
IGJlaW5nIGNoYW5nZWQgdG9vLg0KPj4+Pg0KPj4+PiBTdWdnZXN0ZWQtYnk6IEtldmluIFdvbGYg
PGt3b2xmQHJlZGhhdC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNo
IDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBL
ZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgdGVzdHMvcWVt
dS1pb3Rlc3RzLzA1MSAgICAgICAgfCAgMTAgKy0tDQo+Pj4+ICAgIHRlc3RzL3FlbXUtaW90ZXN0
cy8wNTEucGMub3V0IHwgIDEwICstLQ0KPj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMDkzICAg
ICAgICB8ICAgOSArLQ0KPj4+IFsuLi45DQo+Pj4NCj4+Pg0KPj4+IEkgbm93IGdldCB0aGUgZm9s
bG93aW5nIG9uIHMzOTAuDQo+Pj4gU2VlbXMgdGhhdCB5b3Ugb25seSBmaXhlZCAwNTEucGMub3V0
IGJ1dCBub3QgMDUxLm91dA0KPj4+DQo+Pj4gICAgICAgMDUxICAgICAgLi4uICAgICAgICBbMDk6
MDE6NDldICAgICAgICAgICAgIC4uLiAgICAgICAgICAgICAgMDUxICAgICAgG1sxbRtbMzFtZmFp
bCAgICAgIBtbMG0gWzA5OjAxOjQ5XSBbMDk6MDE6NTBdICAgICAgICAgICAgICAgICAgICBvdXRw
dXQgbWlzbWF0Y2ggKHNlZSAwNTEub3V0LmJhZCkNCj4+PiAgICAgICAtLS0gdGVzdHMvcWVtdS1p
b3Rlc3RzLzA1MS5vdXQJMjAxOS0wNy0wOSAxODozNDoyNi43MzQ2NTQ5MzMgKzAyMDANCj4+PiAg
ICAgICArKysgYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MS5vdXQuYmFkCTIwMTktMDctMjQg
MDk6MDE6NTAuMDE1MDI0OTAxICswMjAwDQo+Pj4gICAgICAgQEAgLTE0OSwyMyArMTQ5LDIzIEBA
DQo+Pj4gICAgICAgIA0KPj4+ICAgICAgICA9PT0gQ2FjaGUgbW9kZXMgPT09DQo+Pj4gICAgICAg
IA0KPj4+ICAgICAgIC1UZXN0aW5nOiAtZHJpdmUgZHJpdmVyPW51bGwtY28sY2FjaGU9bm9uZQ0K
Pj4+ICAgICAgICtUZXN0aW5nOiAtZHJpdmUgZHJpdmVyPW51bGwtY28scmVhZC16ZXJvZXM9b24s
Y2FjaGU9bm9uZQ0KPj4+ICAgICAgICBRRU1VIFguWS5aIG1vbml0b3IgLSB0eXBlICdoZWxwJyBm
b3IgbW9yZSBpbmZvcm1hdGlvbg0KPj4+ICAgICAgICAocWVtdSkgcXVpdA0KPj4+ICAgICAgICAN
Cj4+PiAgICAgICAtVGVzdGluZzogLWRyaXZlIGRyaXZlcj1udWxsLWNvLGNhY2hlPWRpcmVjdHN5
bmMNCj4+PiAgICAgICArVGVzdGluZzogLWRyaXZlIGRyaXZlcj1udWxsLWNvLHJlYWQtemVyb2Vz
PW9uLGNhY2hlPWRpcmVjdHN5bmMNCj4+PiAgICAgICAgUUVNVSBYLlkuWiBtb25pdG9yIC0gdHlw
ZSAnaGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24NCj4+PiAgICAgICAgKHFlbXUpIHF1aXQNCj4+
PiAgICAgICAgDQo+Pj4gICAgICAgLVRlc3Rpbmc6IC1kcml2ZSBkcml2ZXI9bnVsbC1jbyxjYWNo
ZT13cml0ZWJhY2sNCj4+PiAgICAgICArVGVzdGluZzogLWRyaXZlIGRyaXZlcj1udWxsLWNvLHJl
YWQtemVyb2VzPW9uLGNhY2hlPXdyaXRlYmFjaw0KPj4+ICAgICAgICBRRU1VIFguWS5aIG1vbml0
b3IgLSB0eXBlICdoZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbg0KPj4+ICAgICAgICAocWVtdSkg
cXVpdA0KPj4+ICAgICAgICANCj4+PiAgICAgICAtVGVzdGluZzogLWRyaXZlIGRyaXZlcj1udWxs
LWNvLGNhY2hlPXdyaXRldGhyb3VnaA0KPj4+ICAgICAgICtUZXN0aW5nOiAtZHJpdmUgZHJpdmVy
PW51bGwtY28scmVhZC16ZXJvZXM9b24sY2FjaGU9d3JpdGV0aHJvdWdoDQo+Pj4gICAgICAgIFFF
TVUgWC5ZLlogbW9uaXRvciAtIHR5cGUgJ2hlbHAnIGZvciBtb3JlIGluZm9ybWF0aW9uDQo+Pj4g
ICAgICAgIChxZW11KSBxdWl0DQo+Pj4gICAgICAgIA0KPj4+ICAgICAgIC1UZXN0aW5nOiAtZHJp
dmUgZHJpdmVyPW51bGwtY28sY2FjaGU9dW5zYWZlDQo+Pj4gICAgICAgK1Rlc3Rpbmc6IC1kcml2
ZSBkcml2ZXI9bnVsbC1jbyxyZWFkLXplcm9lcz1vbixjYWNoZT11bnNhZmUNCj4+PiAgICAgICAg
UUVNVSBYLlkuWiBtb25pdG9yIC0gdHlwZSAnaGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24NCj4+
PiAgICAgICAgKHFlbXUpIHF1aXQNCj4+PiAgICAgICAgDQo+Pj4NCj4+DQo+PiBUaGFuayB5b3Ug
Q2hyaXN0aWFuIGZvciB5b3VyIHJlcG9ydC4NCj4+IFdvdWxkIHlvdSBwbGVhc2Ugc2VuZCB0aGUg
Y29tbWFuZCBsaW5lIHlvdSByYW4gdGhlIDA1MSB0ZXN0IHdpdGg/DQo+Pg0KPj4gS2V2aW4sDQo+
PiBIb3cgZG8gYWRkIHRoZSAwNTEub3V0IGZpbGUgdG8gdGhlIHBhdGNoPyBOZXcgdmVyc2lvbj8N
Cj4gDQo+IE5vLCB3ZSBuZWVkIGEgZm9sbG93LXVwIHBhdGNoLiBUaGlzIG9uZSBpcyBhbHJlYWR5
IG1lcmdlZCwgc28gd2UgY2FuJ3QNCj4gY2hhbmdlIGl0IGFueSBtb3JlLg0KPiANCj4gS2V2aW4N
Cj4gDQoNClRoYW5rIHlvdSBhbmQgQ2hyaXN0aWFuIGJvdGguDQpJdCBpcyBteSBmaXJzdCB0aW1l
IEkgaGF2ZSBiZWVuIGRvaW5nIHRoZSBmaXggcGF0Y2guDQpTaG91bGQgaXQgYmUgbmFtZWQgYSBz
cGVjaWZpYyB3YXkgbGlrZSAiaW90ZXN0czogRml4IGZvci4uLiI/DQoNCkFuZHJleQ0KLS0gDQpX
aXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

