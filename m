Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA09C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C639E2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BY1M4BJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C639E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwDd-000442-MY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:29:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBo-0002w1-KS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBn-0001Nk-NW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBn-0001LU-Hh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id z16so2260583pgv.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=iKTmI9ncTuLaMcNrrSxuBO2p/7mhBstesEY49w5c0ms=;
	b=BY1M4BJpSx0iy7djdB7+Acxrx3ZaPDMy3YUEN/1ASHo7ISGkt8qU/DE73/kO33M/9v
	v8Y9dRwURwxElKs9/vwBHXTGhQTQLt+6XCke3p79RNWGTzHl6mNyiJyiGBCMYu7Xs7LX
	jJu726/gMlSOQXPO8UiJaUdoQaxTYivZX8o70ce2rfYmBo/lO6gZuoAvu6hkaFk+vg1r
	ulC9AePS5Lcfx/ejXbK1R5Oz1Hy0SWiJ6jRAE5PFUkxOf1qoEsnuA0Lj4Gl51gBq82vs
	gWxf6F5wz7qaTpFaToC0/lK3eXb1uWci8ttHbQya2wUdaLfQWqrYPSG55UKkrfiubkgu
	653g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=iKTmI9ncTuLaMcNrrSxuBO2p/7mhBstesEY49w5c0ms=;
	b=epXI8EwVvUuaWxOObffKhd7QKSSNyYjUsWlwMDmVkk5RuxCgfPNHym+VUdMRQ6AZsO
	RBsmOqF69K7LHDGnsfwSst39LPQZ7k0DwBXdGWOFjexAyE+Kru/771xjxZ/2FvrhNSE9
	pdlzBco8vpz0qfyODYRrnQiNBUK184V4u8EXB/lu+meP/nnD0LEVilRKEwkdZYekm7Sd
	R5eDbZiKUo1YGzJ1B90QDrecWdsSi5mM09JLStsTV9F1atXaNrlVHzgldK22nAd2sbSi
	2BN7oqX2NPD9Zc9AKMLbmqkhEISlFsbwDljJfOXU/0gjYRXAOb3/myDF6OQM1ZWI1D7H
	i14Q==
X-Gm-Message-State: APjAAAWISXjeBeRSk7pxKSILLuJRKmWaP5wH/rfxy11Rws/H0kaf7OMo
	NmKMDIXo7K0tD8My17zqKQVBxDiYHfQ=
X-Google-Smtp-Source: APXvYqzyBCkGDvWecHTnBPFnrruLCwdYP2plQ4iBuHluOsLMvvn8eJVSgmnDfBLULNGL/SiM/I3pZQ==
X-Received: by 2002:a63:445d:: with SMTP id t29mr10619943pgk.303.1557458834238;
	Thu, 09 May 2019 20:27:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:03 -0700
Message-Id: <20190510032710.23910-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 1/8] linux-user: Disallow setting newsp for
 fork
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

Or really, just clone devolving into fork.  This should not ever happen
in practice.  We do want to reserve calling cpu_clone_regs for the case
in which we are actually performing a clone.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf86d..f7d0754c8d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5553,10 +5553,14 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         pthread_mutex_destroy(&info.mutex);
         pthread_mutex_unlock(&clone_lock);
     } else {
-        /* if no CLONE_VM, we consider it is a fork */
+        /* If no CLONE_VM, we consider it is a fork.  */
         if (flags & CLONE_INVALID_FORK_FLAGS) {
             return -TARGET_EINVAL;
         }
+        /* As a fork, setting a new sp does not make sense.  */
+        if (newsp) {
+            return -TARGET_EINVAL;
+        }
 
         /* We can't support custom termination signals */
         if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
@@ -5571,7 +5575,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ret = fork();
         if (ret == 0) {
             /* Child Process.  */
-            cpu_clone_regs(env, newsp);
             fork_end(1);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
-- 
2.17.1


