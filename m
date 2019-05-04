Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC3CC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE390206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsekO3nG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE390206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtV7-0002iH-VZ
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:10:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQN-0007Ki-EH
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0001IO-Gc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQL-0001EA-AU; Sat, 04 May 2019 08:05:49 -0400
Received: by mail-oi1-x244.google.com with SMTP id t184so6328714oie.11;
	Sat, 04 May 2019 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/mCFCVnZxjs86hd/2IkgmcY0FzqDfdRP5Dh6XiOK0Bo=;
	b=RsekO3nG+gnOS+8ZCJ6wGbx02ghB74NNj4NL+ZMwJY5XIxvc7h2RegOpSfeFUKTcE4
	bxaP3bv8qBAIOuy+f3EHxp3Z4A1fIwxLU7eeSO2/NjxyYVMssCgE0doPNnn8ItqOEgqG
	CU0B9LkQ4FlbxLDn67KtU64uoWFVSEsGTScBcemgEsn4l3z76NHCgV/T4BUvFX3muuiN
	+ru9m5Pnf7j+6d7r/LQWfG1+cdULQMSMFODN54TF5Tt0zN5PSEELgR8FM0Z3s368AXCk
	Z/cqfHAOiAqhXYcuMiIOY7y4dDG0HHfKZjMsbnzMcuzHV5PkqaPolYyEuAiQeCrx9l+h
	qZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=/mCFCVnZxjs86hd/2IkgmcY0FzqDfdRP5Dh6XiOK0Bo=;
	b=aofCtycGJla4PEQl8TNXbKbtUbRC374YXnqxZLJSSqBz9vJWYQlIvpR3jSjAQb+Nkf
	kc1+j3DVpYvEKJvAiNhNCSDBcYBlJs/IQ/aU6Mrat+fI2cc5RGaaScbMSkJmT0pr0pjX
	tUMoYti/ngQqOFTvpQJEElzWEiJfvnMLjM3gvGOw0e8CexCIfRiALLpeqjFiUv79VjS4
	lQQHBg1OXLlJGO5OX/SZCRf9Ws3cMq0Dnq3z2ocVJCUYOj99ZtP1THiHawLM+Uwsfl9Y
	toGhsPiZQVfR6k1WzJxScIIpMYKOJrxujQ1uM10d8BiO6cteIDB8VDW/9WO26lDXQeo8
	l+Jg==
X-Gm-Message-State: APjAAAVDwhTx6P5MBePXfCGtsbPIY9TC5Xy2AU2IczX/oReRvBn93x3R
	yt24fGmYE9pftQ3IKqEvMagC0Tb6
X-Google-Smtp-Source: APXvYqwmVMK6pSlmdJHC8xzc241FVkbp6YNMBKYF9tUWG0hi3ERxdpWJzgvvB+5nl6UfzfQZOtdqig==
X-Received: by 2002:aca:4f10:: with SMTP id d16mr2311035oib.17.1556971539772; 
	Sat, 04 May 2019 05:05:39 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:27 -0600
Message-Id: <20190504120528.6389-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH 9/9] linux-user: add IBT support to x86
 safe-syscall.S
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504120527.TKOZ7rZ0TUpDP7DXDa4JEa6KhvFhKrJkarbDKLHEsuA@z>

Because safe-syscall.S does not go through the C compiler, the
.note.gnu.property note has to be added manually.  Safe syscalls do not
involve any indirect branch or stack unwinding, so they are trivially
safe for IBT or shadow stacks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/host/i386/safe-syscall.inc.S   | 19 +++++++++++++++++++
 linux-user/host/x86_64/safe-syscall.inc.S | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/linux-user/host/i386/safe-syscall.inc.S b/linux-user/host/i386/safe-syscall.inc.S
index 9e58fc6504..6c6d568d62 100644
--- a/linux-user/host/i386/safe-syscall.inc.S
+++ b/linux-user/host/i386/safe-syscall.inc.S
@@ -98,3 +98,22 @@ safe_syscall_end:
 	.cfi_endproc
 
 	.size	safe_syscall_base, .-safe_syscall_base
+
+	.pushsection ".note.gnu.property", "a"
+	.p2align 2
+	.long 1f - 0f          /* name length.  */
+	.long 4f - 1f          /* data length.  */
+	.long 5                /* NT_GNU_PROPERTY_TYPE_0.  */
+0:
+	.asciz "GNU"           /* vendor name.  */
+	.p2align 2
+1:
+        /* GNU_PROPERTY_X86_FEATURE_1_AND.  */
+	.long 0xc0000002       /* pr_type.  */
+	.long 3f - 2f          /* pr_datasz.  */
+2:
+	.long 0x3              /* IBT, SHSTK */
+3:
+	.p2align 2
+4:
+	.popsection
diff --git a/linux-user/host/x86_64/safe-syscall.inc.S b/linux-user/host/x86_64/safe-syscall.inc.S
index f36992daa3..e1a57db338 100644
--- a/linux-user/host/x86_64/safe-syscall.inc.S
+++ b/linux-user/host/x86_64/safe-syscall.inc.S
@@ -89,3 +89,22 @@ safe_syscall_end:
         .cfi_endproc
 
         .size   safe_syscall_base, .-safe_syscall_base
+
+	.pushsection ".note.gnu.property", "a"
+	.p2align 3
+	.long 1f - 0f          /* name length.  */
+	.long 4f - 1f          /* data length.  */
+	.long 5                /* NT_GNU_PROPERTY_TYPE_0.  */
+0:
+	.asciz "GNU"           /* vendor name.  */
+	.p2align 3
+1:
+        /* GNU_PROPERTY_X86_FEATURE_1_AND.  */
+	.long 0xc0000002       /* pr_type.  */
+	.long 3f - 2f          /* pr_datasz.  */
+2:
+	.long 0x3              /* IBT, SHSTK */
+3:
+	.p2align 3
+4:
+	.popsection
-- 
2.21.0



