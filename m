Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45227C28CC3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 19:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D9526077
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQuqFSp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D9526077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWQQu-0007Wb-4B
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 15:09:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hWQP2-0006NT-Gh
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hWQP1-00077O-Mu
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:07:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hWQP1-00076c-H6
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:07:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id h1so4906953wro.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=1+7WmdBrHGx6Ha+xOFMNUexdsePyk4/I42eILCOPpxA=;
	b=qQuqFSp6KWGHIdmdRNp9ox93m7Ya67HGS4c8/PuJNCGkTkZTHHBDyi62aRI4vZxHCg
	MmvYqo337hUhse7279KSq3MSUTxjhlcMOnQlC0yJDwxUsd+P/xyxxSuL/X4OTGtwCROA
	VjIjEFaSNPeQOg22/xTA+PcdvJINUlb2nhYyyOfc1XaKT2ZcoabCwSZxpEp0UhguSxZP
	jlvRZPh5S8nEE/MrLQ1gHIiSArJEuy6omamWV9iZU/h4X9PKtPx0Mwbw3weTr/iEFRTj
	YFFx5gwaY3F+OvObGlFKOR7VieoSYafqrkcBW8a5v8rk3MCmyELuLI6mfRrXE2aS3bFB
	KLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=1+7WmdBrHGx6Ha+xOFMNUexdsePyk4/I42eILCOPpxA=;
	b=nZIUTkhiuWCEZ6ckuZGxNgrFMABSHSeRkm4JUgoiI7w6F7x0FM/Romy4PSYs7iGnxy
	do4PBP8/J1lbeC/AjY4/I2ZFUdCfA0280x+N8IAjJNAtWlgO/N/E+jPakxej911bNiaf
	n+TfJUPHprxzz7XrMJn86Lu18l+zVoawPEheA8SsxQ+DVVdwoUIHZdYuH80cFA5VCUvY
	ndoJaHEgneG3xt6Tzia9WuXcLWhZHNz2++Ub/Ly2oL7qqG8EflHppk+RYxM7NCFEHrkn
	WKwKEWH0ZMXGILS0Nx012+70p4Q6k0vwge7d1MHeKQaWD22p1PibTedUndkZrXHZsEm7
	xSkg==
X-Gm-Message-State: APjAAAVjk4K6ibiHwMwHrNyJRViNWG5W35t4EohVOv9mk5cWylK5xWAo
	hHSruMWIifA/3WGZRomg1XBFKvzktAQ=
X-Google-Smtp-Source: APXvYqzS+sHm7HG474ygEuREFQiAkVrGaeUrJaMHOCJVUqEyLlBM4SkmrHdM57qZlPWAoo8yHZqpqg==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr3762317wrn.258.1559243270127; 
	Thu, 30 May 2019 12:07:50 -0700 (PDT)
Received: from localhost.localdomain (bzq-109-65-68-81.red.bezeqint.net.
	[109.65.68.81])
	by smtp.gmail.com with ESMTPSA id u9sm8711230wme.48.2019.05.30.12.07.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 12:07:49 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 22:07:33 +0300
Message-Id: <20190530190738.22713-4-mrolnik@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190530190738.22713-1-mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to check
 for active debugger connection
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sarah Harris <S.E.Harris@kent.ac.uk>

AVR CPUs have a BREAK instruction which behaves differently depending on whether debugging is enabled.
Since the hardware fuses that normally control this are difficult to emulate, and the BREAK instruction is useful for testing, the BREAK instruction is instead enabled/disabled depending on whether a GDB session is attached.

Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 gdbstub.c              | 5 +++++
 include/exec/gdbstub.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 462f89edfe..94ee45798b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1793,6 +1793,11 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     return RS_IDLE;
 }
 
+bool gdb_is_active(void)
+{
+    return gdbserver_state != NULL;
+}
+
 void gdb_set_stop_cpu(CPUState *cpu)
 {
     GDBProcess *p = gdb_get_cpu_process(gdbserver_state, cpu);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 08363969c1..d059bf5339 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -45,6 +45,10 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...);
  */
 void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va);
 int use_gdb_syscalls(void);
+/**
+ * gdb_is_active: return true if debugging in progress
+ */
+bool gdb_is_active(void);
 void gdb_set_stop_cpu(CPUState *cpu);
 void gdb_exit(CPUArchState *, int);
 #ifdef CONFIG_USER_ONLY
-- 
2.18.0


