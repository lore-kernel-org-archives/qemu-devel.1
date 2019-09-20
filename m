Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC4FC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0414D207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LUx+9TUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0414D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHV6-0005LO-4J
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBHUB-0004fB-59
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBHU9-0005Lj-0x
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:54:02 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:23520 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBHU8-0005KW-Fa; Fri, 20 Sep 2019 07:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7l87P4UwOVKLWlFy1+iqo4sG8XnzjLFhbDnXTJ4P8S1nLKDG1cbeoz9hoZwHzVbXm6EBYpyexh3R/qVic2cYLzO/70H32S8Is80SYYL6eWXOxd9ROQZd7gBfftqqtLXeAn6ueZHwNsFalViz1Tqw0G5UZ8zEae3zND/lVPBmBXcb9h+poXePVS/RYVJQkEWweIcKumDfeM2jZVGaG4mpTV2HfC3/ACBlZHMJzVsOHwRaDXvons8xk2xDK96H+k+1mr0sNmZA5lAmFfGVbIQ07RwydzAafmBAX/BZ91NR9L6kfP5vOZZhZingjk5m2lWj0TzBa2AhaqJgvth+1kDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGt5Jga22DEcH0Hlsjl+wtsNZXtmF9dICYRXYuORKcs=;
 b=fCcvthpe1CqOhNsB8Pj2SnmhV3vbHRauRQgbXboGCPl+gI9HthweV+cU5TupyTbPtTXumlzjrXSOWKDTTBur5+GV3FXqxQa5Q74fJlKlZ6Og2HMtWQandP7W6N8kSbxUSzYahc5CASKkNTObzNxjNEY4AzY4fdq1QfeLMgIPasH2SvRfsLIsNtIBMLueImcPKzvL+uGL2mvnqd+TLGf4XMGFCIqXWDXznipEV1eMpD5mTqifi2VGJdd3MESLzbN0GNRqH0t3GOnRNkA2gaxQ2i4dgPdegoAMHSQJy7hrJ2T9Qc31sCi9N2DvqGIzjX8dsTlpsQYJWZDb4MkFhTW+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGt5Jga22DEcH0Hlsjl+wtsNZXtmF9dICYRXYuORKcs=;
 b=LUx+9TUwEsTbB7D1Ih4oQeuxH82I77BZWRR1wSORqMyDvH8zC1Jm5EL1AW1SBLLMwnlJozW6Tjabv3nss6q6BBP6ekc0rXf+BRv6ljSykJTJlZv+fCyPDSxVMXlokDeQPQfTsgi/ZoSGR45uhQmJy/kSot0m0f9J9Tqch+XS5vk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4938.eurprd08.prod.outlook.com (10.255.16.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 20 Sep 2019 11:53:58 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 11:53:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Topic: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVbLeo76n3Ba9lJkqJlS+3Y8+k26c0bngAgAAMPwA=
Date: Fri, 20 Sep 2019 11:53:57 +0000
Message-ID: <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
In-Reply-To: <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0140.eurprd05.prod.outlook.com
 (2603:10a6:7:28::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920145354906
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f012a5d-009d-454a-3df8-08d73dc13848
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4938; 
x-ms-traffictypediagnostic: DB8PR08MB4938:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4938968DBF4BC7DA935B7CE5C1880@DB8PR08MB4938.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(376002)(136003)(346002)(189003)(199004)(53754006)(2616005)(305945005)(6506007)(36756003)(66946007)(386003)(25786009)(256004)(107886003)(14454004)(6512007)(6486002)(5660300002)(4326008)(66476007)(31686004)(6306002)(66446008)(6436002)(66556008)(86362001)(64756008)(229853002)(8936002)(446003)(31696002)(76176011)(486006)(110136005)(26005)(54906003)(476003)(66066001)(7736002)(6246003)(316002)(186003)(71190400001)(53546011)(11346002)(102836004)(2501003)(52116002)(3846002)(2906002)(6116002)(81156014)(99286004)(478600001)(81166006)(8676002)(966005)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4938;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nfWhksow+xOYa9i50ahnyuD/xXkwnT3vIMHp1DGHzKhrzSPEoRQyTxfhLmxNDKCRewYZMwg9KB7bfGn34zvfW5+8ADvQeuUL4qvsulCycWoUhwH0HiwqihRvcvFd+WFGqvz3nmRS9nylwwsibTTc2U+6B1Zp6xcCPWZ+JSPH7sJPu9xRYXr+6gLDX/ZKnn8CzwqrUu7xC6YtxunAPZhPyXHilGX6zvrB5sXmRNVNt5AbWi2qteR4UlyfECuB+k2nqZhEMRuKL95ZZ165ldcsfQHZpgMI9OzRzOMclL2dnwhwazsoLor+LE+Pc8itCBUd3bK2JuMrFlcpMN9ABK7HYQ9SF8gIbYWQHSaNXpiSwJ/0kp6E9FuArCkMG2yr6u+V4Wfw9cHCB259uychFcqIjhCeYRNYy78176k/PVG4j/4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F822BC8EA1FDFF40B748693D8F9941EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f012a5d-009d-454a-3df8-08d73dc13848
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 11:53:57.9416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ycA3VN8RVcPfkpN9fPdJnA3ccl5qjU5ZGMK9S7gMbboh3lJgquJyCimHxKJtD1w+4L52Z6zkIAXeUuNK+JoDx2gSW0XL/ArFA0Wnp/JfF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4938
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.109
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxNDoxMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNi4wOS4xOSAxOTo1Mywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBI
ZXJlIGlzIGFuIGFzeW5jaHJvbm91cyBzY2hlbWUgZm9yIGhhbmRsaW5nIGZyYWdtZW50ZWQgcWNv
dzINCj4+IHJlYWRzIGFuZCB3cml0ZXMuIEJvdGggcWNvdzIgcmVhZCBhbmQgd3JpdGUgZnVuY3Rp
b25zIGxvb3BzIHRocm91Z2gNCj4+IHNlcXVlbnRpYWwgcG9ydGlvbnMgb2YgZGF0YS4gVGhlIHNl
cmllcyBhaW0gaXQgdG8gcGFyYWxsZWxpemUgdGhlc2UNCj4+IGxvb3BzIGl0ZXJhdGlvbnMuDQo+
PiBJdCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBmb3IgZnJhZ21lbnRlZCBxY293MiBpbWFnZXMsIEkn
dmUgdGVzdGVkIGl0DQo+PiBhcyBkZXNjcmliZWQgYmVsb3cuDQo+IA0KPiBUaGFua3MgYWdhaW4s
IGFwcGxpZWQgdG8gbXkgYmxvY2sgYnJhbmNoOg0KPiANCj4gaHR0cHM6Ly9naXQueGFuY2xpYy5t
b2UvWGFuQ2xpYy9xZW11L2NvbW1pdHMvYnJhbmNoL2Jsb2NrDQoNClRoYW5rcyBhIGxvdCENCg0K
PiANCj4+IHY1OiBmaXggMDI2IGFuZCByZWJhc2Ugb24gTWF4J3MgYmxvY2sgYnJhbmNoIFtwZXJm
IHJlc3VsdHMgbm90IHVwZGF0ZWRdOg0KPj4NCj4+IDAxOiBuZXcsIHByZXBhcmUgMDI2IHRvIG5v
dCBmYWlsDQo+PiAwMzogLSBkcm9wIHJlYWRfZW5jcnlwdGVkIGJsa2RiZyBldmVudCBbS2V2aW5d
DQo+PiAgICAgIC0gYXNzZXJ0KCh4ICYgKEJEUlZfU0VDVE9SX1NJWkUgLSAxKSkgPT0gMCkgLT4g
YXNzZXJ0KFFFTVVfSVNfQUxJR05FRCh4LCBCRFJWX1NFQ1RPUl9TSVpFKSkgW3JlYmFzZV0NCj4+
ICAgICAgLSBmdWxsIGhvc3Qgb2Zmc2V0IGluIGFyZ3VtZW50IG9mIHFjb3cyX2NvX2RlY3J5cHQg
W3JlYmFzZV0NCj4+IDA0OiAtIHN1YnN0aXR1dGUgcmVtYWluaW5nIHFjb3cyX2NvX2RvX3B3cml0
ZXYgYnkgcWNvdzJfY29fcHdyaXRldl90YXNrIGluIGNvbW1lbnQgW01heF0NCj4+ICAgICAgLSBm
dWxsIGhvc3Qgb2Zmc2V0IGluIGFyZ3VtZW50IG9mIHFjb3cyX2NvX2VuY3J5cHQgW3JlYmFzZV0N
Cj4+IDA1OiAtIE5vdyBwYXRjaCBkb24ndCBhZmZlY3QgMDI2IGlvdGVzdCwgc28gaXRzIG91dHB1
dCBpcyBub3QgY2hhbmdlZA0KPj4NCj4+IFJlYmFzZSBjaGFuZ2VzIHNlZW1zIHRyaXZpYWwsIHNv
LCBJJ3ZlIGtlcHQgci1iIG1hcmtzLg0KPiANCj4gKEZvciB0aGUgcmVjb3JkLCBJIGRpZG7igJl0
IGNvbnNpZGVyIHRoZW0gdHJpdmlhbCwgb3IgSeKAmWTigJl2ZSBhcHBsaWVkDQo+IE1heGlt4oCZ
cyBzZXJpZXMgb24gdG9wIG9mIHlvdXJzLiAgSSBjb25zaWRlciBhIGNvbmZsaWN0IHRvIGJlIHRy
aXZpYWxseQ0KPiByZXNvbHZhYmxlIG9ubHkgaWYgdGhlcmUgaXMgb25seSBvbmUgd2F5IG9mIGRv
aW5nIGl0OyBidXQgd2hlbiBJDQo+IHJlc29sdmVkIHRoZSBjb25mbGljdHMgbXlzZWxmLCBJIHJl
c29sdmVkIHRoZSBvbmUgaW4gcGF0Y2ggMyBkaWZmZXJlbnRseQ0KPiBmcm9tIHlvdSDigJMgSSBh
ZGRlZCBhbiBvZmZzZXRfaW5fY2x1c3RlciB2YXJpYWJsZSB0bw0KPiBxY293Ml9jb19wcmVhZHZf
ZW5jcnlwdGVkKCkuICBTdXJlLCBpdOKAmXMgc3RpbGwgc2ltcGxlIGFuZCB0aGUgZGlmZmVyZW5j
ZQ0KPiBpcyBtaW5vciwgYnV0IHRoYXQgd2FzIGV4YWN0bHkgd2hlcmUgSSB0aG91Z2h0IHRoYXQg
SSBjYW7igJl0IGNvbnNpZGVyDQo+IHRoaXMgdHJpdmlhbC4pDQo+IA0KDQpIbW0uIE1heSBiZSBp
dCdzIHRyaXZpYWwgZW5vdWdoIHRvIGtlZXAgci1iIChhcyBteSBjaGFuZ2UgaXMgdHJpdmlhbCBp
dHNlbGYpLCBidXQgbm90DQp0cml2aWFsIGVub3VnaCB0byBjaGFuZ2UgYWxpZW4gcGF0Y2ggb24g
cXVldWluZz8gSWYgeW91IGRpc2FncmVlLCBJJ2xsIGJlIG1vcmUNCmNhcmVmdWwgb24ga2VlcGlu
ZyByLWIgaW4gY2hhbmdlZCBwYXRjaGVzLCBzb3JyeS4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

