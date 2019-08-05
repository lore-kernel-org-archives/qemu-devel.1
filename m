Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E2EC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93DF20657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5CHIpZ2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93DF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXB8-0008Ny-3c
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9F-0003Nm-0P
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9D-0001yI-Tp
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:12 -0400
Received: from mail-eopbgr680090.outbound.protection.outlook.com
 ([40.107.68.90]:17375 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9D-0001wB-OY
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo82gVoMr5vKmmFqeSO5C1Veo/ssZOgGw82XMuV64hse3H5fy9t+PCVmIa2bcPRpCMJ2rYjSztblZL7ZJFk0r2F7TitpGlBCpAgzFigUDBMnLXMcSSEiUA2vUMpTj2x0YUTsyT1PafJ+E/qeNJAKE1EG2rK2cLjnbAP9IuhIvCnmn63S+HqLN3bTy6gHaHsIPqBdPmZT8CEbZBXAPNBNjLheERcto/LDQ3zSunyELcuSN2HArNsuzPYW/IlD1aqSiJW9TVidxHzSHinkpBqgUQNBm9uEqsTA8YwCAOnA//XR76wbuIAzI/ZKz26FgA0v3SM/NhwyOZKER8gdT0gvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLqZ7N6FndAlHxi1BeM4RrIT+RxS0dmwioPglks4org=;
 b=LB4KuvJEWcnAA24AJqyo5nTTRA7RIknUbuevgCTQcCIzUaya81VKYWJH5SYtnR3L9Lci4z+fKaGWS2T7TfFYt83Wmw75jVAiQ2bnwXcVfnrY26ff4rLNsVs94EuxjayEXgg+TXedxw3xf4JQ/z9EhLH3n4Exu9guSFfsMKpj0dBaOmqRFMX2A2HO/4dk2pxdh5PgkYe46/4LbjkaJwqsc4LdN/LLnW224Dono2fZsHkPxtTfz15qOyJLmax1br6tE3Nda0IruCOF6OYxn9HXrqbXtX2BKvMV1m/XTCKD/RqZk6eOraC6iVJYhNSHJeaTeJUKTLGu0YiAg/ddWsQ5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLqZ7N6FndAlHxi1BeM4RrIT+RxS0dmwioPglks4org=;
 b=5CHIpZ2ELR6WpxChPGUKHBXZ+vgsIEX0AmJR52sjUgLIZT4NTX6hP5SoIhXWYqj9VT/V6Jn4Y34HkdtbMQnbC4VpH2zemfpW9aDnn560YUi0S7hJULhp7ZHjk1z8+R/pdnbfDSY7LSyzwjfu1H9ILtcckJuh6XycTTEOznkI+6Q=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:10 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:10 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 09/17] fuzz: hardcode needed objects into i386
 target
Thread-Index: AQHVS1z12cNsUlJ23EmoX/Q4K+syRQ==
Date: Mon, 5 Aug 2019 07:11:10 +0000
Message-ID: <20190805071038.32146-10-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74086123-f4cf-46fd-990f-08d7197417cf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB26460253066AA5B9073070D5BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QJUdU8idhycazRExhlleSYzNoZE+PCUGnwEOmTBAQ/z6ChB4r0ccxZFw2wdQYgyRimkz+3H9IAZg0joWBwKcIuZJxEgo59ev8HoXtvnFlWo3VB534xsFxXlvwnSpTd2k0UlY/xuPe7cgjmNhd6VZWJcgWk/wJ5odldISQcDg8hoi4v65/f8UthDS1QMMNSXwr4YQ0NJQGBw68DeKlxB0GO6jAscUO8nGNISYLf3dQUQ5tkX7V+tuCk/SrG+7NZF2VmV7tmJ2SGwqJkeQuGGEbjy83nXDiALdifFn5yRyrba7ro4k4zxXB4pP5RqIt8D2/I2cCP0qQB1S6Aj8XLVVw3zfeGigoVyqhBI/U6qktbW8MQvJSVOYp7vQl1wXWD3FpwN5L8xyZKkPuWEgxcR1wuUIdWaTlbt9AkAOsQGuJV8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 74086123-f4cf-46fd-990f-08d7197417cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:10.5145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.90
Subject: [Qemu-devel] [RFC PATCH v2 09/17] fuzz: hardcode needed objects
 into i386 target
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Temporary solution until there is a better build solution for fuzzers in
tests/Makefile.include

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 target/i386/Makefile.objs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 48e0c28434..1b8976c0a6 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -18,5 +18,25 @@ endif
 obj-$(CONFIG_HVF) +=3D hvf/
 obj-$(CONFIG_WHPX) +=3D whpx-all.o
 endif
+
+# Need to link against target, qtest and qos.. Just list everything here, =
until
+# I find a better way to integrate into the build system
+ifeq ($(CONFIG_FUZZ),y)
+obj-$(CONFIG_FUZZ) +=3D ../../accel/fuzz.o ../../tests/libqos/qos_external=
.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/fuzz.o ../../tests/fuzz/fuzzer_ho=
oks.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/virtio-net-fuzz.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/snapshotting.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/qtest_fuzz.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/libqtest.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/libqos/qgraph.o ../../tests/libqos/lib=
qos.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/qos_fuzz.o ../../tests/fuzz/qos_h=
elpers.o
+obj-$(CONFIG_FUZZ) +=3D  ../../tests/libqos/malloc.o ../../tests/libqos/pc=
i-pc.o \
+	../../tests/libqos/virtio-pci.o ../../tests/libqos/malloc-pc.o \
+	../../tests/libqos/libqos-pc.o ../../tests/libqos/fw_cfg.o \
+	../../tests/libqos/e1000e.o ../../tests/libqos/pci.o \
+	../../tests/libqos/pci-pc.o ../../tests/libqos/virtio.o \
+	../../tests/libqos/virtio-net.o ../../tests/libqos/x86_64_pc-machine.o
+endif
+
 obj-$(CONFIG_SEV) +=3D sev.o
 obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
--=20
2.20.1


