Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A1C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A81B20675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjKTKbRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A81B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSKP-0007dA-LW
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:22:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHr-0005Qd-Oa
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHq-0007N3-PE
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHq-0007M0-Im
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:02 -0400
Received: by mail-pf1-x443.google.com with SMTP id g3so6161750pfi.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=T2aejSpup/jdLylt16k4iHZTGZjrzCHoXu3LKyQVTCY=;
	b=KjKTKbRgASqmgttgBFfUtzWbxlKpxm4MQDNPIJ2R22Ov7bs5vnerAN3YmRIwvDAddG
	bqHPJCoJcRe6hph8jCaQ5Km5rvWJjBPblqVikX9jU1XZEpt4YNodn+qTYNG8SG1fEwPJ
	nJ+33oLOrFA5TGEeoU6q9PYAE2jg7BSo/LR6gUEHlTEocQ8EyP7c13P4AgIPrEShjxA4
	bMJjRWJ1Ipe11hGcVUujGtsgleqr3ZNY/EmKeDUGep6ph6P29VLDsOLIWkedi0gC+ZS6
	3yIFcketU2hD2bVYdhl2TK3nQJWYAe6gtr+YRl4GL9ob94KyRqbuHc0cj5tMjCq2fPPL
	uOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=T2aejSpup/jdLylt16k4iHZTGZjrzCHoXu3LKyQVTCY=;
	b=kyEeJsVMEelzI6G3WCxdDWYJASagkqnkfPykTkgSej3uDppc6L4dt839M+J6f10GyJ
	phpRMNK06UjsmcHIK+uR/7QOTloZxV8c0+XoWd68Z1Vd3TZTcHFmVa0AWPC+62zTpFsG
	ucAC4ZSeTzB9lQF9xBsRkLme8K3xvhculB9Vu+F8eZQo1u+n0ZTSne1Q5CToEhpnNrQ5
	xy80BqzCCRLiYl7HhqIULtswicCI2O396BL6ej3bE1QYQNzNNg3QLc2EVkHg4PxsLEWT
	lLuhynWklC0zMg2XwCUtGUJCtYAc0vwBuHKNqJtZrCgy+1pzkdJ4X5DXHh4d6EFhduLF
	KcpQ==
X-Gm-Message-State: APjAAAVhuEpVVIogl6U0Qc4+OIqlff0fZ842I4/5Ch0teg1UCOftuNHf
	bRU1cUwqj8/z9lKPSMTpubbyGETW5ZA=
X-Google-Smtp-Source: APXvYqzItAv2fO4PMlFSfcmgqi4+ilw/Kculx9x7s5ZhXc6b3oGtqJe8eYVMM1/K0IzPi7aTlcHMdg==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr71711540pgd.26.1558297201454; 
	Sun, 19 May 2019 13:20:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:44 -0700
Message-Id: <20190519201953.20161-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 04/13] linux-user/alpha: Set r20 secondary
 return value
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

This value is not, as far as I know, used by any linux software,
but it is set by the kernel and is part of the ABI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/target_cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index 140a459f73..caadb54372 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -26,10 +26,12 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp)
     }
     env->ir[IR_V0] = 0;
     env->ir[IR_A3] = 0;
+    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
 }
 
 static inline void cpu_clone_regs_parent(CPUAlphaState *env)
 {
+    env->ir[IR_A4] = 0;  /* OSF/1 secondary return: parent */
 }
 
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
-- 
2.17.1


