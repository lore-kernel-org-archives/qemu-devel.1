Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C22C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D8120853
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2jj0o3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D8120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaipk-000354-IA
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaioz-0001v2-Rr
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:40:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaioy-0005p7-Kn
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:40:57 -0400
Received: by mail-pl1-x643.google.com with SMTP id t7so4462068plr.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zs8yQ4sTIGdE2TSYasYP9UgCnUVG+62C46arKRLiiYE=;
 b=j2jj0o3WKR5jD8P8TsSzr4d3rsG6opZ8SQKxtu1rNy5LPzpvH7sVVZ/UY3Wmev5m9p
 9UKxNyjdT6u17lvo5ehMfuVZi9tuTexm2rm+J2KCMdq844gdLJ+l3IBj3aqApT2C45GK
 p8jrAkWQHXaTCBQ8t4cVBBw/y14C3ZLsOM6fqcd0Tb0KJiN1zXB/4BH1ewQdDQhMf0zq
 QjW7tpAlgMU3Fu1+NS7Van5BDDr567g2ap1vtCASFftb7S5F9yN/8ElOkfZRj3qY3XQe
 5AyPleSCO47U6ITQjrLrWJiQtVH00apiKi+ozJpFqkQYwBwKP+qGYZYSQFlLx/sZKrE5
 Uhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zs8yQ4sTIGdE2TSYasYP9UgCnUVG+62C46arKRLiiYE=;
 b=ZETSsK8hOmdGMbuK6Gs9P/2SeOLgbzMYVnoKwYjpOmBdcIfGsxkCgiL9gnsZL8dT+g
 qGOKwktYsZaRhTg7L89lRVx95fQXnTS9uZnjQLoconKRu59GGsyA0m08M3SLFd5mvv9a
 UULTl2Ilx+MZgI/yYthxOEzZr+uzCCkpBW1kYHCZ1JOPY84OuMplEPwdILYTsBwaaCdC
 Q0ZFXRsQoyF0o+n3BF2tLmDASNC6mCcdGr8mRtwbrc3t0eCKn+Gj5Gy3xkwn2YhNfjD9
 AQvIuYyckJU0lTsG/nHdQIkVjhVrkuTGlZP07XMc84p5PGVM4VYr3BUcAWMhFC5bSK60
 aaHg==
X-Gm-Message-State: AOAM533LBLCP64v+9s9hVwvF+kDMFuxWrpz5W1Om91uXh2ju0bang4Fr
 i2JvjoNsvoQuLm/tAkuwZa9yj/JmyEo=
X-Google-Smtp-Source: ABdhPJwaA4Fd4QH/3TMJj08NLyApc7fI+1/Fy4p7AW6ZXVP63IxkJ5UhZGLiU5BU7YMi3k74jPyKGg==
X-Received: by 2002:a17:902:a713:: with SMTP id
 w19mr15883238plq.296.1589820054168; 
 Mon, 18 May 2020 09:40:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:40:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] decodetree: Add non-overlapping groups
Date: Mon, 18 May 2020 09:40:44 -0700
Message-Id: <20200518164052.18689-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a feature that Peter requested for completing the
neon decodetree conversion.

I ought to write some more test cases for this, but the change to
t32.decode proves it is minimally functional.  I'm undecided if I
should add errors for useless nesting of these within other non-
overlapping groups.  While useless, it's likely still functional.


r~


Richard Henderson (8):
  decodetree: Remove python 3.4 check
  decodetree: Tidy error_with_file
  decodetree: Rename MultiPattern to IncMultiPattern
  decodetree: Split out MultiPattern from IncMultiPattern
  decodetree: Allow group covering the entire insn space
  decodetree: Move semantic propagation into classes
  decodetree: Implement non-overlapping groups
  target/arm: Use a non-overlapping group for misc control

 target/arm/t32.decode                         |   4 +-
 ...decode => succ_pattern_group_nest2.decode} |   2 +-
 scripts/decodetree.py                         | 539 ++++++++++--------
 3 files changed, 307 insertions(+), 238 deletions(-)
 rename tests/decode/{err_pattern_group_nest1.decode => succ_pattern_group_nest2.decode} (85%)

-- 
2.20.1


