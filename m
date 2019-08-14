Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43022C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 15:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21EB2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZKUKhDw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21EB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxv3C-00052u-5O
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 11:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxv1r-0004WB-5K
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 11:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxv1p-0005WF-2u
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 11:17:34 -0400
Received: from mail-ve1eur02on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::720]:13700
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxv1o-0005UZ-Ch; Wed, 14 Aug 2019 11:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPHTY3qgE0wH5Fm4Vmdqk5ntJF+ImwQVfT5r/Ifwmg/WN8z6sGfCOo+/X4hoAkgI5vkS17cQS124aVw+hCzLgKN5mz4NSDf1UlAeRieaAC6nk2uNsgrGwMIzk2FRKZzNEpBy2Ri1SIvtCg6pjpOSJuhOnyjMQRZsBnVEEfDv+2MlUrWBNaoLMfDDTSfVplNb7l08XalyrMWP7RvLU08nTBrewDfscLN+HXY5WJQ3cSdy/SjpokdCJEM6qgzOvS8amNE9Axab3oygUouNur1br7A7iY8+8xPsdMVm3pHZ2Ax68aYTSkahm2qSRKe7ego9t+6/ZfGihGcShuWhX44yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu+ypWiuBzXhbBRlBnvGgciDi6hDanoPoPA0e4Mfceo=;
 b=f7bpd65rahJPokmBZZUGadmM63u6ud1AUIvYIaG1qFAIXukY7BfM1LNcNCfBNvppZiVXKwwIRbwbTqRHvb1smx+mHygOTJCKS/elflfjClBp6TtgrOWrupsXu9hjSa6pv9PyITOx7QMHwuQjbp0tsVUPKqHybYVTh9PfC5Flkpc9W89lQVE+asoKNW8dhGxSbTvU05i2dL5CWEC7JsCYqL/1XspkrvgVQQrjasaVkp/tg7add2mgQeqe4mfj+Y80GogPV7/pPgsPAERFXUnMBD9u8T4NhmWDwol8az+v19nn/qCj/wwfxpF5H7lf9jgB7voqLZd+tS7u0BnfWb1E0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu+ypWiuBzXhbBRlBnvGgciDi6hDanoPoPA0e4Mfceo=;
 b=ZKUKhDw0KceTdLiNZtIKtChGHGhmFM/7QXc9pSuLQm14c8qOy6B7bJOVYYk/uAPwzfiSFJ+stANDuT/KP+cqxijFkh3v1NPV0L1EKjuNAFir22JdegGOuZ2U6hwYp8Plaw3n0AhupRacqb0QFk8ueZagj+OMMmyr7g66SV0bhiU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4953.eurprd08.prod.outlook.com (10.255.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 15:17:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 15:17:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 25/42] mirror: Deal with filters
Thread-Index: AQHVTs2fW9lDc3qUnk+iNbQLgM6ojqb3X0KAgAAmTwCAA0OWAA==
Date: Wed, 14 Aug 2019 15:17:28 +0000
Message-ID: <0a309a30-914c-bae2-f49f-2bf6f5cd46cc@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
 <586c3836-66b6-2a67-3f2c-de38f9a52bcd@virtuozzo.com>
 <cbbe5704-7e50-e6b5-a9bd-1b14a6c86019@redhat.com>
In-Reply-To: <cbbe5704-7e50-e6b5-a9bd-1b14a6c86019@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0035.eurprd09.prod.outlook.com
 (2603:10a6:7:15::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190814181726096
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea8d3ab8-8ee2-4900-3b00-08d720ca8528
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4953; 
x-ms-traffictypediagnostic: DB8PR08MB4953:
x-microsoft-antispam-prvs: <DB8PR08MB4953DE3022ADD162651C16FCC1AD0@DB8PR08MB4953.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39840400004)(366004)(396003)(136003)(189003)(199004)(66556008)(66446008)(5660300002)(99286004)(7736002)(256004)(14444005)(2501003)(71200400001)(110136005)(11346002)(54906003)(52116002)(229853002)(6436002)(31696002)(14454004)(66946007)(6512007)(64756008)(305945005)(71190400001)(6486002)(476003)(86362001)(8936002)(316002)(66476007)(478600001)(66066001)(3846002)(102836004)(81166006)(53936002)(186003)(486006)(25786009)(31686004)(26005)(8676002)(53546011)(6116002)(446003)(36756003)(4326008)(386003)(2616005)(6506007)(2906002)(76176011)(6246003)(81156014)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4953;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4VBsd+XVAvvnBpSO4qKIXytkyFkOtfqDvXc+mEHDTSw1+shxQAjdC3YEtJiUqclW/WvU7uZeV4DPKZzAmMT07ttHVE7G3M2BXUwEzfQyaY3Hea2zpNdrQmRmqjJjSq8hx3oRypzZEIizMbUr2vVSVPLjNbWOJCVmht3eUVpMCE1/rFqwj87mv8dfeqJmeVL27p73DGFDA/TQVOZwC9KE0G2RkE+r3puU0ZIhFGdhxMNQCgULQoO+2aiDwzxVNcB1BnyFwSGeWQL7v6OvWgzF5AO/y9EUM4dP0B+WaZ4RXlb/D5UpfUxYr6ZMgomjvcDVWx2llNRCOZiX9n/dH8hlT0Q4SWuLvDKQIMBzBUHkfAtRbCnMIbRCGjFCSL+JoFAF1B3EPJeoH8rv+h196Kln9va5B8M0NO4SWLaLnxt/3rA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5D6B575485FE443878CA724169F0F26@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8d3ab8-8ee2-4900-3b00-08d720ca8528
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 15:17:28.6654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: is+yncg4oID+38tHfK/W7RNhWi604Tjbdjjn5AIABVR1+1BtaWGbtoBDsLrubZ4r96eTmftBuiQeg5wUOIT1A9Hv9j5NE2pfC4wn/0c/X7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4953
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::720
Subject: Re: [Qemu-devel] [PATCH v6 25/42] mirror: Deal with filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxNjoyNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMi4wOC4xOSAxMzowOSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA5LjA4LjIwMTkgMTk6MTMs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBUaGlzIGluY2x1ZGVzIHNvbWUgcGVybWlzc2lvbiBsaW1p
dGluZyAoZm9yIGV4YW1wbGUsIHdlIG9ubHkgbmVlZCB0bw0KPj4+IHRha2UgdGhlIFJFU0laRSBw
ZXJtaXNzaW9uIGZvciBhY3RpdmUgY29tbWl0cyB3aGVyZSB0aGUgYmFzZSBpcyBzbWFsbGVyDQo+
Pj4gdGhhbiB0aGUgdG9wKS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJl
aXR6QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgYmxvY2svbWlycm9yLmMgfCAxMTcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4+ICAgIGJs
b2NrZGV2LmMgICAgIHwgIDQ3ICsrKysrKysrKysrKysrKysrLS0tDQo+Pj4gICAgMiBmaWxlcyBj
aGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svbWlycm9yLmMgYi9ibG9jay9taXJyb3IuYw0KPj4+IGluZGV4IDU0YmFm
ZGYxNzYuLjZkZGJmYjk3MDggMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svbWlycm9yLmMNCj4+PiAr
KysgYi9ibG9jay9taXJyb3IuYw0KPj4NCj4+DQo+PiBbLi5dDQo+Pg0KPj4+IEBAIC0xNjkzLDE1
ICsxNzM0LDM5IEBAIHN0YXRpYyBCbG9ja0pvYiAqbWlycm9yX3N0YXJ0X2pvYigNCj4+PiAgICAg
ICAgLyogSW4gY29tbWl0X2FjdGl2ZV9zdGFydCgpIGFsbCBpbnRlcm1lZGlhdGUgbm9kZXMgZGlz
YXBwZWFyLCBzbw0KPj4+ICAgICAgICAgKiBhbnkgam9icyBpbiB0aGVtIG11c3QgYmUgYmxvY2tl
ZCAqLw0KPj4+ICAgICAgICBpZiAodGFyZ2V0X2lzX2JhY2tpbmcpIHsNCj4+PiAtICAgICAgICBC
bG9ja0RyaXZlclN0YXRlICppdGVyOw0KPj4+IC0gICAgICAgIGZvciAoaXRlciA9IGJhY2tpbmdf
YnMoYnMpOyBpdGVyICE9IHRhcmdldDsgaXRlciA9IGJhY2tpbmdfYnMoaXRlcikpIHsNCj4+PiAt
ICAgICAgICAgICAgLyogWFhYIEJMS19QRVJNX1dSSVRFIG5lZWRzIHRvIGJlIGFsbG93ZWQgc28g
d2UgZG9uJ3QgYmxvY2sNCj4+PiAtICAgICAgICAgICAgICogb3Vyc2VsdmVzIGF0IHMtPmJhc2Ug
KGlmIHdyaXRlcyBhcmUgYmxvY2tlZCBmb3IgYSBub2RlLCB0aGV5IGFyZQ0KPj4+IC0gICAgICAg
ICAgICAgKiBhbHNvIGJsb2NrZWQgZm9yIGl0cyBiYWNraW5nIGZpbGUpLiBUaGUgb3RoZXIgb3B0
aW9ucyB3b3VsZCBiZSBhDQo+Pj4gLSAgICAgICAgICAgICAqIHNlY29uZCBmaWx0ZXIgZHJpdmVy
IGFib3ZlIHMtPmJhc2UgKD09IHRhcmdldCkuICovDQo+Pj4gKyAgICAgICAgQmxvY2tEcml2ZXJT
dGF0ZSAqaXRlciwgKmZpbHRlcmVkX3RhcmdldDsNCj4+PiArICAgICAgICB1aW50NjRfdCBpdGVy
X3NoYXJlZF9wZXJtczsNCj4+PiArDQo+Pj4gKyAgICAgICAgLyoNCj4+PiArICAgICAgICAgKiBU
aGUgdG9wbW9zdCBub2RlIHdpdGgNCj4+PiArICAgICAgICAgKiBiZHJ2X3NraXBfcndfZmlsdGVy
cyhmaWx0ZXJlZF90YXJnZXQpID09IGJkcnZfc2tpcF9yd19maWx0ZXJzKHRhcmdldCkNCj4+PiAr
ICAgICAgICAgKi8NCj4+PiArICAgICAgICBmaWx0ZXJlZF90YXJnZXQgPSBiZHJ2X2ZpbHRlcmVk
X2Nvd19icyhiZHJ2X2ZpbmRfb3ZlcmxheShicywgdGFyZ2V0KSk7DQo+Pj4gKw0KPj4+ICsgICAg
ICAgIGFzc2VydChiZHJ2X3NraXBfcndfZmlsdGVycyhmaWx0ZXJlZF90YXJnZXQpID09DQo+Pj4g
KyAgICAgICAgICAgICAgIGJkcnZfc2tpcF9yd19maWx0ZXJzKHRhcmdldCkpOw0KPj4+ICsNCj4+
PiArICAgICAgICAvKg0KPj4+ICsgICAgICAgICAqIFhYWCBCTEtfUEVSTV9XUklURSBuZWVkcyB0
byBiZSBhbGxvd2VkIHNvIHdlIGRvbid0IGJsb2NrDQo+Pj4gKyAgICAgICAgICogb3Vyc2VsdmVz
IGF0IHMtPmJhc2UgKGlmIHdyaXRlcyBhcmUgYmxvY2tlZCBmb3IgYSBub2RlLCB0aGV5IGFyZQ0K
Pj4+ICsgICAgICAgICAqIGFsc28gYmxvY2tlZCBmb3IgaXRzIGJhY2tpbmcgZmlsZSkuIFRoZSBv
dGhlciBvcHRpb25zIHdvdWxkIGJlIGENCj4+PiArICAgICAgICAgKiBzZWNvbmQgZmlsdGVyIGRy
aXZlciBhYm92ZSBzLT5iYXNlICg9PSB0YXJnZXQpLg0KPj4+ICsgICAgICAgICAqLw0KPj4+ICsg
ICAgICAgIGl0ZXJfc2hhcmVkX3Blcm1zID0gQkxLX1BFUk1fV1JJVEVfVU5DSEFOR0VEIHwgQkxL
X1BFUk1fV1JJVEU7DQo+Pj4gKw0KPj4+ICsgICAgICAgIGZvciAoaXRlciA9IGJkcnZfZmlsdGVy
ZWRfYnMoYnMpOyBpdGVyICE9IHRhcmdldDsNCj4+PiArICAgICAgICAgICAgIGl0ZXIgPSBiZHJ2
X2ZpbHRlcmVkX2JzKGl0ZXIpKQ0KPj4+ICsgICAgICAgIHsNCj4+PiArICAgICAgICAgICAgaWYg
KGl0ZXIgPT0gZmlsdGVyZWRfdGFyZ2V0KSB7DQo+Pj4gKyAgICAgICAgICAgICAgICAvKg0KPj4+
ICsgICAgICAgICAgICAgICAgICogRnJvbSBoZXJlIG9uLCBhbGwgbm9kZXMgYXJlIGZpbHRlcnMg
b24gdGhlIGJhc2UuDQo+Pj4gKyAgICAgICAgICAgICAgICAgKiBUaGlzIGFsbG93cyB1cyB0byBz
aGFyZSBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQuDQo+Pj4gKyAgICAgICAgICAgICAgICAgKi8N
Cj4+PiArICAgICAgICAgICAgICAgIGl0ZXJfc2hhcmVkX3Blcm1zIHw9IEJMS19QRVJNX0NPTlNJ
U1RFTlRfUkVBRDsNCj4+DQo+Pg0KPj4gSG1tLCBJIGRvbid0IHVuZGVyc3RhbmQsIHdoeSByZWFk
IGZyb20gdXBwZXIgbm9kZXMgaXMgbm90IHNoYXJlZD8NCj4gDQo+IEJlY2F1c2UgdGhleSBkb27i
gJl0IHJlcHJlc2VudCBhIGNvbnNpc3RlbnQgZGlzayBzdGF0ZSBkdXJpbmcgdGhlIGNvbW1pdC4N
Cj4gDQo+IFBsZWFzZSBkb27igJl0IGFzayBtZSBkZXRhaWxzIGFib3V0IENPTlNJU1RFTlRfUkVB
RCwgYmVjYXVzZSBJIGFsd2F5cw0KPiBwcmV0ZW5kIEkgdW5kZXJzdGFuZCBpdCwgYnV0IEkgbmV2
ZXIgcmVhbGx5IGRvLCBhY3R1YWxseS4NCj4gDQo+IChNeSBwcm9ibGVtIGlzIHRoYXQgSSBkbyB1
bmRlcnN0YW5kIHdoeSB0aGUgaW50ZXJtZWRpYXRlIG5vZGVzIHNob3VsZG7igJl0DQo+IHNoYXJl
IENPTlNJU1RFTlRfUkVBRDogSXTigJlzIGJlY2F1c2UgdGhleSBvbmx5IHJlYWQgZ2FyYmFnZSwg
ZWZmZWN0aXZlbHkuDQo+ICAgQnV0IEkgZG9u4oCZdCB1bmRlcnN0YW5kIGhvdyBhbnkgYmxvY2sg
am9iIHRhcmdldCAobGlrZSBvdXIgYmFzZSBoZXJlKQ0KPiBjYW4gaGF2ZSBDT05TSVNURU5UX1JF
QUQuDQoNCkkga25vdyBzdWNoIGV4YW1wbGU6IGl0J3MgaW1hZ2UgZmxlZWNpbmcgc2NoZW1lLCB3
aGVuIGZvciBiYWNrdXAgam9iIHNvdXJjZQ0KaXMgYSBiYWNraW5nIGZvciB0YXJnZXQuIElmIHNl
cmlhbGl6YXRpb24gb2YgcmVxdWVzdHMgd29ya3Mgd2VsbCB0YXJnZXQgcmVwcmVzZW50cw0KY29u
c2lzdGVudCBzdGF0ZSBvZiBkaXNrIGF0ZSBiYWNrdXAtc3RhcnQgcG9pbnQgaW4gdGltZS4NCg0K
QnV0IHllcywgaXQncyBub3QgYWJvdXQgbWlycm9yIG9yIGNvbW1pdC4NCg0KPiAgQmxvY2sgam9i
IHRhcmdldHMgYXJlIG1vc3RseSB3cml0dGVuIGZyb250IHRvDQo+IGJhY2sgKGV4Y2VwdCB3aXRo
IHN5bmM9bm9uZSksIHNvIHRoZXkgdG9vIGRvbuKAmXQg4oCcW3JlcHJlc2VudF0gdGhlDQo+IGNv
bnRlbnRzIG9mIGEgZGlzayBhdCBhIHNwZWNpZmljIHBvaW50LuKAnQ0KPiBCdXQgdGhhdCBpcyBo
b3cgaXQgd2FzLCBzbyB0aGF0IGlzIGhvdyBpdCBzaG91bGQgYmUga2VwdC4pDQo+IA0KPiBJZiBp
dCBtYWtlcyB5b3UgYW55IGhhcHBpZXIsIEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBROKAmXMgZGVz
Y3JpcHRpb24NCj4gZXhwbGljaXRseSBub3RlcyB0aGF0IGl0IHdpbGwgbm90IGJlIHNoYXJlZCBv
biBpbnRlcm1lZGlhdGUgbm9kZXMgb2YgYQ0KPiBjb21taXQgam9iLg0KPiANCj4gTWF4DQo+IA0K
Pj4+ICsgICAgICAgICAgICB9DQo+Pj4gKw0KPj4+ICAgICAgICAgICAgICAgIHJldCA9IGJsb2Nr
X2pvYl9hZGRfYmRydigmcy0+Y29tbW9uLCAiaW50ZXJtZWRpYXRlIG5vZGUiLCBpdGVyLCAwLA0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQkxLX1BFUk1fV1JJVEVf
VU5DSEFOR0VEIHwgQkxLX1BFUk1fV1JJVEUsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlcnJwKTsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGl0ZXJfc2hhcmVkX3Blcm1zLCBlcnJwKTsNCj4+PiAgICAgICAgICAgICAgICBpZiAo
cmV0IDwgMCkgew0KPj4+ICAgICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7DQo+Pj4gICAgICAg
ICAgICAgICAgfQ0KPj4NCj4+IFsuLl0NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

