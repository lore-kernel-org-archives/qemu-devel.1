Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D2C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EFB217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz2DcAiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EFB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jUp-0006AL-Qx
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSi-0004dU-8X
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSh-0004Fr-51
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSf-0004F3-UY
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id n10so3316146wmj.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MTI8Bx3uRmLWHyobHqk9B5nXds/7H3re7AzqawWMgtk=;
 b=Fz2DcAiFgvIltoAjBL2x+X8ivimKCUKHAneMcLXoHGkE6MmY+VUgOV33swNVS+2yZP
 +/0+FA0J2hjMFRds46BYo8sk9C396bUsm0xV55utesyH+DOXLoq+rgX5lgGYBd7ehYsP
 o+NNiN1gR5JkeDGqfplAPlw6nrp5j/NIIthMS9Yd5FvhzH4+lx/w4arx680SatPK0JWe
 UddQjlCsww7KqBOV9rYNxrrfXKE7Jo5ayYBvP3V/hPW8y3FopR9wDK5jg5cg0oviHmlE
 eDRfcNuLEkR6NLIzOPc5opFBIsXkSTcZZrOyeP0f9PhMUzrTzql9VadPN+t3pLqgeTUe
 PJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MTI8Bx3uRmLWHyobHqk9B5nXds/7H3re7AzqawWMgtk=;
 b=phbhnsLhRtoCz8T1C3BKXElZFrYD6Yjya4RhlleJAyAfRrvhEk8tDxxbOTgCxzOz53
 7AzM6wfNRXRrhPejrzai+6u6Z1deS4yJ1DTSjFTOVrzpZbQEeCjfJk3UUkpeBJ5/+qFk
 XWzDdRVXChkCIDTqUqSTVakwrw7XvVNxss0TaNMHerm7R6Rs3HwVjJViXldYrVAPBDoi
 LTucapMhBF/5pFqBpThcLM6llUKB0vz5gHPNwAYOlA6kmJrWjXm4d3HXvUo0wthPMnlJ
 VEb3yivUHpCy8mOsX7xoSV+6lb1tAqgVBHYkLyacsNyb3xCyegQ0sqQkJ2MRdYHLFJDg
 tlBQ==
X-Gm-Message-State: APjAAAWF9j8i107fpaR+waI/GvSlh1u615RFd84BYKgytiH/aTu7ICGd
 /y8en+gmvg6yv6cK8W7TViMKSw==
X-Google-Smtp-Source: APXvYqw4efP33Sbh7LMVYhQdo1NHr6vxGUPpnScDe8LszTMSnH9CdC5dPBbuzYOBS3N+HoL0hYgj8A==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr35668865wmf.104.1567419684782; 
 Mon, 02 Sep 2019 03:21:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f143sm2050011wme.40.2019.09.02.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6532D1FF8F;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:12 +0100
Message-Id: <20190902102122.1128-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 02/12] gdbstub: Fix handler for 'F' packet
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sandra Loosemore <sandra@codesourcery.com>

Handling of the 'F' packet has been broken since commit
4b20fab101b9e2d0fb47454209637a17fc7a13d5, which converted it to use
the new packet parsing infrastructure.  Per the GDB RSP specification

https://sourceware.org/gdb/current/onlinedocs/gdb/The-F-Reply-Packet.html

the second parameter may be omitted, but the rewritten implementation
was failing to recognize this case.  The result was that QEMU was
repeatedly resending the fileio request and ignoring GDB's replies of
successful completion.  This patch restores the behavior of the
previous code in allowing the errno parameter to be omitted and
passing 0 to the callback in that case.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190827223317.8614-1-sandra@codesourcery.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 5c067594bae..4cf8af365e2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1820,11 +1820,15 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    if (gdb_ctx->num_params >= 2 && gdb_ctx->s->current_syscall_cb) {
+    if (gdb_ctx->num_params >= 1 && gdb_ctx->s->current_syscall_cb) {
         target_ulong ret, err;
 
         ret = (target_ulong)gdb_ctx->params[0].val_ull;
-        err = (target_ulong)gdb_ctx->params[1].val_ull;
+        if (gdb_ctx->num_params >= 2) {
+            err = (target_ulong)gdb_ctx->params[1].val_ull;
+        } else {
+            err = 0;
+        }
         gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
         gdb_ctx->s->current_syscall_cb = NULL;
     }
-- 
2.20.1


