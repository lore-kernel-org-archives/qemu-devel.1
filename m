Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B908C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D987020449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO4yH7DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D987020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53643 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST9P-0001kU-35
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:15:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZX-0003X5-9b
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZV-0004GD-Ej
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:19 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZS-00049v-MS
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id d21so5723866plr.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+9S8A+10b/scYDuW511dsngcQtz7czOu50I+GmgaCmA=;
	b=YO4yH7DU920V0heupxU9QywCSVUahP0gLIg7yLjjMPtbyThCfZU8jFR412OquWGB1o
	mWMCzJCXEGzqo2g5woL+FAc9Cqt9Y22wJKtEu6Sb3p8/Du+FwbQpOKHxowxmyH7ArVNm
	QIT3yYDNRJ1J3nB1MGdm9Jd55YAdAt6pnuXT/ZK63meevKYeEmKHXJf4WyObb34NRFoL
	V3/hUUX1HF7k2JjzRCiNk5fjxpl6gzFuPE7swOTOuUP6oFKwU0t7Vk9+S2j7LANRMWoa
	JaM6Flp4wSqrPZyCFNUpIfaixcUoP3gZGdunaU1PLQ8qzwdor49EOvJxI6O46vPhod4t
	jY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+9S8A+10b/scYDuW511dsngcQtz7czOu50I+GmgaCmA=;
	b=tLCuBPSZitNurlMwOTzpkUzDe3QL71Z3K8nDgxiT068TkmFf9uXglheUkHJgmVf9ib
	dWCntov0p6vIoXKxiwfi0kzTaOtOx41oZMJF9jrJTegdH5XgIaUI3oXOwZgiZrFeIUdR
	j70aFs5D436DRenR9Szyiogxk/wdhuitl0fwKxoO2sJmA6+jFROWaBazR6F4EOLisxFa
	MS5OT6zBAo9CzTbCENSv800kpJhAJ274zusw0mbcTgyz6IFBPyult9qyYFxWZq12IWWw
	eJi6aaioDMxk4q4GhL/agxzk7FlW2H5G5vuOwOwpoutjBQVeSYx/IiDkvmsiyGVGg+Tt
	hvaw==
X-Gm-Message-State: APjAAAU1f+W4rAWw0v6qjBDKwb0KziCGnCN5cDyOBwnWxj+wRD5IyO6B
	jd97q+FMExxXGtcEkFWBluv3YnQHpTU=
X-Google-Smtp-Source: APXvYqxHv1lMAeNl7shVdbq2wOi7APtYiOx420pq1KyVIUNQlYtYO5kCdokBgV54STjSdyeHkVzyKA==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
	ay10mr63346806plb.74.1558298292191; 
	Sun, 19 May 2019 13:38:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:45 -0700
Message-Id: <20190519203726.20729-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 33/74] linux-user: Split out stime
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  3 +++
 linux-user/syscall-time.inc.c | 12 ++++++++++++
 linux-user/syscall.c          |  9 ---------
 linux-user/strace.list        |  3 ---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 0d8da0c6d6..6ca82af397 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -152,6 +152,9 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_stime
+SYSCALL_DEF(stime, ARG_PTR);
+#endif
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
diff --git a/linux-user/syscall-time.inc.c b/linux-user/syscall-time.inc.c
index 14fec88e47..d1fb72bde0 100644
--- a/linux-user/syscall-time.inc.c
+++ b/linux-user/syscall-time.inc.c
@@ -16,6 +16,18 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef TARGET_NR_stime
+SYSCALL_IMPL(stime)
+{
+    time_t host_time;
+
+    if (get_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(stime(&host_time));
+}
+#endif
+
 #ifdef TARGET_NR_time
 SYSCALL_IMPL(time)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f3e03f535d..ae56ecbbc7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,15 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_stime /* not on alpha */
-    case TARGET_NR_stime:
-        {
-            time_t host_time;
-            if (get_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-            return get_errno(stime(&host_time));
-        }
-#endif
 #ifdef TARGET_NR_alarm /* not on alpha */
     case TARGET_NR_alarm:
         return alarm(arg1);
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 973a4c9209..d0646b9424 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1254,9 +1254,6 @@
 #ifdef TARGET_NR_statfs64
 { TARGET_NR_statfs64, "statfs64" , NULL, print_statfs64, NULL },
 #endif
-#ifdef TARGET_NR_stime
-{ TARGET_NR_stime, "stime" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_streams1
 { TARGET_NR_streams1, "streams1" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


