Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE7CCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AD52087E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="uw3j91G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AD52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpPr-0007ee-0t
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIS-00055L-Pr
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIQ-0007L5-Ve
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:04 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com
 ([40.107.69.115]:23033 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIQ-0007Ax-NH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf05BglszHyI4mb7vhkgvxuQFuur2t/Ua07H7lDw4DKp2nd3P+clRC3CrEuiDt+0m+Gzl/k7gz+xY148ZopafBXHlaald/WxZG1c7r+cjPzirVabx5aqHgpdG7JUnEz4N+K457reJ/yqFoQmg09pX9Ct4Ms/yf03EQ8SbPduYzu6NnJ4gj3hjRX/CWGJbRiC6n5HpG583jPqrYBIDMejbkodvJjsgblt4+nlgTUuc9bhVxj+6l8M+wYpoVhO3fw9y8qX2Fwo13Bv5FTGoHDkTuw6JN6pRXjzqaH/2wSPf00NG1YrsW9e8yL3kInlpC/cDM4voIQy4FOm0Ib2TuDKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ17ZiTE2b8h25fImaMDbzCOeEifhFpxfARBLfnLWlY=;
 b=LMt5uYrz3HAVafC+hSTeDrBVJhCgrmlv/Mf9q+qQ0WOkaDhYikcMPviwBRhPsYTlj2eX0BJtudcEEeraXMcfOOXYOBkd+ZVfOL1mwyGuQ9Z0Sx8F8b1uSn99FQghvX+KdyMLnUAoQanjB8S+Sk0AbZUMEUbJsyVRCciDyKdFgfAgcTzWiBt5qSAGqppKGBux0jf5bHRVFw7wB+19pmJBYlm9tRpHRCq2nOS4dgQOsPOYrWBnnCQxRLdSHHGOtuP1SEwMAkgenHH7SGo9qwTf4cNlv1WEIZDlsX/M/XJJiK0VpL1xvvuVPRc4JkcAHt+Quf3l64fhBdRGEvNiNUjWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ17ZiTE2b8h25fImaMDbzCOeEifhFpxfARBLfnLWlY=;
 b=uw3j91G70nHx/q8l24FW0b8htD57ONSClZtbHu039Ap4Xzy7PurB5YREpHm3KpoTor+kW3O5aRcMRfOobo9F5lDX8GXyYNqBrUHudUdCXNmdCAbEYMg5VbxDuHUxupv7BGZwcbPFxVFYVYqNXRQUoo01qCZM+w44VOYpF50qW6A=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:50:01 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:50:00 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 14/20] fuzz: Add target/fuzz makefile rules
Thread-Topic: [PATCH v4 14/20] fuzz: Add target/fuzz makefile rules
Thread-Index: AQHVjzFNDXmvrhggW0qT5Z69BlHFkQ==
Date: Wed, 30 Oct 2019 14:50:00 +0000
Message-ID: <20191030144926.11873-15-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae0e0d7e-b3b2-471c-7196-08d75d48703a
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB49590437F5EEEE4FFF6AF986BA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuJW+RKhf2s4DeuSzcAvK/qBEf91uQSEatAPFYWsC98e9N2k4kWpyVvYMrnXbxYaxeMzAsr4fGYljCUWzhUgr+W2ZQIC1pfPV2AXoc7FE7qnZr+5SMvoBByRYhxHCIr/ST3xLunbF5TBRXoKNuzxVfyNBztLv/Z9YM67eNiWLRfXeyZFSGPh8aU9iDw38ouQiqnkmHxzT79U+Cx996UD+kga4er+43/tOspNHxtJwVlnTAJNkokiEbVYGDFcF7wRaIgSAyF5os1cKPrMrDlTBVYI17mDQU4+AXkE+QMjpLKZcheSF3vuG9K1YUZ/FPb56zNRdjP3KiV0GmHfYiQmXe0jaMSA26KkxaD2HxFgn1Kj8Woxd0/2QGtZpWXKy2SXdBdZiBe3EoEnpU/57Qm6SntT8LJZXjSEAxRpIfARq58aUeC6m4i4wefRcteK9Yqo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0e0d7e-b3b2-471c-7196-08d75d48703a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:50:00.0190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1pHInRuntGzmrzOdlBMCl8H/QotWaF86CnXUTSBmJl1wTaEIjnPOHZBokXp5Mn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.115
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
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


