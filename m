Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E70C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8002071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="SYqgR9Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8002071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg5q-0002tw-Ef
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzg-00087C-UW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzf-00027k-FD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:28 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzf-0001yv-7l
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocv11NC6UxnmvUjFv0w9/Q0tF3Px3f9MsZ0zUTLFoOtszCPzSt6nn4hkTQxO5Bl2RAmfVv1g7ZMpaXrye4eSUCuds1+cRnYl+9CaPQZ/z5x/LwGcsIzSQAZxjm8jrw7wuuTJdGlfI7n+Ta7a+qeqEeZAePgMtpsyA65AEUxeJ4hj3YvA6XCVoTxXT+rKsMJQmn/SkTOzd2PIag9h9Gdh3Em4O+AbmBIAjplznJcJqnb2SOzKB7Ov9x9FoOJF7fWSk6rTgI52kh8yPkiAhlcggL61nS0/ZaBEPGA4nrblgJrJ+bPEEo1cqgRLh2Jb9ug5dGLkcscO945rzBjW8SUi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfY1+16kphmDJ7KfW3C1Len7PaAQLoDr0wlMmfRhp+w=;
 b=f9I32bFrXfe1V8Prnh4PPxWkwQ09G8dE2a5gGJfI9mPcREQEoTxkw953221tPDP8yi02IuqT3UdrZuNb/e6gI1M1M2i3SW1cRowFqcEBFK1Vl4j6VWpdXsx3ZA101GP4Ntc20KU5Wl3CtablPJmLTTs3TW840ZcsTEAuMo57jyFRZgs/x+LMuTdl9YrsF7XAhUGNRGpKUBxNABMbcYUbaPFOJdY/uzEYnFHgs20I3QMOVC0/aynW17ghNZbXmYX4spyBwoz96qCLysTZAC3I4LckE2kmaZ7BvnI1WxY/w3NdfQ+FNJzxhiTcDfkrnebNFOOaFGKamdxTMVuH0TtY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfY1+16kphmDJ7KfW3C1Len7PaAQLoDr0wlMmfRhp+w=;
 b=SYqgR9EzWWkzUr6jqGvRgk42o5wCefJKDTS14dkQEM6vNgoMMODiBdvxDV2kCMShfvRvJsYT8fgnlzaG4pQhqc8gwyzHmk5Aj9bqaTpcKc3GM+DKeM5aFDEXJ6kTTWEuBFHafr9J+Onfp4fZ+WKvaYqbmJKdJ3vfLchLH0w8bPM=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:25 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:25 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:24 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 16/21] fuzz: add target/fuzz makefile rules
Thread-Topic: [PATCH v8 16/21] fuzz: add target/fuzz makefile rules
Thread-Index: AQHV1mXEaFu0z9GvDkCQhJomZNP68g==
Date: Wed, 29 Jan 2020 05:34:24 +0000
Message-ID: <20200129053357.27454-17-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456c5595-d7dd-4496-e851-08d7a47ce698
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB420651171F23548A3B346CBEBA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQFBaPgf8f4cJmFMKxFCuRsCwKG5F07sfGrCuvm7AdQBFjs2cg+XCGZW8scJQIf1awiW4fV/V6H/A2+3BOHug/93QXgQ6a2YHR3CMbDpZJWCne/OcjoziMqBbjJIkJ5jJ162mpy/g6sf7GNScLd4bNIhB+bF8ag2IvFMcqtWmdF7Bav8om7KZL4Zt0VotEcDbrZVVtaGTc03Q8KvxXpShs6f7WdqQmSYqHGAas+j7jK/QzYh2AOguXjpnZQM2kcqFOuoEoGK1yx2n1cXEm3PoCc8awGSRC1kYMV7UVxvCOK9JHjmQ4KRALFpFGibKwGgH46HJELXWCtIsNbSPlmyeOeEoK4PGg2I0pvja9D6jso6anpJoV5Ph5ujcCG/vR/W6Y7KhBp5bFx2swvCFpg/keoJzWY6iovNzq7ngScdbD2DQYqC0j7f9vaUkludMaQE
x-ms-exchange-antispam-messagedata: uhZHGvUWbxTQxUJVlrS9R1X9LM9uiq6G0j4N+HYh8ReXHqXhNKZFcRJJG3kTXGwE8rtGFK2y62/2eh9/yNkwevXk15vQ1E+Sy+/bbTXjgdZI1LAra26vfySb57ZserAwI1/mWgYrw6SHhoigev+Vqg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 456c5595-d7dd-4496-e851-08d7a47ce698
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:24.9534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9/B1sra+qfO/y7lG/z7U1tv2cmkLJX9YYYNnzwoECvOUOgMMV3IgNvzFCXxNDZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.98
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


