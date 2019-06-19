Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC9C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC2F208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC2F208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSdF-0006C9-LB
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 00:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair@alistair23.me>) id 1hdSbc-0004lP-Kt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1hdSba-0001GV-FD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:53:55 -0400
Received: from mail-oln040092255018.outbound.protection.outlook.com
 ([40.92.255.18]:6165 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1hdSba-0001Ex-4H
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:53:54 -0400
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT192.eop-APC01.prod.protection.outlook.com
 (10.152.252.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Wed, 19 Jun
 2019 04:53:50 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.11 via Frontend Transport; Wed, 19 Jun 2019 04:53:50 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57%2]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 04:53:50 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PATCH v3 1/6] armv7m: Allow entry information to be returned
Thread-Index: AQHVJlr5EI6advsLzUyHHdVjs+pQfw==
Date: Wed, 19 Jun 2019 04:53:50 +0000
Message-ID: <PSXP216MB02772CA8ED100BB578388BA6DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1560919807.git.alistair@alistair23.me>
In-Reply-To: <cover.1560919807.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:0A2DB9DA948C47458DDCD66E49D2CE4413EA324FEF203D898BC9337499876D96;
 UpperCasedChecksum:BC2A8FEC58C0638B7B5E4048525533D3EDAE6868469E47A418F1E2D683316B8D;
 SizeAsReceived:7593; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-tmn: [A6Fsicjmh3sB6uH0nxPFXHn4BldFepHMnGBANj3k7sZksnTol+75Dg0QSXKvBSoV]
x-microsoft-original-message-id: <83a4d0c4a1aa79e4483aec4c011a0fd72b4894d0.1560919807.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT192; 
x-ms-traffictypediagnostic: PU1APC01HT192:
x-microsoft-antispam-message-info: 5btHcM5U85/z5ymcygRI6RzCtAWvknuZSP2pcAOqVCNd9UGWk9irBBicB3ShdFB0xiFAEVlrxwJibovKI/rUQVR0LCR2NJzqOiQUC+yOHh2qUzevo4Ao3nRbNQu/YoTW4Es3KHAKdnPwVfZV4eBOyLMBRLp5qZ9RAwpbCgrX/U9wLZJWoHDFhyiZdnvrQ+kw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f0f314-9b65-4ce7-ec2e-08d6f4721b35
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 04:53:50.1674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT192
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.18
Subject: [Qemu-devel] [PATCH v3 1/6] armv7m: Allow entry information to be
 returned
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWxsb3cgdGhlIGtlcm5lbCdzIGVudHJ5IHBvaW50IGluZm9ybWF0aW9uIHRvIGJlIHJldHVybmVk
IHdoZW4gbG9hZGluZyBhDQprZXJuZWwuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+DQotLS0NCiBody9hcm0vYXJtdjdtLmMgICAgICAg
fCA0ICsrKy0NCiBpbmNsdWRlL2h3L2FybS9ib290LmggfCA0ICsrKy0NCiAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2Fy
bS9hcm12N20uYyBiL2h3L2FybS9hcm12N20uYw0KaW5kZXggYjllZmFkNmJhYy4uOGVlNjI5MWE0
NyAxMDA2NDQNCi0tLSBhL2h3L2FybS9hcm12N20uYw0KKysrIGIvaHcvYXJtL2FybXY3bS5jDQpA
QCAtMzA0LDcgKzMwNCw3IEBAIHN0YXRpYyB2b2lkIGFybXY3bV9yZXNldCh2b2lkICpvcGFxdWUp
DQogICAgIGNwdV9yZXNldChDUFUoY3B1KSk7DQogfQ0KIA0KLXZvaWQgYXJtdjdtX2xvYWRfa2Vy
bmVsKEFSTUNQVSAqY3B1LCBjb25zdCBjaGFyICprZXJuZWxfZmlsZW5hbWUsIGludCBtZW1fc2l6
ZSkNCit1aW50NjRfdCBhcm12N21fbG9hZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNvbnN0IGNoYXIg
Kmtlcm5lbF9maWxlbmFtZSwgaW50IG1lbV9zaXplKQ0KIHsNCiAgICAgaW50IGltYWdlX3NpemU7
DQogICAgIHVpbnQ2NF90IGVudHJ5Ow0KQEAgLTM1MSw2ICszNTEsOCBAQCB2b2lkIGFybXY3bV9s
b2FkX2tlcm5lbChBUk1DUFUgKmNwdSwgY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLCBpbnQg
bWVtX3NpemUpDQogICAgICAqIGJvYXJkIG11c3QgY2FsbCB0aGlzIGZ1bmN0aW9uIQ0KICAgICAg
Ki8NCiAgICAgcWVtdV9yZWdpc3Rlcl9yZXNldChhcm12N21fcmVzZXQsIGNwdSk7DQorDQorICAg
IHJldHVybiBlbnRyeTsNCiB9DQogDQogc3RhdGljIFByb3BlcnR5IGJpdGJhbmRfcHJvcGVydGll
c1tdID0gew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2Jvb3QuaCBiL2luY2x1ZGUvaHcv
YXJtL2Jvb3QuaA0KaW5kZXggYzQ4Y2M0YzJiYy4uNGU0ZGIwNDE2YyAxMDA2NDQNCi0tLSBhL2lu
Y2x1ZGUvaHcvYXJtL2Jvb3QuaA0KKysrIGIvaW5jbHVkZS9ody9hcm0vYm9vdC5oDQpAQCAtMjks
MTEgKzI5LDEzIEBAIHR5cGVkZWYgZW51bSB7DQogICogQGtlcm5lbF9maWxlbmFtZTogZmlsZSB0
byBsb2FkDQogICogQG1lbV9zaXplOiBtZW1fc2l6ZTogbWF4aW11bSBpbWFnZSBzaXplIHRvIGxv
YWQNCiAgKg0KKyAqIHJldHVybnM6IGxvY2F0aW9uIG9mIHRoZSBrZXJuZWwncyBlbnRyeSBwb2lu
dA0KKyAqDQogICogTG9hZCB0aGUgZ3Vlc3QgaW1hZ2UgZm9yIGFuIEFSTXY3TSBzeXN0ZW0uIFRo
aXMgbXVzdCBiZSBjYWxsZWQgYnkNCiAgKiBhbnkgQVJNdjdNIGJvYXJkLiAoVGhpcyBpcyBuZWNl
c3NhcnkgdG8gZW5zdXJlIHRoYXQgdGhlIENQVSByZXNldHMNCiAgKiBjb3JyZWN0bHkgb24gc3lz
dGVtIHJlc2V0LCBhcyB3ZWxsIGFzIGZvciBrZXJuZWwgbG9hZGluZy4pDQogICovDQotdm9pZCBh
cm12N21fbG9hZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFt
ZSwgaW50IG1lbV9zaXplKTsNCit1aW50NjRfdCBhcm12N21fbG9hZF9rZXJuZWwoQVJNQ1BVICpj
cHUsIGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50IG1lbV9zaXplKTsNCiANCiAvKiBh
cm1fYm9vdC5jICovDQogc3RydWN0IGFybV9ib290X2luZm8gew0KLS0gDQoyLjExLjANCg0K

