Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6E4C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E091206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="DeokOdpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E091206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1kR-000899-D9
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TR-00084w-VQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TQ-0007iL-Bf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TQ-0007S1-2c
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhtcfT1cN9EIvQHUNVfrF4qOwCqRvnxY6U/2OHR94nhQRtdQw/KRa9TkBsbn23154B8kiQlSFNHIYNrpfBS8smfZO46BOQlx0jpOVwQ4/SsgQhzsLlVjTVntq4HhSubVrAOWfDveh9Wga3U1SppTM7kDv6gBqvUHVXqopThmgDMgp2K8qmS51/PN/kp7s2WLtvm+Ib3SFH3mLvhqX3dA6ZZ0YnJgOtz1PKtQ4wOeDyntvQ4l/15Rnnq+nNW7gEuIP+nJgzXkEtitSpe/Zvag24F+ObrbsjhDaUrRq3zHLMynQSmfSluiq8vD/UclrUS9lp+dufL01mhhMSotBiDhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7r5XAD4NwDXJokxMi67l76Op+YtX7WoGvsh/JMqx8g=;
 b=lacGOOAIP/PRTApdtdC9bIE4n6EGYZ55ygyqXk+LwrghozCb663hJ6x5VeKJYDWMt8AT8ksJNRE1d9W5cLHQLocnKUx5XNayLcSsBuKE6sls0TGiLpRCtr0nXxGyylt6BqmzuNaoGMt2fQfmCwNnKxHowqMT20PQzoDHrsZ4NDtXK9CJdTOp4H8su8/SJp9mFSI/X+CmKp/oC6yFmHSWby6bz5jTd6Syah7kQL1UBSmU6iQKu0qSD3pRW8FhlW4dTKUPgYh3rhFJ1nAzFhO9X+D6WiTyMDFt07Pu+diykxhCGJSNUF0ssmZSlohi8gp9wbxrzjclBipCTFTjxaX86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7r5XAD4NwDXJokxMi67l76Op+YtX7WoGvsh/JMqx8g=;
 b=DeokOdpPxJPB9c3Pp25s1pcf7t9XWdKSvz9QP5JprbWNjIB2jwzuMj8KHVM8lranvmR8ZKQLy+gQHT4tYpNz2QDVREplBK4l6S/7jrEis2NaP+bVR+NRg+evcs811zdL2R69R+GtoZtxIDu6io9twZDXXZopUwCUJ55F0gR6CyI=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:50 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:50 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 14/20] fuzz: Add target/fuzz makefile rules
Thread-Topic: [PATCH v5 14/20] fuzz: Add target/fuzz makefile rules
Thread-Index: AQHVmnTLMooOWGN6dEScYzJmp8qksg==
Date: Wed, 13 Nov 2019 22:50:50 +0000
Message-ID: <20191113225030.17023-15-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d808876-6294-48ae-e256-08d7688bee19
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50242A0824BC44C9B02E9945BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcRNEs46ZFr3ltvl5aOmT+IavGxmUoTXHY7z4wkqxMx1lCVBKp+4feeLMDTDqeRUC8JFV7LqmKUEQjamV5qs3IFAtvrL/izbMl8aWUR12XPFKVetfMf2/+jSqs0mwBmIMSFNHs+2gFyJee4D1cRwe2bcpIg424wU1b11dlybncnDYIY71kmGNIfsELTmrDZczjqR1g/uBO6AiNzwnXWkAA5tIJqDhnAKFAoOq9igzIJ3q6PzRKXEQ4lhXxwbzZ4Z3QRcy96pLuN5BDHV8zftdf0y7BFniZ7NOKwIGQUrkST/EkftheP9QMyBP/auL2E8qNVBZ9fWFHzEbwskJY+RQhFzgdrZlu+56kj7dtNYx8zLrY4LUIpEk8YzFKFDDa8zhxiuv7i6maimDTgAU8o4xJgqjjQCkswhwXxg10kvTi9OFWr31tDJlKaXkNQzfCZj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d808876-6294-48ae-e256-08d7688bee19
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:50.4918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGwBGZYg5q46gYK7wZjSG0gmXdLSWk1XBLTK9dIPkCxeWja7SVEe0giU94ZdG7p3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::72d
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
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 Makefile                    | 15 ++++++++++++++-
 Makefile.objs               |  4 +++-
 Makefile.target             | 18 +++++++++++++++++-
 tests/fuzz/Makefile.include |  4 ++++
 4 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 tests/fuzz/Makefile.include

diff --git a/Makefile b/Makefile
index d2b2ecd3c4..571f5562c9 100644
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
@@ -476,6 +476,15 @@ $(SOFTMMU_ALL_RULES): config-all-devices.mak
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 $(SOFTMMU_ALL_RULES): $(softmmu-main-y)
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
@@ -526,6 +535,9 @@ subdir-slirp: slirp/all
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
=20
+$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -535,6 +547,7 @@ $(ROM_DIRS_RULES):
=20
 .PHONY: recurse-all recurse-clean recurse-install
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-fuzz: $(addsuffix /fuzz, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
diff --git a/Makefile.objs b/Makefile.objs
index 9ff9b0c6f9..5478a554f6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -86,10 +86,12 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qapi/
+softmmu-obj-y =3D main.o
=20
-softmmu-main-y =3D main.o
 endif
=20
+
+
 #######################################################################
 # Target-independent parts used in system and user emulation
 common-obj-y +=3D cpus-common.o
diff --git a/Makefile.target b/Makefile.target
index ca3d14efe1..cddc8e4306 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -202,7 +202,7 @@ endif
 COMMON_LDADDS =3D ../libqemuutil.a
=20
 # build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
+$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS) $(softmmu-obj-y)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
 	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ=
","$(TARGET_DIR)$@")
@@ -227,6 +227,22 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
=20
+ifdef CONFIG_FUZZ
+include $(SRC_PATH)/tests/fuzz/Makefile.include
+include $(SRC_PATH)/tests/Makefile.include
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
diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
new file mode 100644
index 0000000000..324e6c1433
--- /dev/null
+++ b/tests/fuzz/Makefile.include
@@ -0,0 +1,4 @@
+# QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
+fuzz-obj-y =3D $(libqos-obj-y)
+fuzz-obj-y +=3D tests/libqtest.o
+
--=20
2.23.0


