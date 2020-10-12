Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C56C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 22:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E152074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 22:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJLs0p8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E152074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS60f-0000Sk-93
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 18:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1kS5zk-0008Qb-5I
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 18:08:40 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1kS5zi-0005ps-4N
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 18:08:39 -0400
Received: by mail-lf1-x142.google.com with SMTP id 184so19883567lfd.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Er9outiRWHyk/leMtSr3CNlG0IeLWwXg/xMOKQHeA64=;
 b=TJLs0p8ef4M8/2cD6lB9hj/ouQXXIQ/K0meIiWe4zNhqW2s0ngXyIXQSYlacBFeFlj
 kAIAmHPxQb1/ujaGBZFb+dfwSePuqxvopJiXkpGgjipwT732nRx+BxQq5xTHYgdGIOAs
 isyVPJDcayUq1+Kq2+ze6a/bcqxsM1zaKE47QWncvbSgkZIu/P+xBkVlu92rPPdxxhCJ
 uf6IILkn1+fZNd5nT3ek4QfnUSzfvR1vnFUHYKQRBnDdsyUfUshec2t1/Eul5nz6vq2e
 iiMoUngpjYSAUATlZWlh89jleNr2DKD+euTyWeVfSZAdLsydM7LuN5j4+86z26nK9/j5
 rqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Er9outiRWHyk/leMtSr3CNlG0IeLWwXg/xMOKQHeA64=;
 b=ULyVNhtH7B2jg3gcRVwyt+i5R/giePvF4sMZQm9V2PxYdIS3Td46RGxdhB+Bx9vqXz
 jZnW5cBRNq3DmzsP08wt5ot2g45rAZ7+bxukUNKCGBSWdNKnXz1C4fCSm35mTSp1Bsot
 sGnsav4EP2Un0WZJrZcfytqVMRJgmUy8K3oXE/q1qpR6aMG6nclTYktN3w96DanSES8y
 Ftxib/MiuFyWCnAQUkUllVogi0exuZRH7CjfwrDLf1y1yrnu66DSxaNwU3HT+3uFi4SX
 KOW78bitAjQkPLNh/EolHlRXUcDTNB/P0I6H4u2uGQSBz0bYnN8TLvC8JbYkhaSufZBC
 Hgsw==
X-Gm-Message-State: AOAM532MmNrxmZn+i5NER6q+RsGJomuj+UwZzYGgntiTm13x7OVQC11R
 7PfWOJ919Dxj4UcN/cBbb1rzfg==
X-Google-Smtp-Source: ABdhPJxmiM6IlJtuyaoQ8VZOOBemBYKqhzqgDG6ZrEeg+bRyV1gNNd+WNqR3yadfn3+/FcWbnCxyLA==
X-Received: by 2002:a19:824f:: with SMTP id e76mr6874758lfd.572.1602540515605; 
 Mon, 12 Oct 2020 15:08:35 -0700 (PDT)
Received: from localhost.localdomain
 (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
 by smtp.gmail.com with ESMTPSA id a201sm3039261lfd.213.2020.10.12.15.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 15:08:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
Date: Tue, 13 Oct 2020 00:06:20 +0200
Message-Id: <20201012220620.124408-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=linus.walleij@linaro.org; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, linux-api@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org,
 Florian Weimer <fw@deneb.enyo.de>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was brought to my attention that this bug from 2018 was
still unresolved: 32 bit emulators like QEMU were given
64 bit hashes when running 32 bit emulation on 64 bit systems.

This adds a flag to the fcntl() F_GETFD and F_SETFD operations
to set the underlying filesystem into 32bit mode even if the
file handle was opened using 64bit mode without the compat
syscalls.

Programs that need the 32 bit file system behavior need to
issue a fcntl() system call such as in this example:

  #define FD_32BIT_MODE 2

  int main(int argc, char** argv) {
    DIR* dir;
    int err;
    int fd;

    dir = opendir("/boot");
    fd = dirfd(dir);
    err = fcntl(fd, F_SETFD, FD_32BIT_MODE);
    if (err) {
      printf("fcntl() failed! err=%d\n", err);
      return 1;
    }
    printf("dir=%p\n", dir);
    printf("readdir(dir)=%p\n", readdir(dir));
    printf("errno=%d: %s\n", errno, strerror(errno));
    return 0;
  }

This can be pretty hard to test since C libraries and linux
userspace security extensions aggressively filter the parameters
that are passed down and allowed to commit into actual system
calls.

Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://bugs.launchpad.net/qemu/+bug/1805913
Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v3 RESEND 1:
- Resending during the v5.10 merge window to get attention.
ChangeLog v2->v3:
- Realized that I also have to clear the flag correspondingly
  if someone ask for !FD_32BIT_MODE after setting it the
  first time.
ChangeLog v1->v2:
- Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
  instead of a new fcntl operation, there is already a fcntl
  operation to set random flags.
- Sorry for taking forever to respin this patch :(
---
 fs/fcntl.c                       | 7 +++++++
 include/uapi/asm-generic/fcntl.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 19ac5baad50f..6c32edc4099a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
+		/* Report 32bit file system mode */
+		if (filp->f_mode & FMODE_32BITHASH)
+			err |= FD_32BIT_MODE;
 		break;
 	case F_SETFD:
 		err = 0;
 		set_close_on_exec(fd, arg & FD_CLOEXEC);
+		if (arg & FD_32BIT_MODE)
+			filp->f_mode |= FMODE_32BITHASH;
+		else
+			filp->f_mode &= ~FMODE_32BITHASH;
 		break;
 	case F_GETFL:
 		err = filp->f_flags;
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..edd3573cb7ef 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -160,6 +160,14 @@ struct f_owner_ex {
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define FD_32BIT_MODE	2
 
 /* for posix fcntl() and lockf() */
 #ifndef F_RDLCK
-- 
2.26.2


