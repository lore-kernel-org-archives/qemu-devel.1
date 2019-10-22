Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06040CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D632075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z6buDohi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D632075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtgd-0004Mr-Vx
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 08:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iMtfW-0003QF-0l
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iMtfU-00045X-Fq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:53:45 -0400
Received: from mail-eopbgr130091.outbound.protection.outlook.com
 ([40.107.13.91]:12803 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iMtfT-00044S-Qh; Tue, 22 Oct 2019 08:53:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faK+dgZIXRBAeYP+jB8pKWcfWXKDU8uKlShPkPygxCY31muLcpSzLfm6IPA+bEVi09wRHL0GZj8ssTu6mRQov8eKdtRD9dQBsBUmsaq0myKwP6TnMj+nL9l91SptQsPpvXbTvlnibwbrzhWAVWMudVYbgZaNwBLB5k+r9dcHp1mSN6o9AansR1TAd+Vfh6b9gh1kWxGW4oWOhVT7TxmdI3ozmIVi9EHYGZn/FcgJHABBoMs2/m/SlSS2JiJYWK3A+Z2GHhn1M+Rtd021BKzm4WH1S1VloXfKThTtNyG1ntp0K9c96KrUd+QWDKlTRttgWlYfrnuPkdY4PvOHVoVURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEo35LhnO5Tch1Gh+QzOhE6OjMgt8ws7GDI1fAPkLGA=;
 b=jh1ZtkfXXgCD0m3n6LXh/sytAETOv5pg82GjuE/lZ3343L2ZgTlHplULL3ktj4n2hI8ZdWA7JW+Zv5HzgiPTSWdQNBl5TZOiNmjKdwWngtyY9zUU0kAthB5WEzSpxeZ5ha+eGIYXP9HVmEPw+fzJcB3T3UN2WSZOOhWMuPyO+oHVN5lyRF6zLYmWhIr9ddArBWvkd2OPsTFeM6uVwOMLDW6qhW6JphnxX//tQQLxBWDnJ3BkgqE5nAxBzH0zlCqAVfAznF33ceQ/46Xk7ULDmZamS1IZW0Vld2kv0dF13HLoqU35UddohHObOYuQNgfYCxHrTbMEt3nXjmKiHhoLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEo35LhnO5Tch1Gh+QzOhE6OjMgt8ws7GDI1fAPkLGA=;
 b=Z6buDohilxJwQNPUiy3WTfCyqb2a5TsAVdL0HkSVIinDiyFDXujAN0ihFnY8eY+sP+Yb8SKacIEaS7LG59kHbuGpwzmqsruwx3czrXjy/MHGpOPP7SOIoDYTry3xz3aQ5r7TEjp/BdUE2k9OCGBrb+9nUY1Pdjl1LWQfTrqQg6M=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5522.eurprd08.prod.outlook.com (52.132.215.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 12:53:39 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 12:53:39 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Topic: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Index: AQHVhaz+7x8iUD8wDUy+y9mCSVwunqdgfsuAgARfzQCAAadPgIAAHi4A
Date: Tue, 22 Oct 2019 12:53:39 +0000
Message-ID: <12dab583-cc5e-f790-a77b-b0476f2aa1d1@virtuozzo.com>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
 <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
In-Reply-To: <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:7:28::20) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.161.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 837f50ff-c05f-48f0-7648-08d756eedc2b
x-ms-traffictypediagnostic: AM0PR08MB5522:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5522A267197DE0043C25F277CF680@AM0PR08MB5522.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(39840400004)(366004)(346002)(189003)(199004)(305945005)(7736002)(6436002)(110136005)(54906003)(4326008)(6486002)(229853002)(316002)(6246003)(107886003)(52116002)(102836004)(478600001)(2501003)(76176011)(36756003)(386003)(6506007)(53546011)(66066001)(26005)(14454004)(186003)(71190400001)(11346002)(8676002)(3846002)(256004)(14444005)(5024004)(446003)(71200400001)(86362001)(81166006)(8936002)(486006)(2616005)(81156014)(25786009)(476003)(31696002)(5660300002)(99286004)(66946007)(6512007)(66446008)(64756008)(31686004)(66556008)(6116002)(66476007)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5522;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRE/B8Z+7sRzDh1ljgp6SmSC8pj53Y9bGBMGvpt0WaYbx7yg1CrzoX1RcmYpV36PKtCEdvelUsuawymcZnx6mgzHh33Jzxj4jTZAfThSLeegA5+K2eK5HplvZW6NDQqq+hdF7bj76xQyAM4M2Bln850BchnPcg92tQ7jmPK7DZs+HcH7k0eBus2Vv+vzvRdnj9M6IhlPJ40ugv/W6eI+wIRM8xLEec856LoNY8mflx2bQCxZL+meaLpKusR4Ct2g55iiQFd17YWoDj9uUCQuOd8+XBSrT0cdlzL1kX0yrRhT1m+xwfU9daLRTTAuaEc9gyMod0iBSMFSTiM2NoCLqX6432sdLl7t0L5XTArquz6l6SPlSB5iIGAQN1JBntRzTgiX/kc4xMOYeB/t5FMdUxKXWIiFaat/PYlteW1bqa0yvK93GE7fZ0Gu64qP0Txd
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F08706E63FC9748BC2026C9EB38CAB6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837f50ff-c05f-48f0-7648-08d756eedc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 12:53:39.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNE52S8z5TGjh9ifjyGaPiaIG7inaZeEV9oWpFfDlydzWILQAMdl5MJnP4HARkNNO8JjS3K+jnCw0+qlfGUzHEeoRrdNiUDbCoPVf1eil3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5522
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.91
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAyMi4xMC4yMDE5IDE0OjA1LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDIxLjEwLjE5IDA4
OjUwLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBPbiAxOC4xMC4yMDE5IDE4OjAyLCBNYXgg
UmVpdHogd3JvdGU6DQo+Pj4gT24gMTguMTAuMTkgMTQ6MDksIERlbmlzIFBsb3RuaWtvdiB3cm90
ZToNCj4+Pj4gVGhlIG1vZGlmaWNhdGlvbiBpcyB1c2VmdWwgdG8gd29ya2Fyb3VuZCBleGNsdXNp
dmUgZmlsZSBhY2Nlc3MgcmVzdHJpY3Rpb25zLA0KPj4+PiBlLmcuIHRvIGltcGxlbWVudCBWTSBt
aWdyYXRpb24gd2l0aCBzaGFyZWQgZGlzayBzdG9yZWQgb24gYSBzdG9yYWdlIHdpdGgNCj4+Pj4g
dGhlIGV4Y2x1c2l2ZSBmaWxlIG9wZW5pbmcgbW9kZWw6IGEgZGVzdGluYXRpb24gVk0gaXMgc3Rh
cnRlZCB3YWl0aW5nIGZvcg0KPj4+PiBpbmNvbW1pbmcgbWlncmF0aW9uIHdpdGggYSBmYWtlIGlt
YWdlIGRyaXZlLCBhbmQgbGF0ZXIsIG9uIHRoZSBsYXN0IG1pZ3JhdGlvbg0KPj4+PiBwaGFzZSwg
dGhlIGZha2UgaW1hZ2UgZmlsZSBpcyByZXBsYWNlZCB3aXRoIHRoZSByZWFsIG9uZS4NCj4+Pj4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6
by5jb20+DQo+Pj4gSXNu4oCZdCB0aGlzIHdoYXQgd2Ugd291bGQgd2FudCB0byB1c2UgcmVvcGVu
IGZvcj8NCj4+Pg0KPj4+IE1heA0KPj4gQ291bGQgeW91IHBsZWFzZSBleHBsYWluIHdoYXQgaXMg
InVzZSByZW9wZW4iPw0KPiBJIHdhcyB0aGlua2luZyBvZiB1c2luZyAoeC0pYmxvY2tkZXYtcmVv
cGVuIHRvIGNoYW5nZSB0aGUgZmlsZSB0aGF0IGlzDQo+IHVzZWQgYnkgdGhlIGZvcm1hdCBub2Rl
IChlLmcuIGZyb20gYSBudWxsLWNvIG5vZGUgdG8gYSByZWFsIGZpbGUpOyBvciB0bw0KPiBjaGFu
Z2UgdGhlIGZpbGVuYW1lIG9mIHRoZSBwcm90b2NvbCBub2RlLg0KPg0KPiBLZXZpbiBoYXMgcG9p
bnRlZCBvdXQgKG9uIElSQykgdGhhdCB0aGlzIHdpbGwgbm90IGFsbG93IHlvdSB0byBjaGFuZ2UN
Cj4gdGhlIG5vZGUgdGhhdCBpcyBkaXJlY3RseSBhdHRhY2hlZCB0byB0aGUgZGV2aWNlLiAgV2hp
bGUgSSBkb27igJl0IGtub3cNCj4gd2hldGhlciB0aGF04oCZcyByZWFsbHkgbmVjZXNzYXJ5IGlu
IHRoaXMgY2FzZSwgaWYgaXQgd2VyZSBpbmRlZWQNCj4gbmVjZXNzYXJ5LCBJ4oCZZCBwcmVmZXIg
YSBtZXRob2QgdG8gY2hhbmdlIGEgZ3Vlc3QgZGV2aWNl4oCZcyBAZHJpdmUgb3B0aW9uDQo+IGJl
Y2F1c2UgdGhhdCBzZWVtcyBtb3JlIG5hdHVyYWwgdG8gbWUuDQo+DQo+IEluIGNvbnRyYXN0LCB0
aGUgYXBwcm9hY2ggdGFrZW4gaW4gdGhpcyBwYXRjaCBzZWVtcyBub3QgcXVpdGUgcmlnaHQgdG8N
Cj4gbWUsIGJlY2F1c2UgaXQgb3ZlcmxvYWRzIHRoZSB3aG9sZSBibG9ja2Rldi1jaGFuZ2UtbWVk
aXVtIGNvbW1hbmQgd2l0aCBhDQo+IGNvbXBsZXRlbHkgbmV3IGFuZCBkaWZmZXJlbnQgaW1wbGVt
ZW50YXRpb24gYmFzZWQgb24gd2hldGhlciB0aGVyZeKAmXMgYQ0KPiByZW1vdmFibGUgbWVkaXVt
IG9yIG5vdC4gIElmIHRoZSBpbXBsZW1lbnRhdGlvbiBpcyBzbyBkaWZmZXJlbnQgKGFuZCB0aGUN
Cj4gaW50ZXJmYWNlIGlzLCB0b28sIGJlY2F1c2UgaW4gb25lIHBhdGggeW91IG11c3QgZ2l2ZSBA
bWVkaXVtIHdoZXJlYXMgdGhlDQo+IG90aGVyIGRvZXNu4oCZdCBldmFsdWF0ZSBpdCBhdCBhbGwp
LCBpdCBzaG91bGQgYmUgYSBuZXcgY29tbWFuZC4NCj4NCj4gSSBkb27igJl0IGtub3cgd2hldGhl
ciB3ZSBuZWVkIGEgbmV3IGNvbW1hbmQgYXQgYWxsLCB0aG91Z2guICBPbiB0aGUgbm9kZQ0KPiBs
ZXZlbCwgd2UgaGF2ZSAoeC0pYmxvY2tkZXYtcmVvcGVuLiAgU28gYXNzdW1pbmcgd2UgbmVlZCBz
b21ldGhpbmcgdG8NCj4gY2hhbmdlIHRoZSBsaW5rIGJldHdlZW4gdGhlIGd1ZXN0IGRldmljZSBh
bmQgdGhlIGJsb2NrIGxheWVyLCBJIHdvbmRlcg0KPiB3aGV0aGVyIHRoZXJlIGlzbuKAmXQgc29t
ZXRoaW5nIHNpbWlsYXI7IHNwZWNpZmljYWxseSwgSeKAmWQgcHJlZmVyDQo+IHNvbWV0aGluZyB0
byBzaW1wbHkgY2hhbmdlIHRoZSBkZXZpY2XigJlzIEBkcml2ZSBvcHRpb24uDQo+DQo+IEtldmlu
IGhhcyBwb2ludGVkIG91dCAob24gSVJDIGFnYWluKSB0aGF0IHRoZXJlIGlzIGluZGVlZCBvbmUg
c3VjaA0KPiBjb21tYW5kLCBhbmQgdGhhdOKAmXMgcW9tLXNldC4gIFVuZm9ydHVuYXRlbHksIHRo
aXMgaXMgd2hhdCBoYXBwZW5zIGlmIHlvdQ0KPiB0cnkgdG8gdXNlIGl0IGZvciBAZHJpdmU6DQo+
DQo+IHsiZXJyb3IiOiB7ImNsYXNzIjogIkdlbmVyaWNFcnJvciIsICJkZXNjIjogIkF0dGVtcHQg
dG8gc2V0IHByb3BlcnR5DQo+ICdkcml2ZScgb24gYW5vbnltb3VzIGRldmljZSAodHlwZSAndmly
dGlvLWJsay1kZXZpY2UnKSBhZnRlciBpdCB3YXMNCj4gcmVhbGl6ZWQifX0NCj4NCj4gSG93ZXZl
ciwgS2V2aW4gaGFzIGNsYWltZWQgaXQgd291bGQgYmUgdGVjaG5pY2FsbHkgcG9zc2libGUgdG8g
bWFrZSBhbg0KPiBleGNlcHRpb24gZm9yIEBkcml2ZS4gIE1heWJlIHRoaXMgaXMgd29ydGggaW52
ZXN0aWdhdGluZz8NCg0KSXMgdGhlcmUgYW55IGd1ZXNzIGhvdyBjb21wbGV4IGl0IG1pZ2h0IGJl
PyBJbiB0aGUgY2FzZSBpZiBpdCdzIHF1aXRlIA0KY29tcGxleCBtYXkgYmUgaXQncyB3b3J0aCB0
byBtYWtlIHRoZSBzZXBhcmF0ZSBjb21tYW5kPw0KDQo+DQo+DQo+IChBcyBmb3IgYmxvY2tkZXYt
Y2hhbmdlLW1lZGl1bSwgYXMgSeKAmXZlIHNhaWQsIEkgZG9u4oCZdCByZWFsbHkgdGhpbmsgdGhp
cw0KPiBmaXRzIHRoZXJlLiAgRnVydGhlcm1vcmUsIGJsb2NrZGV2LWNoYW5nZS1tZWRpdW0gaXMg
a2luZCBvZiBhIGxlZ2FjeQ0KPiBjb21tYW5kIGJlY2F1c2UgSSB0aGluayBldmVyeSBjb21tYW5k
IGJ1dCBibG9ja2Rldi1hZGQgdGhhdCBkb2VzIGENCj4gYmRydl9vcGVuKCkga2luZCBvZiBpcyBh
IGxlZ2FjeSBjb21tYW5kLg0KT3V0IG9mIGN1cmlvc2l0eSwgY291bGQgeW91IHBsZWFzZSBleHBs
YWluIHdoeSBpdCdzIGRlY2lkZWQgdG8gYmUgc28/DQo+IFNvIGlmIGFueXRoaW5nLCBpdCBzaG91
bGQgYmUgYQ0KPiBuZXcgY29tbWFuZCB0aGF0IHRoZW4gdGFrZXMgYSBub2RlLW5hbWUuDQo+IEJ1
dCBPVE9ILCBpdCB3b3VsZCBiZSBhIGJpdCBzdHJhbmdlIHRvIGFkZCBhIHNlcGFyYXRlIGNvbW1h
bmQgZm9yDQo+IHNvbWV0aGluZyB0aGF0IGluIHRoZW9yeSBzaG91bGQgYmUgY292ZXJlZCBieSBx
b20tc2V0IEBkcml2ZS4pDQo+DQo+IE1heA0KPg0K

