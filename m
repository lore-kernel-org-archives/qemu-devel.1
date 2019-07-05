Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3D4C4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978E0216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQns0Qcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978E0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQwV-0001Fw-Rs
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhh-0002zx-50
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhe-00029b-RH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjQhd-0000L4-FS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so9662741wmj.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IA9jQ8jl+c2/RuKmRF2JO1M1hIb19YRvsyc1s94BgiI=;
 b=nQns0QcnvgprMmSFmKg5ZouU0gP9psSbjKFL8wMX043yaIIxFUSa+x42/W8Vi186Yl
 SRXMAtZr1bmPw0Qidze+ppB6RniA2CNcoVR9vPYjOeW0bHCxWls4tUFK2D9ePcQetXCB
 FOU4M1uR8G1KRunwrsbroZyQPvPkMGLb+J4z6zkehHfHvzLPB1RDfViqCOPlXSpCtQtJ
 3iGcWYE3uVSDkd1WVK5TkDw1Dywp5XvPE7pCa6AihtXPWPZLXnAlOwOMgMQCQgIYNIZx
 MwSG6N1wSkv5c5qXRfSXZcmXYA2hbHJmd79TS+8afu9FUXDfPoGeSdolSONgzxfh4ak5
 4/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IA9jQ8jl+c2/RuKmRF2JO1M1hIb19YRvsyc1s94BgiI=;
 b=Iaiapthzel2jBkvRrMdQw5xMwC2ArNQI2MifKpUDdfK+Om5kOwGrOE01prjbAFYVRa
 3abCVMNUPFn1+CJWMcvfLhQcD1bOxwGS4/1fGuU78yIi9+2RPYqcA9ysdvKxsF9AeT8l
 xnjq7Xy0vE/dVQsZKBZ2FqxcKOco/p9K26yPM9H43pDFhvYNvF+CM45ZvU0p/BXgn+Ff
 9K4+vpD0lvZ8yMydJf9ciMro6cxvXimLhoPZcTG/6oth3SNxUaVRaFVImYYRqrA6Pi0M
 T8mKiO+LoDhUQ17/+mhzQhTAnIMz7cS+24uXK1x1I0b4qasxHAuY3MJhdgDvZntaERCF
 RKrA==
X-Gm-Message-State: APjAAAUNDfNrb25lbeXtFJUAHpCih/TvqZxOriqmqt5r4IBmh0T+HKzX
 roALqN6/h28uynrea7/z635lcg==
X-Google-Smtp-Source: APXvYqx8Y0QnLP6sttdvemxWuSeVTny9+BqnQqqW5MweVjINCO3XuUmU2DlCXCpp564P0mDqpfo8/A==
X-Received: by 2002:a1c:a514:: with SMTP id o20mr4162743wme.149.1562342662369; 
 Fri, 05 Jul 2019 09:04:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d9sm13335588wrb.71.2019.07.05.09.04.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 09:04:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75FCB1FF87;
 Fri,  5 Jul 2019 17:04:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:04:16 +0100
Message-Id: <20190705160421.19015-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH for 4.1 0/5] tcg tests and gdbstub fixes
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

A small selection of clean-up patches covering failing tests and
gdbstub.

The following patches need review
 patch 0002/tests tcg fix up test i386 fprem.ref generation.patch
 patch 0003/tests tcg fix diff out pass to properly report fa.patch
 patch 0004/gdbstub add some notes to the header comment.patch

Alex Bennée (4):
  tests/tcg: fix up test-i386-fprem.ref generation
  tests/tcg: fix diff-out pass to properly report failure
  gdbstub: add some notes to the header comment
  gdbstub: revert to previous set_reg behaviour

Philippe Mathieu-Daudé (1):
  target/arm/vfp_helper: Call set_fpscr_to_host before updating FPSCR
    reg

 gdbstub.c                      | 24 ++++++++++++++++++------
 target/arm/vfp_helper.c        |  4 ++--
 tests/tcg/Makefile             |  6 +++++-
 tests/tcg/i386/Makefile.target |  4 ++--
 4 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.20.1


