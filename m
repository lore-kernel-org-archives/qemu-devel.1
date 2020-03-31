Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8723B2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2bf+eVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJH9I-00033V-NK
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jJH5T-000069-Cw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jJH5R-0004pI-KS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:37:51 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jJH5R-0004oR-2E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:37:49 -0400
Received: by mail-lf1-x141.google.com with SMTP id v4so17286650lfo.12
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aU5iLCuWaH4zxyOLw8e9l2ANSFZT9vUFLRpaEbsCIeI=;
 b=M2bf+eVpkauwEFyb4CxmjaPvpl1N7Yad7zfCQI7ftWmBLkeJPC0XXouWV2QI8hxZp0
 SWvodVcZIL6Bb/b/rJIkQwkInHpjgZ5o+LFL4a9Pq3M4CqV+zv5VdnUEa/Y9J4upA+Im
 9Jw34jRSN6kWPZ+k5VsdGo8jY+lJaogNfFrBKMbUo/M+wp9QThZUUdUXu+DGnXp8u5k2
 KPhTqiN5HAQpCWvh1il9cj1mhxWhSyWq/d4wVo+nmE3Zy9I/KddzW5kBlWk/4bQIKCOR
 Av5ZU2ntiH08RXx7Vy7fMOQlQY1fz06o4VosndadGp4GHJG5h/oOYOtMMvQhx/Kp3hXh
 clpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aU5iLCuWaH4zxyOLw8e9l2ANSFZT9vUFLRpaEbsCIeI=;
 b=jIJFAM8AlLDjxIJeDkM9R7cHknAC8hnwf06rDKTi2JOqlq9jmHPDVpBxXVDSqhvMx6
 2TlXcMEr6oiAsLOPtlwhaWWpA5vNS1hwPASSYH/IVu/HkDCoOs1haZ3NRFlI5dVRWTsC
 gWXncBLW/0vfF2ixyjCttx0tP1q3luX0hiwkOKbN2kmtJJMa5T76IlGK66ALC3C3lN+M
 /lUAGFbWWFPCP7bHnQGDH3BNi/e47O13aJj1YY4fc2V31NYVLNhkxiLJltOri7MnkClr
 bfg2DoYwogM86g6I7N/ygzwU0djmIckGe/MwKpAM+qsfg8iAtQd3TwzVQ7iLYsAejJpr
 NJLA==
X-Gm-Message-State: AGi0Pub2yAVbCS45HS+kEF20Dd+QGOX7v/cAoIGMQWixpuJr3zqYI1qP
 ng20h9p7J3n2Lj4yIvMlMfLG/g==
X-Google-Smtp-Source: APiQypKT2+uqdUkMNinUZ7US4h3EuWA+Qnq8u+r/x9eYKAF8W37lj90IU1/6iLzyAQ3J8dNMc7hMJw==
X-Received: by 2002:a19:ad43:: with SMTP id s3mr11555874lfd.63.1585661866597; 
 Tue, 31 Mar 2020 06:37:46 -0700 (PDT)
Received: from localhost.localdomain
 (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
 by smtp.gmail.com with ESMTPSA id x128sm9837994lff.67.2020.03.31.06.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 06:37:45 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH] fcntl: Add 32bit filesystem mode
Date: Tue, 31 Mar 2020 15:35:36 +0200
Message-Id: <20200331133536.3328-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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

This adds a fcntl() operation to set the underlying filesystem
into 32bit mode even if the file hanle was opened using 64bit
mode without the compat syscalls.

Programs that need the 32 bit file system behavior need to
issue a fcntl() system call such as in this example:

  #define F_SET_FILE_32BIT_FS (1024 + 15)

  int main(int argc, char** argv) {
    DIR* dir;
    int err;
    int fd;

    dir = opendir("/boot");
    fd = dirfd(dir);
    err = fcntl(fd, F_SET_FILE_32BIT_FS);
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
 fs/fcntl.c                       | 4 ++++
 include/uapi/linux/fcntl.h       | 9 +++++++++
 tools/include/uapi/linux/fcntl.h | 9 +++++++++
 tools/perf/trace/beauty/fcntl.c  | 3 ++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..d194b1265bd4 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -426,6 +426,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_SET_FILE_32BIT_FS:
+		filp->f_mode |= FMODE_32BITHASH;
+		err = 0;
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index ca88b7bce553..b9ad934147e8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -73,6 +73,15 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define F_SET_FILE_32BIT_FS	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Types of directory notifications that may be requested.
  */
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index ca88b7bce553..b9ad934147e8 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -73,6 +73,15 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define F_SET_FILE_32BIT_FS	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Types of directory notifications that may be requested.
  */
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 56ef83b3d130..da80264678cb 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -94,7 +94,8 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 	    cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
 	    cmd == F_GETOWN_EX || cmd == F_SETOWN_EX ||
 	    cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
-	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
+	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT ||
+	    cmd == F_SET_FILE_32BIT_FS)
 		return syscall_arg__scnprintf_hex(bf, size, arg);
 
 	return syscall_arg__scnprintf_long(bf, size, arg);
-- 
2.25.1


