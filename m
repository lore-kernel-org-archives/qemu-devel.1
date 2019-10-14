Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42582C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA3920659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8VAk+64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA3920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0jx-00055Z-5M
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0gT-0002DS-HJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0gS-0006fX-6k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:46:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0gP-0006Zr-FH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:46:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id i16so17356673wmd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=S8VAk+64CwjIOGagIcCky1Yzz72q1j3+upj9nOiS7Jgzmjcd5QVrRMrDNtztjya9Yc
 MwDFP6W8HJEo/FBTqg3Q6fTrkwNgj/DzFht8jN2cSQJencymdxyIu3+rSRhaA9tzqkGE
 8tNiUiV3fcKgeFeWYOfEiOafpv0pCL46jx69xfvsjM3/irmqZ954xdScMnz50yjV+pCT
 +ZAh2CGnOXZjnh5z9kG0NjPhAwWz+lHSsONnYWDcIAjWILSCPpcQYzMwP8Q85y932R1i
 Xx0Xb522jM/MFFiSJ2WP2t3Hu9m3R/lhOTCGD3HM6ANvHbQ+xlyECAKPtX3t+O0Dy1Ml
 91Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=RhKHC7V9M1NM2PGhlfoDCiuyygeoIQFL7Db9twFLgPw1zABjOzFc1uwkCu5bfR8lI0
 iN0X/2Fau+92sUVlCiz8fj1hkFgnXw1deLVg+l3/DAGFHwW6dEDSVDDU0xoOy+VWytTB
 d/VUl8AsoSwmiaMDPfC/oATGiKqbfxTUwpAZCKm/BiiFCgLYYvBmg9kB9LKeZBL1YkPO
 haA1Z1z6J30kIo8f3YcLxn0+YMG81p7iF9cn5BgSiQRWbgwBiYGP/kfjpw5hz1SXBqcS
 p0SmXQeHsNUZNHrwHBeEyAebv+6QIlRFaVqBth5N1VYmCHeSeI3cP2MLTyVpY0lgxCzl
 h7nA==
X-Gm-Message-State: APjAAAUbTGwIt/onXy12ms7X/CujwW9XwZCoYL81VLVSjj3EQg7FYfzY
 DBupWifFAG+JVmKS8L2AfEoQcA==
X-Google-Smtp-Source: APXvYqy6SlkWeOi9GGDdp/dvx5fnbj8g9F4+SAkOWjz7qaPqmBlJXQKjUiGyYDHYEkym6OSPBwclxA==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr16005246wmk.28.1571060800820; 
 Mon, 14 Oct 2019 06:46:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm22878480wrg.67.2019.10.14.06.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:46:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B26801FF87;
 Mon, 14 Oct 2019 14:46:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v1 0/5] gitdm updates
Date: Mon, 14 Oct 2019 14:46:34 +0100
Message-Id: <20191014134639.21509-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

With these changes I get a reasonably clean set of stats going back
two years and to the top 20. However most of the individuals are pure
guess work so I won't submit them in a PR without positive feedback to
it being correct. If you want the numbers to be correct by the time of
the KVM Forum QEMU keynote now is the time to let me know ;-)


Alex Bennée (5):
  contrib/gitdm: add more entries individuals and academics
  contrib/gitdm: add MontaVista to the domain map
  contrib/gitdm: add Andrey to the individual group
  contrib/gitdm: add Bin Meng to the individual group
  contrib/gitdm: add China Mobile to the domain map

 contrib/gitdm/domain-map            | 2 ++
 contrib/gitdm/group-map-academics   | 3 +++
 contrib/gitdm/group-map-individuals | 6 ++++++
 3 files changed, 11 insertions(+)

-- 
2.20.1


