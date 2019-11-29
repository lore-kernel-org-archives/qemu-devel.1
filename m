Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED93C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780782464A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="nGNwb0fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780782464A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao3Y-0002NR-E2
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianuk-00009d-Dw
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuj-0002w8-3G
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:58 -0500
Received: from mail-eopbgr790122.outbound.protection.outlook.com
 ([40.107.79.122]:35989 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianui-0002ny-SR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv0wzpT1GQTY08GaJMFMHaHowp5rseNs1LAizWinWmtaFZEMrD+Y40OZbvirW33rHG2dEk27HPWPcqSE/Zjw6k7Q0qGEmmYMYfLfJw8JAexyWLqa6EFT18guqQcjKas4xkJpi2tw69qnstPVl807hLxBkMJJ9XlopAslkvd2SuMkBMaVEkP9Kl6ECm+uhKAAaJC+fP9AC328J+srHR6+NJmrH/uklo1Ecqwzhk03Q+V2udGVBPfJdkBO5bNf9F05kH/FD0/XG1gcc7ZyX1M3AS7/GhtRbKN+n9krtjt3qg+asZ1Ow2EbVl0P0tuLTs3WVEGcBPIGPL9WVmHZ0H4fYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIasAnJVTZ0N3BfPFu1aeR1+XmK7ECq+MvAC+YnCL2Q=;
 b=E2rrd7VsCnL6Rcrbki41vTunXOqR7hwnOTJmKTAXFqPhAHduC1bJJn+GZosxPGp3879K25JvnPnvTj9oYI1/J+X0PIIhXMbv7DFZsE1dAaSTxwkocgPFjznrIiTEyKiBwuQKi5NsU7hIgx5F0f7ZZ9oY+RJIjpBoBJscLAGdW7XR3gL8+KscZFLiJPj6nh5wD/afRjPQbq6htvK26hEhXaU05ij4avwZczwhT5rhRFq/ZyXQ1NW36q6UhduFu5AU418WsiMoBZfsBTCZ969FBCbawtmZrw1IrWdViOk3+xeavrrpRn/P87vT7gxti/JemZ3FUdKdYrLRdUI3TSpZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIasAnJVTZ0N3BfPFu1aeR1+XmK7ECq+MvAC+YnCL2Q=;
 b=nGNwb0fmk+jaiWJze9rSgnWmdX3GmWNcGvrvT7o/OG6MDBQnktVhK5qxwywq/4Pgj4paf1aH/+a24xwl3h8mPFMHYtp1i5cIdwgqi6Ix3skPJG1W3vqP6KO77N0sA2y43//WO2MHWr5P2iddhHonEldyHuZmrXIumteCXl0s7/c=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:49 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:49 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 14/21] fuzz: Add target/fuzz makefile rules
Thread-Topic: [PATCH v6 14/21] fuzz: Add target/fuzz makefile rules
Thread-Index: AQHVpvzTBOMaTPQMDEWsHDZxXg4kmQ==
Date: Fri, 29 Nov 2019 21:34:48 +0000
Message-ID: <20191129213424.6290-15-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c1ad747-2f53-47ba-c0b4-08d77513f602
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050F9BF2146D37900382CB7BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66imNoTfnqfqkaKg7ynbPH51pN95dPVFJ6T5AD6T9VDs5n5Fg00MEbYi8vaH2WP2mfbT+1JTWRK0jUW4Ww7ybHc8QcXoWR7qnRQbSKVAwz4lhmDPW5LTo+R7GfN2ViCA9tQuoIn4DEHzi689FjapHFj5XL3vLaqr8ECKT72vGQ8QvhbM4Se11GTtK3TnywWIxEknQprgqKW2+qeZywKalgih5eG4s/J8sXrfdQMrMi6U0Uhd6l6hnPPhk8ifXGxhIgLukJKE+jlNCPGECjKV1QUoP5qlevHfTyeDccv407oWcTntNybclA5wVgPTRgGo0piUPmKraIr+nzwnE5wKfXHBU4c5pVTzSOcbU23NnBAEBbDIO44UbAsdPUUkOl2CVkcBOqolSnasgGlIbJP2ihVE7zPbPhv8/vsfXibqlG4uDt5gy/zsVAySMR8X1Jq8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1ad747-2f53-47ba-c0b4-08d77513f602
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:48.9977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnISCqQTPRezP1d2+N7Aepi+osz+OqkPvA7TODD//P20U4+RBfkQid4gj+ohTfdr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.122
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
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 Makefile                    | 15 ++++++++++++++-
 Makefile.objs               |  4 +++-
 Makefile.target             | 18 +++++++++++++++++-
 tests/fuzz/Makefile.include |  4 ++++
 4 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 tests/fuzz/Makefile.include

diff --git a/Makefile b/Makefile
index aeca63a2b1..267385917c 100644
--- a/Makefile
+++ b/Makefile
@@ -471,7 +471,7 @@ config-host.h-timestamp: config-host.mak
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
@@ -485,6 +485,15 @@ ifdef DECOMPRESS_EDK2_BLOBS
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
@@ -535,6 +544,9 @@ subdir-slirp: slirp/all
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
=20
+$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -544,6 +556,7 @@ $(ROM_DIRS_RULES):
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
index 24d79d26eb..217391cae5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -204,7 +204,7 @@ endif
 COMMON_LDADDS =3D ../libqemuutil.a
=20
 # build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
+$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS) $(softmmu-obj-y)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
 	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ=
","$(TARGET_DIR)$@")
@@ -229,6 +229,22 @@ ifdef CONFIG_TRACE_SYSTEMTAP
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


