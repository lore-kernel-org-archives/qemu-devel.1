Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C523C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6F220848
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOKWqBLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6F220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOY1-0000Rp-KT
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSo-0001Zw-Tv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39559)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSb-0003lV-WF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id k26so5311943wmi.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GPgXjokSL0nkYUP8XQBRLPlsmz7/i7RySDFmZrOiI4A=;
 b=nOKWqBLHsMpmQGLC32xv5bKefbRn+lk/GsAKjxNDBUaBjLOgcQWX6IBe/XjdvSAWwk
 5tu8lB07rn5qKOJhc+q1EHS6jOnqCwPWczdUxTtAUxjUrKqFB94lGDa9hZsYVApcOirW
 4AyCfH8G2emb4pnkx8bTxbOWktegzd8I/7WAa8JhJLN0LJL0ZsFEgX8+mHl+WWTAo4o5
 HU5Gl+UdF0pk8p1FwddyTt1E3ZvzHjCtYBxg9jOUSjErJ6X590HGsOz2M8THC0hRdVru
 4pY10zY5UAssRrUJ/bTYCU4uubtCfXYV3vbWOWhqBvOrJEDc6xKR/wqWxlFotqaJvJzt
 M7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GPgXjokSL0nkYUP8XQBRLPlsmz7/i7RySDFmZrOiI4A=;
 b=gAIJxNaGxG1ic9wc0XvDYqPpJVusOJScaCd49R3Za4L3llBbMl7xWDLfMY/NVK1UEV
 nwXbI2vesmi9fOOrTkGkGUpy56oY4TiS6iAFzP1yI4ntuj+DeND5OSW6C54jMO6JVVzj
 nXFsDSCRURcTg5GLi5C3FOOnAd0Uaz/lMUN4LRbo9t7i8PLAJ5njtu8JlvVAVm5F8JwS
 2PAdvPyfjGpkM4rgxB6TeQ44kE6WJMUSQejMiBz1Dd/wv25epo0bpQv1QCd8kBaspGl/
 OwgYI+0N9lAWH4Y9HeCTfBZvQAYagheKeX+U5qtQBtrnz6LyseeTMNBbkuJxN4eqq9ix
 c+dQ==
X-Gm-Message-State: AOAM530UNCJVuPCytm8X0xgV5oPTshye3+ib+igXB0qOs+CY7R38AGcT
 65QAvQYbDSp4K5e15sntfZNHVQ==
X-Google-Smtp-Source: ABdhPJyZq1x4B8zIF6EQ0J/jYV59w+Xn+GPDPVXIAuF80leWW8ZWYQmnuMJJAxwbQwQAYntTe7mrSQ==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr8210172wmb.3.1591886733452;
 Thu, 11 Jun 2020 07:45:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/10] target/arm: Convert 2-reg-scalar to decodetree
Date: Thu, 11 Jun 2020 15:45:19 +0100
Message-Id: <20200611144529.8873-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the whole 2-reg-scalar group to decodetree,
together with the VEXT, VTBL, VTBX, VDUP insns which don't fall
into any particular group. The only remaining unconverted Neon
insns are now the "2 registers misc" group.

Based-on: 20200609160209.29960-1-peter.maydell@linaro.org
("target/arm: Convert Neon 3-reg-diff to decodetree")

The first two patches fix minor bugs in earlier parts of the conversion
that made it into master.

thanks
-- PMM

Peter Maydell (10):
  target/arm: Add 'static' and 'const' annotations to VSHLL function
    arrays
  target/arm: Add missing TCG temp free in do_2shift_env_64()
  target/arm: Convert Neon 2-reg-scalar integer multiplies to decodetree
  target/arm: Convert Neon 2-reg-scalar float multiplies to decodetree
  target/arm: Convert Neon 2-reg-scalar VQDMULH, VQRDMULH to decodetree
  target/arm: Convert Neon 2-reg-scalar VQRDMLAH, VQRDMLSH to decodetree
  target/arm: Convert Neon 2-reg-scalar long multiplies to decodetree
  target/arm: Convert Neon VEXT to decodetree
  target/arm: Convert Neon VTBL, VTBX to decodetree
  target/arm: Convert Neon VDUP (scalar) to decodetree

 target/arm/neon-dp.decode       |  60 ++-
 target/arm/translate-neon.inc.c | 627 +++++++++++++++++++++++++++++++-
 target/arm/translate.c          | 468 +-----------------------
 3 files changed, 694 insertions(+), 461 deletions(-)

-- 
2.20.1


