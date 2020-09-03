Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C9BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486FA205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj8wxckD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486FA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkjx-0007Ce-F3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfL-00085h-Ic
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:45080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfJ-0001XU-Od
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id k15so1703050pfc.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFEZh3+xvAfqz2f0h/nVnmxCipA8eA9k8U4UHOk894U=;
 b=qj8wxckDNeqol6K7T2TpMCS62R0DQcAOjzFZT4MD9AMY7fmSwKyngvBfI0GLsoPQvp
 oXpfMDVeqxCuL5Mo0Gc/nzMPwdUHBY3+VMNBYW2QtJ+7ADJbWRKRvfr89sTUc5SXIWkT
 2e0oIx2T9x1KgRb39urWYgthTrfz0eTv3JgMxHjXqvr+7JQM8GNaP6Ya4LrGc5fqnN5Q
 UZK7SDR7OihqXmU0wExqPRlzauoj5ue4mFS1lMFp/xPiW7/r3apixCsEXZlDJEP62GU6
 ldsF/VtGcBM/lWXs0p3P4yeIc0YdGMBc2kEPWAFqJbzgGqwD6c42jVu3dta+K7IoMaGk
 Oepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFEZh3+xvAfqz2f0h/nVnmxCipA8eA9k8U4UHOk894U=;
 b=esrTPwLVoQr1IIzTq0VMMUNjanc6AB9UstCywVOt/gj5mv3Or/9qTvWsuD2S4hzeZB
 tZBKyBSTG6Za3LzXNFtvtg0fv9Bo3EZd3hE7BlBrkhX78sqGRoBeGwV/mFvfSRdpVV1C
 5bOmWGmwJjM7z3a9cucv9em2NkYeHmVAu84iaRH5mqXw1uKAvGVA+biyL2Yg0JusWpz8
 R96KCLp59jaivBNd0th1pC50aLlsp2QB6DPs/ppRwMj+yJX0w8VhrqMki9KB9qcH24Zg
 Nx3qCmiY1XOs3JVFaCQH4HJ9Xd8LOSjC4OWhAxPEVbChOEx221H/pyBYrNzx/r7zGJit
 zgBw==
X-Gm-Message-State: AOAM530n5Vf6Ak3J6iarFc6u8P7LxcDXdTJa7vZQlJ4u5webJUb7y2Sj
 QIFQE4awlOMiWHZnTophbUrfHFeuikJighJN
X-Google-Smtp-Source: ABdhPJyw221FvmuBu454lAVNwIpygwtdO5d4sfQmLlxCA7OjhYKcxYTOkX7xaj2EzYEA1QTwIQhA4Q==
X-Received: by 2002:a17:902:7c8b:: with SMTP id
 y11mr395682pll.10.1599121936009; 
 Thu, 03 Sep 2020 01:32:16 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/12] osdep: These function are only available on
 Non-Win32 system.
Date: Thu,  3 Sep 2020 16:31:42 +0800
Message-Id: <20200903083147.707-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
int qemu_unlock_fd(int fd, int64_t start, int64_t len);
int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
bool qemu_has_ofd_lock(void);

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 412962d91a..e80fddd1e8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -502,11 +502,11 @@ int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
-#endif
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+#endif
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
-- 
2.28.0.windows.1


