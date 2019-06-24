Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B8C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454FB2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DLgVaEZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454FB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSIi-0000df-7P
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 12:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfSFv-00074c-Oz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfSFu-0001eo-Kc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:55:47 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:35914 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfSFq-0001Tx-7e; Mon, 24 Jun 2019 12:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mSBiT2pEA0L8FuoJ4Gwp5+26aJMwShveHRyp/07M6Y=;
 b=DLgVaEZ5PDDucfEvLbgIh3kexlrAOQ/UFwigCsT0uJ7aFmDjp3PdKGhVMfKGEaJ81BXnpJXqK5Tu40mxYli54zpjGUzdGjud3xa2mT3GjLjkaGjifi09TWpzVQLZHN/MJTt+CkVYD4GkAPl5hxZpCQTfzUSCSGRpjrv6w3JSdL8=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB3167.eurprd08.prod.outlook.com (52.133.15.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Mon, 24 Jun 2019 16:55:40 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 16:55:40 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 7/7] iotests: new file to suppress Valgrind errors
Thread-Index: AQHVIH/WtZ37DP0CJEiTLkjzsZK8gqafw2QAgAtW54A=
Date: Mon, 24 Jun 2019 16:55:39 +0000
Message-ID: <09632364-3d1d-9e5c-a050-f48f76d2e38c@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190617114544.GE7397@linux.fritz.box>
In-Reply-To: <20190617114544.GE7397@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::27)
 To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f890e9-ed34-4ca6-2dfb-08d6f8c4c97b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3167; 
x-ms-traffictypediagnostic: VI1PR08MB3167:
x-microsoft-antispam-prvs: <VI1PR08MB316766244F98F9543F58061AF4E00@VI1PR08MB3167.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(346002)(136003)(366004)(199004)(189003)(6436002)(11346002)(66946007)(53936002)(186003)(8936002)(53546011)(316002)(102836004)(7736002)(256004)(107886003)(305945005)(68736007)(6506007)(31686004)(6246003)(6116002)(3846002)(478600001)(76176011)(99286004)(52116002)(66066001)(2906002)(476003)(25786009)(14454004)(64756008)(229853002)(66446008)(4326008)(386003)(73956011)(86362001)(486006)(66556008)(2616005)(66476007)(446003)(44832011)(54906003)(6486002)(26005)(71200400001)(81166006)(36756003)(31696002)(5660300002)(81156014)(6512007)(8676002)(6916009)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3167;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mWJL0jb/AwClxYIYIbMslemRGxVkHzBmU5g0pZ5rWXAXsdEcR7GD1Qd8YuM+Nb73TW8T0sCYU4v1NnFhtxd0iasAEetPFq33f3hMzHL6ZILXb96HmDtTktC+YHO5hWYrw9xUWSlC8+Lgh9nzkkho2I+JTKNbaQ7LOHdeSXKbPUg7J05GHN6N6/7xgjE+MaZbbhw0n3WxNJSrY5X2tY5S0vVZxWyLO6rDA5vCHVY++oEMO7QLkiDfCno6eEwDETt1bJSLSM/ig68Qc+cHB30np6dv4/gCk+MxVPmmUzUA8lZ6g3jWTKENbb9gPsvM/O4Ha+n48Bse8KI34WQEyrqQ2dpmRLXrob2VCqlQZnndX8hobe26iaPmxuQbj9MjZ7nz0XUz6gDVWu8PeTsLidkJ4POcG7nQUdqc44YtDTlwwZQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8706C9B019109444914D51FAB40B4705@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f890e9-ed34-4ca6-2dfb-08d6f8c4c97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 16:55:39.9713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3167
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.137
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE3LzA2LzIwMTkgMTQ6NDUsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDExLjA2LjIw
MTkgdW0gMjA6MDIgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gVGhlIFZh
bGdyaW5kIHRvb2wgcmVwb3J0cyBhYm91dCBhbiB1bmluaXRpYWxpc2VkIG1lbW9yeSB1c2FnZSB3
aGVuIHRoZQ0KPj4gaW5pdGlhbGl6YXRpb24gaXMgYWN0dWFsbHkgbm90IG5lZWRlZC4gRm9yIGV4
YW1wbGUsIHRoZSBidWZmZXIgJ2J1ZicNCj4+IGluc3RhbnRpYXRlZCBvbiBhIHN0YWNrIG9mIHRo
ZSBmdW5jdGlvbiBndWVzc19kaXNrX2xjaHMoKS4NCj4gDQo+IEkgd291bGQgYmUgY2FyZWZ1bCB3
aXRoIGNhbGxpbmcgaW5pdGlhbGlzYXRpb24gIm5vdCBuZWVkZWQiLiBJdCBtZWFucw0KPiB0aGF0
IHRoZSB0ZXN0IGNhc2UgbWF5IG5vdCBiZWhhdmUgZW50aXJlbHkgZGV0ZXJtaW5zdGljIGJlY2F1
c2UgdGhlDQo+IHVuaW5pdGlhbGlzZWQgbWVtb3J5IGNhbiB2YXJ5IGJldHdlZW4gcnVucy5cDQoN
CkkgYW0gZ29pbmcgdG8gYW1lbmQgdGhlIGNvbW1lbnQuDQoNCkFuZHJleQ0KDQo+IA0KPiBJbiB0
aGlzIHNwZWNpZmljIGNhc2UsIEkgYXNzdW1lIHRoYXQgZ3Vlc3NfZGlza19sY2hzKCkgaXMgY2Fs
bGVkIGZvciBhDQo+IG51bGwgYmxvY2sgbm9kZSwgZm9yIHdoaWNoIC5iZHJ2X2NvX3ByZWFkdiBi
eSBkZWZhdWx0IHJldHVybnMgd2l0aG91dA0KPiBhY3R1YWxseSB3cml0aW5nIHRvIHRoZSBidWZm
ZXIuIEluc3RlYWQgb2YgaWdub3JpbmcgdGhlIHZhbGdyaW5kIGVycm9yLA0KPiB3ZSBjb3VsZCBp
bnN0ZWFkIHBhc3MgcmVhZC16ZXJvZXM9b24gdG8gdGhlIG51bGwgYmxvY2sgZHJpdmVyIHRvIG1h
a2UNCj4gdGhlIHRlc3QgZGV0ZXJtaW5pc3RpYy4NCg0KVGhlIGJ1ZmZlciB0aGF0IHRoZSBWYWxn
cmluZCBjb21wbGFpbnMgb2YgaXMgaW5pdGlhbGl6ZWQgYnkgdGhlIA0KZm9sbG93aW5nIGZ1bmN0
aW9uIGNhbGwgYmxrX3ByZWFkX3VudGhyb3R0bGVkKCkgdGhhdCByZWFkcyB0aGUgZmlyc3QgDQpC
RFJWX1NFQ1RPUl9TSVpFIGJ5dGVzIGZvcm0gYSBkaXNrICJ0byBndWVzcyB0aGUgZGlzayBsb2dp
Y2FsIGdlb21ldHJ5Ii4gDQpUaGUgVmFsZ3JpbmQgZG9lcyBub3QgcmVjb2duaXplIHRoYXQgd2F5
IG9mIGluaXRpYWxpemF0aW9uLiBJIGJlbGlldmUgd2UgDQpkbyBub3QgbmVlZCB0byB6ZXJvIHRo
ZSBidWZmZXIgaW5zdGFudGlhdGVkIG9uIHRoZSBzdGFjayBqdXN0IHRvIG1ha2UgDQp0aGUgVmFs
Z3JpbmQgc2lsZW50IHRoZXJlLg0KDQpBbmRyZXkNCg0KPiANCj4gKFVuZm9ydHVuYXRlbHksIHdo
aWxlIGFkZGluZyB0aGUgcmVhZC16ZXJvZXMgb3B0aW9uLCB3ZSBkaWRuJ3QgYWRkIGl0IHRvDQo+
IHRoZSBRQVBJIHNjaGVtYSwgc28gaXQncyBub3QgYXZhaWxhYmxlIHlldCBpbiAtYmxvY2tkZXYu
IEknbSBnb2luZyB0bw0KPiBzZW5kIGEgZml4IGZvciB0aGF0LCBidXQgbW9zdCBvZiB0aGUgcHJv
YmxlbWF0aWMgdGVzdCBjYXNlcyBwcm9iYWJseQ0KPiBkb24ndCBldmVuIHVzZSAtYmxvY2tkZXYu
KQ0KPiANCj4gS2V2aW4NCj4gDQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5
IFNoaW5rZXZpY2gNCg==

