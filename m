Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0480C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B92218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRastHim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B92218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYpG-0007nM-HP
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3l-0007CM-G2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3k-0002va-4u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3j-0002sn-Fz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so1564591wmb.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=JkFx8EZyku6wPBzGFRNiCBerrbPJdOzb00ZCzJtUmrE=;
 b=IRastHimq8NodMQwvTjCQtfstnwpS8wSDRCnbDFjf5BjyIgO/XxicxKMoRMHy9/HqU
 gq8FdEdfaDFw8yuKp/IWnJL+HDvliw00v72NOvNynSEJUvD+QGJZwij5UiWDFy+fipaV
 RuM9h6i/ly23bEqjCLTBMj2jqk8RXqMb/6A/PJFNRp9YaFdMJmH/EaHH8b9lpsDg6Y39
 QZCQT7VdACLmqIW8aLqZkmBZ016jAI1emSKTOAkbp3j1SEUgNNjGCzxtTDj/bkjZW3eR
 4ObRlBnjE3gG89E7j7Tol9yOivfcUcrJo6NIBzowax7iMTZAyxiDkdiNhNPO4whoo8/8
 7jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=JkFx8EZyku6wPBzGFRNiCBerrbPJdOzb00ZCzJtUmrE=;
 b=N6UFHJHgyM+9TtAMMNpqZvD0aiGmei54Bf+ExJAD7yCAqK6sFDFPBN3uwoMHZmiBXn
 tnsh4oOq19Bw7DFEpuKrM3jop0aIzrvF2gRXM09O+Qjt9yH6hXo+YHL76mMLyLIbtn51
 +iaB1s1I809Q1oxI95kOma5GEZhoIG1HDl6S/+p8/M74yoekT2d4z+eEsJWd2WM49NMW
 WFdvqVUaXapTSuAiM/VM8uI08RS4b/zwuKtTQg/c46Q/emOtq11s0xxYRSNU2528NNzt
 v+SMrEvFjpk6O5NJ8yJY6X9AsEBPIGZ7ki7zduS0GZasXbOUY1scdHfNYTf9Qd5d1Mzy
 i9ag==
X-Gm-Message-State: APjAAAXJtelilsH3KQaeBeOOT1TwWl1DA6Y7O/xeWU1p89pNj/7sQ6Vy
 9vnG6eJsoUzEBxZ50VHlRqpMEiGO
X-Google-Smtp-Source: APXvYqzREdO5W8uimBYCK6b3rsb8V40ZSn+HD4WSgGazObGIndzKuM50BLT8k2NeMgJ1JrFqO842Xg==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr2926060wmc.70.1576670646215;
 Wed, 18 Dec 2019 04:04:06 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 63/87] build: rename CONFIG_LIBCAP to CONFIG_LIBCAP_NG
Date: Wed, 18 Dec 2019 13:02:29 +0100
Message-Id: <1576670573-48048-64-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Since we are actually testing for the newer capng library, rename the
symbol to match.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             |  2 +-
 qemu-bridge-helper.c  |  6 +++---
 scsi/qemu-pr-helper.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 2943f5d..5723a29 100755
--- a/configure
+++ b/configure
@@ -6720,7 +6720,7 @@ if test "$l2tpv3" = "yes" ; then
   echo "CONFIG_L2TPV3=y" >> $config_host_mak
 fi
 if test "$cap_ng" = "yes" ; then
-  echo "CONFIG_LIBCAP=y" >> $config_host_mak
+  echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 3d50ec0..88b2674 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -43,7 +43,7 @@
 
 #include "net/tap-linux.h"
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 #include <cap-ng.h>
 #endif
 
@@ -207,7 +207,7 @@ static int send_fd(int c, int fd)
     return sendmsg(c, &msg, 0);
 }
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 static int drop_privileges(void)
 {
     /* clear all capabilities */
@@ -246,7 +246,7 @@ int main(int argc, char **argv)
     int access_allowed, access_denied;
     int ret = EXIT_SUCCESS;
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
     /* if we're run from an suid binary, immediately drop privileges preserving
      * cap_net_admin */
     if (geteuid() == 0 && getuid() != geteuid()) {
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index debb18f..0659cee 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -24,7 +24,7 @@
 #include <linux/dm-ioctl.h>
 #include <scsi/sg.h>
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 #include <cap-ng.h>
 #endif
 #include <pwd.h>
@@ -70,7 +70,7 @@ static int num_active_sockets = 1;
 static int noisy;
 static int verbose;
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 static int uid = -1;
 static int gid = -1;
 #endif
@@ -97,7 +97,7 @@ static void usage(const char *name)
 "                            (default '%s')\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "                            specify tracing options\n"
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 "  -u, --user=USER           user to drop privileges to\n"
 "  -g, --group=GROUP         group to drop privileges to\n"
 #endif
@@ -827,7 +827,7 @@ static void close_server_socket(void)
     num_active_sockets--;
 }
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 static int drop_privileges(void)
 {
     /* clear all capabilities */
@@ -920,7 +920,7 @@ int main(int argc, char **argv)
             pidfile = g_strdup(optarg);
             pidfile_specified = true;
             break;
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
         case 'u': {
             unsigned long res;
             struct passwd *userinfo = getpwnam(optarg);
@@ -1056,7 +1056,7 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
     if (drop_privileges() < 0) {
         error_report("Failed to drop privileges: %s", strerror(errno));
         exit(EXIT_FAILURE);
-- 
1.8.3.1



