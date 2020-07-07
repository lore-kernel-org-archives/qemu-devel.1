Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43767206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPxgB1UR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43767206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssQe-0001bU-IM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAN-0000K7-QU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAM-0002xq-CC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id q15so92377wmj.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PswJoJ5isVsmaej3e1+NkgMj7VKyF6RHGS5MY4k2LNM=;
 b=jPxgB1URjCd92bRm9xbxwObrqU22NCXCGsBW2B+fwCoFN55Sv8FOfPG+Gt45+pyqfw
 /2letgxfSahhceuUQSsZ9a9XhyIr0dX44NxDbgaLoLvaoMsIpJJR6Rbt0Ng+13WWaBLC
 VvMlUopjAfbodrQp/ID2eotPnK9elIbs7a4bx+KInNs6ezeuo3ZBQdTsMAUJiIQp9yXJ
 Vb6JIkQ/UV9zOeYdd+BbtwOikT9JJnnE95veFWqmKj2FIeH9eHqVI8a8RDtwpUwFgg86
 hZez1exAZmKFd6lZCsTotpodSBGTmScyQDZTFh6yX6JWw9z/4Mw8MBLrQldorF91WN40
 OFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PswJoJ5isVsmaej3e1+NkgMj7VKyF6RHGS5MY4k2LNM=;
 b=Jl1BRDVl3D7sgTFe8flX1do6oz9o0mSgmc9SUxGz4kvFgc3j+hLc3KeC0Q86HsttO0
 MdKY1Rzdd+F9+8AZboECTu6t+/RqoA8wzbtppg7dZ49usIff0fmNORdCA6iCJ2mENeMN
 aYVI+VY5derTjhn0s+xmZA/lpqtY7nCne+hiqjGyR5FfHlT/f/yK/wWNxNSgoJpSPSpV
 PU/9YXC2nQQrML9zi2y9/UwqmepFPz5qv7dyk2GhAKgdqmVDSBTwUZaD5pBkKV98x8WH
 A8BsLh1JOIGfWJNb/RI8Ie1QJL5Zjyj9/KFTjA/O0sz/RJK1m4G5v2spHoNvJ/QdL/zT
 xttA==
X-Gm-Message-State: AOAM532TFBaHz7L0ZEwFAxRsDBPa1rEVBPAj61Pj/QYhFCwdlaLk5pc2
 0t1u3ng0L5G2n3W+bxfSpxkfRhYq
X-Google-Smtp-Source: ABdhPJxESkct/hJR8V+tbhtvDcP3sz/o5d1bSGsUbP2RewfcMydplSLSA8UcMegD++fUYvzeCP4qEQ==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr5401782wmk.39.1594145880547;
 Tue, 07 Jul 2020 11:18:00 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:18:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
Date: Tue,  7 Jul 2020 20:17:08 +0200
Message-Id: <20200707181710.30950-31-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 1f5c00cfdb tlb_flush() is called from cpu_common_reset().

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200707070021.10031-2-f4bug@amsat.org>
---
 target/avr/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index d7ebe4e23b..f0f992aa32 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -78,8 +78,6 @@ static void avr_cpu_reset(DeviceState *ds)
     env->skip = 0;
 
     memset(env->r, 0, sizeof(env->r));
-
-    tlb_flush(cs);
 }
 
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.21.3


