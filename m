Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC73F206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTkc8BAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC73F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexjD-0004Qn-Vz
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhx-0001qr-1z; Sat, 30 May 2020 05:23:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhw-00073A-BS; Sat, 30 May 2020 05:23:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id n5so6510622wmd.0;
 Sat, 30 May 2020 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u9uKPWNzNLOY7VTU1g9/yQJr0QmghdK+v0pLVKAdyqA=;
 b=LTkc8BAYub/Ld4tGrsO4OC29y7x1KWlURfXZ9dG3ytcT0cMyoERYpxYfzP6ntoKzeN
 bEpfB1SEDwg+1UgOlonaoFVrO3ipsclZJEbOT9jdLeodHkhmcpYBEN5nrlTywe6JmWwe
 KRSzF7EV8pxlibThLPW/c6CZB9xPPqUghHmnpZyQQBUAyVUrNkpim4i6ZX8sBae2Ixt1
 baQW0ha/Z5l8OGJAN8lLOeg5wam10vMe6y6S/8wPrmWlir4lS4UgrkOwNZcZYe18a1Z5
 LezSZmQUFMbAqENwFGAw9BANyvuzWzOUO1Z7h6GrPHzcc0xfytllOGX8TXcHNUGetuNa
 cJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u9uKPWNzNLOY7VTU1g9/yQJr0QmghdK+v0pLVKAdyqA=;
 b=bMwG+SucOVpoD7M9kRjZYHIpLfONceilgaDBXJ7XKH1zwdcK6nHMaq9woujV1CymRq
 V+3ZGIE6Pur2h64j5KMhtDarmcDEuAl8W4ONKWvrutSLcOR1ejPfdxEmJlpl/6B4x0yp
 ym79dw8tDkGTrbkbmhTVGv0nIg4R0iN3atfS7EIsoV/+dqCsV/Q4+vNBewT8llu/fsh2
 u0GDU5NtdfBxEIqmsnUW4TKzes/0+ynv7lkkXF50mnUMtDmTamKjXyjm1VdKHWbmmZHh
 f5XfKB4Se50C9ieVth0keCoe4B56kGTzmUg/TwzvrVm3xINmpXWfO7s1hP5ZKDiGUt2Y
 r62w==
X-Gm-Message-State: AOAM533VtBCwZuVuoUoLLCGcg2rYTSGU9XJeNP2NZn0tGRhij95jRbz4
 N3Mz4Nggn6xKxOBtcKYPwoP5Rq9M
X-Google-Smtp-Source: ABdhPJzqW2TQjq+NPfkGDGPHhrsrwqhWELjOVorbfgB/3oV3oHASy5uWNoMeOjrIZoO8xC9SDj5Vxw==
X-Received: by 2002:a1c:6056:: with SMTP id u83mr2296838wmb.138.1590830590337; 
 Sat, 30 May 2020 02:23:10 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm3195237wme.42.2020.05.30.02.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 02:23:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/sh4: Use MemoryRegion typedef
Date: Sat, 30 May 2020 11:23:02 +0200
Message-Id: <20200530092306.26628-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200530092306.26628-1-f4bug@amsat.org>
References: <20200530092306.26628-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the MemoryRegion type defined in "qemu/typedefs.h",
to keep the repository style consistent.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200504081653.14841-2-f4bug@amsat.org>
---
 include/hw/sh4/sh.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 767a2df7e2..fe773cb01d 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -10,9 +10,8 @@
 
 /* sh7750.c */
 struct SH7750State;
-struct MemoryRegion;
 
-struct SH7750State *sh7750_init(SuperHCPU *cpu, struct MemoryRegion *sysmem);
+struct SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem);
 
 typedef struct {
     /* The callback will be triggered if any of the designated lines change */
@@ -32,7 +31,7 @@ int sh7750_register_io_device(struct SH7750State *s,
 #define TMU012_FEAT_TOCR   (1 << 0)
 #define TMU012_FEAT_3CHAN  (1 << 1)
 #define TMU012_FEAT_EXTCLK (1 << 2)
-void tmu012_init(struct MemoryRegion *sysmem, hwaddr base,
+void tmu012_init(MemoryRegion *sysmem, hwaddr base,
                  int feat, uint32_t freq,
 		 qemu_irq ch0_irq, qemu_irq ch1_irq,
 		 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
-- 
2.21.3


