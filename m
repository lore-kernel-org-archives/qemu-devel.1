Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED43FC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A218C206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PCd3iZyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A218C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWIZ-0004Xk-Ob
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:12:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGl-0003Fb-28
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGj-0001zn-CV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:54 -0400
Received: from mail-ve1eur01on072b.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::72b]:39198
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGb-0001pj-Ul; Tue, 14 May 2019 08:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Rg7D/a+iT9WfCd2aWRPFbMGZPpRwrY5dRk0eN4Tjngs=;
	b=PCd3iZyBRWmtH7jULuSKp+KjSBOZBME6BwAhTwpctHEhRQVDFx1Qr29noF+SPGKWGzvOxUrfMMtJ+v4ZbE+cGim4pEigY4oDdxlY5i4mFGNij0ZGr6rWWYGWmpEiDdMzAN8ekhLC19Mysr9iQheJrxje0G80PC4cINK7we/1cnI=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4480.eurprd08.prod.outlook.com (20.179.27.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:41 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:41 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 1/9] qapi: group BlockDeviceStats fields
Thread-Index: AQHVCk4Msg5xVF3ks0K0yXQYuJj01Q==
Date: Tue, 14 May 2019 12:10:41 +0000
Message-ID: <20190514121015.32190-2-anton.nefedov@virtuozzo.com>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0057.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29aa7d06-e5f2-4ff3-48ac-08d6d8652ef9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4480; 
x-ms-traffictypediagnostic: VI1PR08MB4480:
x-microsoft-antispam-prvs: <VI1PR08MB44809B41BE532CDB5ADAAB88F8080@VI1PR08MB4480.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39850400004)(189003)(199004)(186003)(86362001)(6116002)(486006)(3846002)(66066001)(4326008)(256004)(52116002)(316002)(26005)(44832011)(36756003)(6512007)(6486002)(25786009)(6506007)(14444005)(478600001)(102836004)(6916009)(386003)(2351001)(54906003)(76176011)(64756008)(66446008)(66556008)(5640700003)(7736002)(14454004)(2616005)(2906002)(73956011)(53936002)(476003)(71190400001)(446003)(71200400001)(11346002)(99286004)(107886003)(66946007)(66476007)(2501003)(305945005)(6436002)(8936002)(1076003)(81166006)(81156014)(8676002)(5660300002)(50226002)(68736007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4480;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ZiYLaJgTMEaeYypNXmYesDANv7TkuFuoCbCXk0hnNOiLVIl/5dtHx5oJKzWrYKj5IJT+4UEiQISbr5/iBsnxIqJWoFmgPm/FomfdkuvRgEKOASL5YFoipNf/w8j6YK3mhC6T5B6GcrTuKWM9YFKoCGWKEa7dcV5TnMFNngzddyMInBQN2jjxdTtWETY1v0nUaKJm+VryEPXq6jRjXTTdiMOcUwHvmNKbZyMeBF5S5eDijLb0AEbXIIvTs8bMJZvqH8SXa2XPxlvEtSuHOmuFETovrDvLWmaGXAtLuFhyZFfOX13SVlYyfN+Tg+GqZWtVKkEp0EWF75UNlE8sgP/hpWyyXQilhs9fOgC3Qk+AF/R+fWPTcYYwr1b18ruCf2uikZ7MJTsAAbeTVYLSEE6893HU2lyQLr7aUfG5SuQajo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aa7d06-e5f2-4ff3-48ac-08d6d8652ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:41.3441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::72b
Subject: [Qemu-devel] [PATCH v7 1/9] qapi: group BlockDeviceStats fields
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSB0aGUgc3RhdCBmaWVsZHMgZGVmaW5pdGlvbiBzbGlnaHRseSBtb3JlIHJlYWRhYmxlLg0K
QWxzbyByZW9yZGVyIHRvdGFsX3RpbWVfbnMgc3RhdHMgcmVhZC13cml0ZS1mbHVzaCBhcyBkb25l
IGVsc2V3aGVyZS4NCkNvc21ldGljIGNoYW5nZSBvbmx5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBBbnRv
biBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQpSZXZpZXdlZC1ieTogQWxi
ZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KLS0tDQogcWFwaS9i
bG9jay1jb3JlLmpzb24gfCAyNiArKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCmluZGV4IDdjY2Jm
ZmY5ZDAuLjc1NGQwN2YxZmIgMTAwNjQ0DQotLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KKysr
IGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCkBAIC04NjMsMTIgKzg2MywxMiBAQA0KICMgQGZsdXNo
X29wZXJhdGlvbnM6IFRoZSBudW1iZXIgb2YgY2FjaGUgZmx1c2ggb3BlcmF0aW9ucyBwZXJmb3Jt
ZWQgYnkgdGhlDQogIyAgICAgICAgICAgICAgICAgICAgZGV2aWNlIChzaW5jZSAwLjE1LjApDQog
Iw0KLSMgQGZsdXNoX3RvdGFsX3RpbWVfbnM6IFRvdGFsIHRpbWUgc3BlbmQgb24gY2FjaGUgZmx1
c2hlcyBpbiBuYW5vLXNlY29uZHMNCi0jICAgICAgICAgICAgICAgICAgICAgICAoc2luY2UgMC4x
NS4wKS4NCisjIEByZF90b3RhbF90aW1lX25zOiBUb3RhbCB0aW1lIHNwZW50IG9uIHJlYWRzIGlu
IG5hbm9zZWNvbmRzIChzaW5jZSAwLjE1LjApLg0KICMNCi0jIEB3cl90b3RhbF90aW1lX25zOiBU
b3RhbCB0aW1lIHNwZW5kIG9uIHdyaXRlcyBpbiBuYW5vLXNlY29uZHMgKHNpbmNlIDAuMTUuMCku
DQorIyBAd3JfdG90YWxfdGltZV9uczogVG90YWwgdGltZSBzcGVudCBvbiB3cml0ZXMgaW4gbmFu
b3NlY29uZHMgKHNpbmNlIDAuMTUuMCkuDQogIw0KLSMgQHJkX3RvdGFsX3RpbWVfbnM6IFRvdGFs
X3RpbWVfc3BlbmQgb24gcmVhZHMgaW4gbmFuby1zZWNvbmRzIChzaW5jZSAwLjE1LjApLg0KKyMg
QGZsdXNoX3RvdGFsX3RpbWVfbnM6IFRvdGFsIHRpbWUgc3BlbnQgb24gY2FjaGUgZmx1c2hlcyBp
biBuYW5vc2Vjb25kcw0KKyMgICAgICAgICAgICAgICAgICAgICAgIChzaW5jZSAwLjE1LjApLg0K
ICMNCiAjIEB3cl9oaWdoZXN0X29mZnNldDogVGhlIG9mZnNldCBhZnRlciB0aGUgZ3JlYXRlc3Qg
Ynl0ZSB3cml0dGVuIHRvIHRoZQ0KICMgICAgICAgICAgICAgICAgICAgICBkZXZpY2UuICBUaGUg
aW50ZW5kZWQgdXNlIG9mIHRoaXMgaW5mb3JtYXRpb24gaXMgZm9yDQpAQCAtOTIxLDE0ICs5MjEs
MTggQEANCiAjIFNpbmNlOiAwLjE0LjANCiAjIw0KIHsgJ3N0cnVjdCc6ICdCbG9ja0RldmljZVN0
YXRzJywNCi0gICdkYXRhJzogeydyZF9ieXRlcyc6ICdpbnQnLCAnd3JfYnl0ZXMnOiAnaW50Jywg
J3JkX29wZXJhdGlvbnMnOiAnaW50JywNCi0gICAgICAgICAgICd3cl9vcGVyYXRpb25zJzogJ2lu
dCcsICdmbHVzaF9vcGVyYXRpb25zJzogJ2ludCcsDQotICAgICAgICAgICAnZmx1c2hfdG90YWxf
dGltZV9ucyc6ICdpbnQnLCAnd3JfdG90YWxfdGltZV9ucyc6ICdpbnQnLA0KLSAgICAgICAgICAg
J3JkX3RvdGFsX3RpbWVfbnMnOiAnaW50JywgJ3dyX2hpZ2hlc3Rfb2Zmc2V0JzogJ2ludCcsDQot
ICAgICAgICAgICAncmRfbWVyZ2VkJzogJ2ludCcsICd3cl9tZXJnZWQnOiAnaW50JywgJyppZGxl
X3RpbWVfbnMnOiAnaW50JywNCisgICdkYXRhJzogeydyZF9ieXRlcyc6ICdpbnQnLCAnd3JfYnl0
ZXMnOiAnaW50JywNCisgICAgICAgICAgICdyZF9vcGVyYXRpb25zJzogJ2ludCcsICd3cl9vcGVy
YXRpb25zJzogJ2ludCcsDQorICAgICAgICAgICAnZmx1c2hfb3BlcmF0aW9ucyc6ICdpbnQnLA0K
KyAgICAgICAgICAgJ3JkX3RvdGFsX3RpbWVfbnMnOiAnaW50JywgJ3dyX3RvdGFsX3RpbWVfbnMn
OiAnaW50JywNCisgICAgICAgICAgICdmbHVzaF90b3RhbF90aW1lX25zJzogJ2ludCcsDQorICAg
ICAgICAgICAnd3JfaGlnaGVzdF9vZmZzZXQnOiAnaW50JywNCisgICAgICAgICAgICdyZF9tZXJn
ZWQnOiAnaW50JywgJ3dyX21lcmdlZCc6ICdpbnQnLA0KKyAgICAgICAgICAgJyppZGxlX3RpbWVf
bnMnOiAnaW50JywNCiAgICAgICAgICAgICdmYWlsZWRfcmRfb3BlcmF0aW9ucyc6ICdpbnQnLCAn
ZmFpbGVkX3dyX29wZXJhdGlvbnMnOiAnaW50JywNCi0gICAgICAgICAgICdmYWlsZWRfZmx1c2hf
b3BlcmF0aW9ucyc6ICdpbnQnLCAnaW52YWxpZF9yZF9vcGVyYXRpb25zJzogJ2ludCcsDQotICAg
ICAgICAgICAnaW52YWxpZF93cl9vcGVyYXRpb25zJzogJ2ludCcsICdpbnZhbGlkX2ZsdXNoX29w
ZXJhdGlvbnMnOiAnaW50JywNCisgICAgICAgICAgICdmYWlsZWRfZmx1c2hfb3BlcmF0aW9ucyc6
ICdpbnQnLA0KKyAgICAgICAgICAgJ2ludmFsaWRfcmRfb3BlcmF0aW9ucyc6ICdpbnQnLCAnaW52
YWxpZF93cl9vcGVyYXRpb25zJzogJ2ludCcsDQorICAgICAgICAgICAnaW52YWxpZF9mbHVzaF9v
cGVyYXRpb25zJzogJ2ludCcsDQogICAgICAgICAgICAnYWNjb3VudF9pbnZhbGlkJzogJ2Jvb2wn
LCAnYWNjb3VudF9mYWlsZWQnOiAnYm9vbCcsDQogICAgICAgICAgICAndGltZWRfc3RhdHMnOiBb
J0Jsb2NrRGV2aWNlVGltZWRTdGF0cyddLA0KICAgICAgICAgICAgJypyZF9sYXRlbmN5X2hpc3Rv
Z3JhbSc6ICdCbG9ja0xhdGVuY3lIaXN0b2dyYW1JbmZvJywNCi0tIA0KMi4xNy4xDQoNCg==

