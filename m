Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE4C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 02:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80842081C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 02:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psw/YEIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80842081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUMLD-0001Mq-PJ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 22:23:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hUMJm-0000UP-H9
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hUMIW-0003aY-7G
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:20:37 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:56126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hUMIW-0003aQ-32
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:20:36 -0400
Received: by mail-it1-x144.google.com with SMTP id g24so11930317iti.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FaLRym9qoHWfpYrSmaKpwioVaNz4Jc0X02F6oDD3AfA=;
	b=psw/YEIUWAcY3Qy/UhpzoNBfHrB3Ni6RHbFalO5pUpIVGHEwwv5D0wj1x2ssIUZLCJ
	wR4LoiOz3FA0S94XDgBEsByICzQUAhFEXhtIM2QZ5EArnpCo/VDZ3oZOUi61BvTp68qz
	cKkmsyPl54BbSMDa+63PLMvJsZ1dhYZUHAwM1GnkoVciVp74Yhs+9zEmYVq40ODhYekc
	MsO4IIyLfc/Z658wlY7O+NtEEhIHjzFd8TV33njUCmBXnc3DYGASYcOQVL7j6D1cjnQm
	lWjWPy/mL0shVGVS647KwR+4SagS3EBltR0sc0HbIu5fVuEi6NdKgGEX6GMb41ujwsyM
	KT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FaLRym9qoHWfpYrSmaKpwioVaNz4Jc0X02F6oDD3AfA=;
	b=Zr46ASW0qIz1EWrEwEsiZeJUbAIB7aGGNpOhuKGtO0jKqZH7+XVWoEc/CybuvYoY7x
	8Ywj9P+d5jsMkWyQf9dk1FR77Bkr5YXpU4pzCAOuEiCadWTRFpJ2wClFlYafXfwZ9u5o
	jrCk31OiLV1W2M1554F9yTAOEJDBMtsVz5fr8fNcLJ4ohipNGLb1ctg+5M8XfTiW951O
	gPm1Fzc3KugIooQniejcsRJ4TKs+1fZMvdk7DtxOpB0S1fEzGhMhB5UJf4Onxw+t65cc
	WgnDsYiYIcTV70AKGE/g5NT3dQChiOcQ/D8e57x1NUqWVCelmzpwhX63Rz5EV415rX52
	qC2w==
X-Gm-Message-State: APjAAAUae/RIS/ELknfNPqK9jutI/7k+vwQujETjYz7ms6AuOTt49sKu
	9bZb3aFVMULtaOfxNNCZEzE=
X-Google-Smtp-Source: APXvYqzGVJH+lgHKnKSaOTInd/lNVS06orm9e4S0R25m05B1TFrYyU6zEgb5P8cb0W7xTzahc6+/qw==
X-Received: by 2002:a24:81d4:: with SMTP id q203mr20127283itd.55.1558750835562;
	Fri, 24 May 2019 19:20:35 -0700 (PDT)
Received: from localhost.localdomain (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	p20sm1575524ioj.63.2019.05.24.19.20.34
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Fri, 24 May 2019 19:20:34 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
To: richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.orgd,
	david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk
Date: Fri, 24 May 2019 22:20:08 -0400
Message-Id: <20190525022008.24788-3-programmingkidx@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20190525022008.24788-1-programmingkidx@gmail.com>
References: <20190525022008.24788-1-programmingkidx@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: [Qemu-devel] [PATCH 2/2] Implement the PowerPC Floating Point
 Status and Control Register Fraction Rounded bit
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
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 target/ppc/fpu_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 0b7308f539..0baf1ce8e4 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -630,6 +630,10 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
         env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
     }
 
+    /* Set or clear the Fraction Rounded bit */
+    env->fpscr = deposit32(env->fpscr, FPSCR_FR, 1,
+                           (status & float_flag_rounded) != 0);
+
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
         (env->error_code & POWERPC_EXCP_FP)) {
         /* Differred floating-point exception after target FPR update */
-- 
2.14.3 (Apple Git-98)


