Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA5B208A7
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fl1x2PKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA5B208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgA73-0008N5-37
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgA6P-0007jx-O7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:49:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgA6O-0005OE-Jz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:49:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id l26so3598564wme.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qu7tvER0IKqrMliw7MGPzBrrSEYyVxBvPs7B5vkCjKg=;
 b=fl1x2PKz2dTddLBPBFB5XbLaJGvQ9SmsOZzb5qgeFiEEXdakwPbTMB8a29GYTl74WY
 1ubZI+rYf8lLmToekeGLra0JYd7JPoh/FwJKE3yd1vFJpEm9KopWatpKKkKKA8ncZt/k
 sWXQ2lCoIl8UXl7sC0oP0ub27z60AckFkg+TDm+7bXENrwDCV/vti18oIjg6h05MKoSi
 t+d6aNCPR6D6WIiynC6gRpDMd3inHB1LQOrwqL5B+Cre6Bekgw7ABOzwI45YB49jLqFp
 xw7QBCxeykfgueLYPiQQJwLFXhvt3Qj0ur1RkAqUnfXa2tFTCSsZG+nM7Rb6pv4K3k3L
 k4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qu7tvER0IKqrMliw7MGPzBrrSEYyVxBvPs7B5vkCjKg=;
 b=pbQ6GgZbl4ARb4WK3bcpJPXrCgZiAL13H0825ysIv8ggNLDhYhEskvNA7esbsAYmlX
 NRfBdePQx87Uqw9s3cGfoY5cqjp3+tqoI//b/rQePzvLBjt3Og9cyJ2J2+1uzrqp9NgS
 y8ukK6BITaI36OdH3ZxSxhpIdhQZcC3jEqQysw6lBXN7yg5bm//LfZVePHsmDesEH+y5
 B9xeiNfwWOm5Yw7GBsYjwiZiAWwME6u2ooWQqr4rYIEp5e5dCsFDD9TFe4B2/zc9yF50
 kHcb3dbRo3s7BsOOraHSmfqfQhMK1LLQPV+nKUhdz3K4zDEXnd8E4iJMuNTEKHsnnx9q
 IS7g==
X-Gm-Message-State: AOAM530+aTxRYl89iIAUN26kt1AROVnA++MnwIWYTrzMduzwWmu6aTYx
 p7RwnXc8X2zM8wsNO6CLIa/Wkg==
X-Google-Smtp-Source: ABdhPJzeWmpDNqKCOr1mVCJYIZgqaUvnmTYmT0ou3sLQVzLVJU+YO8cE0Kvl1JTBlJ0mx0F8+YsZDg==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr5061846wmh.111.1591116562723; 
 Tue, 02 Jun 2020 09:49:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm346902wmi.35.2020.06.02.09.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 09:49:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B9F521FF7E;
 Tue,  2 Jun 2020 17:49:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] exec: flush the whole TLB if a watchpoint crosses a page
 boundary
Date: Tue,  2 Jun 2020 17:49:11 +0100
Message-Id: <20200602164911.5706-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no particular reason why you can't have a watchpoint in TCG
that covers a large chunk of the address space. We could be clever
about it but these cases are pretty rare and we can assume the user
will expect a little performance degradation.

NB: In my testing gdb will silently squash a watchpoint like:

  watch (char[0x7fffffffff]) *0x0

to a 4 byte watchpoint. Practically it will limit the maximum size
based on max-value-size. However given enough of a tweak the sky is
the limit.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 exec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 5162f0d12f9..851ac180fe7 100644
--- a/exec.c
+++ b/exec.c
@@ -1056,7 +1056,11 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
         QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
     }
 
-    tlb_flush_page(cpu, addr);
+    if (((addr + len) & TARGET_PAGE_MASK) != (addr & TARGET_PAGE_MASK)) {
+        tlb_flush(cpu);
+    } else {
+        tlb_flush_page(cpu, addr);
+    }
 
     if (watchpoint)
         *watchpoint = wp;
-- 
2.20.1


