Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A858C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DC52068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TbbuQQtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC52068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBMK-0000eM-33
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxl-00006j-PM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:57 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:34520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxj-0006HU-Mv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:57 -0400
Received: by mail-pg1-x531.google.com with SMTP id t6so888653pgq.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GIJ/UPBp2WO1BlyJ6/1RakPZrL4gW2QpybA3d/fh+SA=;
 b=TbbuQQtXZYu2JpdFy8Tdk7LxbOGQyLrthVVvl0wL1MDdvLcXnf3uS2TKeJ0Q7bq+Zw
 gsLKn/nZC0HA+012QiJ3HEhgYGrTPw1lUo2MM+25qpzxpKK3DOv00HRWA2w+1HMtcIgO
 eSD9SIWanyGhOF6gKUAGYgcAiEMwCoBUot1MpNLI/fIUh/omnsd3Hay5NNXw5atdbMQC
 Zp3hrOfevwPqU3dSmiGaeudf6LMN6hy9fm8f4hl8imlwWIDTp94mZ/xAztDhJD2rdH4s
 0U5S8GDvYxrQ+sCXNSgStr24wDKE+4XGjE2K3kAGgquuasVC05vh03Q+qnSBE/Bmo+PJ
 wXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GIJ/UPBp2WO1BlyJ6/1RakPZrL4gW2QpybA3d/fh+SA=;
 b=XIMC2e03cQgt2AEpfjgM3w+oguWzcLYnrSY0ZSsabnhyAHUk5B/nu45PLaxDuqHhCy
 AT0xqB/WW8oF/ei8kh1+BN8+LLfUP3CoEBelLYH8ym5gb7Zli3klA+ot/m5Vzwv1oaUY
 ldwjO/Fy+LOHdEVmRpYdGT8j1ytPAPNenYbse+RSYDQeRx7XFg9Ua6Ku2ywqX+ch9GAV
 uf/zz+DzplwsoHbUVwwGihq2S3dtWw7ikz8gfpoqoRt/aytvauGbWcw7WgJFKf9voAbO
 YVnOVFwXlFkYkIR7td70kXgnWiCCVr23MVzTiex+Y1L4gIgHQvYTInr6YRBe0VzOCA4u
 TGqQ==
X-Gm-Message-State: AOAM530CPrvFHQyekI53+axmkFQWj/ftX/5yEgAqZ99DB5YuNQBZyQnA
 Cl0wX5XquMw5eWxlIk3bjPhXRDSX/no=
X-Google-Smtp-Source: ABdhPJyHbDRWFvF6iQV+zWgVF8l6wJO3Q5vFAKDFGHWF6yMpzrPehgMV82I6RSBAaCJ0Ht7gF/Nt/w==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr25240703pgp.67.1595409774369; 
 Wed, 22 Jul 2020 02:22:54 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:22:54 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 76/76] target/riscv: gdb: support vector registers for rv32
Date: Wed, 22 Jul 2020 17:16:39 +0800
Message-Id: <20200722091641.8834-77-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Greentime Hu <greentime.hu@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greentime Hu <greentime.hu@sifive.com>

This patch adds vector support for rv32 gdb. It allows gdb client to access
vector registers correctly.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 8d69013a97..dbe3c4e4c5 100755
--- a/configure
+++ b/configure
@@ -8222,7 +8222,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
+    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-vector-128b.xml riscv-64bit-vector-256b.xml riscv-64bit-vector-512b.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
-- 
2.17.1


