Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB0C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02852217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlD0cDps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02852217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvlUx-000691-5R
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 12:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTe-0004Sm-BN
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTc-0007S9-T1
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvlTc-0007Qz-MG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id e8so4079891wme.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PByY6aE1r1PmQACqLQNXAt7diARYnx0F27haLHd5obY=;
 b=wlD0cDpsLlKcygxrY0W9nuqKDj0tkHDrtmn2n+k6B9G9ZboX/TIRa+ziv1332tMvoA
 6bCJn3C0js/HXeGYjJRXrX6uxK6K4JeuGMCfCS/Dz3u38jBIuzQ8jV1daOU+xPF3YvZH
 jjSP9lgvFjis0uLEmBrXqs3qhuzZh5hhWLXGCZnCYXx1wpFH9i2gvmojDg0Vdxhbvq41
 MeZ/KunKvEcgqeGAdpaMML1+FtaVObFXPEwKA27Qj1Zr7imf3goSP0XAkZ5lhc6H5KB0
 SpZmNGT0nwrPoKiRgneDtFrjgrWjU3JN7cASA9GHc/tEuEv0I7DIJjfnDfQyBHsCuqY9
 c2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PByY6aE1r1PmQACqLQNXAt7diARYnx0F27haLHd5obY=;
 b=rpw88tqPt7wDiLcdmCLmR7qM5RMo/evTEBJ7ouVBf46Ve17M0BOxG8i33gyutDdhJ5
 qpKRG3K+XDm+EdtGE7rvmQLWVBZESPDbmnIbCNuHUEB0Fecr0mnaie+3Sxc4uG9aIUsm
 iOeqco+7NxXjWjYJMvAmyVd+LwUXtS76HaOh2xZ1lquyjqfxTkKA+HAQzS1+0iMNYI0X
 vaeOLomvffwOBpgy4pFF5D7FFD+/IHgV4DFJgLyk4YHGaRrB+Nn4r0kdt2DJQIoSWKA2
 9FZZe4O/XW7I1/bz4rdf6gMA7DFhp8HTQhQ8gczvw4ZSBpgBY5/5jQV6y+nh7lED071Y
 DALw==
X-Gm-Message-State: APjAAAXH8gjZhK91h76Mpl6k7eDdb+FLmMnYGrF/aHLigtRNMiA8LujO
 LokUefV2qiHIhhJAUY9C3qIhzQ==
X-Google-Smtp-Source: APXvYqy2qIyFuB5FxhsZfJQ4wwUMRRefYgkRo0448/1s2HJpeoNdvCh8snO3LQc7zRSEGpzm/sz7cQ==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr2805230wmb.60.1565282479140;
 Thu, 08 Aug 2019 09:41:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t15sm83982626wrx.84.2019.08.08.09.41.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 09:41:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 101101FF87;
 Thu,  8 Aug 2019 17:41:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 17:41:10 +0100
Message-Id: <20190808164117.23348-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH  v1 0/7] softfloat header cleanups
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

As promised here is a softfloat specific follow-up to your headers
clean-up series:

  From: Markus Armbruster <armbru@redhat.com>
  Date: Tue,  6 Aug 2019 17:14:06 +0200
  Message-Id: <20190806151435.10740-1-armbru@redhat.com>
  Subject: [Qemu-devel] [PATCH v2 00/29] Tame a few "touch this, recompile the world" headers

The first few patches do a little light re-organising of the header
files and some renaming. The remaining patches then rationalise the
header usage in the targets mostly by removing the inclusion of
softfloat.h from cpu.h which is most likely to trigger the largest
number of rebuilds.

I'm happy for you to pull these straight into your larger series if
you want otherwise I'll collect tags and submit once the tree
re-opens.

Alex Bennée (7):
  fpu: move LIT64 helper to softfloat-types
  fpu: move inline helpers into a separate header
  fpu: make softfloat-macros "self-contained"
  fpu: rename softfloat-specialize.h -> .inc.c
  target/mips: rationalise softfloat includes
  target/riscv: rationalise softfloat includes
  targets (various): use softfloat-helpers.h where we can

 ...pecialize.h => softfloat-specialize.inc.c} |   0
 fpu/softfloat.c                               |   2 +-
 include/fpu/softfloat-helpers.h               | 118 ++++++++++++++++++
 include/fpu/softfloat-macros.h                |   2 +
 include/fpu/softfloat-types.h                 |   2 +
 include/fpu/softfloat.h                       |  65 +---------
 target/alpha/helper.c                         |   2 +-
 target/microblaze/cpu.c                       |   2 +-
 target/mips/cpu.h                             |   3 +-
 target/mips/msa_helper.c                      |   1 +
 target/mips/op_helper.c                       |   1 +
 target/riscv/cpu.c                            |   1 +
 target/riscv/cpu.h                            |   2 +-
 target/riscv/fpu_helper.c                     |   1 +
 target/s390x/cpu.c                            |   2 +-
 target/sh4/cpu.c                              |   3 +-
 target/tricore/helper.c                       |   2 +-
 target/unicore32/cpu.c                        |   1 -
 18 files changed, 136 insertions(+), 74 deletions(-)
 rename fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} (100%)
 create mode 100644 include/fpu/softfloat-helpers.h

-- 
2.20.1


