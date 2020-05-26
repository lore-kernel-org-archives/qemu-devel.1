Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0199C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840712073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE4ULK+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840712073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX8c-0008Kp-MK
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7M-0006Xv-38
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:32 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7L-00028B-9t
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:31 -0400
Received: by mail-ej1-x643.google.com with SMTP id a2so23239991ejb.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EByAZJAoFFtdeFOm6eReFE+ZTy/iIA5ZSOD5vs5S6WA=;
 b=qE4ULK+cCDM1bDfECEA+Ewb5/i4BaLjSeLZPV+dWrLqc5QT/1TzN8mr+eQumeCmffI
 z479JeFAH67a9GMUVxVXTAxwJ3/4b5VTWyapDZBJChPREgaw3teeS+J8OtUsYGSSzCJK
 9/KmxMNmbmWTzLg7Cj4DynfKbuA9De/9oV6u7JLFqvB7aBpmIbANGIoCkUGBrxobO7MX
 /DOs5l3vnGzZQbclZEUSVbaDGsSfWXDSQoGVAbjkV0w147MRFHOxNyXU1N55dcS/SyJh
 p+JECTsM29IdBuWX+2/bEkPBq5NaugAz59aOT4MlSJC0h+u3OfqGVSDY/gFDSbE+r/LM
 a8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EByAZJAoFFtdeFOm6eReFE+ZTy/iIA5ZSOD5vs5S6WA=;
 b=S32YHdl/aVUuKNnAZwmhvcBSJrzpgypnG2tNWS4LYeSTZQsO6SL6dX+f+tL+7XfoVk
 dDdsKCFURGFpxN3qWoxsS6iup+Iv+R1AFuJ4XiAqApMjX5CSEPh5k7dba/DQjoEBSLJw
 Xgc4+Ob6a81HEArfPqLQ/dpxVvOVh/Os9jwvhXxurlM9w4WHUMIy6Lr5W3OmU/lnG4g3
 XmSqSlRpxQ4zlqnLmFoPVraxu757CvkVQJAWcXFDHW0nb3gzIuCctcee5grcPEBGrq68
 +8IXHUkGDgprgZ8AfaREpVnmMZ1h30xdT+QTRxS8QhE6G61/XnEkHB2BaG7148MzEQmE
 OBgw==
X-Gm-Message-State: AOAM531G4xgo/3aQQBuleqoW9To9ZH0UNed/o19nttWQ/UMMvpj1pf6f
 dLtCf8MjInhklR4bpseplFWVpdGulBQ=
X-Google-Smtp-Source: ABdhPJxMn7k1V8NNzV6+qNGwt3Xwk0fih0F7NPgNRvR1jI1qStLpQoIwhp+EyJmb9JETJBNxrH7b+A==
X-Received: by 2002:a17:906:9714:: with SMTP id
 k20mr586763ejx.18.1590490049645; 
 Tue, 26 May 2020 03:47:29 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/14] MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
Date: Tue, 26 May 2020 12:47:13 +0200
Message-Id: <20200526104726.11273-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <chenhc@lemote.com>

I submitted the MIPS/fuloong2e support about ten years ago, and
after that I became a MIPS kernel developer. Last year, Philippe
Mathieu- Daudé asked me that whether I can be a reviewer of
MIPS/fuloong2e, and I promised that I will do some QEMU work in
the next year (i.e., 2020 and later). I think now (and also in
future) I can have some spare time, so I can finally do some real
work on QEMU/MIPS. And if possible, I hope I can be a co-maintainer
of MIPS/fuloong2e.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Message-Id: <1586337380-25217-3-git-send-email-chenhc@lemote.com>
[PMD: Added Jiaxun Yang as reviewer]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200510210128.18343-2-f4bug@amsat.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3690f313c3..8f597aae12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1082,8 +1082,10 @@ S: Obsolete
 F: hw/mips/mips_r4k.c
 
 Fulong 2E
+M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-- 
2.21.3


