Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28DCA9EBB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AFB21928
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aqo1sdet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AFB21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCXo-00070X-Iq
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 05:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNC53-0005u5-Vt
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNC4z-0002mP-Cd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:33:21 -0400
Received: from mail-eopbgr00117.outbound.protection.outlook.com
 ([40.107.0.117]:20960 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNC4v-0002aw-Ku; Wed, 23 Oct 2019 04:33:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiZOw/+TcJneRrILbjggSdcTYMjGgeBUiDEE0COmnnbk9MKrqj5BVJVNNCj1rYFw3xZxhAouoY23CCVI8RFSG34Cn8ahDUUbGyScGzhHrTMiTzDlAdaCDEjmxjZSFxycFDW5W5lTw30zLB89obpAVX/o1FlllNCA0Qr/lfKLfTn1Wwwk+u+wGX5+guLqpPe6e9dhHV9BaRcvhzK7I+v6zA4JhOV86OqhyQrAh/xl14LhL7mn6KUZ456HvubmkFEYxGgg2g17tt6YyULf2yAMjD+U+RNRedgNUNEX2hzWQhMmd+Chilf/JIy8yHi9gXCUvcceGgt55XVW4xN00Vmonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMn0tRrjvgiZxTzgeU1VDKzH+6qopEfgzoEKa+Gc/ZA=;
 b=UzcTyj2sjP+oaKaG4Y740xCi0WxNuDpw7/rQqky/MuSTm+yU4NSaSwecnplr8Y10PFsgX146T8mgFOW/eL/X7I6ReBqN9vRpU1zDVaBN39Ib9zN6nXOh74tJhBu0GAlkJG9MzP2ULCOLkOBeFOAgTcPPLYSHvAAvu5uv3zERbBm+iFL3fxolMsuuk4qS3ohvQyHKG3plMTlev1rBJNmwdwq56nkLCFralKnDDWMkb7MJJ4sNB40VLUuqIEeI52t3V+drXR4Dye9XSXW3Pf/DvVIMamqC9d/ZZQpFifu4d9Rke+cn9zwznq0HVzK5095ii556OulgeqbYoWovYHb9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMn0tRrjvgiZxTzgeU1VDKzH+6qopEfgzoEKa+Gc/ZA=;
 b=aqo1sdetv2Yi0iBJNI2iWZLMZwR3SmSKAKdeeEB6loQmFdxmdrnM/Cg24rTLvQsdOZ21DEksaZfIpqdBXWl1bLtdr9p5AOIED67V+/pideVISpm+oJGgZxRikxwRkqVVvZ0qJgIYjFVgjPLG/pJrW37tcHTWP+FSBHvayZ1lQQ0=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3281.eurprd08.prod.outlook.com (52.134.94.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 08:33:05 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 08:33:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v10 3/3] iotests: test nbd reconnect
Thread-Topic: [PATCH v10 3/3] iotests: test nbd reconnect
Thread-Index: AQHVfn1tkY25C7hQq0KKMe63jIFNNKdnhiGAgAB13IA=
Date: Wed, 23 Oct 2019 08:33:05 +0000
Message-ID: <45ff7437-6b8a-c430-5a19-06ccd9742f5e@virtuozzo.com>
References: <20191009084158.15614-1-vsementsov@virtuozzo.com>
 <20191009084158.15614-4-vsementsov@virtuozzo.com>
 <0c87e5cd-cddf-b91a-3cca-fa3af9799d2b@redhat.com>
In-Reply-To: <0c87e5cd-cddf-b91a-3cca-fa3af9799d2b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191023113302968
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56374459-bd3e-40a1-93ea-08d757939fd6
x-ms-traffictypediagnostic: AM0PR08MB3281:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3281104540B5C39C7D520E84C16B0@AM0PR08MB3281.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39840400004)(136003)(366004)(376002)(199004)(189003)(6506007)(6512007)(64756008)(478600001)(66556008)(66476007)(66946007)(2906002)(6306002)(26005)(66446008)(256004)(14444005)(6116002)(3846002)(71190400001)(36756003)(25786009)(76176011)(52116002)(71200400001)(99286004)(2501003)(53546011)(229853002)(102836004)(6436002)(6486002)(386003)(14454004)(966005)(86362001)(186003)(31686004)(8936002)(316002)(31696002)(81166006)(81156014)(8676002)(5660300002)(476003)(2616005)(4326008)(54906003)(66066001)(486006)(305945005)(6246003)(7736002)(11346002)(446003)(107886003)(110136005)(33290500001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3281;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0t/u8QqSminaMNpCTrbU9XrlGS2wRQQ58D/yQTwPGuh5509qtGrvFE0Hv4xQsr6v/bTFT95+yYX3CpuKI0dOMnndJmS3zExzNmip4+/YNM+kGbg08EOYNs/VYiWt8G/y43/YjdWS8eGhYZBCEY3SQPOW0gF0wWFg8U1V3oVyKTcxpK4wuc8MPido1wnpQrLWJX9ov12/S/1fnysLXBBXRljd5daHfZUDrOXADRv+hGlcs+fjLeWLOc/iDvaRA8u6/wKVjkVjoItiXQAEAFpsDq68dPw+4XZX/wm05SyM/HEtyR8HPgxUEQJi/CHqQaYG6qrCrVcmiuVOpCwx7ruVush0gDhZzv+lN6XTwgkNe4D6e2BbOlZFYi9InOYUCCIBF1JPNdeYmnsL79AWigdKyabMPp/N3+mqpxmiM79+xqTrRke3PlDaM0rrXH4Te7KGwWsJdcgnqlvODF8HzkIWZaNCV9TfkbhpI/681lg33Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1290A26AE6E111469F49F636CC11F333@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56374459-bd3e-40a1-93ea-08d757939fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 08:33:05.1472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTZI5t6HikOO7QtvIyo0u4ert0hoChZhd70ZWyl5dsqlDA5w2GDeQIuxmQuoOwKp/X7mx5A0d8GbwHqF2Zr2JFs4eWnoMACFDzBXWa3QAHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3281
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.117
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMTAuMjAxOSA0OjMxLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiAxMC85LzE5IDM6NDEgQU0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBBZGQgdGVzdCwgd2hpY2gg
c3RhcnRzIGJhY2t1cCB0byBuYmQgdGFyZ2V0IGFuZCByZXN0YXJ0cyBuYmQgc2VydmVyDQo+PiBk
dXJpbmcgYmFja3VwLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gwqAgdGVzdHMv
cWVtdS1pb3Rlc3RzLzI2NMKgwqDCoMKgwqDCoMKgIHwgOTUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjQub3V0wqDCoMKgIHwg
MTMgKysrKysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cMKgwqDCoMKgwqAgfMKgIDEg
Kw0KPj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfCAxMSArKysrDQo+PiDCoCA0
IGZpbGVzIGNoYW5nZWQsIDEyMCBpbnNlcnRpb25zKCspDQo+PiDCoCBjcmVhdGUgbW9kZSAxMDA3
NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2NA0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3FlbXUtaW90ZXN0cy8yNjQub3V0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy8yNjQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjY0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDc1
NQ0KPj4gaW5kZXggMDAwMDAwMDAwMC4uYzhjZDk3YWUyYg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4g
KysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2NA0KPiANCj4+ICtpbXBvcnQgaW90ZXN0cw0KPj4g
K2Zyb20gaW90ZXN0cyBpbXBvcnQgcWVtdV9pbWdfY3JlYXRlLCBxZW11X2lvX3NpbGVudF9jaGVj
aywgZmlsZV9wYXRoLCBcDQo+PiArwqDCoMKgwqDCoMKgwqAgcWVtdV9uYmRfcG9wZW4sIGxvZw0K
Pj4gKw0KPj4gK2Rpc2tfYSwgZGlza19iLCBuYmRfc29jayA9IGZpbGVfcGF0aCgnZGlza19hJywg
J2Rpc2tfYicsICduYmQtc29jaycpDQo+PiArbmJkX3VyaSA9ICduYmQrdW5peDovLy8/c29ja2V0
PScgKyBuYmRfc29jaw0KPiANCj4gTmVlZHMgcmViYXNpbmcgb24gdG9wIG9mIE1heCdzIHBhdGNo
ZXMgdG8gc3RpY2sgc29ja2V0cyBpbiBTT0NLX0RJUjoNCj4gDQo+IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTEwL21zZzA0MjAxLmh0bWwNCj4gDQo+
IFtvciwgaWYgbXkgcHVsbCByZXF1ZXN0IGxhbmRzIGZpcnN0LCBNYXggbmVlZHMgdG8gYWRkIHRo
aXMgb25lIHRvIHRoZSBsaXN0IG9mIGFmZmVjdGVkIHRlc3RzLi4uXQ0KPiANCj4gDQo+PiArdm0u
cW1wX2xvZygnYmxvY2tkZXYtYWRkJywgZmlsdGVycz1baW90ZXN0cy5maWx0ZXJfcW1wX3Rlc3Rm
aWxlc10sDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgKip7J25vZGVfbmFtZSc6ICdiYWNrdXAw
JywNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnZHJpdmVyJzogJ3JhdycsDQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ2ZpbGUnOiB7J2RyaXZlcic6ICduYmQnLA0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdzZXJ2ZXInOiB7
J3R5cGUnOiAndW5peCcsICdwYXRoJzogbmJkX3NvY2t9LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdyZWNvbm5lY3QtZGVsYXknOiAxMH19KQ0KPj4g
K3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWJhY2t1cCcsIGRldmljZT0nZHJpdmUwJywgc3luYz0nZnVs
bCcsIHRhcmdldD0nYmFja3VwMCcsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BlZWQ9KDEg
KiAxMDI0ICogMTAyNCkpDQo+IA0KPiBUaGlzIHN0YXJ0cyB0aGUgam9iIHRocm90dGxlZCwgdG8g
Z2l2ZSB1cyB0aW1lLi4uDQo+IA0KPj4gKw0KPj4gKyMgV2FpdCBmb3Igc29tZSBwcm9ncmVzcw0K
Pj4gK3QgPSAwDQo+PiArd2hpbGUgdCA8IHdhaXRfbGltaXQ6DQo+PiArwqDCoMKgIGpvYnMgPSB2
bS5xbXAoJ3F1ZXJ5LWJsb2NrLWpvYnMnKVsncmV0dXJuJ10NCj4+ICvCoMKgwqAgaWYgam9icyBh
bmQgam9ic1swXVsnb2Zmc2V0J10gPiAwOg0KPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrDQo+PiAr
wqDCoMKgIHRpbWUuc2xlZXAod2FpdF9zdGVwKQ0KPj4gK8KgwqDCoCB0ICs9IHdhaXRfc3RlcA0K
Pj4gKw0KPj4gK2lmIGpvYnMgYW5kIGpvYnNbMF1bJ29mZnNldCddID4gMDoNCj4+ICvCoMKgwqAg
bG9nKCdCYWNrdXAgam9iIGlzIHN0YXJ0ZWQnKQ0KPj4gKw0KPj4gK2xvZygnS2lsbCBOQkQgc2Vy
dmVyJykNCj4+ICtzcnYua2lsbCgpDQo+PiArc3J2LndhaXQoKQ0KPj4gKw0KPj4gK2pvYnMgPSB2
bS5xbXAoJ3F1ZXJ5LWJsb2NrLWpvYnMnKVsncmV0dXJuJ10NCj4+ICtpZiBqb2JzIGFuZCBqb2Jz
WzBdWydvZmZzZXQnXSA8IGpvYnNbMF1bJ2xlbiddOg0KPj4gK8KgwqDCoCBsb2coJ0JhY2t1cCBq
b2IgaXMgc3RpbGwgaW4gcHJvZ3Jlc3MnKQ0KPj4gKw0KPj4gK3ZtLnFtcF9sb2coJ2Jsb2NrLWpv
Yi1zZXQtc3BlZWQnLCBkZXZpY2U9J2RyaXZlMCcsIHNwZWVkPTApDQo+PiArDQo+PiArIyBFbXVs
YXRlIHNlcnZlciBkb3duIHRpbWUgZm9yIDEgc2Vjb25kDQo+PiArdGltZS5zbGVlcCgxKQ0KPiAN
Cj4gLi4uYnV0IG9uY2Ugd2UgcmVzdGFydCwuLi4NCj4gDQo+PiArDQo+PiArbG9nKCdTdGFydCBO
QkQgc2VydmVyJykNCj4+ICtzcnYgPSBxZW11X25iZF9wb3BlbignLWsnLCBuYmRfc29jaywgJy1m
JywgaW90ZXN0cy5pbWdmbXQsIGRpc2tfYikNCj4+ICsNCj4+ICtlID0gdm0uZXZlbnRfd2FpdCgn
QkxPQ0tfSk9CX0NPTVBMRVRFRCcpDQo+IA0KPiAuLi5zaG91bGQgd2UgdW50aHJvdHRsZSB0aGUg
am9iIHRvIGFsbG93IHRoZSB0ZXN0IHRvIGNvbXBsZXRlIHNsaWdodGx5IGZhc3RlciBhZnRlciB0
aGUgcmVjb25uZWN0P8KgIEJ1dCB0aGF0IGNhbiBiZSBkb25lIGFzIGFuIGltcHJvdmVtZW50IG9u
IHRvcCwgaWYgaXQgaGVscHMuDQoNCkl0IGlzIGRvbmUgYWJvdmUsIGJlZm9yZSB0aW1lLnNsZWVw
KDEpDQoNCj4gDQo+IA0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+
IEBAIC0xNjUsNiArMTY1LDEzIEBAIGRlZiBxZW11X2lvX3NpbGVudCgqYXJncyk6DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgtZXhpdGNv
ZGUsICcgJy5qb2luKGFyZ3MpKSkNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIGV4aXRjb2RlDQo+PiAr
ZGVmIHFlbXVfaW9fc2lsZW50X2NoZWNrKCphcmdzKToNCj4+ICvCoMKgwqAgJycnUnVuIHFlbXUt
aW8gYW5kIHJldHVybiB0aGUgdHJ1ZSBpZiBzdWJwcm9jZXNzIHJldHVybmVkIDAnJycNCj4+ICvC
oMKgwqAgYXJncyA9IHFlbXVfaW9fYXJncyArIGxpc3QoYXJncykNCj4+ICvCoMKgwqAgZXhpdGNv
ZGUgPSBzdWJwcm9jZXNzLmNhbGwoYXJncywgc3Rkb3V0PW9wZW4oJy9kZXYvbnVsbCcsICd3Jyks
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0ZGVycj1zdWJwcm9jZXNzLlNURE9VVCkNCj4gDQo+IFRoaXMgZGlzY2FyZHMg
dGhlIHN0ZG91dCBkYXRhLCBldmVuIG9uIGZhaWx1cmUuIElzIHRoZXJlIGEgc21hcnRlciB3YXkg
dG8gZ3JhYiB0aGUgb3V0cHV0IGludG8gYSB2YXJpYWJsZSwgYnV0IG9ubHkgZHVtcCBpdCB0byB0
aGUgbG9nIG9uIGZhaWx1cmUsIHJhdGhlciB0aGFuIG91dHJpZ2h0IGRpc2NhcmRpbmcgaXQ/DQo+
IA0KPiBCdXQgZm9yIHRoZSBzYWtlIG9mIGdldHRpbmcgdGhpcyB0ZXN0IGluIGJlZm9yZSBmcmVl
emUsIHRoYXQgY2FuIGJlIGEgZm9sbG93dXAsIGlmIGF0IGFsbC4NCj4gDQo+IFJldmlld2VkLWJ5
OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gDQo+IEknbGwgc2VuZCBhIHB1bGwg
cmVxdWVzdCBzb29uLg0KPiANCg0KVGhhbmsgeW91ISENCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

