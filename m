Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09D020748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z1dGx0Hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09D020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibi9K-0006EY-Gy
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibi81-0005O0-SA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibi80-00088f-JK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:36:25 -0500
Received: from mail-eopbgr140109.outbound.protection.outlook.com
 ([40.107.14.109]:39542 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ibi80-00087z-Bs
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:36:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2y9IJIsbTgiGmc+oxTZq7Aj7OmV/m2WFXl4U2N5XXrkNUz0LwX486h7ydnleuj2Xpe9yt9gexwS7CMmuLeGxVx708B85PICs3aTijWwQHCCZIbVm/DZ4lerJ4q+BD+x1qr1ZkHLT2XE4QebFdBS7wnIEWruUYpPC8HtvpzYtoqAI/ScY3SfMxzE9YwD+/i5kk54lSiNTUHY20Ucdg1UqNRvqJy92l1KCWHL8kmjG6h88PwcFoK96Sb+jm/fIEbzVJlXnEmn7Ikn+H4KMwtYNx1R7f65izdbsNLx06H86L7/NY+t/w91YP89QxPeHVDE9WN0pTG7/9ZGJEZsIQYc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiEFzEV9WGvO2OvH1XGjo3m4w70XlUKlV+N2PQFwmgs=;
 b=IEpY7AccZXYxHUG1MlgSEErniy+2eyohoUo6PWTdrGaJV6P3/KILxNKAy94Rcc7ayiVL6CqLSh/msw35ZDbNF12unrD6Z2/FfnvbrrZrBHKN8YxOR6HuY/3NOHgmBEzH7Cx5JKy7HK087G3jqHesbGuRe+3y+BsgWc4sKFEC7IYm+0O7B8vPaahmpujU/c3/TSaDPP6JUIkd6BE2ScX2krH9c0RS58965I+PkbcNpAz/kyiPOzWjZ/gTa/CvubtR3HnfUfqjwCX2M4uWdAM9w+WTHrOJDQWLDdjpQ83VnDf+vctE2N/p+WLXRnEaRV6YAhM50aAD7OKDKmiRlPp/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiEFzEV9WGvO2OvH1XGjo3m4w70XlUKlV+N2PQFwmgs=;
 b=Z1dGx0Hvvn3/d22hVpF3b2i79tJreh4GL2uOVVV0fXTBBEDe4cLW0kNhxflR9B7DyvN0VjLmIBiLiSpPL1j2Eph5L6ELMyWm9TpCsaB/SwIK2Q8mSpbXr9eXhM9We20G+uZ4/Tg+mQNU7bz1g6q/Wikk47ZNtqdaN0s25EZNZDE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5159.eurprd08.prod.outlook.com (10.255.120.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 09:36:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 09:36:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6] 9pfs: well form error hint helpers
Thread-Topic: [PATCH v6] 9pfs: well form error hint helpers
Thread-Index: AQHVpVcX6xUXUnhNWkSzrCZQGpCUr6efm+EAgAcBV4A=
Date: Mon, 2 Dec 2019 09:36:21 +0000
Message-ID: <9410855e-8bb1-7623-6940-8848832db662@virtuozzo.com>
References: <20191127191549.21216-1-vsementsov@virtuozzo.com>
 <20191127233742.198e00f7@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191127233742.198e00f7@bahia.w3ibm.bluemix.net>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191202123619758
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8861a231-8054-4b2b-6e04-08d7770b173e
x-ms-traffictypediagnostic: AM6PR08MB5159:
x-microsoft-antispam-prvs: <AM6PR08MB51594A407D291764BC4D4E8DC1430@AM6PR08MB5159.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(6512007)(52116002)(305945005)(6306002)(3846002)(6116002)(229853002)(966005)(31696002)(446003)(11346002)(4326008)(102836004)(25786009)(14454004)(71190400001)(71200400001)(6506007)(386003)(26005)(8936002)(478600001)(186003)(99286004)(64756008)(66946007)(5660300002)(31686004)(66446008)(66556008)(66476007)(2616005)(81166006)(81156014)(316002)(256004)(14444005)(36756003)(86362001)(6436002)(8676002)(2906002)(6916009)(66066001)(6486002)(76176011)(6246003)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5159;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/ibMV1NbEsrOPd4oApsPHGZqJG9kAmS8nolovDS/mYVd+f51YYWuliqAEGVmcu1bOkqptwBMjE2cRJXzKI9t8Li7qdQKqCpIaJD7/U8h2HKjR6w4prWIutFIqUECNgGebWlNWQw610OumLw5PeSuG2l3FThF+VmQnmOC74VHMa8zVPTkDY421so6gw/i0OKjxGANWG0UU6PDecmkXl76Myf4Vg75rvwMP7uW3rDqqW+jZXASStaWYV8EW9ZtgzRgPwMuIRDkZTpA2xx9PWcJMq0pbGI83UwpBu5Rbg9qL0m+AsYxIMIpZHaSlNOx5hrFY7HSoo/k1sfRVtzJf7v/6ytt7E5fL5JL4B8rXpcB/68QAjm2qhWIA36BH3CEF3ABS38aZDsKdX0FRiQFFw9/J5Ii5s7Jhdphl5Q7CpHYEKOeVr/Y29B/db2VD0XG8fi9YSXcHl8ME8eFnhN5gIbkYwJjTucTuETMgFdvNBFoL8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3178B2532CC855429B550210A69DAFDD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8861a231-8054-4b2b-6e04-08d7770b173e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 09:36:21.6306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26jLuwdqwHPYeg0TiBF4mzwupez46xp4eLL4PaquvfR2qCwzd/4GUwuU4im6qkfujQGIrELcjeZdtPvTSWc/JNofPkqx91WNnq2Yd9Om4Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5159
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.109
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTEuMjAxOSAxOjM3LCBHcmVnIEt1cnogd3JvdGU6DQo+IE9uIFdlZCwgMjcgTm92IDIwMTkg
MjI6MTU6NDkgKzAzMDANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPiB3cm90ZToNCj4gDQo+PiBNYWtlIGVycm9yX2FwcGVuZF9zZWN1cml0
eV9tb2RlbF9oaW50IGFuZA0KPj4gZXJyb3JfYXBwZW5kX3NvY2tldF9zb2NrZmRfaGludCBoaW50
IGFwcGVuZCBoZWxwZXJzIHdlbGwgZm9ybWVkOg0KPj4gcmVuYW1lIGVycnAgdG8gZXJycF9pbiwg
YXMgaXQgaXMgSU4tcGFyYW1ldGVyIGhlcmUgKHdoaWNoIGlzIHVudXN1YWwNCj4+IGZvciBlcnJw
KS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiBBY2tlZC1ieTogR3JlZyBLdXJ6IDxncm91Z0Br
YW9kLm9yZz4NCj4+IC0tLQ0KPj4NCj4+IHY2OiBhZGQgR3JlZydzIGEtYg0KPj4NCj4gDQo+IEkn
dmUgYWxyZWFkeSBwdXNoZWQgdGhhdCB0byBteSA5cC1uZXh0IGJyYW5jaDoNCj4gDQo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9na3Vyei9xZW11L2NvbW1pdHMvOXAtbmV4dA0KDQoNCk1hcmt1cyBwcm9w
b3NlZCB0byB1c2UgRXJyb3IgKmNvbnN0ICplcnJwIGZvciBzdWNoIGNhc2VzIChhbW9uZyBvdGhl
cg0KdGhpbmdzKQ0KDQpTbywgc2VlbXMgdGhlcmUgd291bGQgYmUgdjcsIHRoZSBjdXJyZW50IHZl
cnNpb24gaXMgaGVyZToNCmdpdDovL3JlcG8ub3IuY3ovcWVtdS9hcm1icnUuZ2l0IGJyYW5jaCBl
cnJvci1wcmVwDQoNCkRpc2N1c3Npb24gaXMgaGVyZToNCmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9h
cmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTExL21zZzA0NjMzLmh0bWwNCmFuZCBoZXJlOg0K
aHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMTEvbXNn
MDQ2MzYuaHRtbA0KDQo+IA0KPiANCj4+ICAgaHcvOXBmcy85cC1sb2NhbC5jIHwgNCArKy0tDQo+
PiAgIGh3LzlwZnMvOXAtcHJveHkuYyB8IDUgKysrLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3Lzlw
ZnMvOXAtbG9jYWwuYyBiL2h3LzlwZnMvOXAtbG9jYWwuYw0KPj4gaW5kZXggNDcwOGMwYmQ4OS4u
NzZmYTE4NThiNyAxMDA2NDQNCj4+IC0tLSBhL2h3LzlwZnMvOXAtbG9jYWwuYw0KPj4gKysrIGIv
aHcvOXBmcy85cC1sb2NhbC5jDQo+PiBAQCAtMTQ3Myw5ICsxNDczLDkgQEAgc3RhdGljIHZvaWQg
bG9jYWxfY2xlYW51cChGc0NvbnRleHQgKmN0eCkNCj4+ICAgICAgIGdfZnJlZShkYXRhKTsNCj4+
ICAgfQ0KPj4gICANCj4+IC1zdGF0aWMgdm9pZCBlcnJvcl9hcHBlbmRfc2VjdXJpdHlfbW9kZWxf
aGludChFcnJvciAqKmVycnApDQo+PiArc3RhdGljIHZvaWQgZXJyb3JfYXBwZW5kX3NlY3VyaXR5
X21vZGVsX2hpbnQoRXJyb3IgKiplcnJwX2luKQ0KPj4gICB7DQo+PiAtICAgIGVycm9yX2FwcGVu
ZF9oaW50KGVycnAsICJWYWxpZCBvcHRpb25zIGFyZTogc2VjdXJpdHlfbW9kZWw9Ig0KPj4gKyAg
ICBlcnJvcl9hcHBlbmRfaGludChlcnJwX2luLCAiVmFsaWQgb3B0aW9ucyBhcmU6IHNlY3VyaXR5
X21vZGVsPSINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICJbcGFzc3Rocm91Z2h8bWFwcGVk
LXhhdHRyfG1hcHBlZC1maWxlfG5vbmVdXG4iKTsNCj4+ICAgfQ0KPj4gICANCj4+IGRpZmYgLS1n
aXQgYS9ody85cGZzLzlwLXByb3h5LmMgYi9ody85cGZzLzlwLXByb3h5LmMNCj4+IGluZGV4IDk3
YWI5YzU4YTUuLjllMjlhYmMzZWYgMTAwNjQ0DQo+PiAtLS0gYS9ody85cGZzLzlwLXByb3h5LmMN
Cj4+ICsrKyBiL2h3LzlwZnMvOXAtcHJveHkuYw0KPj4gQEAgLTExMTQsOSArMTExNCwxMCBAQCBz
dGF0aWMgaW50IGNvbm5lY3RfbmFtZWRzb2NrZXQoY29uc3QgY2hhciAqcGF0aCwgRXJyb3IgKipl
cnJwKQ0KPj4gICAgICAgcmV0dXJuIHNvY2tmZDsNCj4+ICAgfQ0KPj4gICANCj4+IC1zdGF0aWMg
dm9pZCBlcnJvcl9hcHBlbmRfc29ja2V0X3NvY2tmZF9oaW50KEVycm9yICoqZXJycCkNCj4+ICtz
dGF0aWMgdm9pZCBlcnJvcl9hcHBlbmRfc29ja2V0X3NvY2tmZF9oaW50KEVycm9yICoqZXJycF9p
bikNCj4+ICAgew0KPj4gLSAgICBlcnJvcl9hcHBlbmRfaGludChlcnJwLCAiRWl0aGVyIHNwZWNp
Znkgc29ja2V0PS9zb21lL3BhdGggd2hlcmUgL3NvbWUvcGF0aCINCj4+ICsgICAgZXJyb3JfYXBw
ZW5kX2hpbnQoZXJycF9pbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIkVpdGhlciBzcGVj
aWZ5IHNvY2tldD0vc29tZS9wYXRoIHdoZXJlIC9zb21lL3BhdGgiDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAiIHBvaW50cyB0byBhIGxpc3RlbmluZyBBRl9VTklYIHNvY2tldCBvciBzb2Nr
X2ZkPWZkIg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIiB3aGVyZSBmZCBpcyBhIGZpbGUg
ZGVzY3JpcHRvciB0byBhIGNvbm5lY3RlZCBBRl9VTklYIg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIiBzb2NrZXRcbiIpOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

