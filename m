Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196A5C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BB820730
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qlJPxY46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BB820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWeKO-0002vD-24
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iWeIY-0001sQ-GD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iWeIW-00059f-Ru
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:30:22 -0500
Received: from mail-am5eur02on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::711]:44814
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iWeIW-00059D-Lq; Mon, 18 Nov 2019 05:30:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU4hLFhB9H4PQjraOMP574cpjJDFsyx3TlJsQZt25CGWwVwfVX+LhdagFcwuGKRu4nbPamkmmcx1ndmHgcgMHY4YncsHpCPP6S2P8T1twN6f5B0P8vFRpUoX0YZmFUCK+vnuUrXrBqDiLJ46AZ9VpXebJpZ+ARhlDdA6dzmupvcGP6+JMuVvUmV7eMYuxe6pheqZC9owa8UuboPPyCzTeh6v/WP2PQ0ql57xZdburL3YLbgK+etU6XfB3jed01gouwhDPe3hOBunqfC6UsKhlioayAcicvfCxMY9qc814rZT8JRy/nyTY/2pBXtb7ahMTdgg1wypC62UPrZe8W6QOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tATb+/piZfo5M1aRsAHScr5O3b4sN12Je4wEwSAoHNA=;
 b=hcds4FnlOAALChrJ6NLXaXJ/ZRXsrRTXesKByqTz0OwVMl3O4DREiO2qw78KrnQiPotJcQeV2bewUi6puDLD1ezeC3z70T3Nnt7XchQvHiR4IdQ8TLknd/EOM5rx3/fAMxnGuYmXMe0LJFg0b3lGZ31C6hwaom0e8CjDs+BhJdX+Wrwclbdn6RYfSs/s60JOSzG08RLC/K2vM51iQ1wZYvvcpoZ3aEm1zNl+YxXAxQorjB/xBs3uTCMfSp3ZSm4EnSrFc7qwUQfsF0d3urZqxXo5wJmV2BC4solFAIx9a4iKWaN+EeR/7nUVaybtyFkq+7ldhT14EeWQgoukvDlqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tATb+/piZfo5M1aRsAHScr5O3b4sN12Je4wEwSAoHNA=;
 b=qlJPxY460Iq39AQRg47Zi9UHBI7is07HSYJoMBsnfy8ihSYMAfDMiFfJA2bJ27VPiN12yP8uRUp2bsggoKxI/oCzWys1VTo0B4zOpYYrnWwXQhogWmRwPFMp38c40KdwoFGt9ogaPXhB/y0ci6I5d7YBnNKuFl6hFfmkXxIcPKA=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3459.eurprd08.prod.outlook.com (20.177.110.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 10:30:11 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 10:30:11 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v0 0/2] allow to set 'drive' property on a realized block
 device
Thread-Topic: [PATCH v0 0/2] allow to set 'drive' property on a realized block
 device
Thread-Index: AQHVl/mlibo7ZG8X4kOJhAn0iDaTjqeQxlkA
Date: Mon, 18 Nov 2019 10:30:11 +0000
Message-ID: <be30ccc4-4b3c-8d5a-2060-5f461b7f4554@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::14) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.163.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c061f887-456c-4434-0585-08d76c124aac
x-ms-traffictypediagnostic: AM0PR08MB3459:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3459B4B8DDC5872CFE0A0A01CF4D0@AM0PR08MB3459.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(366004)(396003)(136003)(376002)(199004)(189003)(36756003)(52116002)(316002)(76176011)(446003)(5660300002)(26005)(25786009)(6246003)(107886003)(6436002)(5640700003)(6306002)(53546011)(6116002)(476003)(2616005)(386003)(6506007)(31696002)(102836004)(486006)(66556008)(66446008)(478600001)(64756008)(66476007)(186003)(66066001)(14454004)(966005)(71190400001)(71200400001)(66946007)(99286004)(14444005)(256004)(6916009)(4326008)(31686004)(11346002)(2501003)(6486002)(3846002)(305945005)(7736002)(8936002)(229853002)(8676002)(81166006)(81156014)(54906003)(6512007)(2906002)(2351001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3459;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VIjclK7r13wIzB44RoBMAUSN3cgHPjX7C1xUSZRlq6blq2sYhYVCs+ZWKS9NKF+cUnAxdlLzT47Yl3wK8IXWviY0jVGDjoW05jKJ8POclFlDc9IRjhte8aoyEY6Ug+02EOwcQquzcuBMwt27ygjcuasa5+MqBW2Y9IYQDD8C+N3pmrcwdRqw3ZkPLq7nSvDNJh/HRQ5qQ0+uU8bBgNLNUbtnSdDe4oaUPkNN29CpGGGplDt/f+nlr/zkKrOJ3hSn7sop6KtKVfLfoUl9FTN/T2eJfQeeiHNug2U8VAtc15hciGuWXb3QOVTVl0+nzrMwr+134MSLhvNED8uEj6iCebNDH14CVDcEFCPSx9K3WJlrQVODRyeEmk6BhGSHxVs/d5UgJ5aVvjBkuBkH9CCcIGf1Nqkg7KONVGgbFsXJDUWbVjXaZaJ1VQZPmuIdv6ag
Content-Type: text/plain; charset="utf-8"
Content-ID: <63B333ACB4D37D42B0ED274CD9412E3E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c061f887-456c-4434-0585-08d76c124aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 10:30:11.5802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V701c7LGschnvqPxZIOa0abxLs6nrGOrkJWQqY3f17D8nxupmrE8iEugnCTgGviMgrSiLOJlAz/TYEUXUh/er2ttwtJKnHNKo7gGvESD7ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3459
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::711
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KT24gMTAuMTEuMjAxOSAyMjowMywgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBU
aGlzIGFsbG93cyB0byByZXBsYWNlIHRoZSBmaWxlIG9uIGEgYmxvY2sgZGV2aWNlIGFuZCBpcyB1
c2VmdWwNCj4gdG8gd29ya2Fyb3VuZCB0aGUgY2FzZXMgKG1pZ3JhdGlvbikgd2hlbiB0aGUgVk0g
aW1hZ2UgaXMgcGxhY2VkIG9uDQo+IHNvbWUgc2hhcmVkIHN0b3JhZ2Ugd2l0aCBleGNsdXNpdmUg
ZmlsZSBvcGVuaW5nIG1vZGVsIGJ1dCB0aGUgaW1hZ2UNCj4gc2hvdWxkIGJlIG9wZW4gZm9ybSBt
b3JlIHRoYW4gb25lIGFwcC4NCj4NCj4gVGhlIHByZXZpb3VzIHZlcnNpb24gb2YgYXBwcm9hY2hp
bmcgdGhlIHdvcmthcm91bmQgd2FzIGJhc2VkIG9uIHRoZQ0KPiAiYmxvY2tkZXYtY2hhbmdlLW1l
ZGl1bSIgY29tbWFuZCBtb2RpZmljYXRpb24gYnV0IGhhZCBzb21lIGZsYXdzOg0KPiAgICAqIHNl
bWFudGljczogYmxvY2tkZXYtY2hhbmdlLW1lZGl1bSBpcyBhaW1lZCB0byBiZSB1c2VkIHdpdGgg
cmVtb3ZhYmxlIGRldmljZXMNCj4gICAgICBvbmx5DQo+ICAgICogaW50ZXJmYWNlOiBpdCBjYW4n
dCBhY2NlcHQgYWxsIHBvc3NpYmxlIGNvbWJpbmF0aW9uIG9mIHBhcmFtZXRlcnMgZm9yDQo+ICAg
ICAgdGhlICJkcml2ZSIgcmVwbGFjZW1lbnQgKGNyZWF0aW9uKS4NCj4NCj4gTW9yZSBkZXRhaWxz
IGhlcmU6IGh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMTc5MzI5Lw0KPg0KPiBU
aGUgY3VycmVudCBzZXJpZXMgc3VnZ2VzdHMgYW5vdGhlciBhcHByb2FjaDoNCj4gMS4gYmxvY2tk
ZXYtYWRkDQo+IDIuIHFvbS1zZXQgZGlzay5kcml2ZSA9IHRoZSBibG9ja2RldiBhZGRlZCAodGhp
cyBpcyB3aGF0IHRoZSBzZXJpZXMgYWRkcykNCj4gICANCj4NCj4gRGVuaXMgUGxvdG5pa292ICgy
KToNCj4gICAgcWRldi1wcm9wZXJ0aWVzLXN5c3RlbTogZXh0ZW5kIHNldF9waW9udGVyIGZvciB1
bnJlYWxpemVkIGRldmljZXMNCj4gICAgYmxvY2s6IGFsbG93IHRvIHNldCAnZHJpdmUnIHByb3Bl
cnR5IG9uIGEgcmVhbGl6ZWQgYmxvY2sgZGV2aWNlDQo+DQo+ICAgaHcvY29yZS9xZGV2LXByb3Bl
cnRpZXMtc3lzdGVtLmMgfCAxMTcgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4NCg0K

