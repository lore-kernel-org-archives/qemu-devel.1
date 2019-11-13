Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A10FC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4307D206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="J3+iniX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4307D206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1eg-0001NP-4S
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TO-000841-Vn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007c5-39
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TM-0007aZ-Mr
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh9TNJNlf6pOEfBwsAPNWJgmT1jn1tExV0krLXfJNSFYDrpE+vRr4NSe7lvHABQLezH96ih3c6eWUKdRLAYV7oiPqnDXmfGMizygeVcdpuU4DNpzXttwVJ962Vo+FGU8LrfILVpVntA1bm9VNyUNoMR7GUSNhD5z2cil59I/P5TXZHYUk8s1ZJ15P2dqyk+kVMb/OAFSTEpYxdQbK7A8OBv9w9QbJ9kMTUDkVOM6J79dY4eTu5bNvtQAPAlUpJvGe3FabgjQrtEBsxaoGevlNZDMT+QJObpNdEFH3KUm8S2rySHDZfwbngaS8XTWRVUUx0iEukO6sWc1CNqeTaFasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPW70vhuDCy9oDq26QeRC1tJQO5d+nILsOwrQqFMipg=;
 b=BODcYdPI+J9Qy/+n7+lOJ0jaJGvrhvR1Eg0tFTmyKsgm7heIVchNnW05RLcV4P2icFBbK5HMKSzoDBT2Mj1vcdrvEIeKQ7wWUZL/sX+rY2lKUft0TBA7y2byHDdx0uhuVTJ/feMkYTKC0D7ngw+PTWJQUx/xOE1X440mPMXMzfCRvkpfK4vmIv6UfDxNyNyLdT8YxrqstOR1RZV9MBhEQ774HprxNJVcBmbFPrEnoRI3afmlB0dOW3mNE9PyVwoiyK4RfaAJCEpjVkVJnIxAeHeQjMyz7zj1sxiQfDZ/5anutR3JI9/lVg8837sCY4WIYaZP9jqx92Gu47Q8CI6UUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPW70vhuDCy9oDq26QeRC1tJQO5d+nILsOwrQqFMipg=;
 b=J3+iniX1luNUwmdp78qP4DEFmhRh/5er27XTfF8QVmKEhaCS3ItUIGWbf23T0HigIdYCAIsYeGuxGk7gd+83rp1s0fDe5Mabck99a1SxKQRZxpVnRDiXGoUCNdKknJgRssUCG3rRw9J8TAmr3jc3AZTd7H/sqKhfTy/u+hQIOuY=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:42 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:42 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 01/20] softmmu: split off vl.c:main() into main.c
Thread-Topic: [PATCH v5 01/20] softmmu: split off vl.c:main() into main.c
Thread-Index: AQHVmnTGsVmsxY6a30O5nXkOvQbtug==
Date: Wed, 13 Nov 2019 22:50:42 +0000
Message-ID: <20191113225030.17023-2-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: df437fb3-3246-4465-0eac-08d7688be94b
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50243E7F76EBB9DBF7310B23BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyzhBvh8OGJrOnavvnP1OVuVz+Y65axZs9i2jRJmouJiZbR2BLDaIt22qeLcCkZdwZbkDwwVNrK6fYDhSwX1cWbof/RNd02GzYGzUwsfs8rSDtwecL3R2Si4tSk5DzaxtCOvyeXEoKt7IFqfKPAbnsrY7nZnVNXTFDnqDn0Ch09j3WRFPvV6muCNmLWKGGQ6DmqbNxe4iFnOkW9IdJzo8B16rC5/2wj5f19nzJuZnqdhSYHd8rduwjTuGtbogpaZIjrgMrOumfXoYxl/jFF9yjW5KwqZb6aAc+CAu5Od5RJA5m9AvWrjfomTkKnAycbdNzQiAfFh7hVUUWbXod4rIiZDsZMJsjgo1/KeCsjPWLEycHMUVao/bXPazavNbDr0TCVgrvp+8c+KjSMHwvbTuXeSxx5Uyrb9esE96HpMgzy1t2qAqLxx7PCuba3Hqe+G
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: df437fb3-3246-4465-0eac-08d7688be94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:42.2196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otqjKGWZ0RNMYnzFPu55JvFcpblrE1hIrRrCNFqGx7A2hlEmLH6j7lI1TMUQZRYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.113
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
 include/sysemu/sysemu.h |  4 ++++
 main.c                  | 53 +++++++++++++++++++++++++++++++++++++++++
 vl.c                    | 38 ++++++++---------------------
 5 files changed, 70 insertions(+), 28 deletions(-)
 create mode 100644 main.c

diff --git a/Makefile b/Makefile
index 0e994a275d..d2b2ecd3c4 100644
--- a/Makefile
+++ b/Makefile
@@ -474,6 +474,7 @@ $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
+$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
=20
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
diff --git a/Makefile.objs b/Makefile.objs
index 11ba1a36bd..9ff9b0c6f9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -86,6 +86,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qapi/
+
+softmmu-main-y =3D main.o
 endif
=20
 #######################################################################
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 44f18eb739..d1dbf85414 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -114,6 +114,10 @@ QemuOpts *qemu_get_machine_opts(void);
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
index c389d24b2c..adb08a3d41 100644
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
@@ -1797,7 +1778,7 @@ static bool main_loop_should_exit(void)
     return false;
 }
=20
-static void main_loop(void)
+void qemu_main_loop(void)
 {
 #ifdef CONFIG_PROFILER
     int64_t ti;
@@ -2824,7 +2805,7 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
=20
-int main(int argc, char **argv, char **envp)
+void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot, linux_boot;
@@ -3404,7 +3385,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_watchdog:
                 if (watchdog) {
                     error_report("only one watchdog option may be given");
-                    return 1;
+                    exit(1);
                 }
                 watchdog =3D optarg;
                 break;
@@ -3847,7 +3828,7 @@ int main(int argc, char **argv, char **envp)
     set_memory_options(&ram_slots, &maxram_size, machine_class);
=20
     os_daemonize();
-    rcu_disable_atfork();
+    /* rcu_disable_atfork(); */
=20
     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
         error_reportf_err(err, "cannot create PID file: ");
@@ -4327,7 +4308,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     /* do monitor/qmp handling at preconfig state if requested */
-    main_loop();
+    qemu_main_loop();
=20
     audio_init_audiodevs();
=20
@@ -4440,7 +4421,7 @@ int main(int argc, char **argv, char **envp)
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
-        return 0;
+        exit(0);
     }
=20
     if (incoming) {
@@ -4457,8 +4438,11 @@ int main(int argc, char **argv, char **envp)
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
@@ -4495,6 +4479,4 @@ int main(int argc, char **argv, char **envp)
     qemu_chr_cleanup();
     user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
-
-    return 0;
 }
--=20
2.23.0


