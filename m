Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A1E2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ju6P1evB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A1E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbbW-00004t-7s
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaD-0007Bi-2C
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZba8-0005kD-4A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:32917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZba7-0005jZ-Pu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:44 -0500
Received: by mail-wr1-x432.google.com with SMTP id w9so22696339wrr.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 06:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nw7Hn+qRDbWUvvnz+5J2uZy0VcWScKIcOlub/mEYLHM=;
 b=Ju6P1evBu5UVfikEYFRnEBwA0oEDBNt7/4IIgPWLxHwaSEESOPyUajY9j6UlfIcCb9
 ww/FpCc6yIAIHGDXPLRWcuEIEt/ra9lcdPXpRqYhaN+qqwiN/VL75H27Xdf95GUPnvS7
 YslI3l+nk5739aUaX34/prWrLrKamkiZI47Jwa9L6xC2YpaYvtVM7k/li1XWPyvH2QLb
 /HDy/CW4SVvzp0jEAbB3w7xce/wex3pfb9JBCC066hVTA8PIT4jasqqraadfMFN4swpE
 NlWKBgBjrJxso9vnREYwVE64V2YqdMVSxiQpnr4XTK7suO5MuovF7mzqgeFasW+Hl+Wf
 Q5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nw7Hn+qRDbWUvvnz+5J2uZy0VcWScKIcOlub/mEYLHM=;
 b=sLH1xQTCmktHWWhs5zghDtcHyvNFQe3BFdfPuIf1z6ow563SSqYiXFx56WOt4tlO2x
 JncKEYVdOKyO9GGbbFM5tr1PriOv9bI+oyojRpV8okjIgHByXd+u1CVLz35gIysU77BG
 X1tr0j0o/txsq7Di+hR/tnuxIRI1jxyX83vS0wqwGTh5NG1YefrOx2cgNOlii6K5fFT0
 3uFpFSfc8Ci6eE4VtdWKgG1r0/Be3+Vbsk28BhecJWW1OabwBRrMltbMTKn3PQU0aslT
 KyF7BAq2PoQjLEgg7LFy74z8g1B7QhET31lfbhzFDqUcuArvFoFlpymj/pVB+nrSR/vj
 0tZw==
X-Gm-Message-State: APjAAAWB1iFBFfmzJuxWgs3tl7JPayBq+7dc8+Udqc7dsQWFN5dF7CJ7
 UHbOOIhNUCHjar1HXVw1jvMuISmwrCE=
X-Google-Smtp-Source: APXvYqwOd9efGC+tC3r+4p/rNHXzme1GUealV5+D6YvND4ez0/i1EPhtdYCrVwzEIjO7Rpq8Tov2xg==
X-Received: by 2002:adf:fd4a:: with SMTP id h10mr35441207wrs.90.1574777562204; 
 Tue, 26 Nov 2019 06:12:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i127sm3364581wma.35.2019.11.26.06.12.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 06:12:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target-arm queue
Date: Tue, 26 Nov 2019 14:12:35 +0000
Message-Id: <20191126141239.8219-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Arm patches for rc3 : just a handful of bug fixes.

thanks
-- PMM


The following changes since commit 4ecc984210ca1bf508a96a550ec8a93a5f833f6c:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.2-rc3' into staging (2019-11-26 12:36:40 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191126

for you to fetch changes up to 6a4ef4e5d1084ce41fafa7d470a644b0fd3d9317:

  target/arm: Honor HCR_EL2.TID3 trapping requirements (2019-11-26 13:55:37 +0000)

----------------------------------------------------------------
target-arm queue:
 * handle FTYPE flag correctly in v7M exception return
   for v7M CPUs with an FPU (v8M CPUs were already correct)
 * versal: Add the CRP as unimplemented
 * Fix ISR_EL1 tracking when executing at EL2
 * Honor HCR_EL2.TID3 trapping requirements

----------------------------------------------------------------
Edgar E. Iglesias (1):
      hw/arm: versal: Add the CRP as unimplemented

Jean-Hugues Deschênes (1):
      target/arm: Fix handling of cortex-m FTYPE flag in EXCRET

Marc Zyngier (2):
      target/arm: Fix ISR_EL1 tracking when executing at EL2
      target/arm: Honor HCR_EL2.TID3 trapping requirements

 include/hw/arm/xlnx-versal.h |  3 ++
 hw/arm/xlnx-versal.c         |  2 ++
 target/arm/helper.c          | 83 ++++++++++++++++++++++++++++++++++++++++++--
 target/arm/m_helper.c        |  7 ++--
 4 files changed, 89 insertions(+), 6 deletions(-)

