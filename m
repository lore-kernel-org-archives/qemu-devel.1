Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPOOFED_FREEMAIL,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B57C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51BB206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTukjVzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51BB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8sW1-000659-Pc
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 16:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorcunov@gmail.com>) id 1i8nji-0003D2-LX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gorcunov@gmail.com>) id 1i8njh-00043E-HM
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:43:50 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <gorcunov@gmail.com>) id 1i8njh-00042T-9f
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:43:49 -0400
Received: by mail-lj1-x244.google.com with SMTP id r14so4495865ljn.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=jgKKW5aJp4Q5nX7o5nn0ll5PZTXD30muXp2gJ8hwP7c=;
 b=NTukjVzjmrIUFOCC7bDsiG1cQw6Y8Att60dfPKgKq4psGg+Lg+30dncZAY0D9cV/qe
 gA6Wu7PI8zFA1a2PexqhczATvJLs7iHcN1sTCYahuDktAYW8T0O3aDXLmP37reDH0VE8
 JkHyTu72kr2Xk5ZBxsZPTM0VsBi3vdGR1hOTAwCNhEYRPObA1q+fDbR/yVIveSgddJSK
 rEwiBVUdha0zUvGoJ7NzU/35PEKuvQ1ppCQiZ6FfwLCu8SBPcEztZ8VkUkG6b9THD6rd
 uD+qp7Y0v+7LSBSc6lx3kWgyyCxrqvmpqEcgY1/3Is3G5eV+9V8z6BiJ+IGDETGnGni+
 UOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=jgKKW5aJp4Q5nX7o5nn0ll5PZTXD30muXp2gJ8hwP7c=;
 b=c0kQZGGYa005u+Tq7nZYk40Y4G+oG27aBgt9qhAPX6k9gw+t3vDvwOguhAvP/zjbAC
 J+7rMk8mVRLS0xVnDTFBYHLiA/9br6Fh/Qm7WdjNUaSmSNDF79HIOCdLe/ajekBVnlNI
 C7Nr2RmRX6FH4e7tkXVP2M0yQ22St+3LarBas7qa0ZYdCC1nEDFRUm7o5VnE43wNABWQ
 U79qzoZE4y3RHOnHSzDuA4jSgZuDQOcMPHEJ8QPUjtKhTGH8V7G/YbZAeutXJXQ3CsFQ
 8KapIrzWXUp4G+4hUvdTMvrHYGkLSdD0mWSGuR10ypsw/u2+Vb5aTmtSKYYpBYiuU2x+
 NI+Q==
X-Gm-Message-State: APjAAAUZIG6/UZSOz/1rhBHfn5vuz4o0v2xPtbC+CvaTFCfGcltauWdG
 FbfTuaspZLG9ExI+WTtAm5jnAPN3
X-Google-Smtp-Source: APXvYqzbeRv2/8LLRsGy7WwxYzHCUDe4lbDrk9Eq+xOSkW5ZtSrDew6wdImIBkoCYoupRfiXasaJrg==
X-Received: by 2002:a2e:3513:: with SMTP id z19mr31330904ljz.135.1568389427082; 
 Fri, 13 Sep 2019 08:43:47 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
 by smtp.gmail.com with ESMTPSA id o5sm7048871lfn.42.2019.09.13.08.43.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:43:45 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
 id 5FC9F460FA3; Fri, 13 Sep 2019 18:43:44 +0300 (MSK)
Date: Fri, 13 Sep 2019 18:43:44 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190913154344.GH1508@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
X-Mailman-Approved-At: Fri, 13 Sep 2019 16:47:11 -0400
Subject: [Qemu-devel] [PATCH] error-report: Add info_report_once helper
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

We already have error_report_once and warn_report_once,
thus lets add info_report_once to complement. Actually
I use this helper a lot so might be usefull for others.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 include/qemu/error-report.h |   13 +++++++++++++
 util/qemu-error.c           |   20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

Index: vanilla.git/include/qemu/error-report.h
===================================================================
--- vanilla.git.orig/include/qemu/error-report.h
+++ vanilla.git/include/qemu/error-report.h
@@ -47,6 +47,8 @@ bool error_report_once_cond(bool *printe
     GCC_FMT_ATTR(2, 3);
 bool warn_report_once_cond(bool *printed, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
+bool info_report_once_cond(bool *printed, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 void error_init(const char *argv0);
 
@@ -72,6 +74,17 @@ void error_init(const char *argv0);
                               fmt, ##__VA_ARGS__);      \
     })
 
+/*
+ * Similar to info_report(), except it prints the message just once.
+ * Return true when it prints, false otherwise.
+ */
+#define info_report_once(fmt, ...)                      \
+    ({                                                  \
+        static bool print_once_;                        \
+        info_report_once_cond(&print_once_,             \
+                              fmt, ##__VA_ARGS__);      \
+    })
+
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
 
Index: vanilla.git/util/qemu-error.c
===================================================================
--- vanilla.git.orig/util/qemu-error.c
+++ vanilla.git/util/qemu-error.c
@@ -350,6 +350,26 @@ bool warn_report_once_cond(bool *printed
     return true;
 }
 
+/*
+ * Like info_report(), except print just once.
+ * If *printed is false, print the message, and flip *printed to true.
+ * Return whether the message was printed.
+ */
+bool info_report_once_cond(bool *printed, const char *fmt, ...)
+{
+    va_list ap;
+
+    assert(printed);
+    if (*printed) {
+        return false;
+    }
+    *printed = true;
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_INFO, fmt, ap);
+    va_end(ap);
+    return true;
+}
+
 static char *qemu_glog_domains;
 
 static void qemu_log_func(const gchar *log_domain,

