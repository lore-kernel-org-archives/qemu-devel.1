Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FEFC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BE820830
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2zgZNrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BE820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ4i-0001w0-Ew
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:32:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0N-0007ae-Go
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007DX-KK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007D7-Cg
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id j10so13142277otq.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hFh8u7VvLXZSxRQAF9IApVSzIxy5BTFFlRPFEY6766Q=;
	b=j2zgZNrJlHa2nIbsiesz4uo4KQAb+QUYqFHwtk1HMIuLs9ILgjpjNbLyqYg/HuYd1v
	QGo97y3K022rU6SIiJVvjrrCFc6RYqcuKSY4nGmyPXtbJCCuoTm7/Q4Ei3ZdYGTTmB5+
	RMvt3Cnb0q/VhxAfhwv/a+uek4k9w+LDZ93O3PPjSRXY+4VWgRGBPQdes2xf9aaPiX49
	OXsaggJ4IIAgy+Tod1x2dYxMDJeMOoDS4UDQrcQ6zNBo4dWrBMSooK5MhByv+dJO04GD
	XfMoW5eb0zpkp7gB5w5VXlviSfrkWidrFCpjQmes9V02K2TvZbkmY/dymZIdNhPu7QCD
	rT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hFh8u7VvLXZSxRQAF9IApVSzIxy5BTFFlRPFEY6766Q=;
	b=R2c92jz66Sawl4CwxYWtaqgldBNJZDyk4ZgUlX6i9J6cjmlZFxzGF/8YgJe+WjOK/k
	siLkg2WvpNiwY0y+YL6ZfPOWmsHLUml2NY8TfaBVUOgG5uV0nL1c31SUk/jWgwkgeFKy
	8rBYajzTzVnOrJFrNZjcTg/HJvRC4bUuUeE8RLVn2VFHw26M8oPJ9DdBcMEzjzoUZ8Ch
	NyCcy3yGaHCXbeUfPgY/Cnj8X8yV6GuC2OoDj8O8x8kB9xSYCaDY/GegEkNUGUhVhPIn
	NmPBN6HaVn/XvPNC1BeVLmPmOUKiFAbKE6ip9fv1C5EvNzo4gFXa8lBnCtEud46Za4YT
	Brmw==
X-Gm-Message-State: APjAAAXnT+sYjDmvSDP3EwaKsx7IVi7Y6bHz3aN6jclVJNeMSTL+9FX8
	UaqgaIq/+WLqDfxwuJ1Mcr7uyu6H2pQ=
X-Google-Smtp-Source: APXvYqxlEaT5PmbwoBjtrcCuTPk4xqy081eOeU8wcNuuXas+J+s8zuKEpRvc4a6jVrA9RtiagZbOlg==
X-Received: by 2002:a05:6830:2144:: with SMTP id
	r4mr20673494otd.250.1554748105538; 
	Mon, 08 Apr 2019 11:28:25 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	r133sm9940295oib.21.2019.04.08.11.28.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:28:25 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:27:47 -0400
Message-Id: <20190408182748.1238-5-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RISU PATCH 4/5] risu_i386: implement missing
 CPU-specific functions
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Jan Bobek <jan.bobek@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408182747.1J5TdP8Wqz5cnsFCe_GgtrYH1Jb-aFlGpKsBIXWx7Sw@z>

risu_i386.c is expected to implement the following functions:

- advance_pc
- get_reginfo_paramreg, set_ucontext_paramreg
- get_risuop
- get_pc

This patch adds the necessary code. (We use EAX as the parameter
register.)

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 31 ++++++++++++++++++++++++++++++-
 risu_reginfo_i386.h |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/risu_i386.c b/risu_i386.c
index 2d2f325..eb4dff4 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -25,14 +25,43 @@ static int insn_is_ud2(uint32_t insn)
 
 void advance_pc(void *vuc)
 {
+    ucontext_t *uc = (ucontext_t *) vuc;
+
     /* We assume that this is either UD1 or UD2.
      * This would need tweaking if we want to test
      * expected undefs on x86.
      */
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.gregs[REG_EIP] += 2;
 }
 
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = (ucontext_t *) vuc;
+    uc->uc_mcontext.gregs[REG_EAX] = (uint32_t) value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[REG_EAX];
+}
+
+int get_risuop(struct reginfo *ri)
+{
+    switch (ri->faulting_insn & 0xffff) {
+    case 0xb90f:                /* UD1 */
+        return OP_COMPARE;
+    case 0x0b0f:                /* UD2 */
+        return OP_TESTEND;
+    default:                    /* unexpected */
+        return -1;
+    }
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+    return ri->gregs[REG_EIP];
+}
+
 int send_register_info(int sock, void *uc)
 {
     struct reginfo ri;
diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
index 5bba439..4ad90e1 100644
--- a/risu_reginfo_i386.h
+++ b/risu_reginfo_i386.h
@@ -28,6 +28,7 @@ struct reginfo {
 #   define REG_ES      2
 #   define REG_DS      3
 #   define REG_ESP     7
+#   define REG_EAX    11
 #   define REG_TRAPNO 12
 #   define REG_EIP    14
 #   define REG_EFL    16
-- 
2.20.1


