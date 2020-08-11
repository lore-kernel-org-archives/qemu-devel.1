Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126EC20774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuI8lyEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126EC20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OTD-0008Nj-CJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Q0QyXwMKCpQG0K4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--scw.bounces.google.com>)
 id 1k5OQ3-0004tF-Gi
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:09:59 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:50832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Q0QyXwMKCpQG0K4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--scw.bounces.google.com>)
 id 1k5OQ1-0000kY-RB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:09:59 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id u189so15666105ybg.17
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=p92oowU9ZC1iU/Ox3DTKv9I37S1q6EF9YrLFp30qbYg=;
 b=vuI8lyEKsYwoI7xSTLJUzpuEDBHgrrvOdEWYuEtcfBUfWNjambssmcotPuM2oeKiqY
 JPbzMZNAc93MBulP7nEHOTyQl7+Th66HznMkllK2ZW+G9jr2Nts3QiZLe4D+W9+Dnymz
 D9SFp5fPKcAvq/IrbD50TSnNhBgXDyr6XJN+fbogMACBbSSixeEIHUKFyihvA2nNmrJN
 0wYlnCExxlvnhpAe43zPpbnGhr3bO3iVBFIqToC+2EBMSo/8qsURYCdM/o1IFggJqxZS
 QmqNaM4GioyJ9a/7x0JhkUDmUXp9zL5z1smDO4kjz1PcVPQ9ie86BvUtBzy0Js9IfNBM
 2+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=p92oowU9ZC1iU/Ox3DTKv9I37S1q6EF9YrLFp30qbYg=;
 b=KTtOeUrxgoNOP/fWXRP7xLDxvQE8Lc3eNokudb//Z3rPghW4dO3umLixBAJwCvQSXu
 y+COriSkZVjujhSfYFOru3ybjrhpP6FAwkNUptgaN1AadQVxWUu8wseiLntP5DRla833
 0YFfmGZYg2xRNH6pEU3el/OVn7ivO7H9Xitlvbu0LxE8LvSiOeXEH4iCh/1Y8K8H8Dc5
 PSrDVWiAzy9H3Scj+qNW9FIaQ/2I7w3NRTe/gGjp6jELAyzot7bGm+NWhLU+3WvdFbG1
 fTw/SykJWAl/9pZ51rOuOBEW+vKctzSWJlXv+n0hLzZbbNZX4jXNrGyZ0NitzIYoZ/Qu
 Mkuw==
X-Gm-Message-State: AOAM532//WKKU0xdLjunKJWKO9T0l46Bffn5RhjZA7AJ7FiPRhXG9W1l
 dyZ1DzyeXOaYbmRUHth+ceqaiXc6w0TWZU75pGrXFu5Z2Sav57XD+RGuPv551wOi8sd7xUNgn5n
 rJ3/haZ7NGmdkQdKF7djAtNQfq8H8y/0em1PMybd1VXrV2p+rftmL
X-Google-Smtp-Source: ABdhPJz8dwbOvoQpcPDcvQJAMYBZtYmGnQVvOQmmNivr9Ni3SebyqabG0zDmEwBiMSDMmrKKf//S/eU=
X-Received: by 2002:a25:3b0d:: with SMTP id i13mr45459447yba.314.1597129795399; 
 Tue, 11 Aug 2020 00:09:55 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:41 -0700
In-Reply-To: <cover.1597129029.git.scw@google.com>
Message-Id: <020a4b8e2185a0aab62c99abd0d8f9d8ff315c37.1597129029.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 1/8] linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Q0QyXwMKCpQG0K4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also reorder blocks so that they are all in the same order everywhere.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v1 -> v2:
  Updated print_fcntl().

 linux-user/strace.c       | 55 ++++++++++++++++++++++++++++++++-------
 linux-user/syscall.c      | 10 +++++++
 linux-user/syscall_defs.h | 14 +++++-----
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 13981341b3..4fff24b880 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1684,6 +1684,18 @@ print_fcntl(const struct syscallname *name,
         qemu_log("F_SETFL,");
         print_open_flags(arg2, 1);
         break;
+    case TARGET_F_OFD_GETLK:
+        qemu_log("F_OFD_GETLK,");
+        print_pointer(arg2, 1);
+        break;
+    case TARGET_F_OFD_SETLK:
+        qemu_log("F_OFD_SETLK,");
+        print_pointer(arg2, 1);
+        break;
+    case TARGET_F_OFD_SETLKW:
+        qemu_log("F_OFD_SETLKW,");
+        print_pointer(arg2, 1);
+        break;
     case TARGET_F_GETLK:
         qemu_log("F_GETLK,");
         print_pointer(arg2, 1);
@@ -1726,26 +1738,51 @@ print_fcntl(const struct syscallname *name,
 #endif
     case TARGET_F_SETLEASE:
         qemu_log("F_SETLEASE,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
     case TARGET_F_GETLEASE:
         qemu_log("F_GETLEASE");
         break;
-    case TARGET_F_SETPIPE_SZ:
-        qemu_log("F_SETPIPE_SZ,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
-        break;
-    case TARGET_F_GETPIPE_SZ:
-        qemu_log("F_GETPIPE_SZ");
-        break;
+#ifdef F_DUPFD_CLOEXEC
     case TARGET_F_DUPFD_CLOEXEC:
         qemu_log("F_DUPFD_CLOEXEC,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
+#endif
     case TARGET_F_NOTIFY:
         qemu_log("F_NOTIFY,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
+#ifdef F_GETOWN_EX
+    case TARGET_F_GETOWN_EX:
+        qemu_log("F_GETOWN_EX,");
+        print_pointer(arg2, 1);
+        break;
+#endif
+#ifdef F_SETOWN_EX
+    case TARGET_F_SETOWN_EX:
+        qemu_log("F_SETOWN_EX,");
+        print_pointer(arg2, 1);
+        break;
+#endif
+#ifdef F_SETPIPE_SZ
+    case TARGET_F_SETPIPE_SZ:
+        qemu_log("F_SETPIPE_SZ,");
+        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
+        break;
+    case TARGET_F_GETPIPE_SZ:
+        qemu_log("F_GETPIPE_SZ");
+        break;
+#endif
+#ifdef F_ADD_SEALS
+    case TARGET_F_ADD_SEALS:
+        qemu_log("F_ADD_SEALS,");
+        print_raw_param("0x"TARGET_ABI_FMT_lx, arg2, 1);
+        break;
+    case TARGET_F_GET_SEALS:
+        qemu_log("F_GET_SEALS");
+        break;
+#endif
     default:
         print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
         print_pointer(arg2, 1);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc25279..5645862798 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6305,6 +6305,14 @@ static int target_to_host_fcntl_cmd(int cmd)
     case TARGET_F_GETPIPE_SZ:
         ret = F_GETPIPE_SZ;
         break;
+#endif
+#ifdef F_ADD_SEALS
+    case TARGET_F_ADD_SEALS:
+        ret = F_ADD_SEALS;
+        break;
+    case TARGET_F_GET_SEALS:
+        ret = F_GET_SEALS;
+        break;
 #endif
     default:
         ret = -TARGET_EINVAL;
@@ -6591,6 +6599,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
     case TARGET_F_GETLEASE:
     case TARGET_F_SETPIPE_SZ:
     case TARGET_F_GETPIPE_SZ:
+    case TARGET_F_ADD_SEALS:
+    case TARGET_F_GET_SEALS:
         ret = get_errno(safe_fcntl(fd, host_cmd, arg));
         break;
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..70df1a94fb 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2292,12 +2292,14 @@ struct target_statfs64 {
 #endif
 
 #define TARGET_F_LINUX_SPECIFIC_BASE 1024
-#define TARGET_F_SETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 0)
-#define TARGET_F_GETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 1)
-#define TARGET_F_DUPFD_CLOEXEC (TARGET_F_LINUX_SPECIFIC_BASE + 6)
-#define TARGET_F_SETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 7)
-#define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
-#define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
+#define TARGET_F_SETLEASE            (TARGET_F_LINUX_SPECIFIC_BASE + 0)
+#define TARGET_F_GETLEASE            (TARGET_F_LINUX_SPECIFIC_BASE + 1)
+#define TARGET_F_DUPFD_CLOEXEC       (TARGET_F_LINUX_SPECIFIC_BASE + 6)
+#define TARGET_F_NOTIFY              (TARGET_F_LINUX_SPECIFIC_BASE + 2)
+#define TARGET_F_SETPIPE_SZ          (TARGET_F_LINUX_SPECIFIC_BASE + 7)
+#define TARGET_F_GETPIPE_SZ          (TARGET_F_LINUX_SPECIFIC_BASE + 8)
+#define TARGET_F_ADD_SEALS           (TARGET_F_LINUX_SPECIFIC_BASE + 9)
+#define TARGET_F_GET_SEALS           (TARGET_F_LINUX_SPECIFIC_BASE + 10)
 
 #include "target_fcntl.h"
 
-- 
2.28.0.220.ged08abb693-goog


