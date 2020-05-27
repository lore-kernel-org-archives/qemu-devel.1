Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A089DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708D8207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYeYzNCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708D8207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxaQ-0006AS-KJ
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSY-0001rZ-Hv
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSV-0008B3-R4
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id x6so10675012wrm.13
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kYq+Iqo+cKi5UFcKLWoiaFCpkMVAa+BEZNXisFwmIpA=;
 b=FYeYzNCyCbTKOMRgCoghqQ7NbL+LGtxnqqP4nb2XQaThP37M1JgJTOcGjwxjXVXB3b
 +V9zTqkuipZ50eDBS7grJHTQaoGHAeqViIftxQD3+pjVu0BxdN9zabDgpJ+FGRIoPFXP
 xckGS4MschZeSWfFinyIIUD7BNztNCpXVCNtSv0VRFcuSXWFeeh/qwAwFmT7r5fQAWZb
 hxWO2z+nT7wJx5ksJ57qaK592TXhtV7Rl4ei1arBBtWBApn4oOGwuLtUm/GmD275WNuh
 LFg1fv7Jd84el5Kpy0ZRODGN5E27sCntkkBL0mV/KW0tBLSHXGSClVJzfLcD07oRq8lc
 FhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kYq+Iqo+cKi5UFcKLWoiaFCpkMVAa+BEZNXisFwmIpA=;
 b=CB2B//8BfVyfyfT6BXZP+tLf64bqAQD3mcxAc/fFhREpfn+aQT+qhX7fHTVoaLtzkR
 oZiVuuB1jg5J1edqFPVORkgNhHiPSZBAv/9iw0fg1s0Bjj9NDPQd+TnG4bemoqQPo86D
 2EU8TgPdi0Dt04RidMqbLdc0hTNJnP6EL64brrmIuFDHH6ViSFkBl1M45Vj1s0+ZbiVq
 SysEkZxORJE2TcKjXKl8O8XanD5/615WuKTYO5w83MO4YjrIL3gWm7NGLRrqlIP+6eED
 xHJS70ruHZBq5yYtElJyKYbROmGqy66XMEO+h+bR3RLmqg600VejHoYn/mMF/NJTlNfI
 Ny+A==
X-Gm-Message-State: AOAM533Jbh8OZ4KbsxgyuyENKqiNMA58tWEf4uj43EW+UZZYsHFX2Z+W
 UQND5jQE5JSpwkS+WIqawJwewFq5QJg=
X-Google-Smtp-Source: ABdhPJxnFURYlwqnsSec+ayi88hb8qGzo3i1VGBhRd+3jSCfddXOkLO09fG/ldiQx0XugoLuBIWMaQ==
X-Received: by 2002:adf:e381:: with SMTP id e1mr23933904wrm.320.1590591306344; 
 Wed, 27 May 2020 07:55:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u74sm3027545wmu.13.2020.05.27.07.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:55:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB9B51FF93;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/12] tests/tcg: better detect confused gdb which can't connect
Date: Wed, 27 May 2020 15:54:50 +0100
Message-Id: <20200527145455.2550-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we may gamely give the right information it can still confuse
the wide range of GDBs out there. For example ppc64abi32-linux-user
reports:

  warning: Selected architecture powerpc:common is not compatible with reported target architecture powerpc:common64
  warning: Architecture rejected target-supplied description

but still connects. Add a test for a 0 pc and exit early if that is
the case. This may actually be a bug we need to fix?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200520140541.30256-8-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
index 734553b98bb..2bfde49633c 100644
--- a/tests/tcg/multiarch/gdbstub/sha1.py
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -65,6 +65,10 @@ except (gdb.error, AttributeError):
     print("SKIPPING (not connected)", file=sys.stderr)
     exit(0)
 
+if gdb.parse_and_eval('$pc') == 0:
+    print("SKIP: PC not set")
+    exit(0)
+
 try:
     # These are not very useful in scripts
     gdb.execute("set pagination off")
-- 
2.20.1


