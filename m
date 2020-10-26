Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D206C56201
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB6E20872
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVYUIsqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB6E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBxv-00050O-IZ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBvu-00034B-Dh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:46 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:40494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBvs-0000G4-Uj
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:46 -0400
Received: by mail-ed1-x535.google.com with SMTP id p93so1163116edd.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=urFZaeBJKljDRkArj0HwcSmE633p30vmh0ol15kKy9E=;
 b=mVYUIsqdMcm4JDdnKtYSmnLzcAatosaK79SgzMhDRVgep3RogvqG66cjf7Di22kUx7
 3AUNiiBuOydJFnaw+x5n1VQiTGJ32VVvPisI33ZIcYpe7X+wq31hDkq1vy085SjkNcfR
 YZv11qr0l7v6cy92OQIXnMb1djFD9FdBTio0TK5HXRGQZSYyQ2M8yoJOp8vf8lNtTVgl
 ChQD/cxtkMsfABLbpos/mjLJPcrqUTPi9ZlRHdgNdEKGVj+aL7WMZmHfoq6KK8IbU3mN
 FkSj0mgirpXChqywlclbK0v2kHq5qsWsgEHqMWW25pP6HFaqUlZ2vxPK9SdosdvHqt42
 jHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=urFZaeBJKljDRkArj0HwcSmE633p30vmh0ol15kKy9E=;
 b=DIysfLqItitLIqFf5+badZoaZU73j5MAwSNr/JVXDxevX/J6EtH/BTxURvXXb6SQH2
 +bf+7ulajs8kCPdWZQNA+FzLIOzinOGaTmXB4pFllfcZkEKIp6l82hMhiK3us70yucI9
 GR4BsGk1eePrnLn17LJOMH4a8quV+lRqz9ROeE0KwU2n/KxrmEEWmaA32lEhKrUqItBy
 0kyZyYFoIJz1q9D3f0mtovepoHRDSm4npp6tP6gLBsOJsRxlLOze+4GfF9wlgJxsetxd
 lobK1NcwLRSTw4ym/9toXjlX4EebaG/RoTSDNrwxh7pr29XUD2FcdKwZQn0fM+fP7iuN
 XuKg==
X-Gm-Message-State: AOAM532cN6mFDD4oR2SXICf7+BwfomVC8Ml6aq9LrKc6b6G3Da+H0Jcy
 O9Xm9r4KFVDKQRvmPTqQ5CG/6AMWlLY=
X-Google-Smtp-Source: ABdhPJyW6/eo7p9K54Vvl072fTYA7gHXy/vs5BzmhhMbmYP+49xJ2JAnHIR8KWBBcHl58hCCZDKbHg==
X-Received: by 2002:a05:6402:a45:: with SMTP id
 bt5mr2669162edb.101.1603754983034; 
 Mon, 26 Oct 2020 16:29:43 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q9sm6642658ejr.115.2020.10.26.16.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:29:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] elf: Add EM_RX definition
Date: Tue, 27 Oct 2020 00:29:28 +0100
Message-Id: <20201026232935.92777-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

RX's ELF machine is not defined in "elf.h".
Added it.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200814131438.28406-1-ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index c117a4d1ab0..d9bf4a95d86 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -172,6 +172,8 @@ typedef struct mips_elf_abiflags_v0 {
 
 #define EM_UNICORE32    110     /* UniCore32 */
 
+#define EM_RX           173     /* Renesas RX family */
+
 #define EM_RISCV        243     /* RISC-V */
 
 #define EM_NANOMIPS     249     /* Wave Computing nanoMIPS */
-- 
2.26.2


