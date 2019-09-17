Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA6C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26717214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I2Jmcqyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26717214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFru-0006Vw-75
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAFk3-0008RW-7H
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAFk0-0007E1-9T
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:50:10 -0400
Received: from mail-eopbgr140128.outbound.protection.outlook.com
 ([40.107.14.128]:8866 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAFjz-0007CT-Ae; Tue, 17 Sep 2019 11:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCleundLOqBwmUIUzrxTUIMEaZQ9VhdPFd1ADeekoZC3sRh6Mr1qRXb/0bPL1FQ3j9YW3PJ/sc0Eq7QXBKNxaT3ieBk2CZ5BytVW9g9NkOYpG4vnA8IMXSUcxjWTkSWvzdx73dkz9EqINdIoq5qr8b3mke8LEEWMNyjISeAyRIug7bwdCbIrJUtN10xYeo/ZVzaTVrKFRxw7F3EXGqAaY7++d/fIsU+q3/bSLeCv1AgH+ERQRgPRdPhJrWmKJrjb4O+qcpvNyFLaK51O9m9ADji5OMDfuVqTbPWhW7zJxwaMZyx6p1PpRuNnG6mqQiNADio0NgmCzGpo+twiQO4rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kguFgAWgd86qGmq1QoCUKRuWCBdCbqet0ZynRhoE3pY=;
 b=i9a9Lhxd+YT1Yy8PqzK2b8T8bXw1gPV1+cmUuOfkkXnjs/qwwsxdAROk82tNb4ePAxzFl5TXQzTdPRho6iNLJvYsfSyNaJGAmdKm9BLe1Oms8Eh1A6KoUtMQlxHJb2pHe9Qn+aQIm92wYNPAftRedWpzN/pGhwSbRK0dqZ9t6FjsPb/HZENET7k+OeKlWkwOhe+Z5pGr9cOimrujwriPj3OhW2DEVDYRrGfxXJPvam4P4Gfg2bntwxwFqZu+NVN1hd3LBOlE0IeI1U7LHsC2mZ7CSSFd+qYPUwhW7WWqltGM+JrZrj9FrqNi/bY/IjNzG15bjKkmoNKgTHW6zCotag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kguFgAWgd86qGmq1QoCUKRuWCBdCbqet0ZynRhoE3pY=;
 b=I2Jmcqyvk8iQMWc9Nm9eSQp1FJb7K668e4ZkwK164NMN+W7o+Ile8mFoYC6gH/vOzw+hOpmFGE5Wwc4tC85uuw/T86i3j2G5AVbGVhBk1kOK9AmMnvxX+Yt6FgSQXZjMduxSUMWhT2Sv9Y1YZFVRN49q4XXPXzklTsHQi4L8dms=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5260.eurprd08.prod.outlook.com (10.255.17.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 17 Sep 2019 15:50:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:50:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v8 1/3] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Thread-Index: AQHVWEDQlz6z3mdYBUSaEAS5dc92WacwKHMAgAAGLIA=
Date: Tue, 17 Sep 2019 15:50:04 +0000
Message-ID: <29f3feba-4b42-004a-e1df-5e08033d8daa@virtuozzo.com>
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
 <20190821165215.61406-2-vsementsov@virtuozzo.com>
 <20190917152756.GG4824@localhost.localdomain>
In-Reply-To: <20190917152756.GG4824@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0224.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917185001909
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89dee95b-c25c-4f54-4b74-08d73b86b4ca
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5260; 
x-ms-traffictypediagnostic: DB8PR08MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB526028801C93DA7039FE65AEC18F0@DB8PR08MB5260.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(54094003)(3846002)(81166006)(81156014)(4326008)(8936002)(486006)(229853002)(31686004)(66066001)(478600001)(64756008)(8676002)(66446008)(66556008)(66476007)(66946007)(476003)(2616005)(316002)(25786009)(6116002)(14454004)(54906003)(11346002)(186003)(6246003)(26005)(14444005)(446003)(36756003)(305945005)(6512007)(6506007)(2906002)(107886003)(7736002)(6436002)(6916009)(76176011)(256004)(5660300002)(99286004)(52116002)(71190400001)(86362001)(71200400001)(102836004)(386003)(6486002)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5260;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t4FePL2P6jmhl5ZQ8v19t+FewicnhrEWra+yJzpwje3k8mmaQrZyAy5NEE59u6ic2luFMCUkN4DJU9WgXS1qfP5RORN4Jivug+yn0rUM5QYoVvO5h2BvbMHnV6A721kwOnoifwh4Em1mslCrp6oOgBBmiog9CL1qL8Z1BQgWtUUGAlGrbQd6kQbKA3Tvdixb9ta1oUABYRKX5hZV0shWzTNlvRnqWpnuD9C4gATSOLue624gOW9Gl8GE3ceVy8uM4YwocM+tvnj2bdIdrM+to3ZSFfbshlmFEevkMdHWhNHs/Ng5az3YGQjITImIpSI+kQncLIOix3T3vb64F99HAEgzeNrg7em+zSUEx1wHg7spFD4BhdO8pRS619C809f0WPUd0y4Lky+Diun00vv76H2Wb94q1QLALfxjH2MnEDg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73220131732EEF448F0063628F5E1181@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dee95b-c25c-4f54-4b74-08d73b86b4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:50:04.2198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3GW6mTih0qMT0KjsgaY5Mk92rYK+BfjMOWSu5/+luwidNqZ6X/5jDFxYJlecjvdHpNXcl2XI5YiZ21pXJUx5vE0gRq4JV5iazaA6rRKDPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5260
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.128
Subject: Re: [Qemu-devel] [PATCH v8 1/3] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "sheepdog@lists.wpkg.org" <sheepdog@lists.wpkg.org>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "namei.unix@gmail.com" <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDkuMjAxOSAxODoyNywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjEuMDguMjAxOSB1bSAx
ODo1MiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IElu
dHJvZHVjZSBhIGZ1bmN0aW9uIHRvIGdyYWNlZnVsbHkgd2FrZSBhIGNvcm91dGluZSBzbGVlcGlu
ZyBpbg0KPj4gcWVtdV9jb19zbGVlcF9ucygpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gDQo+
IEhtLCB0aGlzIGhhcyBiZWNvbWUgYSBiaXQgbW9yZSBjb21wbGV4IHdpdGggdGhlIG5ldyBzbGVl
cF9zdGF0ZSwgYnV0DQo+IGl0J3MgcHJvYmFibHkgdW5hdm9pZGFibGUgZXZlbiB3ZSBuZWVkIHRv
IHRpbWVyX2RlbCgpIGZyb20gdGhlIGNhbGxiYWNrLg0KPiANCj4+ICAgaW5jbHVkZS9xZW11L2Nv
cm91dGluZS5oICAgIHwgMTcgKysrKysrKysrKysrLS0NCj4+ICAgYmxvY2svbnVsbC5jICAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4+ICAgYmxvY2svc2hlZXBkb2cuYyAgICAgICAgICAgIHwgIDIg
Ky0NCj4+ICAgdGVzdHMvdGVzdC1iZHJ2LWRyYWluLmMgICAgIHwgIDYgKystLS0NCj4+ICAgdGVz
dHMvdGVzdC1ibG9jay1pb3RocmVhZC5jIHwgIDIgKy0NCj4+ICAgdXRpbC9xZW11LWNvcm91dGlu
ZS1zbGVlcC5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4g
ICA2IGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvY29yb3V0aW5lLmggYi9pbmNsdWRlL3FlbXUv
Y29yb3V0aW5lLmgNCj4+IGluZGV4IDk4MDFlN2Y1YTQuLjk2NzgwYTQ5MDIgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL3FlbXUvY29yb3V0aW5lLmgNCj4+ICsrKyBiL2luY2x1ZGUvcWVtdS9jb3Jv
dXRpbmUuaA0KPj4gQEAgLTI3NCw5ICsyNzQsMjIgQEAgdm9pZCBxZW11X2NvX3J3bG9ja193cmxv
Y2soQ29Sd2xvY2sgKmxvY2spOw0KPj4gICB2b2lkIHFlbXVfY29fcndsb2NrX3VubG9jayhDb1J3
bG9jayAqbG9jayk7DQo+PiAgIA0KPj4gICAvKioNCj4+IC0gKiBZaWVsZCB0aGUgY29yb3V0aW5l
IGZvciBhIGdpdmVuIGR1cmF0aW9uDQo+PiArICogWWllbGQgdGhlIGNvcm91dGluZSBmb3IgYSBn
aXZlbiBkdXJhdGlvbi4gRHVyaW5nIHRoaXMgeWllbGQgQHNsZWVwX3N0YXRlIChpZg0KPj4gKyAq
IG5vdCBOVUxMKSBpcyBzZXQgdG8gb3BhcXVlIHBvaW50ZXIsIHdoaWNoIG1heSBiZSB1c2VkIGZv
cg0KPj4gKyAqIHFlbXVfY29fc2xlZXBfd2FrZSgpLiBCZSBjYXJlZnVsLCB0aGUgcG9pbnRlciBp
cyBzZXQgYmFjayB0byB6ZXJvIHdoZW4gdGltZXINCj4+ICsgKiBzaG9vdHMuIERvbid0IHNhdmUg
b2J0YWluZWQgdmFsdWUgdG8gb3RoZXIgdmFyaWFibGVzIGFuZCBkb24ndCBjYWxsDQo+PiArICog
cWVtdV9jb19zbGVlcF93YWtlIGZyb20gYW5vdGhlciBhaW8gY29udGV4dC4NCj4+ICAgICovDQo+
PiAtdm9pZCBjb3JvdXRpbmVfZm4gcWVtdV9jb19zbGVlcF9ucyhRRU1VQ2xvY2tUeXBlIHR5cGUs
IGludDY0X3QgbnMpOw0KPj4gK3ZvaWQgY29yb3V0aW5lX2ZuIHFlbXVfY29fc2xlZXBfbnMoUUVN
VUNsb2NrVHlwZSB0eXBlLCBpbnQ2NF90IG5zLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAqKnNsZWVwX3N0YXRlKTsNCj4gDQo+IExldCdzIG1ha2UgdGhlIHR5
cGVkZWYgZm9yIFFlbXVDb1NsZWVwU3RhdGUgcHVibGljIHNvIHRoYXQgd2UgZG9uJ3QgaGF2ZQ0K
PiB0byB1c2UgYSB2b2lkIHBvaW50ZXIgaGVyZS4NCj4gDQo+IEkgd29uZGVyIGlmIGl0IHdvdWxk
IG1ha2Ugc2Vuc2UgdG8gcmVuYW1lIHRoaXMgZnVuY3Rpb24gYW5kIGtlZXANCj4gcWVtdV9jb19z
bGVlcF9ucygpIGFzIGEgd3JhcHBlciAobWF5YmUgZXZlbiBqdXN0IG1hY3JvKSBzbyB0aGF0IG1v
c3QNCj4gY2FsbGVycyBkb24ndCBoYXZlIHRvIGFkZCBhIE5VTEwuDQoNClN1cmUuIFN0cmFuZ2Ug
dGhhdCBJIGRpZG4ndCBnbyB0aGF0IHdheSBhbmQgdG91Y2hlZCBhIGxvdCBvZiBleHRyYSBmaWxl
cy4NCg0KPiANCj4+ICsvKioNCj4+ICsgKiBXYWtlIGEgY29yb3V0aW5lIGlmIGl0IGlzIHNsZWVw
aW5nIGJ5IHFlbXVfY29fc2xlZXBfbnMuIFRpbWVyIHdpbGwgYmUNCj4+ICsgKiBkZWxldGVkLiBA
c2xlZXBfc3RhdGUgbXVzdCBiZSB0aGUgdmFyaWFibGUgd2hpY2ggYWRkcmVzcyB3YXMgZ2l2ZW4g
dG8NCj4+ICsgKiBxZW11X2NvX3NsZWVwX25zKCkgYW5kIHNob3VsZCBiZSBjaGVja2VkIHRvIGJl
IG5vbi1OVUxMIGJlZm9yZSBjYWxsaW5nDQo+PiArICogcWVtdV9jb19zbGVlcF93YWtlKCkuDQo+
PiArICovDQo+PiArdm9pZCBxZW11X2NvX3NsZWVwX3dha2Uodm9pZCAqc2xlZXBfc3RhdGUpOw0K
Pj4gICANCj4+ICAgLyoqDQo+PiAgICAqIFlpZWxkIHVudGlsIGEgZmlsZSBkZXNjcmlwdG9yIGJl
Y29tZXMgcmVhZGFibGUNCj4gDQo+IFRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24gbG9va3Mgcmln
aHQgdG8gbWUsIHNvIHdpdGggYSBwdWJsaWMNCj4gUWVtdUNvU2xlZXBTdGF0ZSBhbmQgb3B0aW9u
YWxseSB0aGUgd3JhcHBlcjoNCj4gDQo+IFJldmlld2VkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkBy
ZWRoYXQuY29tPg0KPiANCg0KV2lsbCByZXNlbmQgd2l0aCBib3RoIHRoaW5ncywgdGhhbmsgeW91
IQ0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

