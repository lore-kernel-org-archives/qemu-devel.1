Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F14C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75B32072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hswH03OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75B32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZO5-0006mK-0J
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jeZLX-000356-9M
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:27 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jeZLW-0000nj-08
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:26 -0400
Received: by mail-lj1-x242.google.com with SMTP id o9so1341899ljj.6
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dl25yjAmJuE5AxkRwc5qz4dWHRUh+gkJVzHXFvs+rfg=;
 b=hswH03OEBTEgok3PtkSVa8NSZO20xTjVRoaF6RX18g3v51a3hFRNQq1utdUpGr9Z+q
 X0d8OiqCQkSgY7tBpDOoibOwLHpXeCKtZIfzhxr6OXnsSFPaccLBqztx6eRQDL6nQA96
 R7Gh7KWcHd0rcO+5eyuklKCsu2JYny3gaHcv7QnG5kdWnIe1mi12m0EC/ShEZa9D/27y
 Wt8TPxDCkKvjnK61EJeBc1ygn05qOqGBeSquohq7VPUR0fRff9mPKPVyr5aK7UVkIGkj
 xH5lh580rUwSSMLJCkZZM8WZLHeb5HXjjF5A/8ck/w7RyZP/fxxukcleq03s9CqprG8h
 JUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dl25yjAmJuE5AxkRwc5qz4dWHRUh+gkJVzHXFvs+rfg=;
 b=mIif90hi+PF200shcW5mpte2USZO2U7HYqXRcqyzqU5zH7nVVzlZgvlqH6QvAvMrO3
 UYZvQAjOw0VqpCPvhUr/bXXp/w+sJ/eKwih5UUuyRD232PLgvzbGXwygzkoFBvQ0DoGr
 kdKIdCYQnp2H0ZIT0wSc2ZF10z5w3ii/xzLqvmhErDZJj56WYQ6YzJp1Y+SOSGrS7xxu
 PaPEr9PC2zrPOkdGAFm4XOm6GMeobDwK7FyZa7CMfFAzG2gLx9BbhYHhqjC7M3rWIJ0D
 +0/arFKGN1UQoR3aCdsQIX7n4Hxd2GJU0CdxWjZeGbQUT57tzPibCFItVNmjmtLCTLxa
 8rqg==
X-Gm-Message-State: AOAM530+V1sK0aFBZ0ULhNj6IA/wcJdpWq1fWjM+DVhUxuP/j7W9HLyW
 DbQlVnnYQZ7JU42Hsa0YxN88EA==
X-Google-Smtp-Source: ABdhPJw41qmTFNR1CsfUZRyTyoeD0cdsQ+X861XvpuY9BXFNpuN+0C0bxdkiKXtLjIsMiCEHv54kPQ==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3122624lji.315.1590736943242; 
 Fri, 29 May 2020 00:22:23 -0700 (PDT)
Received: from localhost.localdomain ([92.34.219.140])
 by smtp.gmail.com with ESMTPSA id k27sm2068399lfe.88.2020.05.29.00.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 00:22:22 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH v2] fcntl: Add 32bit filesystem mode
Date: Fri, 29 May 2020 09:20:17 +0200
Message-Id: <20200529072017.2906-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=linus.walleij@linaro.org; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
ChangeLog v1->v2:
- Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
  instead of a new fcntl operation, there is already a fcntl
  operation to set random flags.
- Sorry for taking forever to respin this patch :(
---
 fs/fcntl.c                       | 5 +++++
 include/uapi/asm-generic/fcntl.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..10a6b712d3a7 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -335,10 +335,15 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
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
2.25.4


