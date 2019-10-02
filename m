Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D89C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C350621920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MS8IuSnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C350621920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeRl-0005oH-NF
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFeQM-0004nB-7Q
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFeQK-00079C-H6
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:12:09 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:10465 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFeQJ-00077k-Qc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmCcLaQqEFrjSPxYkX6JU+6ZqNApXbOAZ/ZyUteWeYa4c9ohk58/ZQajzwHZ5uPUWqzf6Hgll8xNpLFyfbz9MOHmwa3yiTQIGhM5LYH2+9eA9X1j2TB1mDO/R3IWJ1D8Fji7t6LqMHgCkpPUPJ9DXu/1OoN/SUFSDbtM7bJsMObvL4UuHba9wv0s3ZdDEevtmq9Cqeom70IblQY9gXrWDimLrB1ML9A2tFvob7o0dqbwAM2423rWppecaxP/32yoUZ9aFSKdbZOWdgrQTscIp3Z07JcqpwvDbdwsgkT4b1N748vKPwZ6jqKGFXzxD/TTl4CX95QP15iF6/SafdK8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOrnst0z4t+QA+fL59llLjBBbaPOcKPysBAvLstfEaQ=;
 b=R1EwBboeFXhhGIlManCxuWbWo6AJII2pX0NPNCt1bWfkCDcOE9NTNNCDuWfFd7xHGFzmUeLyIZoposktyKmmRL4LMSG4G2H+hZrOesv2VlRsxr7ya1zrfzJCy6bZ4EZuZyjVk1ViQEPelOTgrD425uRUgp5KR6TUjbbYcWzBtO73VLBqpTfvpuyJTeYvmRIlqwXVmLZ5eeRJoocMq4K42BemDTcDW/FYl4R2DTwFPY45jD7Pytr2Ldht8pXk0XKeeBYFMFr9FstKqWJkBZDxKZe6vaOO8U8TICxTdmXBhL2MHLHZAcJ1QWaNTO1ua+O8l6UnYKXTIveD/csdqYCfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOrnst0z4t+QA+fL59llLjBBbaPOcKPysBAvLstfEaQ=;
 b=MS8IuSnnWR+0EEphHRL4jzLeBtgwsxqNLop8idQ5whf2suhZvz0MUHyWQOWJIDiQg5hqmHL5krnYq8H5APOKMnvX/h869a0UwJQIMF54uJ95U/SX7BayiKq6OvXI6B0UqxERwsM3gcpvpjm0NoY238trY9MPMXRicK7PuaOstIc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5132.eurprd08.prod.outlook.com (10.255.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 13:11:58 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:11:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 21/31] virtio-9p: Fix error_append_hint/error_prepend
 usage
Thread-Topic: [PATCH v4 21/31] virtio-9p: Fix error_append_hint/error_prepend
 usage
Thread-Index: AQHVeHBjsJBaOkT9y0K+qBVLhCi+pKdHFAcAgAA9KQCAAAPcgA==
Date: Wed, 2 Oct 2019 13:11:58 +0000
Message-ID: <7e6ff8eb-ecf8-1e5f-0bfc-2fc1986857ad@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-22-vsementsov@virtuozzo.com>
 <20191002111912.647a4470@bahia.lan>
 <6413b323-2b2b-b5b5-3a19-46330bca0140@virtuozzo.com>
In-Reply-To: <6413b323-2b2b-b5b5-3a19-46330bca0140@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0033.eurprd09.prod.outlook.com
 (2603:10a6:7:15::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002161155933
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f604852-db91-431b-373b-08d7473a1ad6
x-ms-traffictypediagnostic: DB8PR08MB5132:
x-microsoft-antispam-prvs: <DB8PR08MB5132D09C881533000729C639C19C0@DB8PR08MB5132.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(136003)(346002)(396003)(366004)(189003)(52314003)(199004)(81166006)(66446008)(476003)(36756003)(64756008)(66066001)(25786009)(66476007)(66946007)(478600001)(486006)(6916009)(5660300002)(66556008)(76176011)(7736002)(305945005)(31686004)(54906003)(52116002)(99286004)(316002)(4326008)(6436002)(14444005)(81156014)(31696002)(14454004)(6506007)(102836004)(8936002)(386003)(256004)(8676002)(6116002)(71200400001)(26005)(71190400001)(2906002)(86362001)(6486002)(229853002)(6512007)(3846002)(11346002)(6246003)(446003)(186003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5132;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKyhs+XOofHbtv/55JZ7a3wUrsRGy9llLZkZDCuGIpeHWPEIrMgJZou/iYZjryszcj7aA5zXdGt5q4WOOAkjdwK9P0FVVVLEt3fxy9hlR8l4oGnQnt3pbHPSeKt1RDu2Pqyp167y6IeUlqWe57p+bBdcJMpRs7XM8/9wevcFKTd8wxbkVKd93oFBo85Nkg38hP2N6QaehYvIB2sxKRA1p1w5RPVAhZEHZkTKPv9g5ft+gzlulkdy5eMczDbb+T9MpafjElPxu75XlVZCCFthJ1WRn2bmUBnOizhs6XvoBzJdtNW9fAoQqTDkz1MIFFBWo2/R26GEYNV2iIdTRD6LWzqIasvZ+huX8R66UhyW+nyIaYi1vkW38bPRjiOLVQxCvhvHZ5qE3uEG9AUt77W852Dc8rTl8e94a/rqybFqrP0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F273E993B79D2E4CACA9A606D314BCEE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f604852-db91-431b-373b-08d7473a1ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:11:58.1797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIbzukaUEMUq2kqFJGY4f9P/wJMYE/Hzc9KjlnM012p8RYpRBEqBEZmwwJQyMLi2UWoWZ8IzcTT8MkvizACdRimPImqdHPECWaerXZl0+6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5132
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.118
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

MDIuMTAuMjAxOSAxNTo1OCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDIuMTAuMjAxOSAxMjoxOSwgR3JlZyBLdXJ6IHdyb3RlOg0KPj4gT24gVHVlLMKgIDEgT2N0IDIw
MTkgMTg6NTM6MDkgKzAzMDANCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+Pg0KPj4+IElmIHdlIHdhbnQgdG8gYWRkIHNv
bWUgaW5mbyB0byBlcnJwIChieSBlcnJvcl9wcmVwZW5kKCkgb3INCj4+PiBlcnJvcl9hcHBlbmRf
aGludCgpKSwgd2UgbXVzdCB1c2UgdGhlIEVSUlBfQVVUT19QUk9QQUdBVEUgbWFjcm8uDQo+Pj4g
T3RoZXJ3aXNlLCB0aGlzIGluZm8gd2lsbCBub3QgYmUgYWRkZWQgd2hlbiBlcnJwID09ICZmYXRh
bF9lcnINCj4+PiAodGhlIHByb2dyYW0gd2lsbCBleGl0IHByaW9yIHRvIHRoZSBlcnJvcl9hcHBl
bmRfaGludCgpIG9yDQo+Pj4gZXJyb3JfcHJlcGVuZCgpIGNhbGwpLsKgIEZpeCBzdWNoIGNhc2Vz
Lg0KPj4+DQo+Pg0KPj4gV2VsbC4uLiB0aGlzIHBhdGNoIGRvZXNuJ3QgcmVhbGx5IGZpeCBhbnl0
aGluZyBiZWNhdXNlLi4uDQo+IA0KPiBJJ20gc3VyZSBpdCBmaXhlcy4gQnV0IGl0IGFsc28gYnJl
YWtzIHNvbWUgdGhpbmdzIHlvdSBtZW50aW9uIGJlbG93Li4NCj4gDQo+Pg0KPj4+IFRoaXMgY29t
bWl0ICh0b2dldGhlciB3aXRoIGl0cyBuZWlnaGJvcnMpIHdhcyBnZW5lcmF0ZWQgYnkNCj4+Pg0K
Pj4+IGdpdCBncmVwIC1sICdlcnJvcl9cKGFwcGVuZF9oaW50XHxwcmVwZW5kXCkoZXJycCcgfCB3
aGlsZSByZWFkIGY7IGRvIFwNCj4+PiBzcGF0Y2ggLS1zcC1maWxlIHNjcmlwdHMvY29jY2luZWxs
ZS9maXgtZXJyb3ItYWRkLWluZm8uY29jY2kgXA0KPj4+IC0taW4tcGxhY2UgJGY7IGRvbmUNCj4+
Pg0KPj4+IGFuZCB0aGVuDQo+Pj4NCj4+PiAuL3B5dGhvbi9jb21taXQtcGVyLXN1YnN5c3RlbS5w
eSBNQUlOVEFJTkVSUyAiJCg8IGF1dG8tbXNnKSINCj4+Pg0KPj4+IChhdXRvLW1zZyB3YXMgYSBm
aWxlIHdpdGggdGhpcyBjb21taXQgbWVzc2FnZSkNCj4+Pg0KPj4+IGFuZCB0aGVuIGJ5IGhhbmQs
IGZvciBub3QgbWFpbnRhaW5lZCBjaGFuZ2VkIGZpbGVzOg0KPj4+DQo+Pj4gZ2l0IGNvbW1pdCAt
bSAiPFNVQi1TWVNURU0+OiAkKDwgYXV0by1tc2cpIiA8RklMRVM+DQo+Pj4NCj4+PiBTdGlsbCwg
Zm9yIGJhY2twb3J0aW5nIGl0IG1heSBiZSBtb3JlIGNvbWZvcnRhYmxlIHRvIHVzZSBvbmx5IHRo
ZSBmaXJzdA0KPj4+IGNvbW1hbmQgYW5kIHRoZW4gZG8gb25lIGh1Z2UgY29tbWl0Lg0KPj4+DQo+
Pj4gUmVwb3J0ZWQtYnk6IEdyZWcgS3VyeiA8Z3JvdWdAa2FvZC5vcmc+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4+IC0tLQ0KPj4+IMKgIGh3LzlwZnMvOXAtbG9jYWwuYyB8IDEgKw0KPj4+IMKgIGh3
LzlwZnMvOXAtcHJveHkuYyB8IDEgKw0KPj4+IMKgIGh3LzlwZnMvOXAuY8KgwqDCoMKgwqDCoCB8
IDEgKw0KPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvaHcvOXBmcy85cC1sb2NhbC5jIGIvaHcvOXBmcy85cC1sb2NhbC5jDQo+Pj4g
aW5kZXggMDhlNjczYTc5Yy4uZmNjYmY3NThiZCAxMDA2NDQNCj4+PiAtLS0gYS9ody85cGZzLzlw
LWxvY2FsLmMNCj4+PiArKysgYi9ody85cGZzLzlwLWxvY2FsLmMNCj4+PiBAQCAtMTQ3MSw2ICsx
NDcxLDcgQEAgc3RhdGljIHZvaWQgbG9jYWxfY2xlYW51cChGc0NvbnRleHQgKmN0eCkNCj4+PiDC
oCBzdGF0aWMgdm9pZCBlcnJvcl9hcHBlbmRfc2VjdXJpdHlfbW9kZWxfaGludChFcnJvciAqKmVy
cnApDQo+Pj4gwqAgew0KPj4+ICvCoMKgwqAgRVJSUF9BVVRPX1BST1BBR0FURSgpOw0KPj4+IMKg
wqDCoMKgwqAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgIlZhbGlkIG9wdGlvbnMgYXJlOiBzZWN1
cml0eV9tb2RlbD0iDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiW3Bhc3N0aHJvdWdofG1hcHBlZC14YXR0cnxtYXBwZWQtZmlsZXxub25lXVxuIik7
DQo+Pj4gwqAgfQ0KPj4NCj4+IFRoaXMgZnVuY3Rpb24gZG9lc24ndCBuZWVkIGF1dG8gcHJvcGFn
YXRpb24gaW4gdGhlIGZpcnN0IHBsYWNlLiBJdCBpcw0KPj4gc2ltcGx5IGEgd3JhcHBlciBhcm91
bmQgZXJyb3JfYXBwZW5kX2hpbnQoKS4gRVJSUF9BVVRPX1BST1BBR0FURSgpDQo+PiBzaG91bGQg
Z28gdG8gdGhlIGNhbGxlciBsb2NhbF9wYXJzZV9vcHRzKCkuDQo+IA0KPiBIbW0sIHRoYXQncyBi
YWQuIFNvLCBhY3R1YWxseSBpdCdzIG9uZSBtb3JlIGVycnAgSU4gcGFyYW1ldGVyLg0KPiANCj4+
DQo+PiBBbHNvIHNvbWUgZXh0cmEgY2FyZSBpcyBuZWVkZWQgdGhlcmUgdG8gaGFuZGxlIHBhcnQg
WzMuXSBvZiB0aGUNCj4+IGNsZWFudXAuIEkgdW5kZXJzdGFuZCB0aGlzIGlzIG91dCBvZiB0aGUg
c2NvcGUgb2YgdGhhdCBzZXJpZXMsDQo+PiBidXQgSSdkIHJhdGhlciBzZWUgYWxsIG9mIHRoaXMg
Zml4ZWQgaW4gdGhlIHNhbWUgcGF0Y2guDQo+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody85cGZzLzlw
LXByb3h5LmMgYi9ody85cGZzLzlwLXByb3h5LmMNCj4+PiBpbmRleCA1N2E4YzFjODA4Li45Mjkx
YzhlZmEyIDEwMDY0NA0KPj4+IC0tLSBhL2h3LzlwZnMvOXAtcHJveHkuYw0KPj4+ICsrKyBiL2h3
LzlwZnMvOXAtcHJveHkuYw0KPj4+IEBAIC0xMTE2LDYgKzExMTYsNyBAQCBzdGF0aWMgaW50IGNv
bm5lY3RfbmFtZWRzb2NrZXQoY29uc3QgY2hhciAqcGF0aCwgRXJyb3IgKiplcnJwKQ0KPj4+IMKg
IHN0YXRpYyB2b2lkIGVycm9yX2FwcGVuZF9zb2NrZXRfc29ja2ZkX2hpbnQoRXJyb3IgKiplcnJw
KQ0KPj4+IMKgIHsNCj4+PiArwqDCoMKgIEVSUlBfQVVUT19QUk9QQUdBVEUoKTsNCj4+PiDCoMKg
wqDCoMKgIGVycm9yX2FwcGVuZF9oaW50KGVycnAsICJFaXRoZXIgc3BlY2lmeSBzb2NrZXQ9L3Nv
bWUvcGF0aCB3aGVyZSAvc29tZS9wYXRoIg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIiBwb2ludHMgdG8gYSBsaXN0ZW5pbmcgQUZfVU5JWCBzb2Nr
ZXQgb3Igc29ja19mZD1mZCINCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICIgd2hlcmUgZmQgaXMgYSBmaWxlIGRlc2NyaXB0b3IgdG8gYSBjb25uZWN0
ZWQgQUZfVU5JWCINCj4+DQo+PiBTYW1lIGhlcmUuIEVSUlBfQVVUT19QUk9QQUdBVEUoKSBzaG91
bGQgZ28gdG8gcHJveHlfcGFyc2Vfb3B0cygpLg0KPiANCj4gYW5kIHRoaXMgb25lLg0KPiANCj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2h3LzlwZnMvOXAuYyBiL2h3LzlwZnMvOXAuYw0KPj4+IGluZGV4
IGNjZTIzNjYyMTkuLjFkZjI3NDllMDMgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvOXBmcy85cC5jDQo+
Pj4gKysrIGIvaHcvOXBmcy85cC5jDQo+Pj4gQEAgLTM1NTIsNiArMzU1Miw3IEBAIHZvaWQgcGR1
X3N1Ym1pdChWOWZzUERVICpwZHUsIFA5TXNnSGVhZGVyICpoZHIpDQo+Pj4gwqAgaW50IHY5ZnNf
ZGV2aWNlX3JlYWxpemVfY29tbW9uKFY5ZnNTdGF0ZSAqcywgY29uc3QgVjlmc1RyYW5zcG9ydCAq
dCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEVycm9yICoqZXJycCkNCj4+PiDCoCB7DQo+Pj4gK8KgwqDCoCBFUlJQ
X0FVVE9fUFJPUEFHQVRFKCk7DQo+Pg0KPj4gVGhpcyBpcyBjb3JyZWN0IHNpbmNlIHRoaXMgZnVu
Y3Rpb24gY2FsbHMgZXJyb3JfcHJlcGVuZCgpIGJ1dCBJIHRoaW5rDQo+PiBlcnJwIGlzIG5ldmVy
ICZlcnJvcl9mYXRhbCBvciAmZXJyb3JfYWJvcnQgb24gdGhlIHJlYWxpemUgcGF0aC4gQW55d2F5
LA0KPj4gYmV0dGVyIHNhZmUgdGhhbiBzb3JyeS4NCj4+DQo+Pj4gwqDCoMKgwqDCoCBpbnQgaSwg
bGVuOw0KPj4+IMKgwqDCoMKgwqAgc3RydWN0IHN0YXQgc3RhdDsNCj4+PiDCoMKgwqDCoMKgIEZz
RHJpdmVyRW50cnkgKmZzZTsNCj4+DQo+PiBQbGVhc2UgZHJvcCB0aGlzIHBhdGNoIGZyb20geW91
ciBzZXJpZXMgYW5kIEknbGwgZG8gdGhlIGNoYW5nZSBvbmNlDQo+PiBFUlJQX0FVVE9fUFJPUEFH
QVRFKCkgZ2V0cyBtZXJnZWQuDQo+Pg0KPj4gR3JlYXQgdGhhbmtzIGZvciB5b3VyIHRpbWUgaW4g
ZmluZGluZyBhIGNsZXZlciB3YXkgdG8gZGVhbCB3aXRoIGVycm9yDQo+PiBwcm9wYWdhdGlvbi4g
OikNCj4+DQo+IA0KPiBIbW0sIGFjdHVhbCBxdWVzdGlvbiBpczogaG93IG1hbnkgb3RoZXIgZXJy
cCBJTiBwYXJhbWV0ZXJzIEkndmUgYnJva2VuIGluDQo+IHRoZXNlIHNlcmllcz8NCj4gDQo+IEkg
Y2FuJ3Qgc2ltcGx5IGRyb3Agb25lIHBhdGNoIGZyb20gYXRvbWF0aWNhbGx5IGdlbmVyZWF0ZWQg
c2VyaWVzOiBob3cgcGVvcGxlDQo+IHdpbGwgYmFja3BvcnQgaXQgdGhhbiwgb3IgdW5kZXJzdGFu
ZCBob3cgdG8gYmFja3BvcnQgb3RoZXIgY3Jvc3NpbmcgdGhpbmdzPw0KPiANCj4gQWN0dWFsbHks
IGZvciB0aGUgY2FzZXMgeW91IG1lYW4sIEVSUlBfQVVUT19QUk9QQUdBVEUgaXMgbm8tb3AsIGFz
IGl0IHVzZXMgb3JpZ2luYWwNCj4gZXJycCBpZiBpdCdzIG5vdCBOVUxMIGFuZCBkb24ndCBwb2lu
dCB0byBlcnJvcl9mYXRhbC4NCj4gDQo+IFNvLCBub3RoaW5nIGlzIGJyb2tlbiBoZXJlLCBtYXkg
YmUgd2UgY2FuIHByb2NlZWQgYXMgaXM/IEJ1dCBJIGFncmVlLCBpdCBsb29rcyBzdHJhbmdlLg0K
PiANCj4gRXJpYywgd2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBJIHRyaWVkIHRvIGNoYW5nZSBj
b2NjaSBzY3JpcHQgdG8NCj4gDQo+ICDCoCBAcnVsZTBADQo+ICDCoCAvLyBBZGQgaW52b2NhdGlv
biB0byBlcnJwLWZ1bmN0aW9ucw0KPiB+IGlkZW50aWZpZXIgZm4sIGZuMjsNCj4gIMKgIEBADQo+
IA0KPiAgwqDCoCBmbiguLi4sIEVycm9yICoqZXJycCwgLi4uKQ0KPiAgwqDCoCB7DQo+ICDCoCAr
wqDCoCBFUlJQX0FVVE9fUFJPUEFHQVRFKCk7DQo+ICDCoMKgwqDCoMKgIDwrLi4uDQo+ICvCoMKg
wqDCoCBmbjIoLi4uLCBlcnJwLCAuLi4pDQo+ICvCoMKgwqDCoCAuLi4NCj4gIMKgICgNCj4gIMKg
wqDCoMKgwqAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgLi4uKTsNCj4gIMKgIHwNCj4gIMKgwqDC
oMKgwqAgZXJyb3JfcHJlcGVuZChlcnJwLCAuLi4pOw0KPiAgwqAgKQ0KPiAgwqDCoMKgwqDCoCAu
Li4rPg0KPiAgwqDCoCB9DQo+IA0KPiANCj4gYnV0IGl0IHN0dWJzIG9uIGh3L3ZmaW8vcGNpLmMu
Li4gYW5kIGl0IHNraXBzIGEgbG90IG9mIHZhbGlkIGNhc2VzLCBzbyBpdCdzIHdyb25nLg0KPiAN
Cj4gDQo+IA0KDQpFcmljLCB5b3UgYXJlIHRoZSBtb3N0IGludGVyZXN0ZWQgbWFpbnRhaW5lciwg
bWF5IGJlLCBJJ2xsIG1ha2UgYSB2NSB3aXRoIG9ubHkgbmJkIHVwZGF0ZWQ/DQpUaGVuIEdyZWcg
d2lsbCB1cGRhdGUgaGlzIHN1YnN5c3RlbSwgdGhlbiBtYXkgYmUgSSBvciBzb21lb25lIGVsc2Ug
d2lsbCB1cGRhdGUgYmxvY2suLiBJJ20NCmFmcmFpZCwgbm9ib2R5IHdpbGwgcmV2aWV3IHRoZSB3
aG9sZSBzZXJpZXMsIGFuZCBHcmVnIHNob3dzLCB0aGF0IHRoZXJlIG1heWJlIHNvbWUgdW5wcmVk
aWN0ZWQNCmVmZmVjdHMuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

