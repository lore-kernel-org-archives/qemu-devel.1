Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47AF2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YfvHw/wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47AF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0j6-0006NK-Tx
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iP0hx-0004eH-Si
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iP0hv-00085o-FM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:49:01 -0400
Received: from mail-eopbgr40124.outbound.protection.outlook.com
 ([40.107.4.124]:43494 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iP0hq-00082b-EG; Mon, 28 Oct 2019 04:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va35n4uHjemYLwF1Zwb3vGHl9ast+PrwDzjIKvJpw7GkMA76uF+RyhpnfEgyk3XhfGCumKz/2j+FgSeyTI7JFASaqKMTMkSvj0obwR9MCFMIBwuekLf9NyVr8WiUaupOQRxQpsOph9+3rWw3jZE3mnEg2cTT7NiOasmS0K4M5bnmVUWxsF873yftrVgsgZd16phbRnprSxOOZyFvwjI+cIN7c1oOtmw1OCzEt28jGQyv/qRRnlNNkLGBAkNJzULN8HsD7urjznuWViqDuSR5DBGP+jE2oHc3qc2m2R96/56el0ADepvDGBkqKo6bJ7oxkLzp33Kdz5+k0ozZMgaTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPeySbmKC2TnGsYcdtb56mbbVYlEc8aMadIGaUctdmk=;
 b=IYc6PLN0qpcThMVvEmD+dMtQLnbjteYzLYxspUdwXg/0YkKaKIh9/FDDVsGb1c0ca6+My0oNKNyeNGRWZ7El3VMExuxwUqAK7u+OJJvA4GHY3HUXEukHH4gT0Hnm/OiUx3TIvLgmJEeHAIpuMTkUHIWklZ+tvWNfah6xvT+0L5wTFLCaKwsGJ3+QTENkcAtciULRcgdleyGA2BQKoBKjJFNIABYCmgmS3+ZT2GlO666Im+1+G4lTpbqKLSJo1xI5GKcy+1I3U+XZEKwiOg9o5o/suJ+8O6+pFB4FstE+t7b/6ytTK9ul9LQ1fiB8GRXjqRm+UTGJKtHQt4C1AZx8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPeySbmKC2TnGsYcdtb56mbbVYlEc8aMadIGaUctdmk=;
 b=YfvHw/wdEtmU4svfeR0DsLO24KNprbe+Y9KqHf+qkdvAblPPACjS4i/tdcO9yHw2INWK2VPAZHUGTm44rah1ZWayTTp/0F8fSAMgKn6vDWq7fWAv46L18NiZsfbKP7E49y8apCsicF81JMi1wpv5MQSsvnwmyAHgPKUT4hnmNXE=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2759.eurprd08.prod.outlook.com (10.170.222.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 08:48:52 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 08:48:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] iotests: Test nbd client reconnect
Thread-Topic: [PATCH] iotests: Test nbd client reconnect
Thread-Index: AQHVjNWt0TAMGNw3iEi7A8SFdwW3mqdvv1yA
Date: Mon, 28 Oct 2019 08:48:51 +0000
Message-ID: <f6677fb5-d4fd-f29b-27cd-6b58cdd14bc5@virtuozzo.com>
References: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::35) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f2a80e4-7679-44a7-f969-08d75b83a826
x-ms-traffictypediagnostic: DB6PR08MB2759:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB27597FC61B64046900C27EC4F4660@DB6PR08MB2759.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39840400004)(189003)(199004)(6486002)(6116002)(6246003)(3846002)(102836004)(76176011)(256004)(52116002)(71190400001)(229853002)(71200400001)(14454004)(6506007)(31686004)(486006)(305945005)(31696002)(2906002)(99286004)(186003)(446003)(11346002)(86362001)(7736002)(53546011)(107886003)(2616005)(476003)(4326008)(64756008)(5660300002)(66556008)(66476007)(36756003)(66446008)(6436002)(66946007)(386003)(26005)(66066001)(81166006)(81156014)(8936002)(8676002)(25786009)(110136005)(316002)(54906003)(478600001)(6512007)(2501003)(44832011)(6306002)(2004002)(33290500001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2759;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Nko9p9lpxvUhCi6RaGunDA1mSTzniacY4tiMTL800U1/nc58+m9fPqAgmclQtFtT6rH9/YG4cFfnKypChohrUcUblNwYbfWimy1C3eP5N3o4lnCkQ4POJQ52fY0k/NvWKF3l6uirxvuem/eGGv3N5kr2FIQfC/2mQQMBjaPrS3GJQ39j6gkG9y3W64a5WdJLVbM/Mg6+HfZtxC6usEsxqaRqrP4ifuElPWHy7Nnd6jZ4snHCOlnrEbV4yWXpXrW9oNr6o9I1qimprftaWFp/IpyLy3taMdwafLUxgCFwhdphpc4GZvIXZ64fOrxcxJu6kllVolwJudl2ICc0UtnaoWRIp1cuBe1mqRmkdGZveNARH12sjHx00878URVEZKTqTPFoNMhsNHkElgS13nbya7EsKtL9YIPYRacqb3eLeTREVqs2Dx88G2yfQhw20kliuX/7aBbaeZ9Qub+LL4n+6AwTP4/ZYjRIj+krowPOpA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F016C46AF9DC08459DBE747548981E94@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2a80e4-7679-44a7-f969-08d75b83a826
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:48:51.8732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmTQNkqpP+gwtTy5sPU15liV0wuPpmz50iT4sYxk7aVy7cC280Lm/L7OYSI1p8d6zOHRS+sCuKv0lOKaKMi5smQXRY42JR/YlzVCuaYEyjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2759
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.124
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzEwLzIwMTkgMTc6NDgsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPiBUaGUg
c3RyZXNzIHRlc3QgZm9yIGFuIE5CRCBjbGllbnQuIFRoZSBOQkQgc2VydmVyIGlzIGRpc2Nvbm5l
Y3RlZCBhZnRlcg0KPiBhIGNsaWVudCB3cml0ZSBvcGVyYXRpb24uIFRoZSBOQkQgY2xpZW50IHNo
b3VsZCByZWNvbm5lY3QgYW5kIHJldHJ5IHRoZQ0KPiBvcGVyYXRpb24uDQo+IA0KPiBTdWdnZXN0
ZWQtYnk6IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4gU2lnbmVkLW9mZi1ieTog
QW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IC0t
LQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNzcgICAgIHwgOTEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNzcu
b3V0IHwgIDcgKysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDEgKw0KPiAg
IDMgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjc3DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Fl
bXUtaW90ZXN0cy8yNzcub3V0DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI3NyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNzcNCj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4g
aW5kZXggMDAwMDAwMC4uNDZhMjliNw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8yNzcNCj4gQEAgLTAsMCArMSw5MSBAQA0KPiArIyEvdXNyL2Jpbi9lbnYgcHl0
aG9uDQo+ICsjDQo+ICsjIFRlc3QgbmJkIGNsaWVudCByZWNvbm5lY3QNCj4gKyMNCj4gKyMgQ29w
eXJpZ2h0IChjKSAyMDE5IFZpcnR1b3p6byBJbnRlcm5hdGlvbmFsIEdtYkgNCj4gKyMNCj4gKyMg
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFu
ZC9vciBtb2RpZnkNCj4gKyMgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCj4gKyMgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3INCj4gKyMgKGF0IHlv
dXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4gKyMNCj4gKyMgVGhpcyBwcm9ncmFtIGlz
IGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+ICsjIGJ1
dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5
IG9mDQo+ICsjIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVS
UE9TRS4gIFNlZSB0aGUNCj4gKyMgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4NCj4gKyMNCj4gKyMgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UNCj4gKyMgYWxvbmcgd2l0aCB0aGlzIHByb2dy
YW0uICBJZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+ICsjDQo+
ICsNCj4gK2ltcG9ydCBvcw0KPiAraW1wb3J0IHN5cw0KPiAraW1wb3J0IGlvDQo+ICtpbXBvcnQg
c3VicHJvY2Vzcw0KPiAraW1wb3J0IGlvdGVzdHMNCj4gK2Zyb20gaW90ZXN0cyBpbXBvcnQgZmls
ZV9wYXRoLCBsb2cNCj4gKw0KPiArDQo+ICtkZWYgc3RhcnRfc2VydmVyX05CRChuYmRfc29jaywg
Y29uZl9maWxlKToNCj4gKyAgICBzcnYgPSBzdWJwcm9jZXNzLlBvcGVuKFsibmJkLWZhdWx0LWlu
amVjdG9yLnB5IiwgIi0tY2xhc3NpYy1uZWdvdGlhdGlvbiIsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICBuYmRfc29jaywgY29uZl9maWxlXSwgc3Rkb3V0PXN1YnByb2Nlc3MuUElQRSwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0ZGVycj1zdWJwcm9jZXNzLlNURE9VVCwg
dW5pdmVyc2FsX25ld2xpbmVzPVRydWUpDQo+ICsgICAgbGluZSA9IHNydi5zdGRvdXQucmVhZGxp
bmUoKQ0KPiArICAgIGlmICJMaXN0ZW5pbmcgb24gIiBpbiBsaW5lOg0KPiArICAgICAgICBsb2co
J05CRCBzZXJ2ZXI6IHN0YXJ0ZWQnKQ0KPiArICAgIGVsc2U6DQo+ICsgICAgICAgIGxvZygnTkJE
IHNlcnZlcjoge30nLmZvcm1hdChsaW5lLnJzdHJpcCgpKSkNCj4gKw0KPiArICAgIHJldHVybiBz
cnYNCj4gKw0KPiArDQo+ICtkZWYgY2hlY2tfc2VydmVyX05CRChzcnYpOg0KPiArICAgIGV4aXRj
b2RlID0gc3J2LndhaXQodGltZW91dD0xMCkNCj4gKw0KPiArICAgIGlmIGV4aXRjb2RlIDwgMDoN
Cj4gKyAgICAgICAgc3lzLnN0ZGVyci53cml0ZSgnTkJEIHNlcnZlcjogRVJST1IgJWlcbicgJSAo
LWV4aXRjb2RlKSkNCj4gKyAgICAgICAgbG9nKHNydi5jb21tdW5pY2F0ZSgpWzBdKQ0KPiArICAg
IGVsc2U6DQo+ICsgICAgICAgIGxpbmUgPSBzcnYuc3Rkb3V0LnJlYWRsaW5lKCkNCj4gKyAgICAg
ICAgbG9nKCdOQkQgc2VydmVyOiAnICsgbGluZS5yc3RyaXAoKSkNCj4gKw0KPiArICAgIG9zLnJl
bW92ZShuYmRfc29jaykNCj4gKyAgICBvcy5yZW1vdmUoY29uZl9maWxlKQ0KPiArDQo+ICsNCj4g
K2RlZiBtYWtlX2NvbmZfZmlsZShjb25mX2ZpbGUsIGV2ZW50KToNCj4gKyAgICBpZiBvcy5wYXRo
LmV4aXN0cyhjb25mX2ZpbGUpOg0KPiArICAgICAgICBvcy5yZW1vdmUoY29uZl9maWxlKQ0KPiAr
DQo+ICsgICAgd2l0aCBvcGVuKGNvbmZfZmlsZSwgIncrIikgYXMgY29uZmY6DQo+ICsgICAgICAg
IGNvbmZmLndyaXRlKCJbaW5qZWN0LWVycm9yXVxuZXZlbnQ9e31cbndoZW49YWZ0ZXIiLmZvcm1h
dChldmVudCkpDQo+ICsNCj4gKw0KPiArZGlzaywgbmJkX3NvY2sgPSBmaWxlX3BhdGgoJ2Rpc2sn
LCAnbmJkLXNvY2snKQ0KDQpUaGUgJ2Rpc2snIGlzIGdvaW5nIHRvIGJlIHJlbW9vdmVkIGFzIGEg
Y29uc3RydWN0aW9uIHdhc3RlLg0KDQo+ICtuYmRfdXJpID0gJ25iZCt1bml4Oi8vLz9zb2NrZXQ9
JyArIG5iZF9zb2NrDQo+ICtpZiBvcy5wYXRoLmV4aXN0cyhuYmRfc29jayk6DQo+ICsgICAgb3Mu
cmVtb3ZlKG5iZF9zb2NrKQ0KPiArDQo+ICtjb25mX2ZpbGUgPSBvcy5wYXRoLmpvaW4oaW90ZXN0
cy50ZXN0X2RpciwgIm5iZC1mYXVsdC1pbmplY3Rvci5jb25mIikNCj4gK21ha2VfY29uZl9maWxl
KGNvbmZfZmlsZSwgImRhdGEiKQ0KPiArc3J2ID0gc3RhcnRfc2VydmVyX05CRChuYmRfc29jaywg
Y29uZl9maWxlKQ0KPiArDQo+ICtsb2coJ05CRCBjbGllbnQ6IFFFTVUtSU8gd3JpdGUnKQ0KPiAr
YXJncyA9IGlvdGVzdHMucWVtdV9pb19hcmdzICsgWyctZicsICdyYXcnLCAnLWMnLCAnd3JpdGUg
LVAgMHg3IDAgM00nLCBuYmRfdXJpXQ0KPiArY2x0ID0gc3VicHJvY2Vzcy5Qb3BlbihhcmdzLCBz
dGRvdXQ9c3VicHJvY2Vzcy5QSVBFLCBzdGRlcnI9c3VicHJvY2Vzcy5TVERPVVQpDQo+ICsNCj4g
K2NoZWNrX3NlcnZlcl9OQkQoc3J2KQ0KPiArDQo+ICttYWtlX2NvbmZfZmlsZShjb25mX2ZpbGUs
ICJyZXBseSIpDQo+ICtzcnYgPSBzdGFydF9zZXJ2ZXJfTkJEKG5iZF9zb2NrLCBjb25mX2ZpbGUp
DQo+ICsNCj4gK2V4aXRjb2RlID0gY2x0LndhaXQodGltZW91dD0xMCkNCj4gK2lmIGV4aXRjb2Rl
IDwgMDoNCj4gKyAgICBzeXMuc3RkZXJyLndyaXRlKCdxZW11LWlvIHJlY2VpdmVkIHNpZ25hbCAl
aTogJXNcbicgJQ0KPiArICAgICAgICAgICAgICAgICAgICAgKC1leGl0Y29kZSwgJyAnLmpvaW4o
YXJncykpKQ0KPiArDQo+ICtmb3IgbGluZSBpbiBpby5UZXh0SU9XcmFwcGVyKGNsdC5zdGRvdXQs
IGVuY29kaW5nPSJ1dGYtOCIpOg0KPiArICAgIGlmICIzIE1pQiIgbm90IGluIGxpbmU6DQo+ICsg
ICAgICAgIGxvZygnTkJEIGNsaWVudDogJyArIGxpbmUucnN0cmlwKCkpDQo+ICsNCj4gK2NoZWNr
X3NlcnZlcl9OQkQoc3J2KQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI3Ny5v
dXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjc3Lm91dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiBpbmRleCAwMDAwMDAwLi4wN2U2ZTgyDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMv
cWVtdS1pb3Rlc3RzLzI3Ny5vdXQNCj4gQEAgLTAsMCArMSw3IEBADQo+ICtOQkQgc2VydmVyOiBz
dGFydGVkDQo+ICtOQkQgY2xpZW50OiBRRU1VLUlPIHdyaXRlDQo+ICtOQkQgc2VydmVyOiBDbG9z
aW5nIGNvbm5lY3Rpb24gb24gcnVsZSBtYXRjaCBpbmplY3QtZXJyb3INCj4gK05CRCBzZXJ2ZXI6
IHN0YXJ0ZWQNCj4gK05CRCBjbGllbnQ6IENvbm5lY3Rpb24gY2xvc2VkDQo+ICtOQkQgY2xpZW50
OiB3cm90ZSAzMTQ1NzI4LzMxNDU3MjggYnl0ZXMgYXQgb2Zmc2V0IDANCj4gK05CRCBzZXJ2ZXI6
IENsb3NpbmcgY29ubmVjdGlvbiBvbiBydWxlIG1hdGNoIGluamVjdC1lcnJvcg0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3Vw
DQo+IGluZGV4IGFmMzIyYWYuLjIyZWYxYjggMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy9ncm91cA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXANCj4gQEAgLTI4Miwz
ICsyODIsNCBAQA0KPiAgIDI2NyBydyBhdXRvIHF1aWNrIHNuYXBzaG90DQo+ICAgMjY4IHJ3IGF1
dG8gcXVpY2sNCj4gICAyNzAgcncgYmFja2luZyBxdWljaw0KPiArMjc3IHJ3DQo+IA0KDQotLSAN
CldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

