Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF48DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BA320735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6oiI683"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BA320735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWIa-0006oj-Jr
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWHb-00050g-9R; Mon, 04 May 2020 04:16:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWHa-000113-Lh; Mon, 04 May 2020 04:16:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id v4so14904378wme.1;
 Mon, 04 May 2020 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GveMK/FOfLu+JK3BfCWLXw/TcwXbl1ACRiMVo4kAufk=;
 b=c6oiI683Lc/iaCqO8DCw6bacQIb1LFvxsB5jHon4f/9XEacnaTvfecuO05U0tmK9c9
 5gtuGe7Ia1+jzwmFUyt+uHiK+tc4/W/cbmxNxB37c5Z8ZS4YmweNZORoRWO1Bsc77ZC1
 HoNDoPYvt/hUMgaQZHfU/rCHNL7Obv+Nm/prunlcfd4zwWi06q63uPfiPvAPAh3Suye6
 +qyGq368V1p0FhT6XGCSWXfoDQeJZUCudTKIUsH8JsY7N0bZlLVLFNsnjIVPafZc4tU8
 cfB1XM5wu0XAr2zTGlWJsY56brWr0D+Tx+frTC7R9Yxx/BAilusfjK+DW2q24tGIj+kR
 VjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GveMK/FOfLu+JK3BfCWLXw/TcwXbl1ACRiMVo4kAufk=;
 b=Puf/SeufjK1uYFmpx+MZG+7aSEsBdw1kvDTCkJkuLo2CEP0RAnhi2nY8WgWSeKbjrS
 VOdSImE8BgRdal+e4hOJLtvDzlygMJfFAwXeg1Visji/J+CPLhjno2tIHMFEbE6EqYCd
 YcpWaUWTs+rXo5jq4ZkZVJ2jKco/YbKw75EI5E7nzTa5TZNaK/+pb6dD3Wvya/n9yABM
 CmDciFf0we/FI08YS8I6BHcTGJJ6xqEiaTKEiB9dkw3hBwyhAVKejcLAMtSTSVOVMStV
 8s9Zfs8Gala7f18S6Kb9lOkTv775mcGChUBdT2eWbh5iikcsmaEzJrsJncmamozY2JSR
 qLHA==
X-Gm-Message-State: AGi0PuZr5ms8OD9+ukMIDcBZco+NKZrzRgys0R2M4R9y3JjOn4gMli5J
 szcaK2M+O01ULdZup4G2Sxyami+7
X-Google-Smtp-Source: APiQypIplVu2uSzA0Hedb8XYQ7x6qDN6xjb5iqUbWM64qWvdNrxZp7FR4Ey/lPIpRfHApO+g2rdK9A==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr13358806wmf.77.1588580216863; 
 Mon, 04 May 2020 01:16:56 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id r15sm5092972wrq.93.2020.05.04.01.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:16:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/sh4: Use MemoryRegion typedef
Date: Mon,  4 May 2020 10:16:51 +0200
Message-Id: <20200504081653.14841-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504081653.14841-1-f4bug@amsat.org>
References: <20200504081653.14841-1-f4bug@amsat.org>
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Magnus Damm <magnus.damm@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the MemoryRegion type defined in "qemu/typedefs.h",
to keep the repository style consistent.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


