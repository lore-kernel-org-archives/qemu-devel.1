Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9B3C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C3624658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="yNqmDUGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3624658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dCy-00079X-FL
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBd-0004Hn-O2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBc-0005vJ-Bl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:41 -0500
Received: from mail-co1nam11on2123.outbound.protection.outlook.com
 ([40.107.220.123]:19041 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBc-0005uk-2M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFIleQ+xan2OlQVVXhNMliMRMgn2cOi9FqfhENlgZBy7p8udCvSoPJMAVYgs+ouyTnqyyt46GAZQWZxDD0XpJgVLSf7lYoDq9dOeuxFZZDQ3VGTPQm4zSSR1kJ7IM//PsFSPXOR+Tmh+OYzefblULCKzF5CRRlSXxs/ciiYWQa483dZdmNtQeloEzFBYksCa5W4OR+DxGaRBMcVBJe5QzJA5qwMOCQNgdPYBTfxwvAiTw+5YuN66zaMADi9fKYCh9uLaWrEAmWABk2MJN47VriFj3HDuDhrhNDSm81fBhlrab1ce6SZUYqBAJdwXEsi0Y3eXVxrY2zbGD4qzS/pE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuvvFHo6ZGB+9RGFigaQNfb08YzO4AL7TOYeMAhs/FE=;
 b=Y/6TO0mVII3HIyTYOSojBP00iOlUkf19+wFIAfW4ccTzaaOtwqJDOmJV+gw88ah2Gt57zf+KRBKKzaYEtL7bfPM/PdIXW6QAm7Lc17KSYp9PpG9EtKvsTMqqATlaigqCOSSrDi8pPAtXYvualNpHKXUGJAzLLbtXBrwRhmF8hj33fxpjOiH5hZ3lV9y63DmyrnTpDErtUYjzPBK6f3IemSTiRwZdsR+Aht/8WUM5xEWApOi6dbY6nQlfxBZQZHZhREj77d9A2n0MYXL6xuALpCGwC4edHgxw6F7UZ4s0hyTPnBJ2xNgTkhHfgM90ee8T7EEZfWHXmhJQlYnjgDij1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuvvFHo6ZGB+9RGFigaQNfb08YzO4AL7TOYeMAhs/FE=;
 b=yNqmDUGw+AH7Lt9sFbgqQFq1YLrzMmqxgMpmFE4V50QypmlFc9rstzpmq3Go0kxoCm062pP7kBIXdZRiF0T1quWfw5a07UNDp4wTVfOM5gVNMWX4Wr9Hw/04sP/KgNGTnbWf+MJnU6vavpA7NKi9hj6QcGjVkn8q99B347taEMA=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:37 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:37 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 02/22] softmmu: split off vl.c:main() into main.c
Date: Wed, 19 Feb 2020 23:10:58 -0500
Message-ID: <20200220041118.23264-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:36 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54eac7ee-7f48-4ef2-8af0-08d7b5bafab0
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38070796388AA7FA475326FCBA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UTKJYKMm40xKSd4ebk1OZpsTPtS/12qZDViCyEkkR4o4nF/+n3Z04Rgeg1FItxk8qM7zPPN/c26iowT7rrBhG69xjtyswWYdOzYld+GR5wjTyPWEIuOQlcI+MChBECBtveXcUVuda0QkBLllUAaVU/JFwqkqnk5ll6o5v1nomc1Vd8U3oVqRk6TnZdbMIDer6OaEDpCyP2S0Zd4+NC09HbwDx9F4PIZ++tRlC4u9guCl9SUVmUhVgJqPAYLYw5uk4S8Aoov5FEdRS4HQE2TBn3FqhDXbMgodqZnDkOiXmb7UUBbfXPVUw6La1pZ+Z1n1JiP8byryD+qrYzz6bD5wVLQYGAgenMjdP+zEGdCI3iW3hX+qL0ilYWmd5zSc9yGTJSBzLWSbrKJ9ECf9+vvi49qgQHExO7rbdI5u8FJ5kxqdE3bl1qHYn6BVSptxbOi
X-MS-Exchange-AntiSpam-MessageData: dGkNNqfo5NJp7Q6nnlitPQxbDJbcC/ezhvXF8bszLAK/Jl0y8dplBtaoU1jvLIRTIWfKocDRpk+NWZcoCtFj7OeESDmurMoD++Bf7D1q4VDTd70cN1TMB1YUbCwV6VLyj0FGkYiYITU3ZVpb7Z076Q==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eac7ee-7f48-4ef2-8af0-08d7b5bafab0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:37.3301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktiEnfAcF0782NNanw1oXxw26DD4A0YwWC2CWHok5oehm70tI3Oc9xSVUbQvxEPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.123
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 MAINTAINERS             |  1 +
 Makefile.target         |  2 +-
 include/sysemu/sysemu.h |  4 ++++
 softmmu/Makefile.objs   |  1 +
 softmmu/main.c          | 53 +++++++++++++++++++++++++++++++++++++++++
 softmmu/vl.c            | 36 +++++++---------------------
 6 files changed, 69 insertions(+), 28 deletions(-)
 create mode 100644 softmmu/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 98cbeaab97..a8e2a5f8c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2024,6 +2024,7 @@ F: include/sysemu/runstate.h
 F: util/main-loop.c
 F: util/qemu-timer.c
 F: softmmu/vl.c
+F: softmmu/main.c
 F: qapi/run-state.json
=20
 Human Monitor (HMP)
diff --git a/Makefile.target b/Makefile.target
index 06c36d1161..6f4dd72022 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -203,7 +203,7 @@ endif
 COMMON_LDADDS =3D ../libqemuutil.a
=20
 # build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
+$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS) $(softmmu-main-y)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
 	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ=
","$(TARGET_DIR)$@")
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 6358a324a7..3e81a1a79c 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -116,6 +116,10 @@ QemuOpts *qemu_get_machine_opts(void);
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
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index d80a5ffe5a..dd15c24346 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,2 +1,3 @@
+softmmu-main-y =3D softmmu/main.o
 obj-y +=3D vl.o
 vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/softmmu/main.c b/softmmu/main.c
new file mode 100644
index 0000000000..7adc530c73
--- /dev/null
+++ b/softmmu/main.c
@@ -0,0 +1,53 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2020 Fabrice Bellard
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
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 7dcb0879c4..46a48d09df 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
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
@@ -1671,7 +1652,7 @@ static bool main_loop_should_exit(void)
     return false;
 }
=20
-static void main_loop(void)
+void qemu_main_loop(void)
 {
 #ifdef CONFIG_PROFILER
     int64_t ti;
@@ -2839,7 +2820,7 @@ static void configure_accelerators(const char *progna=
me)
     }
 }
=20
-int main(int argc, char **argv, char **envp)
+void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot, linux_boot;
@@ -3391,7 +3372,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_watchdog:
                 if (watchdog) {
                     error_report("only one watchdog option may be given");
-                    return 1;
+                    exit(1);
                 }
                 watchdog =3D optarg;
                 break;
@@ -4300,7 +4281,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     /* do monitor/qmp handling at preconfig state if requested */
-    main_loop();
+    qemu_main_loop();
=20
     audio_init_audiodevs();
=20
@@ -4418,7 +4399,7 @@ int main(int argc, char **argv, char **envp)
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
-        return 0;
+        exit(0);
     }
=20
     if (incoming) {
@@ -4435,8 +4416,11 @@ int main(int argc, char **argv, char **envp)
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
@@ -4473,6 +4457,4 @@ int main(int argc, char **argv, char **envp)
     qemu_chr_cleanup();
     user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
-
-    return 0;
 }
--=20
2.25.0


