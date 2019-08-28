Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D93C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950CB2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BINih3F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950CB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Qr-0006hp-NX
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C3-0007cP-Rf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C2-0000og-HY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31C2-0000nT-AJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id t9so779614wmi.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pefR7nFPk8DjAjuJAmFv11EX8F/m/CQNr4qIm+iK9Ug=;
 b=BINih3F9kZf9Nxxs+HhsX/VWBHwBwppQMzzccCaewDt1zzmc3Az0/leiWtCdp2Qsgh
 pxODCrKMDVUppU0zHF5FbZAjGLEtriM7xquGgJk9R9lGbHQYsiHTRgQz+i82ebb+o1an
 U7GefnVHh96Mh+Exa7eF7/wlphUvNw2D6iJ7k2jB1EP+7TJWXYyJP4pH1VBrwQpO9UwR
 NXLT9AGYtdFi4UFZztcSOUvad0Zdu1udGKZyTUNzk5EL263ERp6/VCQd1AggsHXT/tVg
 0knR+vv/KmJ/C1Xdj+A7zIPB6Oi6F5he/2ae7QuR1s6buLxFVISqV93LFse64QnCM9BV
 jMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pefR7nFPk8DjAjuJAmFv11EX8F/m/CQNr4qIm+iK9Ug=;
 b=ZfQ/oZeF9LBvJQOx+JH9UFQoaP4QIAW7u+YeovnJTfS8kSP2Az1y1PfXIyQu1keT5d
 4u9mMtsPKzgDtqb4ffJSjUc5Qs0g+GJC7FaOqt0U1WZYLdpTHXwOfj4FDW/8VRmoniDa
 Z+wBq4kHoHImCIVZT7Ph/viBhnMuszC40r+Bd0pbHZ04MCnZnozhtP5ApXNwr9nEryCm
 Ft+f6oL+s8mAZ/Zwzhjvq8YvoNTWi5053Vh53dCGobypouK52IHgJM1abkO9EMHM7Kxa
 ZFsC0ooi6clGK1dIeg6JBdjZtjNntQijei66kO92GKT8crc0klEGSMdULYCLRBnEN9bb
 X8bg==
X-Gm-Message-State: APjAAAXL6rc4Cnh7KrOzwamm6Mf1wqFFdLuDX6DejtN7AH6Au2Fn/PqI
 rAd4bZ3pA8COVAhV0SqoFAcOrA==
X-Google-Smtp-Source: APXvYqyRz04/yGm/5QZl0Dg6xYbo70nARCnORmTIag//51up+cShIhmJJdVc5THS2DXgKq2Y76xDfA==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr6395855wmc.143.1567011188670; 
 Wed, 28 Aug 2019 09:53:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm4281480wmj.27.2019.08.28.09.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 690821FF87;
 Wed, 28 Aug 2019 17:53:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:52:58 +0100
Message-Id: <20190828165307.18321-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PATCH v1 0/9] arm semih-hosting cleanups and other
 misc cleanups
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

Hi Peter,

Here are the ARM semi-hosting cleanup patches and a small selection of
miscellaneous TCG clean-ups. If your happy taking them all through
your tree please do otherwise I'll poke Richard. I'm just trying to
reduce the delta for my next iteration of the plugin series.

The following patches need review
   04 - target arm remove run time semihosting checks
   05 - includes remove stale smp max _cpus externs

The first is the result of review comments, moving CONFIG_TCG ifdefs
around and the second is pretty trivial.

Alex Bennée (7):
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile T32 semihosting at translate time
  target/arm: handle A-profile A32 semihosting at translate time
  target/arm: remove run time semihosting checks
  includes: remove stale [smp|max]_cpus externs
  accel/stubs: reduce headers from tcg-stub
  include/exec/cpu-defs.h: fix typo

Emilio G. Cota (2):
  tcg/README: fix typo s/afterwise/afterwards/
  atomic_template: fix indentation in GEN_ATOMIC_HELPER

 accel/stubs/tcg-stub.c      |  2 -
 accel/tcg/atomic_template.h |  2 +-
 include/exec/cpu-defs.h     |  2 +-
 include/sysemu/sysemu.h     |  2 -
 target/arm/helper.c         | 96 +++++++++----------------------------
 target/arm/m_helper.c       | 18 +++----
 target/arm/translate.c      | 64 +++++++++++++++++++++----
 tcg/README                  |  2 +-
 8 files changed, 87 insertions(+), 101 deletions(-)

-- 
2.20.1


