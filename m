Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D75C4CECC
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 13:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16ECD214C6
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/WrLhPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16ECD214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Uw8-0004dt-1M
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 09:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9UuY-0003cY-Ga
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9UuW-0003hG-4h
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:39542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9UuV-0003h3-UV
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:52 -0400
Received: by mail-ed1-x533.google.com with SMTP id g12so5109979eds.6
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9GCRTNNXoXA1IxfBNrRaF75J31+JT+3skuWDdylXHTE=;
 b=W/WrLhPEBbLkMj+1U9563/M4OaSAA/HKs/x2rO5YrPumIjmYxn1a/YA6E+j6kY6IQf
 B4vwoezHyz4i6Mq3sjG+AAaUcsaOJIwjsBss34Pjgp0findJvq0wI4TenhyMVTvvlIlx
 JJF2X5/pydrGSoQuilcXp6pHCEN8up5o1WTqHjyBlqQ704EB431ALLzCQWS6AcN77lX2
 wHPW4whioZ62ioLIypvHeTqUwcutAbuH+Pm77KfpVvFSxPfhMyheodvwWihy/XK7pg3v
 OSu9k+I4IIy32AHRcEcSaw+G1d5otJW4KBlhy/xCpsEnwHTNC02oX8ULzf47RNv06d0v
 9AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9GCRTNNXoXA1IxfBNrRaF75J31+JT+3skuWDdylXHTE=;
 b=Qz6s2yBnov0WWYjpyzN+VaoonvUWrYUFEEskmEbFemXPn9zZER3whLOwd2iefyN2Ex
 HQFiONgvnnWUkD2PIW1B33ZzGaIckoI4CcHiBKUmB05Tm6ugRDbFb5A5uDuJ68Ir1sig
 Q4K6PfSFYxBXu3E3WsV8nWjfn0yPxsXZD5OnPXgFTP5VmHoXm5vDyJF8v909G1zBjFgD
 8RrJfsEpbDb13T0SgHfFM4V1UXLKZBhk3j3/OtRCwAaojErMc79EjFH/z124KQ+pMGar
 f/bisMXgxd4GUK6hSrJmQB8nZdYoYxWLmBxE9TKL3CAluA6IdCfe+XyfMUPKd+MUe94r
 OUPA==
X-Gm-Message-State: APjAAAXjKjH6K5LlcRCY3tBFRJdcz6D14rGCsNi6oTGeaqRhecIm+H5K
 UkY17idOMamAsCawNn1QaT5IEZ2nBfbquA==
X-Google-Smtp-Source: APXvYqxsBdKTLxmLZzfJLDVdpU55y2iMkWhYq6jnrr/eNLgo8BP6mxEb92lVCxyjpfsLH3PfSpFv6g==
X-Received: by 2002:a50:f00c:: with SMTP id r12mr57592428edl.274.1568555390327; 
 Sun, 15 Sep 2019 06:49:50 -0700 (PDT)
Received: from localhost.localdomain ([185.81.138.17])
 by smtp.gmail.com with ESMTPSA id ot24sm123053ejb.59.2019.09.15.06.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 06:49:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 09:49:42 -0400
Message-Id: <20190915134944.2173-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::533
Subject: [Qemu-devel] [PULL 0/2] target/hppa updates
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

The following changes since commit 85182c96de61f0b600bbe834d5a23e713162e892:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190912a' into staging (2019-09-13 14:37:48 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190915

for you to fetch changes up to a6deecce5b11827fff8a3de2142d02c5388aee1c:

  target/hppa: prevent trashing of temporary in do_depw_sar() (2019-09-14 15:39:24 -0400)

----------------------------------------------------------------
Two temp live across branch fixes.

----------------------------------------------------------------
Sven Schnelle (2):
      target/hppa: prevent trashing of temporary in trans_mtctl()
      target/hppa: prevent trashing of temporary in do_depw_sar()

 target/hppa/translate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

