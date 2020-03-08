Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169B1C10F25
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 01:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0C8206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 01:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSEf8TIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0C8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAkml-0008Ac-Vu
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 20:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jAklM-0006p9-Tg
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jAklM-0003rQ-2e
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:52 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:40778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jAklL-0003pz-U3
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:52 -0500
Received: by mail-pj1-x1035.google.com with SMTP id gv19so2828766pjb.5
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wo/STEifr4nmC/0JpTEtkvLorS3QUThlr96fAb4k+0Q=;
 b=bSEf8TIgp2EQdgsHPDk/JkLSeAVw0u/t2cUQk3VV+B0z5CSxrnhpm3BeDO55+AZx43
 oh5CEyoEPIEFtent272LOWWrywr1RfNoX7j89oYKbBCdcYEMBss8jEXv42b3EHRGbD4m
 YvaoLNdpEkI3+mKzqdhCdNsYslE5xCueG8AOXuVXaK+4pJcRm/ur04oodWyLtlJ1XyoS
 JpqRPCuVbx5zClyubMEh/d4UFyOcHKvEn16kJcYrUpFcHOCEDNzYDqJ2nc13Ai/oNvCp
 SHzyfnurMkm1RrRNrUZZgoHXDzhl0JcvEuablqJzvrKeyyY90Td5oZpXgukQL4KIbeoj
 Uvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wo/STEifr4nmC/0JpTEtkvLorS3QUThlr96fAb4k+0Q=;
 b=dPcFmyQ+2KAT1+G6M6Rfxp7BU7a/CBJfpx2Rw4gthtYDlg6tgBjd2KgrKvVCcaJteS
 Ko1J007PPznvWbpbAb39Y76DGMQxau873ZWMbWgbE6OXMXKtjHjDgd8xxFv35JlZmXVH
 kFTlRE5Jm1QX92dRg3M9J32HHX7OZ20ClZpncMoYV6tkNbKssu8Uh1cVFrUGHiaiTh6x
 lZqxBh9/oJ2PszlIy3+eK2XApT0VYE1HophnIpu1PM/SK+PNpR2Bm2Xh52M5F45IysIU
 b4NUulx87bX9R/l3mTYk6HZNdDe4tvOBEW22nSGdcFIwVpfqFxxQvv+d/8qPo4SZJtSw
 ArgQ==
X-Gm-Message-State: ANhLgQ0+mdV4H7WvcQGZ89jXG2DL/OlAxlcYBIGYxbI66auA4VteMWDG
 PxXXQjqyU3/92myCFfdMVVDqahKo6sQ=
X-Google-Smtp-Source: ADFU+vsGoplvf4J4eFeG+655l/626TTgzjPNAS+mesIsxTNxP0sDvk1ba50JfJDKlGtt4KwcSWue5w==
X-Received: by 2002:a17:902:a511:: with SMTP id
 s17mr9408207plq.317.1583630990251; 
 Sat, 07 Mar 2020 17:29:50 -0800 (PST)
Received: from cloudburst.hsd1.or.comcast.net
 ([2601:1c0:6100:5580:6886:21be:91dd:78be])
 by smtp.gmail.com with ESMTPSA id w19sm32636891pgm.27.2020.03.07.17.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 17:29:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] target/arm: Misc cleanups surrounding TBI
Date: Sat,  7 Mar 2020 17:29:44 -0800
Message-Id: <20200308012946.16303-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes for v3:
  * All but 2 patches are now merged.
  * Use regime_el to determine aa64-ness of physical memory addressing.


r~


Richard Henderson (2):
  target/arm: Check addresses for disabled regimes
  target/arm: Disable clean_data_tbi for system mode

 target/arm/helper.c        | 35 ++++++++++++++++++++++++++++++++++-
 target/arm/translate-a64.c | 11 +++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.20.1


