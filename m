Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BFCC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 04:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4412133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 04:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpcIR5ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4412133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbHAi-00034w-A7
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 00:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbHA1-0002E5-Vt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbHA1-0005zb-1i
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:16:25 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbHA0-0005wx-R3
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:16:24 -0400
Received: by mail-pg1-x543.google.com with SMTP id v9so8421999pgr.13
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 21:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=9ElN7O2V6ogrMWXTuqWDjkdhBhIHlMpRdMcfbCMe8Fc=;
 b=YpcIR5ZKXNCOddvVbK4CxdCQQD5zXyFo7LyrehZf9kvRl3xlz0nuBVw6udGK++eb15
 rmGN0a8jUngvfIBecSsfINSNS4Bb6j9ICwCwo6NRppc9ziiASdQqpEV2MbAtQeeCbYnM
 90R0Sy1RcQcyZtFTrBegorLfgRMjIbzMJm7O/mzTdu4CWOb2pVueSvRgPJpZviQZ3w28
 gPNEc0kt0RPeknX6NAOKQJAQQDrDPlzzt2/yOluLoIsVC0SRmpkwWS9k6epp1EGlSvaC
 V6M67leFH/wFcfUft7+7Sa3YkRN1AAclHxMsqGE+A1fxkERtXXvo9Vca4dBft6vKmZAc
 f0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9ElN7O2V6ogrMWXTuqWDjkdhBhIHlMpRdMcfbCMe8Fc=;
 b=PTCy7hLt+ugRh7ylhnDS/5apNYv2i6Si5MHzdyud5bU7cnW5olS08WPvCrVsX9yyBX
 eYoEmqDL4iqWGcts0LqLPtE/Iowcd+m1JlmigylvcCBBM4tCJ4NjbGQOjRN2eg92Tib4
 YAwQ8IhmpFK/6nACX6Gl6ku9Vs9aa8QUA65MyxWxI/6X81BsDSZQkyVM7RipWkc/bk1Y
 Db6JEgJmsh89l9qIalVJXgjESiFmV3JvKjPmY/R8Y2/HU2gIwz8rpMFz3M+Kh4uPKmQH
 qP9oGSJc45pP1M/ycAVrI8qMxoUu3aGfF2AZznfA0o/DTUeuB5b/nU4i2/Z1o87bsjHF
 G2kQ==
X-Gm-Message-State: APjAAAX2iYd7EgvGzM+27aitJ8SlBLTeBmTouaL00XwlNjYc83/uZFta
 d6Z+SnYjf98p+ekikcUQuCVy3nDaexc=
X-Google-Smtp-Source: APXvYqzWyUSK1owGxRcduGY3Tafea/jyD1NUelredoivnwMa7eeAs9+m/307H2DRwRy/GdSo0QF02Q==
X-Received: by 2002:a63:de53:: with SMTP id y19mr28318456pgi.166.1560399382940; 
 Wed, 12 Jun 2019 21:16:22 -0700 (PDT)
Received: from localhost.localdomain
 (50-247-96-158-static.hfc.comcastbusiness.net. [50.247.96.158])
 by smtp.gmail.com with ESMTPSA id m19sm1301262pff.153.2019.06.12.21.16.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 21:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 21:16:18 -0700
Message-Id: <20190613041619.32102-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 0/1] tcg: queued patch
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

The following changes since commit a050901d4b40092dc356b59912c6df39e389c7b9:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612' into staging (2019-06-12 14:43:47 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190612

for you to fetch changes up to 899f08ad1d1231dbbfa67298413f05ed2679fb02:

  tcg: Fix typos in helper_gvec_sar{8,32,64}v (2019-06-12 21:08:38 -0700)

----------------------------------------------------------------
Fix vector arithmetic right shift helpers.

----------------------------------------------------------------
Richard Henderson (1):
      tcg: Fix typos in helper_gvec_sar{8,32,64}v

 accel/tcg/tcg-runtime-gvec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

