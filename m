Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61891C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAF52073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="J3IaHCAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAF52073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQB5-0000It-4S
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1j-0007Kv-BV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1g-0006Tf-01
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:07 -0500
Received: from mail-bn7nam10on2111.outbound.protection.outlook.com
 ([40.107.92.111]:18623 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1f-0006TL-QT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQFiWZmVVxzkY2oALYFK6NE35iqduQU6wTJoacKXw0K2SUunz3LQdPN3/bMoWY+4sAhCYyvslFO265AEzFPmWPND9Wx+f9BnscDw9/x3d06z37jYO8ahxP29jU2K0tj+zzB7d6uxe5eDD2AE0hH7RWx/SGnzJKjs+qpji+Oen+/bh8PGSvUBtBndZhD/jJ+4+kIQCPCguGT6QBRnqpx+S65wFvCjzeqTkZXwQ4A1eklnVUx47YZLskNoQ3IDq5NpVHZ+x25/oL2oEb8O/zlZCGNcZkQ9mfmLiOmpbN77qBD5mg/G+XCtkbQ5bzrtg+fIZVY6RFUT3BThi0TcnziGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfY1+16kphmDJ7KfW3C1Len7PaAQLoDr0wlMmfRhp+w=;
 b=G59Fnu5/L7+aMQ+qKEeNJVh7tlIW0RvdHWGmQfPmwqkgKZpC6EpvE450kAlh6l7Ed6WX7XgD55BK4ONTvh0K/L895ZWCiKCxSwAh7HDgMXQSOHRylrdnrGgmeVglzH+5u8Cp9YX8b71h7Z6a0B6/go6ol3IAV59MTWZbjlfRrWyUwnYWZCoPG9LwgtBM6z1NUba3BXMTHmoY/0n45YMWWqmA3lAIMvTmlyxP53h+YuJyr/jQBRwknRIxom0CYVlaadEN8xxiMndBDFPpkMn3OYKe848AL6mdjmjzadtEnXwlrCQPrzh6RMz6zeN5hoRnsK2p40q0iH30LOuPyYIWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfY1+16kphmDJ7KfW3C1Len7PaAQLoDr0wlMmfRhp+w=;
 b=J3IaHCAE2gIW49KoTbtsSMPiaVdTwJKP0Zk2vXAoYbyRcreubE+ZYM73ncqH21FkbgO7cTwy3Ak04vr5HQEP306N+B9NY++DXhl4VE5WY11FDF1NfLnxpwqS5NEcj83Xxtvg626n2eg98qqAGwiq7q7nLKMeguzBYPhCkJy1oSs=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:55:03 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:55:03 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:55:01 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 15/20] fuzz: add target/fuzz makefile rules
Thread-Topic: [PATCH v7 15/20] fuzz: add target/fuzz makefile rules
Thread-Index: AQHVz1YozqjYdhj3yUy1KAakuF80Pw==
Date: Mon, 20 Jan 2020 05:55:02 +0000
Message-ID: <20200120055410.22322-21-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100b29b4-6c82-4aa4-033a-08d79d6d4a84
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399BA9139DF9D5BF711B606BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Tus7UVIvX3P08BshOIS4GYbkT+CetiMeLONwOE3Nx29pLG81eT8EUwVsgxOPEUjSVBkv9sC7As+06s/BKk4xxaazieAbj5SCR0S0y41NApWJTD1qI8xRhefKvFOQbXQPlTH/otZ7W4QGlZKRtd6xyX9MedN0rueaDFEn8dzsAQ2ZHiLsb8CQBvZcASAKY4+zWvnxL1B295LppgAokO9eiVbp6sMVsUNcS81FbFE600Q9jEWGWLU3Qus95f6DQcoq6v/uZRv7BYdQJEFLh8IG6hnpZPLHA71HiEorUMcA0c4lrnHNcjUxFMJYmo/OU5zJsrzusTKj8Trn922lNKrhFuZhDE+cqbtD+DsMiIZ8QOGLprCl7WsokU4Md53G+2y3ZANKXDB5aDCtDCr5LM8wVUjMyOLDs2pC6k7/kWjrzujFexSC8ihJ8E4Oaydl/S/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 100b29b4-6c82-4aa4-033a-08d79d6d4a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:55:02.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFLvqxpReEiMIDB2vaJRWraOH8xN0Zb32DqUwd9pQT6jVekTdm4aXw7/v8DQwCNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.111
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Bulekov, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile        | 15 ++++++++++++++-
 Makefile.objs   |  2 +-
 Makefile.target | 16 ++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e6de7a47bb..dab291455f 100644
--- a/Makefile
+++ b/Makefile
@@ -464,7 +464,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@=
")
=20
-TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t), =
$(TARGET_DIRS)))
+TARGET_DIRS_RULES :=3D $(foreach t, all fuzz clean install, $(addsuffix /$=
(t), $(TARGET_DIRS)))
=20
 SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
@@ -478,6 +478,15 @@ ifdef DECOMPRESS_EDK2_BLOBS
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 endif
=20
+SOFTMMU_FUZZ_RULES=3D$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
+$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
+$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
+$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
+
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
 # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
@@ -528,6 +537,9 @@ subdir-slirp: slirp/all
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y)
=20
+$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -537,6 +549,7 @@ $(ROM_DIRS_RULES):
=20
 .PHONY: recurse-all recurse-clean recurse-install
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-fuzz: $(addsuffix /fuzz, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
diff --git a/Makefile.objs b/Makefile.objs
index 5ab166fed5..9d87a1009e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -84,8 +84,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qapi/
-
 softmmu-obj-y =3D main.o
+
 endif
=20
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index 8dcf3dddd8..fd6fe79495 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -227,6 +227,22 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
=20
+ifdef CONFIG_FUZZ
+include $(SRC_PATH)/tests/qtest/fuzz/Makefile.include
+include $(SRC_PATH)/tests/qtest/Makefile.include
+
+fuzz: fuzz-vars
+fuzz-vars: QEMU_CFLAGS :=3D $(FUZZ_CFLAGS) $(QEMU_CFLAGS)
+fuzz-vars: QEMU_LDFLAGS :=3D $(FUZZ_LDFLAGS) $(QEMU_LDFLAGS)
+fuzz-vars: $(QEMU_PROG_FUZZ)
+dummy :=3D $(call unnest-vars,, fuzz-obj-y)
+
+
+$(QEMU_PROG_FUZZ): config-devices.mak $(all-obj-y) $(COMMON_LDADDS) $(fuzz=
-obj-y)
+	$(call LINK, $(filter-out %.mak, $^))
+
+endif
+
 install: all
 ifneq ($(PROGS),)
 	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
--=20
2.23.0


