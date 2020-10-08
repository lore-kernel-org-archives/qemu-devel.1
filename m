Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805F9221F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9W3ge+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805F9221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYhd-0003l7-DY
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgD-0002Rw-9W
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:09 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:45951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYg3-0007dt-Sf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:05 -0400
Received: by mail-ot1-x333.google.com with SMTP id f37so5958610otf.12
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=94Z0jUkUzmfUn5U+1GJavLRJ+p/K0pJn87QewJivFBY=;
 b=f9W3ge+Movwd8twHI8VvsMejpdOToEATUscBDM1oa4DKnLFT73ge/UoiTX0c/0zhhi
 hOKZRt5LULKbGq7my4nYuBDFrfOlg+iPNwi0myomZlDyyNaq+IOePyywrmOtXMypxQ8T
 D1JQ3LWyh3jE8pHFzxlrFNCt5bL0FHey7OJA+jGb9dbaA2gOqhcAsgmGoAxlpyhZnQ7/
 gG54RYNexgFnqJvK498znxV/GIC3+pnraW3oesIgjchnbrdlIhsDSPvIU/arvwq619MH
 DF5UpJ+PW04fqCKBIfoRtucMGpIudgEWTXa7pA+igwA6V4bZVUbvtg9Q45oXGWsT3hFV
 cgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=94Z0jUkUzmfUn5U+1GJavLRJ+p/K0pJn87QewJivFBY=;
 b=cR504tPmWXerRe4sFXzxaY98gWMSzGgilLRe6L8YGaZ/4aB1qMdXmB9hyR1/4SJKR+
 ivASAajjGA0uNhGx19P9fOFx1azxJKoK5PCRW6LiLV320OLygFdtMmztrPaHGONHVMSh
 o7bHlc9TnuFpzwigO4Uc4NV+YHLPNr533OyuVNIvibcl8R1o2owES/FlYm4TuNe4+hY5
 ofVEEP2rWGPfFPV3BNJDiVJVYqZYRTGlR3iEWhZVwUHbm35ZN2FYPuQE1N4xMqzPWcHK
 3Jpr2WT9L5j2kBWrJPECY0T8ksfHAeTLxKOhoBTh9C/kTyp0D+Y52oLKUwT+n9JtoGsU
 2lAA==
X-Gm-Message-State: AOAM533CX8L8eSkphz/iauF3vwVOHxJxioHvgxrVC1n3pASZaHtUedKJ
 0LgS0RRFXy/mH/msO17sDtC/hiX+tEUtNEQi
X-Google-Smtp-Source: ABdhPJwPFYB8fScArqG5bVbI7LDrX+gjFfXX7H4rpG6Zko/h+13Wid/bC/0T6Ie6U4Dkhusd6pD0bg==
X-Received: by 2002:a9d:4e18:: with SMTP id p24mr5918518otf.190.1602174118112; 
 Thu, 08 Oct 2020 09:21:58 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id l138sm5076218oih.32.2020.10.08.09.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 09:21:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: MTE fixes
Date: Thu,  8 Oct 2020 11:21:52 -0500
Message-Id: <20201008162155.161886-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One code cleanup and two bug fixes for MTE.

Vincenzo, thanks for the clear report.  Can you please run
this through your test case?


r~


Richard Henderson (3):
  target/arm: Remove redundant mmu_idx lookup
  target/arm: Fix reported EL for mte_check_fail
  target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11

 target/arm/internals.h  |  9 +++++----
 target/arm/helper.c     |  9 +++++----
 target/arm/mte_helper.c | 13 ++++---------
 3 files changed, 14 insertions(+), 17 deletions(-)

-- 
2.25.1


