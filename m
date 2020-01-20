Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C9C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40002073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IDSh7trz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40002073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQ6G-00043x-Vl
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 00:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1L-0006jf-UR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1K-0006EE-7z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:43 -0500
Received: from mail-bn7nam10on2099.outbound.protection.outlook.com
 ([40.107.92.99]:53408 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1K-0006Cs-2K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfHav3OJ2V4QeQ0mqmSfUexG++8TF89LMybKVvaJUA/gSKJLCHv/TfnDECVBip1FHKTLT+U/fg6M4Ir/OZzqMmx5LwZYg4IYCiUJP03ia6EHGoxfjZM+Fy3TTDJf2V00tav7FxVeJGKdlGx9zPYjOJeHoSiDUxWeWArjwydbu0lVADh7ngc1KvhE5XHH6VqPTCzzdZY/9SYlqo2gvXivRvUdZIaPh7IKgiGF8gqr5NMprMaSAdv3fZZ39C1+VoUMn3eZBYlzKyzf/M2C97e33wq2avI59QoHWUwHqOPPMPRUKJ7J9cu5GVAFAQuFW7zbOgWFFaifKrb1mweWGEEn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUyxkMgSXmZiu/Rc1nJfJkjjXVUMnmlDUGvnTkwt2jI=;
 b=QHjtUgRcqlSIU5dp2v7avuqncRwIGiNWT4nUYZAr/WxSNJJOD0jnZm3BxosL+crVAqS1vsaim39dzhWjBkADFCFpYV3/EL5FbreI0C6oQDZMGuJLLylvKdVOUfhMtG+juQG/hj7rsIY/EufqmC+7GBBbD4xn6s9z/9AP9LAbACEE99fmLtk9Hj5LZ4Svh/UVbPyJb7HMAPWinJSDoKnPxTyRV39A24eo3HQU4eUyimwLgEuLap8E/PUbDKl/oNmBcCbFEFq11joJ9rfepiv6RCN2Oipqh7ZeMg4vlgrAj9Xm8nECF3w1vWOBKv5hGF4FtNs7RaHYd8R/boRJ1bX4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUyxkMgSXmZiu/Rc1nJfJkjjXVUMnmlDUGvnTkwt2jI=;
 b=IDSh7trzoWXoUFSyKmWKHW9JZqeW4YccW4kRxPCNM+y1MigunsyqhWRns7OM9TCwuvV13NnHixs0OG9h9mzqmiYZe3U0gbOVPa2VRvSqfamLdvFfD5Nh1ttLfm43ONxhj80tniI/feruS+RtkfRtOMDFpqhXKcIRlYgmuIW6x00=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:41 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:41 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:37 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 01/20] softmmu: split off vl.c:main() into main.c
Thread-Topic: [PATCH v7 01/20] softmmu: split off vl.c:main() into main.c
Thread-Index: AQHVz1YZvX5VLYzcBUSUoT2caaa2xw==
Date: Mon, 20 Jan 2020 05:54:38 +0000
Message-ID: <20200120055410.22322-2-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 56d109b1-d738-4206-6562-08d79d6d3c28
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB439914DEDFEDA5C668F73923BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
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
x-microsoft-antispam-message-info: JPdP9/2DpAUH+yw0vuf9TVhjJCxm106nijbAzRWxtw165sK0jVhPJLc9+GoZfs/eQoSGgHORgznNgbeH3XX6eVz0Nk8ZjQbKe1WQlVpGqMV3ULtNukOdPaLTjBOEBXnv2bldd8YPClSeI26I8AQdFzKUcbyUtjOW/9qeW5MrmugPcJ9+1g09AUZc0EU48Yw9bvK4Uad2W2UsEdS2TmEGVJuPxw2Kwc3QGuLWQobCGKuWusso86Bbws31iv+s0EBGcCnDYZ6wBb26VrbNvX1FL3kKQ6EKY38i1MjK2j8oF9/zS0bzPoTtPDes2CW4IKdesjdiOFkGcZm2jpKYRArjMVNlVo/AiYJbqCeFZ/W+o8pYzKDfMyckR+eVKto/Jy3+HpIaBMkptwX8u6m1ztRxrq1o+64yRkvOejvg3OxruLFViWw75+8yAbo4/Vg6GGLd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d109b1-d738-4206-6562-08d79d6d3c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:38.7897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9AqJA0Ajzf/AalcJHzZTx34M7+kxEOVY8dJQpJZgVX2k93v26sKOFg+rL1uU7Hv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.99
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
 "Bulekov, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A program might rely on functions implemented in vl.c, but implement its
own main(). By placing main into a separate source file, there are no
complaints about duplicate main()s when linking against vl.o. For
example, the virtual-device fuzzer uses a main() provided by libfuzzer,
and needs to perform some initialization before running the softmmu
initialization. Now, main simply calls three vl.c functions which
handle the guest initialization, main loop and cleanup.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 Makefile                |  1 +
 Makefile.objs           |  2 ++
 Makefile.target         |  2 +-
 include/sysemu/sysemu.h |  4 ++++
 main.c                  | 53 +++++++++++++++++++++++++++++++++++++++++
 vl.c                    | 38 ++++++++---------------------
 6 files changed, 71 insertions(+), 29 deletions(-)
 create mode 100644 main.c

diff --git a/Makefile b/Makefile
index 32bd554480..e6de7a47bb 100644
--- a/Makefile
+++ b/Makefile
@@ -473,6 +473,7 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
+$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
 ifdef DECOMPRESS_EDK2_BLOBS
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 endif
diff --git a/Makefile.objs b/Makefile.objs
index 7c1e50f9d6..5ab166fed5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -84,6 +84,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qapi/
+
+softmmu-obj-y =3D main.o
 endif
=20
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index 6e61f607b1..8dcf3dddd8 100644
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
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 80c57fdc4e..270df5fa34 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -118,6 +118,10 @@ QemuOpts *qemu_get_machine_opts(void);
=20
 bool defaults_enabled(void);
=20
+void qemu_init(int argc, char **argv, char **envp);
+void qemu_main_loop(void);
+void qemu_cleanup(void);
+
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
 extern QemuOptsList qemu_drive_opts;
diff --git a/main.c b/main.c
new file mode 100644
index 0000000000..f10ceda541
--- /dev/null
+++ b/main.c
@@ -0,0 +1,53 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+
+#ifdef CONFIG_SDL
+#if defined(__APPLE__) || defined(main)
+#include <SDL.h>
+int main(int argc, char **argv)
+{
+    return qemu_main(argc, argv, NULL);
+}
+#undef main
+#define main qemu_main
+#endif
+#endif /* CONFIG_SDL */
+
+#ifdef CONFIG_COCOA
+#undef main
+#define main qemu_main
+#endif /* CONFIG_COCOA */
+
+int main(int argc, char **argv, char **envp)
+{
+    qemu_init(argc, argv, envp);
+    qemu_main_loop();
+    qemu_cleanup();
+
+    return 0;
+}
diff --git a/vl.c b/vl.c
index 751401214c..132a41ac0f 100644
--- a/vl.c
+++ b/vl.c
@@ -36,25 +36,6 @@
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
=20
-#ifdef CONFIG_SDL
-#if defined(__APPLE__) || defined(main)
-#include <SDL.h>
-int qemu_main(int argc, char **argv, char **envp);
-int main(int argc, char **argv)
-{
-    return qemu_main(argc, argv, NULL);
-}
-#undef main
-#define main qemu_main
-#endif
-#endif /* CONFIG_SDL */
-
-#ifdef CONFIG_COCOA
-#undef main
-#define main qemu_main
-#endif /* CONFIG_COCOA */
-
-
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "sysemu/accel.h"
@@ -1657,7 +1638,7 @@ static bool main_loop_should_exit(void)
     return false;
 }
=20
-static void main_loop(void)
+void qemu_main_loop(void)
 {
 #ifdef CONFIG_PROFILER
     int64_t ti;
@@ -2820,7 +2801,7 @@ static void configure_accelerators(const char *progna=
me)
     }
 }
=20
-int main(int argc, char **argv, char **envp)
+void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot, linux_boot;
@@ -3372,7 +3353,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_watchdog:
                 if (watchdog) {
                     error_report("only one watchdog option may be given");
-                    return 1;
+                    exit(1);
                 }
                 watchdog =3D optarg;
                 break;
@@ -3813,7 +3794,7 @@ int main(int argc, char **argv, char **envp)
     set_memory_options(&ram_slots, &maxram_size, machine_class);
=20
     os_daemonize();
-    rcu_disable_atfork();
+    /* rcu_disable_atfork(); */
=20
     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
         error_reportf_err(err, "cannot create PID file: ");
@@ -4284,7 +4265,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     /* do monitor/qmp handling at preconfig state if requested */
-    main_loop();
+    qemu_main_loop();
=20
     audio_init_audiodevs();
=20
@@ -4394,7 +4375,7 @@ int main(int argc, char **argv, char **envp)
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
-        return 0;
+        exit(0);
     }
=20
     if (incoming) {
@@ -4411,8 +4392,11 @@ int main(int argc, char **argv, char **envp)
     accel_setup_post(current_machine);
     os_setup_post();
=20
-    main_loop();
+    return;
+}
=20
+void qemu_cleanup(void)
+{
     gdbserver_cleanup();
=20
     /*
@@ -4449,6 +4433,4 @@ int main(int argc, char **argv, char **envp)
     qemu_chr_cleanup();
     user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
-
-    return 0;
 }
--=20
2.23.0


