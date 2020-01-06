Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BF2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313DF2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxgaaiaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313DF2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXhN-00044O-QG
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5K-00048o-9p
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5J-0005NT-0f
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:38 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:33737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX5I-0005ND-TK; Mon, 06 Jan 2020 13:26:36 -0500
Received: by mail-qt1-x841.google.com with SMTP id d5so43225469qto.0;
 Mon, 06 Jan 2020 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XLjlJHRdZ19eNFwu3xtUWDKA1dixiH7lhcQ1c7qm+lk=;
 b=rxgaaiaGGAXY4b6eaHrizaVp6uRoDPzxm0U99pvv3OC2vBkxMyVPG1nC3ijsI2Xeiu
 Io8w5WoSUPCizvSw3Sjyz0yfIZEp9HGSV+PbEBxooaWvy264gz4Ijm3NpxPMMPZin937
 0iuI4IW00jfInthvUMN1kPBSZbQEWy3l8JL3I87w6KuqnCbX5V0wV8Iliqa5n4jI+ewh
 3uki8cLhCINIkX0ml3n6wGlT2zkRxfCCdlGlsVyUa1UbSeQ559yHXsZh/WK5bv2cH5w2
 uk6FPikyAAHpY0NxBpSjTC/BxG+q7XOug+eBodSz16DcveCs8//r+mDJnLHs5X/t+Rff
 uj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XLjlJHRdZ19eNFwu3xtUWDKA1dixiH7lhcQ1c7qm+lk=;
 b=h0Wdu4AMAZ9i1Al8pg4+lE1Wf9n7a2LbFkCqcj9IBnFqgSkd2FCQBtN7UewMMIiTvB
 Acq4b+zOBOi6PkwjCmGGDwNfTrvLvCKp0PmSKmJNadgyM09pUYPRcCLNpocQuSxLPiHu
 wbBiSfGUWTTk9RyPUpMkx2yVMw+Gpu6DuWkeV2Ho5CF7PYkzCkJT3TJf1Me877csnsuF
 K5rU8yIlnUm52LVhKGOtVRn6MkHheyGjAaNkzh2mtv9GoFn4+pfujV2Qy7y7Km1YKFDE
 0tmXpx5Hs3AEXFVVQvZRfEA73VhZxrzzZ1sADHmImTTq5teftV30PBTlBNRgucAp0bmt
 +15g==
X-Gm-Message-State: APjAAAWKnQj+wzP5FEraDVG01drIAWBobEOgJFJmbQwHDKFS0n5nRVue
 sXGA8np8ZN/vtHlluzA7L/+ewfCo
X-Google-Smtp-Source: APXvYqwqRExlnWSj4gM1GN00iSoFDDf0O6JVyrbbvKFfmIWOynI3GK8nhm+eTh7R+pmsda/kpSdNhA==
X-Received: by 2002:ac8:5442:: with SMTP id d2mr78989156qtq.297.1578335196334; 
 Mon, 06 Jan 2020 10:26:36 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:35 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 58/59] linux-user/syscall.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:24 -0300
Message-Id: <20200106182425.20312-59-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out2' label in do_sendrecvmsg_locked() can be replaced by
'return' with the adequate exit value. Same thing with the
label 'out' in do_ioctl_blkpg(), and in that function we
can get rid of the 'ret' variable as well.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 linux-user/syscall.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 49c6151c2d..5db066921e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2941,7 +2941,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
              */
             msg.msg_name = (void *)-1;
         } else if (ret) {
-            goto out2;
+            return ret;
         }
     } else {
         msg.msg_name = NULL;
@@ -2960,15 +2960,13 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
         /* sendrcvmsg returns a different errno for this condition than
          * readv/writev, so we must catch it here before lock_iovec() does.
          */
-        ret = -TARGET_EMSGSIZE;
-        goto out2;
+        return -TARGET_EMSGSIZE;
     }
 
     vec = lock_iovec(send ? VERIFY_READ : VERIFY_WRITE,
                      target_vec, count, send);
     if (vec == NULL) {
-        ret = -host_to_target_errno(errno);
-        goto out2;
+        return -host_to_target_errno(errno);
     }
     msg.msg_iovlen = count;
     msg.msg_iov = vec;
@@ -3020,7 +3018,6 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
 
 out:
     unlock_iovec(vec, target_vec, count, !send);
-out2:
     return ret;
 }
 
@@ -4952,7 +4949,6 @@ static abi_long do_ioctl_blkpg(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     int target_size;
     const argtype *arg_type = ie->arg_type;
     const argtype part_arg_type[] = { MK_STRUCT(STRUCT_blkpg_partition) };
-    abi_long ret;
 
     struct blkpg_ioctl_arg *host_blkpg = (void*)buf_temp;
     struct blkpg_partition host_part;
@@ -4962,8 +4958,7 @@ static abi_long do_ioctl_blkpg(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     target_size = thunk_type_size(arg_type, 0);
     argptr = lock_user(VERIFY_READ, arg, target_size, 1);
     if (!argptr) {
-        ret = -TARGET_EFAULT;
-        goto out;
+        return -TARGET_EFAULT;
     }
     thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
     unlock_user(argptr, arg, 0);
@@ -4975,8 +4970,7 @@ static abi_long do_ioctl_blkpg(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
         break;
     default:
         /* Unknown opcode */
-        ret = -TARGET_EINVAL;
-        goto out;
+        return -TARGET_EINVAL;
     }
 
     /* Read and convert blkpg->data */
@@ -4984,18 +4978,14 @@ static abi_long do_ioctl_blkpg(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     target_size = thunk_type_size(part_arg_type, 0);
     argptr = lock_user(VERIFY_READ, arg, target_size, 1);
     if (!argptr) {
-        ret = -TARGET_EFAULT;
-        goto out;
+        return -TARGET_EFAULT;
     }
     thunk_convert(&host_part, argptr, part_arg_type, THUNK_HOST);
     unlock_user(argptr, arg, 0);
 
     /* Swizzle the data pointer to our local copy and call! */
     host_blkpg->data = &host_part;
-    ret = get_errno(safe_ioctl(fd, ie->host_cmd, host_blkpg));
-
-out:
-    return ret;
+    return get_errno(safe_ioctl(fd, ie->host_cmd, host_blkpg));
 }
 
 static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
-- 
2.24.1


