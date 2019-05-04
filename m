Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA54C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40B6206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Snk0mZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40B6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtUg-0002EJ-Qx
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:10:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ8-000790-Kn
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ6-0001CE-V4
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:36 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:33741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQ6-0001Ba-HU; Sat, 04 May 2019 08:05:34 -0400
Received: by mail-ot1-x334.google.com with SMTP id s11so7661612otp.0;
	Sat, 04 May 2019 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=SKe5W6gEyQ6vDMvZhmfmuPkjdQXC7onAVuM4AddCdiY=;
	b=m7Snk0mZEgvRNhSoMKv9Mv+4ZfKDiMWO+G/SIiPUmIA6LUoE+uxAvMuz9Y5YxPNBhR
	AJkwNPhs5VEMNc4coPjRNM0om1beXAyiuIA0n3ZIPNWwPO4HiS7nK/2IBdXf3VxpQhtX
	hp08nNyjGaHRxWrWybOZteoVTBdBbrnwJx2ZIMKAy+yvn15HNHbHvPtuUj6na1r/6His
	qyyXUz45KKFXwope4iWZjRQhCb4F6tLsTJn3rF29S7NALHkQQsiCRmE6lc5QUF1wBYA9
	YM7MGrbyAmvhI2URK0xmhJ/52Hm0zObC9X1kwlt6Y9MJstxeaFirknFDd7dH+lgZqqsO
	VPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=SKe5W6gEyQ6vDMvZhmfmuPkjdQXC7onAVuM4AddCdiY=;
	b=f1WX89Or5aTHDtu//0HLc26n+NF3TtJGefwu9DH75IjT5OD88JDkbfMR5F5sPsR3lP
	ARln4BnNFM8loB45BoAJPYVpTjSDFLsSe63dX2G+4OoTH9255rY0s8P471lQ1ai6JNIK
	lEAnu8krtlkTO7i7E70u/n9H5YuqbuSnEspld9fVFBwMXEhtWoOy1O2FQhw9Z4+39oiT
	SJTvrhgRXGO+n1TeyDvtT7WyvJ33ridrrANzgZ5ntFtateo3/jaVbnA27y3xRJu0V5oe
	YuoFwOTu6+6QIzrI9dllmTrsSpTTDR9hdruYQN86b3/kc8kpXK/OK7eu+w5kQ+xJUkEW
	RltA==
X-Gm-Message-State: APjAAAWnbV6GMD4XQNVTIxWNsmp5+Oi/cRIUK/3Cbjoe/b6sLl2YbbwA
	SpPbhFmLpBGLbr/0arIpHhy8pONv
X-Google-Smtp-Source: APXvYqx/9giXRu2PfOMGUFS/d2TCMtOy96P2IRLQRXywWtPBLOF8IJWEuwbzhO/JIhsPJcA1KeFB2A==
X-Received: by 2002:a9d:27c8:: with SMTP id c66mr4601174otb.85.1556971532677; 
	Sat, 04 May 2019 05:05:32 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:20 -0600
Message-Id: <20190504120528.6389-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: [Qemu-devel] [PATCH 2/9] qemugdb: allow adding support for other
 architectures
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
Message-ID: <20190504120520.UJ9jboFaG5OaqUDE1puyjDn-2eERooD1YDI6OwoF7nA@z>

$sp and $pc are standard register names that are available
on most machines, use them instead of $rsp and $rip so that
other architectures can use qemu_coroutine_sp and
qemu_coroutine_pc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemugdb/coroutine.py          | 4 ++--
 scripts/qemugdb/coroutine_ucontext.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index db2753d949..076f6808ab 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -62,11 +62,11 @@ class CoroutineSPFunction(gdb.Function):
         gdb.Function.__init__(self, 'qemu_coroutine_sp')
 
     def invoke(self, addr):
-        return coroutine_backend().get_coroutine_regs(addr)['rsp'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['sp'].cast(VOID_PTR)
 
 class CoroutinePCFunction(gdb.Function):
     def __init__(self):
         gdb.Function.__init__(self, 'qemu_coroutine_pc')
 
     def invoke(self, addr):
-        return coroutine_backend().get_coroutine_regs(addr)['rip'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['pc'].cast(VOID_PTR)
diff --git a/scripts/qemugdb/coroutine_ucontext.py b/scripts/qemugdb/coroutine_ucontext.py
index a2f8c1dbbf..eed095be22 100644
--- a/scripts/qemugdb/coroutine_ucontext.py
+++ b/scripts/qemugdb/coroutine_ucontext.py
@@ -57,12 +57,12 @@ def get_jmpbuf_regs(jmpbuf):
     pointer_guard = get_glibc_pointer_guard()
     return {'rbx': jmpbuf[JB_RBX],
         'rbp': glibc_ptr_demangle(jmpbuf[JB_RBP], pointer_guard),
-        'rsp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
+        'sp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
         'r12': jmpbuf[JB_R12],
         'r13': jmpbuf[JB_R13],
         'r14': jmpbuf[JB_R14],
         'r15': jmpbuf[JB_R15],
-        'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
+        'pc': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
 
 def get_coroutine_regs(addr):
     co = addr.cast(gdb.lookup_type('CoroutineUContext').pointer())
-- 
2.21.0



