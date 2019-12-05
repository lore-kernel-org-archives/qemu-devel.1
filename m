Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2449BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE73206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N2NNS8jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE73206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictCk-0001e7-U5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icszG-0003V8-Bd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icszF-000687-5F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:24:14 -0500
Received: from mail-vi1eur04on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::712]:39331
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icszE-0005t4-Gl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:24:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/buNp3oGPYtmqIDITGkygpx6KZY3zQtVit/pUcjcQhHdqp13eTQMs4eaicoJd8b5zlvfYMtwCBWbQILfIpSgMlfO16+3GYOMyot/7q3gF3s/jGPW7jPGqGjVtjNeS3kuzvrdjQ0xe84JZxv4qH6EsobADEd9W3547yQMuIP70lWGGXeuVlOhHgsiclHHY4VGUok0cbYRdDzUYlc88tSkfzsiBmjPeW0GxElhKJyq8q0pRsOK6oJRrWWweYw+UX47FnCWlTXmmkh48Lbw4k61Tm7IWg4ymfEpqc7p4+4tfMKPVVfdbX37WACrOqt8jwoD/j9PKaXMdcoEZ9o9kaBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7al+nIHampC4P5Udr4xjAwqO3ClzNcqILw6UzmVhvy4=;
 b=asu1iyqhvwxGHJs0CaKexVNpYNZV5IkfXIAZTTF1GXyiU0JZtgNTgggzN+UJTFWlthjZtUrYdDvoEzUG4Vpo1TkRcjqAJ+YaKbscD7GBAQIiIRQ8YPTxzoeUy+MiOv2Pt0JCLq6iBrZTGjCZ5OLOsKyYrICqZItkParXxZF2weB0VvUrYvv82omzSkUpzRUS3u/TSuh3iEF0z9x0vGl1Wd4NuIzJ210vpOqQiLUI42HNScF9+xIHeL3AfqPHnSwO1e7o9HnD0SQCHcQfiXJjzYeXLtEAWCd9UZJY82r2/P0gXaSfVs3apBqZMh4qwlKnOXJBVd4KEU7rm5pB/exvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7al+nIHampC4P5Udr4xjAwqO3ClzNcqILw6UzmVhvy4=;
 b=N2NNS8jb4E7grbNLf/JU5RvW6tYkXPMjLUYIwvz9GmghYLDIk8w+o+USsartw3DEGuiLkkLhqENt8q2ZskZZhqgVeQOIB+v4+GOenz+gM+WkiBsWXisHjonfP6HX8e9iNmt60k7GzVFbX+M6ZxwdZHwOd9b8fgk7NeUWN+ns4Dk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 15:24:08 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:24:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 04/21] crypto: Fix certificate file error handling crash
 bug
Thread-Topic: [PATCH 04/21] crypto: Fix certificate file error handling crash
 bug
Thread-Index: AQHVp7ZbnY2XG/N6U0yo5cERHlzSxqersKKA
Date: Thu, 5 Dec 2019 15:24:08 +0000
Message-ID: <adfad9d1-0e71-4666-c153-676f3931089f@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-5-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-5-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0277.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205182405322
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 460de087-387a-4c39-7148-08d779972b79
x-ms-traffictypediagnostic: AM6PR08MB3797:
x-microsoft-antispam-prvs: <AM6PR08MB379703B4674093551D15D112C15C0@AM6PR08MB3797.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:255;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39850400004)(189003)(199004)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(186003)(229853002)(102836004)(86362001)(26005)(4326008)(5660300002)(305945005)(14454004)(81156014)(2906002)(81166006)(8676002)(478600001)(25786009)(31686004)(6486002)(14444005)(6512007)(36756003)(11346002)(2616005)(71200400001)(31696002)(6506007)(52116002)(110136005)(316002)(71190400001)(99286004)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8AkBL4YnCR26pQj+Mph0qBmatDy6Co219nBbeZqAxyVQLYaNv6U4U3MacEqVlXBoPIiqcRv/tBgtS7rSpWbRlswo7GW+RSLbl7xfy8ve524bZD37Vji5RU2XPymTEBSsOac6M76zwwQr8kivhIxnLx7PG8tDLNlyOa/pyG+KIJk3976qHJlPOcKy2ddiMFXaDuczU/MmxibcZ+ZfOLDwJatlvJ3Fm8SEpSgOURDpwj6WmzLFYetObmOdqZ/IgKxm0GcPq/4RM7KoGVEQ1WAKTKs/OjgCw0dhsQ57oHVd08VhtvfY7x8sbvKEYdI9mnvYeuEWlLyJNBCAW83aGmC56F6Fn1JCzfumtXs8ilZTkgz0sWvXMlA6CMbEGIoNJ6NQenA6awWcc92/9P3ynxdGGOfOQSBUCc+f2rp1MOQFMQzyPTr4LVrGlln8+NTwjOi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD720695787EC147B8E798774A7D85D8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460de087-387a-4c39-7148-08d779972b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:24:08.4099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtdGUchOH2EuwWgBzOMU/CR5xhpDvLubaaE4/vgs1TRJvbKJ886qB/6JC2sSWkY6jgL7BRnxFKKUE415XsrmMo4+p8d+ir7g3CoiWces2FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::712
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IHFjcnlwdG9fdGxz
X2NyZWRzX2xvYWRfY2VydCgpIHBhc3NlcyB1bmluaXRpYWxpemVkIEdFcnJvciAqZ2VyciBieQ0K
PiByZWZlcmVuY2UgdG8gZ19maWxlX2dldF9jb250ZW50cygpLiAgV2hlbiBnX2ZpbGVfZ2V0X2Nv
bnRlbnRzKCkgZmFpbHMsDQo+IGl0J2xsIHRyeSB0byBzZXQgYSBHRXJyb3IuICBVbmxlc3MgQGdl
cnIgaXMgbnVsbCBieSBkdW1iIGx1Y2ssIHRoaXMNCj4gbG9ncyBhIEVSUk9SX09WRVJXUklUVEVO
X1dBUk5JTkcgd2FybmluZyBtZXNzYWdlIGFuZCBsZWF2ZXMgQGdlcnINCj4gdW5jaGFuZ2VkLiAg
cWNyeXB0b190bHNfY3JlZHNfbG9hZF9jZXJ0KCkgdGhlbiBkZXJlZmVyZW5jZXMgdGhlDQo+IHVu
aW5pdGlhbGl6ZWQgQGdlcnIuDQo+IA0KPiBGaXggYnkgaW5pdGlhbGl6aW5nIEBnZXJyIHByb3Bl
cmx5Lg0KPiANCj4gRml4ZXM6IDlhMmZkNDM0N2M0MDMyMWY1Y2JiNGFiNDIyMGU3NTlmY2JmODdk
MDMNCj4gQ2M6ICJEYW5pZWwgUC4gQmVycmFuZ8OpIiA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KPiAt
LS0NCj4gICBjcnlwdG8vdGxzY3JlZHN4NTA5LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY3J5cHRv
L3Rsc2NyZWRzeDUwOS5jIGIvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jDQo+IGluZGV4IDAxZmMzMDRl
NWQuLjUzYTQzNjhmNDkgMTAwNjQ0DQo+IC0tLSBhL2NyeXB0by90bHNjcmVkc3g1MDkuYw0KPiAr
KysgYi9jcnlwdG8vdGxzY3JlZHN4NTA5LmMNCj4gQEAgLTM4MCw3ICszODAsNyBAQCBxY3J5cHRv
X3Rsc19jcmVkc19sb2FkX2NlcnQoUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsDQo+ICAgICAg
IGdudXRsc194NTA5X2NydF90IGNlcnQgPSBOVUxMOw0KPiAgICAgICBnX2F1dG9mcmVlIGNoYXIg
KmJ1ZiA9IE5VTEw7DQo+ICAgICAgIGdzaXplIGJ1ZmxlbjsNCj4gLSAgICBHRXJyb3IgKmdlcnI7
DQo+ICsgICAgR0Vycm9yICpnZXJyID0gTlVMTDsNCj4gICAgICAgaW50IHJldCA9IC0xOw0KPiAg
ICAgICBpbnQgZXJyOw0KPiAgIA0KPiANCg0KSSBkaWRuJ3QgY2hlY2sgdGhlIGxvZ2ljIGluIGNv
bW1pdCBtZXNzYWdlIChhbmQgSSBkb24ndCBrbm93IGhvdyBHRXJyb3Igd29ya3MpLA0KYnV0IGlu
aXRpYWxpemluZyBsb2NhbCBwb2ludGVyIHRvIE5VTEwgbmV2ZXIgaHVydHM6DQoNClJldmlld2Vk
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

