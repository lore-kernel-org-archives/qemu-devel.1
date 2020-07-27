Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8573DC433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3F920663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpDxS6kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3F920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02IM-0001uO-Ie
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ay-0007Hl-0p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Aw-0006RT-7f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id a5so4689632wrm.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A1EXBcwTpNFpPkUTTl0N+dnXsHPfdMclDDa4XH/uy3c=;
 b=GpDxS6kJwD6PpBilKFPpAq0t7I7YaSo7GEP5XxSugJv2CnQkFEJv4K5ZqFMEv6NTSD
 ClqBtKPxjY2aFrolaWyO+UwQQUMHdhFZ7+t0Euo9EjvvBuyDXOLt0GCnHwBuNa8LNc6t
 NCibKexDPzrteSoaxwlhUPYatsmlKm/eISas3HHODoA8YMIeidk8i4yTwNfxWT4mBNbF
 5INJN7wUlsuQe4dv26lCwf3EGGeM8foRJlxpceBnmWstFHYK53ZWWvdi31lxwgJ+qjKr
 KDGSKPFDV/Vc85nDdpioFA6fwAaZGAzlji20WAfcPAy1V6/ldXJZuF2xAVMeuFiyHvof
 /GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A1EXBcwTpNFpPkUTTl0N+dnXsHPfdMclDDa4XH/uy3c=;
 b=Jehq1maJYkT0mjIIilYRVlfNz+6Tc4E7te8QinNFCkLvALhMYsztiKcmwZewYLi/vJ
 0FYS7sbGrZfxAs11lNoiXNDAWc/Hp5Mq0rifgDHgjX/+/8A3OfvSdNhHrSu7dzG8A0nq
 UZHyXpmNf5d9TOm2XCIzuGXFz4SJ5WHH2MKyOMn4e0VZcQ+Mmke/kaD9sYPU8xEdFItp
 vZ86TYxsfIUsQFonOvwVB9GaeHMF280wrrtYhAKCkY7hGb3a7YNsKDkLFeW4eH/gLhr8
 pVd8Zgg5vrC1QJ4d5jMo5Gf3I7VQBBtX5kk/I/TFxDYb6Lu7uSoqaZMrVmRIy9OWWkmL
 YlyQ==
X-Gm-Message-State: AOAM530Ean0TEPS79lLdhwr7AjtLgMabs5aybO5C3Jm8BGfQPBS+uNaY
 hbj+Nq6HdoNhqr3LKBO3dXjdvw==
X-Google-Smtp-Source: ABdhPJzLXOrNiGwtmszzN+1CukDxAdAsNmKTuBpDgMP4X5oTp6XpFq7QRxLvFHjtHXOX+RR2D9nnsg==
X-Received: by 2002:adf:e902:: with SMTP id f2mr11465106wrm.174.1595852652822; 
 Mon, 27 Jul 2020 05:24:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h14sm7341410wml.30.2020.07.27.05.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EAA41FF9B;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/16] linux-user: fix clock_nanosleep()
Date: Mon, 27 Jul 2020 13:23:53 +0100
Message-Id: <20200727122357.31263-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

If the call is interrupted by a signal handler, it fails with error EINTR
and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
the remaining unslept time in "remain".

Update linux-user to not overwrite the "remain" structure if there is no
error.

Found with "make check-tcg", linux-test fails on nanosleep test:

  TEST    linux-test on x86_64
.../tests/tcg/multiarch/linux-test.c:242: nanosleep

Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200722174612.2917566-2-laurent@vivier.eu>
Message-Id: <20200724064509.331-13-alex.bennee@linaro.org>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c26..43a6e283961 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11831,8 +11831,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         target_to_host_timespec(&ts, arg3);
         ret = get_errno(safe_clock_nanosleep(arg1, arg2,
                                              &ts, arg4 ? &ts : NULL));
-        if (arg4)
+        /*
+         * if the call is interrupted by a signal handler, it fails
+         * with error -TARGET_EINTR and if arg4 is not NULL and arg2 is not
+         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
+         */
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
             host_to_target_timespec(arg4, &ts);
+        }
 
 #if defined(TARGET_PPC)
         /* clock_nanosleep is odd in that it returns positive errno values.
-- 
2.20.1


