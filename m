Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C8C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF762054F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJUikcpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF762054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbU3a-0001Jy-RV
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSl9-0003tK-8X
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSl6-0002h2-B9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSl1-0001fI-Mt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id k11so3327682wrl.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jkv2tV7T5KFrjVdetifVI23wGPLfGThH9CbytKhyysc=;
 b=aJUikcpn74iZg1Nl03coA+mYssTVs4eDaX56OzJ8VXXiYG+ufcQlGrRkBQ/7e7I28J
 rWUDiNC1N48aM8u5YTdOJ4bUUhsRJSAS9UThbgmvZzsLAaHkKRBkH/agCowrkqDfLVYT
 I0u1FgJ8EjPyzd/dmk9DmfTqFQY9hgV5Hw8nP6a0sQEcsynN+DBteC1EJBZqoLIb9csV
 c8kIPSxOOfe0evdfKng1SSJPdL58rZqj19oLH51ujgIH4cStt6kfeS0KAlVGppZaOEMP
 wf6hWVFLQGhUpRmWKmRBqOaQyB53HmTXpqP03YR4rDSpc8TMR2Dk0oJewEwuFtPRngBT
 +gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jkv2tV7T5KFrjVdetifVI23wGPLfGThH9CbytKhyysc=;
 b=KIqUyCM01nsvsEd7j+hOjzPkW4tT8qxBfdCHwGsmeJ+DIj1b2GdvAtgVAhtqkTTKS5
 FScUHjZiD2FQjsGiJnnLzQsyZWfWjWwRiS6RdrCY4UjekJyfYhx2doIT9we0wEB5Rq6/
 hn3U9/29jegKF2wNgWt6xuDO6yY0diIAFiQ1SOZffvjWodEfDismSInEH7WEqnuXJbNt
 LDa/KpenkrTKDH8BLoWF9GneoA/Rezr/OJs00cSC2tIDtDKWmw5kRAEn2I7Is2F8Gj50
 pVbXjAszD+dxMjTyBhWluaNVyjZaoxw9sw0I8TQkojQH1+E/mvL248QV+gvhjV4P47jx
 Ttwg==
X-Gm-Message-State: APjAAAVlbwnpHhSQcUtjCCCtrgD0XSuKw9NBv4r04C3rI+mj4XHE/X3z
 eo/ues0XIAevVim5Iqf+cEKWvQ==
X-Google-Smtp-Source: APXvYqwB3RDyqUNg7puU72kdv9gyfYwN3Yaxp0HGZiJtNVgrz3PRabM5NT7lAp+JjYFmDPQF+QEg5g==
X-Received: by 2002:adf:ebc8:: with SMTP id v8mr5747880wrn.46.1560443959155;
 Thu, 13 Jun 2019 09:39:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:05 +0100
Message-Id: <20190613163917.28589-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PATCH 00/12] target/arm: VFP decodetree conversion
 followups
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

This patchset does a couple of the cleanup/leftover things noted
in the coverletter of the vfp decodetree conversion or discussed
in code review:
 * use vfp_expand_imm() for doing the VFP const-immediate
   decode, rather than hand-coding it
 * get rid of the final uses of cpu_F[01][sd]

cpu_V0, cpu_V1 and cpu_M0 will have to wait until somebody
cares to tackle the Neon decode logic and the iwmmxt decode...

thanks
-- PMM

Peter Maydell (12):
  target/arm: Move vfp_expand_imm() to translate.[ch]
  target/arm: Use vfp_expand_imm() for AArch32 VFP VMOV_imm
  target/arm: Stop using cpu_F0s for NEON_2RM_VABS_F
  target/arm: Stop using cpu_F0s for NEON_2RM_VNEG_F
  target/arm: Stop using cpu_F0s for NEON_2RM_VRINT*
  target/arm: Stop using cpu_F0s for NEON_2RM_VCVT[ANPM][US]
  target/arm: Stop using cpu_F0s for NEON_2RM_VRECPE_F and
    NEON_2RM_VRSQRTE_F
  target/arm: Stop using cpu_F0s for Neon f32/s32 VCVT
  target/arm: Stop using cpu_F0s in Neon VCVT fixed-point ops
  target/arm: stop using deprecated functions in NEON_2RM_VCVT_F16_F32
  target/arm: Stop using deprecated functions in NEON_2RM_VCVT_F32_F16
  target/arm: Remove unused cpu_F0s, cpu_F0d, cpu_F1s, cpu_F1d

 target/arm/translate-a64.h     |   1 -
 target/arm/translate.h         |   7 +
 target/arm/translate-a64.c     |  32 -----
 target/arm/translate-vfp.inc.c |  61 +++++----
 target/arm/translate.c         | 240 ++++++++++++---------------------
 target/arm/vfp.decode          |  10 +-
 6 files changed, 133 insertions(+), 218 deletions(-)

-- 
2.20.1


