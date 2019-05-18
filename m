Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3EEC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C264F20873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4FR0k76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C264F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4mz-0002vy-W5
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:14:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dV-0002nw-Gh
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4ao-0002Un-Uk
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:03 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4ao-0002Ta-OE
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:02 -0400
Received: by mail-pg1-x533.google.com with SMTP id c13so4840139pgt.1
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id;
	bh=4VC9fdoah9gPOaYawpacu+qq5CIKFODz7Uj8uZWxwZE=;
	b=d4FR0k76QcCVsdPh3ACXUZcxF70Yq61ZuxhkVhVT0DqWMJ0bVjIvxo6ICfd2Fo5N7t
	cbzltKXH1FgLCPfP5rvlKyrBz9J9+KMUGaS02z3K7MZ++PMLZ3X+hpCyteGoH6g8ZWvt
	VD+F3bzJIaYqb737WJL+w8/0DL0Pw7jGjUpBgeSPYI0g5ORK/z8++ffuFstqsrKINEsM
	bCLqEqGTYrum/ap1G/A03BL+sVLrdw2m4VwDgg4Q5PKFtGvzBBNRPdip0hE+NpkUdCaP
	bD5e7nZhuJlIFwAX1KY56UpVsXa9pnBFtjWgLOOZNrokHLLcCt9IyFqL7V9Nalf+t1iL
	cK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=4VC9fdoah9gPOaYawpacu+qq5CIKFODz7Uj8uZWxwZE=;
	b=I0d0qiM2k0OQ7w+E6BuCbLqLLd8/UJdK11r89PqsaFKegtbIDFDWT7ULjnljqiCzBn
	qvOKLe3xHVx7x1PifNEfJSY686AWsPsdP4cyEAgKbMNF6gfFjYRQukkL7dDns3zoATiq
	U2so0qmyC0IlJfWgpETELv3gALxVDnK2dFTIT1ocfguVsds1/LjUW7/rDmt5g/kRV4Z0
	OMDF/uRfjzDFuG3Bh9dWmz6f6GD9bLjgv8pBwZPcOWPCBcRpwDYZSLLkMI0bD65t2xo8
	NLbOVz/xVae8fVA/pLuH0gJoZM5bhukDwwKJUqlxO79rhP6BvzTHRweZq2afS0tGAcvh
	U/gg==
X-Gm-Message-State: APjAAAU4ldrNnYJSpZrUA3GOxB1Rnh64Hme9Iu05uM5XFSgmiLuy9Dwn
	oVh1puoeBq+fZ3GU+sq4ugccnlnUeko=
X-Google-Smtp-Source: APXvYqwSH89UdNExCpg2oPbdT2xSVv2HDRjVcb69gbznpKd4qjleNz3o6pXVbTzbYE2mkSLM4ttIZQ==
X-Received: by 2002:a62:ac0a:: with SMTP id v10mr70072798pfe.57.1558206121080; 
	Sat, 18 May 2019 12:02:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.01.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:01:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:41 -0700
Message-Id: <20190518190157.21255-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PATCH 00/16] tcg: misc gvec improvments
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for bitsel and cmpsel primitives, which will be
used by target/* patches that I'll post shortly.

Improvements to the i386 and aarch64 backends.

A handfull of bug fixes.

Assert that we haven't forgotten a QEMU_ALIGNED() marker,
by using MOVDQA for x86_64.


r~


Richard Henderson (16):
  tcg/i386: Fix dupi/dupm for avx1 and 32-bit hosts
  tcg: Fix missing checks and clears in tcg_gen_gvec_dup_mem
  tcg: Add support for vector bitwise select
  tcg: Add support for vector compare select
  tcg: Introduce do_op3_nofail for vector expansion
  tcg: Expand vector minmax using cmp+cmpsel
  tcg: Add TCG_OPF_NOT_PRESENT if TCG_TARGET_HAS_foo is negative
  tcg/i386: Support vector comparison select value
  tcg/i386: Remove expansion for missing minmax
  tcg/i386: Use umin/umax in expanding unsigned compare
  tcg/aarch64: Support vector bitwise select value
  tcg/aarch64: Split up is_fimm
  tcg/aarch64: Use MVNI in tcg_out_dupi_vec
  tcg/aarch64: Build vector immediates with two insns
  tcg/aarch64: Allow immediates for vector ORR and BIC
  tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store

 accel/tcg/tcg-runtime.h      |   2 +
 tcg/aarch64/tcg-target.h     |   2 +
 tcg/i386/tcg-target.h        |   2 +
 tcg/tcg-op-gvec.h            |   7 +
 tcg/tcg-op.h                 |   5 +
 tcg/tcg-opc.h                |   5 +-
 tcg/tcg.h                    |   2 +
 accel/tcg/tcg-runtime-gvec.c |  14 ++
 tcg/aarch64/tcg-target.inc.c | 371 ++++++++++++++++++++++++++---------
 tcg/i386/tcg-target.inc.c    | 169 ++++++++++------
 tcg/tcg-op-gvec.c            |  71 ++++---
 tcg/tcg-op-vec.c             | 142 ++++++++++++--
 tcg/tcg.c                    |   5 +
 tcg/README                   |  11 ++
 14 files changed, 620 insertions(+), 188 deletions(-)

-- 
2.17.1


