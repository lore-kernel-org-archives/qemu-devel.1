Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703B5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0EA206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xddiOOt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0EA206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ianwg-0001sj-Qo
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianuX-0008WR-Dn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuT-0002if-R7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:44 -0500
Received: from mail-eopbgr740129.outbound.protection.outlook.com
 ([40.107.74.129]:22092 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuT-0002eA-F6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHA0ldWaa6jmL95hBYuwoYhzU/UyaQl6TydZsNcvv7yS2Ri93qzWns20uh3kcGi2FUExju59VG5dWi1242Ku2jkm9zPBVK3DsVjREU/mVFJ3Acd4N/cVer5+U4attrl/70LCuOtS9TDO4gq59XlFAV66J1Lk25BDgAfLnDRRUnaNPyhWeyxaEB2lKfX4j0d3ax4RIEQqVchU8GVQHIwqNh0DYfzuF1khDmZXrNwxG04Tkqex53C2guWNVCUiYZut8xyQvu4IgmjV+oGvrNF/TusA2dWqGl3cesS8oTAFYpzkuOph4myAOoK8vrAhuI5XFGWZb9h5I/tqJp17YNgOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj6eCWoHwrk+6rvsZD0Z+GnUkPZZ8qN30v1c2c+IavQ=;
 b=RPQ2/b5E1o8EL5PrKhUb8HEOQgR55ChtILgOh+JmPw0TuvjjDnqJNe6bSh1PpIA3ytQ+XEkOExWpdlW5wu0kzh3iGhUph6bIAWiPAMVzwK4V8m5M6AxZOjRlJGfCdnj6pRCcs1GuamqU5QWBcMwY9QWPesCpfnSXNlqpC/kMu0al3h4TPj2csi6kMRKy8Ua1XqfXJ1pUMXcCw7A5Ytb8UPhXZaHOPtLOpiNx+vM3xuXiTLb1JYxK0ERo22d8E7vsspQIwWadufn9wjz0zsqWtCtBicZmxgoKVkeGOsLq1EDTcG+1qpfiYjLw/yLq802ybjCbvnvXB61ctzvcQLSRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj6eCWoHwrk+6rvsZD0Z+GnUkPZZ8qN30v1c2c+IavQ=;
 b=xddiOOt5+2LqtitVM2jLU2xqGW6mariCRgjN0wQ1ggJwtr1Hj0lyxWruAVWDcT0uRR4HOI2kzaucivOo6TAB4mKKSp1sZ9IRzI32s1JicZzYnAsX5TvxZVdSInrxF6m5wi7puiL7V8QfU8v8Z4Mw7NGI7SeANYaj1jMxyf5VgGo=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:38 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:38 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 01/21] softmmu: split off vl.c:main() into main.c
Thread-Topic: [PATCH v6 01/21] softmmu: split off vl.c:main() into main.c
Thread-Index: AQHVpvzMn5eDiehRxkSA/IIME9gp2w==
Date: Fri, 29 Nov 2019 21:34:36 +0000
Message-ID: <20191129213424.6290-2-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: a5074784-748d-438f-620a-08d77513ee8e
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050E844309ADF9F95256EECBA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLD+ha5NnDAGpRWAhcZLagtr8VhPZCvRLP6xx1TeX2Cw9GmDX1Qmc9KGyC1t+BZ8MZk6bWHA225ai7VJ4whIZI/90wk8746FCX9Mf2DPoYzTyFjrHUxW/Ph7NSsWCZgQHuxWT2MbNz0OZ6PQhHu8nVLn3uT1Jlsi/OJ9/JTxQsaksOtBjfo9GgS7AQs8Mu8gEDPuQJWNFGGQAliySW+gVBA2OdGEH6GUH0M2ZC1j0tKEpYesA0Bk3KsFlRbkqyPYQ2BZ0JRKzmfrfcy+ErmmaJRERVsoOd5381ReH0HQXnLHAim5LJ7KQMHmeNSbYKyCeauJCwsk+fZpUiSoIQ+Wc7cB98fpSloQSNYdDdt9zMj9sw2NpJkiHRlHgVS68Trlec/2/UxcW8EHY5M8mq8t3/g8KSA+IpsiZjJ7nDKZgjOd5jKaA/Wo/I+W8ZxGNTyT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5074784-748d-438f-620a-08d77513ee8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:36.9208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lz6QsKr4KYOxHBcrWY80Dm5SY5bxToc2La/oPqnMAmFw/gTMEN/sDJZBMKud6qrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.129
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
index b437a346d7..aeca63a2b1 100644
--- a/Makefile
+++ b/Makefile
@@ -480,6 +480,7 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
+$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
 ifdef DECOMPRESS_EDK2_BLOBS
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 endif
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
index 6a65a64bfd..d294f94ab4 100644
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
@@ -1798,7 +1779,7 @@ static bool main_loop_should_exit(void)
     return false;
 }
=20
-static void main_loop(void)
+void qemu_main_loop(void)
 {
 #ifdef CONFIG_PROFILER
     int64_t ti;
@@ -2825,7 +2806,7 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
=20
-int main(int argc, char **argv, char **envp)
+void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot, linux_boot;
@@ -3407,7 +3388,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_watchdog:
                 if (watchdog) {
                     error_report("only one watchdog option may be given");
-                    return 1;
+                    exit(1);
                 }
                 watchdog =3D optarg;
                 break;
@@ -3853,7 +3834,7 @@ int main(int argc, char **argv, char **envp)
     set_memory_options(&ram_slots, &maxram_size, machine_class);
=20
     os_daemonize();
-    rcu_disable_atfork();
+    /* rcu_disable_atfork(); */
=20
     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
         error_reportf_err(err, "cannot create PID file: ");
@@ -4338,7 +4319,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     /* do monitor/qmp handling at preconfig state if requested */
-    main_loop();
+    qemu_main_loop();
=20
     audio_init_audiodevs();
=20
@@ -4451,7 +4432,7 @@ int main(int argc, char **argv, char **envp)
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
-        return 0;
+        exit(0);
     }
=20
     if (incoming) {
@@ -4468,8 +4449,11 @@ int main(int argc, char **argv, char **envp)
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
@@ -4506,6 +4490,4 @@ int main(int argc, char **argv, char **envp)
     qemu_chr_cleanup();
     user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
-
-    return 0;
 }
--=20
2.23.0


