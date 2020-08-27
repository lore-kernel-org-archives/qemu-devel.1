Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899C4207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899C4207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNW8-0004ML-QP
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS7-0004Hl-H8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS4-0000Hd-16
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:51 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Myb8N-1kWmFs2PIj-00yvbX; Thu, 27 Aug 2020 21:20:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] linux-user: Add missing termbits types and values
 definitions
Date: Thu, 27 Aug 2020 21:20:10 +0200
Message-Id: <20200827192018.2442099-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y+sY9KuLKv6w3ax14hGN/Ki47Yey+tevoZDfqy7rFvfur8lUI50
 Zfsj8t36xXZzFktg/WClO4GyeNF8PzjHsgPsgR5prpN122PgryP5YGj+Sj1X3xDJ3FOzUKK
 6CXiLnQ3gY1BBPTfzduEyLxEwR4DQAlod4+ItrId5H5dbckm5uXk2IVaL9p24ChpSdnyLXw
 fobJS45aYaf4hruFA4iKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LTBaspZAbWk=:5jFq/AHiLRFnm/GHFo3dGf
 QDXOoBbJ+vJtp+BwE+FqWa7aV3Zd81xaGpG14BDSKBVZSc3pw6Z/EGa6+q75Rpy9UG0j/De0+
 E7i2/G5RvZK0DMJcYfHludcFaIl0ttg6m24s/chwCvdtkYYyOIjidutxV44we3dzX7IPzPjR4
 6dsdDM14Bl7Q6yDi2VAOuMuIDa7RLDw5s7lJ2N26PV1TdoXVnLgx2mQEOd0ehZkDiu0U51ewy
 0jwGXHwapz+kt7EubDNtEs6nfoHiNRIK/6V3+T0nf3VQ5DjeDswVyAPQwowcjeuDLqPFmzN2p
 IvSkIlW8qRD9FbMz/rYm1bbk1j06fCeOf3Qm/leXtlWtciuNQLaLhR13Hkmsa0IRtZD65YKIl
 Tr+94FLnFPRh9FJZfLyKqwEQbUXNhkkJDZKeea7PrsM9E2Sf763ZxAUwzH04rpmxkpz+i7K8G
 lHV94KJt7Gq6/o8my8bR8mreSIU4qUTuRxIlNjVcERF5KO8B9pdajOXqzLStdvDVNbuyeRhXd
 N1nW7To/OtoN5t4KQFCJGkZuOcwqaXk6Z5qiCHkVr0Kmsa4AWKapSBcKLhDS8TTfRaW9anBJ+
 jNKEq5kZt3kPBD+7WPyduKgx6wwP4g/NLUF3iEh7WgH4RfaxPSY0MYZ5yZOB1sfXPzkJJjzLu
 gvO6kC+AZTmmR7rXaeYd11YSzcrG7yC/tYvQDGw85weC/3hskm/8kJefmDqwrEz3HYJPSyCje
 mNPMy1h1eKsV1I8hHpsC4zVRbZzVir1eRqGdCFcdxgk4oL1U1/J88IRxsQA5syTIp7t0Q/4St
 mkuJbEGe8gH2BZB2btMs445u951vfqohCon72AC2Ym5HjSkfKL6MQsxaFCheU8QrfJSMiFu
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch introduces missing target types ('target_flag_t', 'target_cc_t',
'target_speed_t') in a few 'termibts.h' header files. Also, two missing
values ('TARGET_IUTF8' and 'TARGET_EXTPROC') were also added. These values
were also added in file 'syscall.c' in bitmask tables 'iflag_tbl[]' and
'lflag_tbl[]' which are used to convert values of 'struct termios' between
target and host.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200723210233.349690-3-Filip.Bozuta@syrmia.com>
[lv: keep TARGET_NCCS definition in xtensa/termbits.h]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/termbits.h   |  1 +
 linux-user/cris/termbits.h    | 18 ++++++++----
 linux-user/hppa/termbits.h    | 17 +++++++----
 linux-user/mips/termbits.h    | 17 +++++++----
 linux-user/ppc/termbits.h     | 21 ++++++++-----
 linux-user/sh4/termbits.h     | 19 ++++++++----
 linux-user/sparc/termbits.h   | 18 ++++++++----
 linux-user/sparc64/termbits.h | 18 ++++++++----
 linux-user/syscall.c          | 34 ++++++++++++----------
 linux-user/xtensa/termbits.h  | 55 ++++++++++++++++++-----------------
 10 files changed, 132 insertions(+), 86 deletions(-)

diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index a71425174a97..4a4b1e96f21c 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -159,6 +159,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00800000
 #define TARGET_PENDIN	0x20000000
 #define TARGET_IEXTEN	0x00000400
+#define TARGET_EXTPROC  0x10000000
 
 #define TARGET_FIOCLEX		TARGET_IO('f', 1)
 #define TARGET_FIONCLEX	TARGET_IO('f', 2)
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
index 475ee70fed37..0c8d8fc05164 100644
--- a/linux-user/cris/termbits.h
+++ b/linux-user/cris/termbits.h
@@ -5,13 +5,17 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
 /* c_iflag bits */
@@ -29,6 +33,7 @@ struct target_termios {
 #define TARGET_IXANY   0004000
 #define TARGET_IXOFF   0010000
 #define TARGET_IMAXBEL 0020000
+#define TARGET_IUTF8   0040000
 
 /* c_oflag bits */
 #define TARGET_OPOST   0000001
@@ -118,6 +123,7 @@ struct target_termios {
 #define TARGET_FLUSHO  0010000
 #define TARGET_PENDIN  0040000
 #define TARGET_IEXTEN  0100000
+#define TARGET_EXTPROC 0200000
 
 /* c_cc character offsets */
 #define TARGET_VINTR	0
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 8fba839dd4e6..11fd4eed6232 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -5,13 +5,17 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
 /* c_iflag bits */
@@ -120,6 +124,7 @@ struct target_termios {
 #define TARGET_FLUSHO  0010000
 #define TARGET_PENDIN  0040000
 #define TARGET_IEXTEN  0100000
+#define TARGET_EXTPROC 0200000
 
 /* c_cc character offsets */
 #define TARGET_VINTR    0
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 3287cf6df8b8..e8b4b58d878d 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -5,13 +5,17 @@
 
 #define TARGET_NCCS 23
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
 /* c_iflag bits */
@@ -133,6 +137,7 @@ struct target_termios {
 #define TARGET_PENDIN  0040000
 #define TARGET_TOSTOP  0100000
 #define TARGET_ITOSTOP TARGET_TOSTOP
+#define TARGET_EXTPROC 0200000
 
 /* c_cc character offsets */
 #define TARGET_VINTR	0
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index 19e4c6eda86c..7066d1e5523d 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -5,15 +5,19 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
-    unsigned char c_line;                    /* line discipline */
-    unsigned int c_ispeed;		/* input speed */
-    unsigned int c_ospeed;		/* output speed */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_speed_t c_ispeed;               /* input speed */
+    target_speed_t c_ospeed;               /* output speed */
 };
 
 /* c_cc character offsets */
@@ -158,6 +162,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00800000
 #define TARGET_PENDIN	0x20000000
 #define TARGET_IEXTEN	0x00000400
+#define TARGET_EXTPROC  0x10000000
 
 /* ioctls */
 
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index dd125b6a2b2a..f91b5c51cf83 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -5,15 +5,20 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-	unsigned int c_iflag;			/* input mode flags */
-	unsigned int c_oflag;			/* output mode flags */
-	unsigned int c_cflag;			/* control mode flags */
-	unsigned int c_lflag;			/* local mode flags */
-	unsigned char c_line;			/* line discipline */
-	unsigned char c_cc[TARGET_NCCS];	/* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 /* c_cc characters */
 #define TARGET_VINTR 0
 #define TARGET_VQUIT 1
@@ -150,6 +155,8 @@ struct target_termios {
 #define TARGET_FLUSHO	0010000
 #define TARGET_PENDIN	0040000
 #define TARGET_IEXTEN	0100000
+#define TARGET_EXTPROC  0200000
+
 
 /* tcflow() and TCXONC use these */
 #define TARGET_TCOOFF		0
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index f85219ed7112..704bee1c427e 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -5,15 +5,20 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 /* c_cc characters */
 #define TARGET_VINTR    0
 #define TARGET_VQUIT    1
@@ -170,6 +175,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00002000
 #define TARGET_PENDIN	0x00004000
 #define TARGET_IEXTEN	0x00008000
+#define TARGET_EXTPROC  0x00010000
 
 /* ioctls */
 
diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.h
index 11b5abcf8439..1ab1e80db548 100644
--- a/linux-user/sparc64/termbits.h
+++ b/linux-user/sparc64/termbits.h
@@ -5,15 +5,20 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 /* c_cc characters */
 #define TARGET_VINTR    0
 #define TARGET_VQUIT    1
@@ -170,6 +175,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00002000
 #define TARGET_PENDIN	0x00004000
 #define TARGET_IEXTEN	0x00008000
+#define TARGET_EXTPROC  0x00010000
 
 /* ioctls */
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 027dea35af41..3a7eced7d858 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5549,6 +5549,7 @@ static const bitmask_transtbl iflag_tbl[] = {
         { TARGET_IXANY, TARGET_IXANY, IXANY, IXANY },
         { TARGET_IXOFF, TARGET_IXOFF, IXOFF, IXOFF },
         { TARGET_IMAXBEL, TARGET_IMAXBEL, IMAXBEL, IMAXBEL },
+        { TARGET_IUTF8, TARGET_IUTF8, IUTF8, IUTF8},
         { 0, 0, 0, 0 }
 };
 
@@ -5616,22 +5617,23 @@ static const bitmask_transtbl cflag_tbl[] = {
 };
 
 static const bitmask_transtbl lflag_tbl[] = {
-	{ TARGET_ISIG, TARGET_ISIG, ISIG, ISIG },
-	{ TARGET_ICANON, TARGET_ICANON, ICANON, ICANON },
-	{ TARGET_XCASE, TARGET_XCASE, XCASE, XCASE },
-	{ TARGET_ECHO, TARGET_ECHO, ECHO, ECHO },
-	{ TARGET_ECHOE, TARGET_ECHOE, ECHOE, ECHOE },
-	{ TARGET_ECHOK, TARGET_ECHOK, ECHOK, ECHOK },
-	{ TARGET_ECHONL, TARGET_ECHONL, ECHONL, ECHONL },
-	{ TARGET_NOFLSH, TARGET_NOFLSH, NOFLSH, NOFLSH },
-	{ TARGET_TOSTOP, TARGET_TOSTOP, TOSTOP, TOSTOP },
-	{ TARGET_ECHOCTL, TARGET_ECHOCTL, ECHOCTL, ECHOCTL },
-	{ TARGET_ECHOPRT, TARGET_ECHOPRT, ECHOPRT, ECHOPRT },
-	{ TARGET_ECHOKE, TARGET_ECHOKE, ECHOKE, ECHOKE },
-	{ TARGET_FLUSHO, TARGET_FLUSHO, FLUSHO, FLUSHO },
-	{ TARGET_PENDIN, TARGET_PENDIN, PENDIN, PENDIN },
-	{ TARGET_IEXTEN, TARGET_IEXTEN, IEXTEN, IEXTEN },
-	{ 0, 0, 0, 0 }
+  { TARGET_ISIG, TARGET_ISIG, ISIG, ISIG },
+  { TARGET_ICANON, TARGET_ICANON, ICANON, ICANON },
+  { TARGET_XCASE, TARGET_XCASE, XCASE, XCASE },
+  { TARGET_ECHO, TARGET_ECHO, ECHO, ECHO },
+  { TARGET_ECHOE, TARGET_ECHOE, ECHOE, ECHOE },
+  { TARGET_ECHOK, TARGET_ECHOK, ECHOK, ECHOK },
+  { TARGET_ECHONL, TARGET_ECHONL, ECHONL, ECHONL },
+  { TARGET_NOFLSH, TARGET_NOFLSH, NOFLSH, NOFLSH },
+  { TARGET_TOSTOP, TARGET_TOSTOP, TOSTOP, TOSTOP },
+  { TARGET_ECHOCTL, TARGET_ECHOCTL, ECHOCTL, ECHOCTL },
+  { TARGET_ECHOPRT, TARGET_ECHOPRT, ECHOPRT, ECHOPRT },
+  { TARGET_ECHOKE, TARGET_ECHOKE, ECHOKE, ECHOKE },
+  { TARGET_FLUSHO, TARGET_FLUSHO, FLUSHO, FLUSHO },
+  { TARGET_PENDIN, TARGET_PENDIN, PENDIN, PENDIN },
+  { TARGET_IEXTEN, TARGET_IEXTEN, IEXTEN, IEXTEN },
+  { TARGET_EXTPROC, TARGET_EXTPROC, EXTPROC, EXTPROC},
+  { 0, 0, 0, 0 }
 };
 
 static void target_to_host_termios (void *dst, const void *src)
diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
index d1e09e61a69b..ce6fb081e355 100644
--- a/linux-user/xtensa/termbits.h
+++ b/linux-user/xtensa/termbits.h
@@ -15,40 +15,42 @@
 
 #include <linux/posix_types.h>
 
-typedef unsigned char   cc_t;
-typedef unsigned int    speed_t;
-typedef unsigned int    tcflag_t;
-
 #define TARGET_NCCS 19
+
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    tcflag_t c_iflag;       /* input mode flags */
-    tcflag_t c_oflag;       /* output mode flags */
-    tcflag_t c_cflag;       /* control mode flags */
-    tcflag_t c_lflag;       /* local mode flags */
-    cc_t c_line;            /* line discipline */
-    cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 struct target_termios2 {
-    tcflag_t c_iflag;       /* input mode flags */
-    tcflag_t c_oflag;       /* output mode flags */
-    tcflag_t c_cflag;       /* control mode flags */
-    tcflag_t c_lflag;       /* local mode flags */
-    cc_t c_line;            /* line discipline */
-    cc_t c_cc[TARGET_NCCS]; /* control characters */
-    speed_t c_ispeed;       /* input speed */
-    speed_t c_ospeed;       /* output speed */
+    target_tcflag_t c_iflag;       /* input mode flags */
+    target_tcflag_t c_oflag;       /* output mode flags */
+    target_tcflag_t c_cflag;       /* control mode flags */
+    target_tcflag_t c_lflag;       /* local mode flags */
+    target_cc_t c_line;            /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_speed_t c_ispeed;       /* input speed */
+    target_speed_t c_ospeed;       /* output speed */
 };
 
 struct target_ktermios {
-    tcflag_t c_iflag;       /* input mode flags */
-    tcflag_t c_oflag;       /* output mode flags */
-    tcflag_t c_cflag;       /* control mode flags */
-    tcflag_t c_lflag;       /* local mode flags */
-    cc_t c_line;            /* line discipline */
-    cc_t c_cc[TARGET_NCCS]; /* control characters */
-    speed_t c_ispeed;       /* input speed */
-    speed_t c_ospeed;       /* output speed */
+    target_tcflag_t c_iflag;       /* input mode flags */
+    target_tcflag_t c_oflag;       /* output mode flags */
+    target_tcflag_t c_cflag;       /* control mode flags */
+    target_tcflag_t c_lflag;       /* local mode flags */
+    target_cc_t c_line;            /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_speed_t c_ispeed;       /* input speed */
+    target_speed_t c_ospeed;       /* output speed */
 };
 
 /* c_cc characters */
@@ -195,6 +197,7 @@ struct target_ktermios {
 #define TARGET_FLUSHO   0010000
 #define TARGET_PENDIN   0040000
 #define TARGET_IEXTEN   0100000
+#define TARGET_EXTPROC  0200000
 
 /* tcflow() and TCXONC use these */
 
-- 
2.26.2


