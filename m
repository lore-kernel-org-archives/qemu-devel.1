Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984EEC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A98206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3/2caUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A98206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtRw-0008J9-EW
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:07:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ8-00078z-Km
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ6-0001C1-TA
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQ6-0001BF-H1; Sat, 04 May 2019 08:05:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id m204so739796oib.0;
	Sat, 04 May 2019 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dKw1M5TMrx9RVC+EkDflBIPpLpBXd4MngIdK+jRChiM=;
	b=E3/2caUVfgjUBk22xg5stnPmEdYqB/xSkR0H2hRGkprJj1DzmNo6BGoc5ZTC8W3Vgl
	pWVA90yFOl57Rjrm6Z8RmF4ZDRX4HGRQBfX5gAJVag1jud6h+Iu0ncH0ZX5cvEOQO5K3
	LgmPLZSGWzfdYYpvll/WQWRiSDkEexGeozVtFb4s9LuvA8ai1T5BBZ83fAKrGhzfDC+S
	zewi5BgLQBmSRi/vUaaBtorCVSMGml53Df3b2kreI6qPP1i8Ls0nXfso4kWJNWf/okdi
	KvNWCD3UAMdqxZJntecovtmU7RKTVuTAiX1xlSg2CD6a87+GiAGVgGtakX7Z8xVgxcwY
	KvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=dKw1M5TMrx9RVC+EkDflBIPpLpBXd4MngIdK+jRChiM=;
	b=bxHDA36UBFE8l/bM/z0+T5j8uOsES5Xa1mBN6MLwjEfs273aOlLKOndXhr1dTf36pI
	hKJQQs0uSkYliix2BwnTLU/+YCEESJWkgQr8W1EDK/zU7VestN3WSY7Cyf13SqQ7NLeJ
	LKz31visA6AHLkivWBVQyapu4+VIYx88LJvPEK97nv9iuu4VCe0SX7UuAKX8/8nidq5t
	XK1Sb+oZUzJdKjQTTSLqWCaCzyibVKbGi1XkAeduaDEeF1gTrHSKnzM3AC5+nplh907I
	Rq6DgQH7SHkumo8U+LYZOLQ3E1cOlYX8k8cPfsAZcTAKurmqmgEHt23fmnt9O9eW0NP1
	oJtQ==
X-Gm-Message-State: APjAAAX/k+kRbJVY8wz8oNFSPBWF3+xnv8Kn7S6O/Igzu8aJRM8q+Sa0
	zL/bqSfqHOIDSs6tSmoeAv/E9B1C
X-Google-Smtp-Source: APXvYqx6M7IcWHtRlQ7WEtsXucJFDVE5XjAe+TE6c3zZqhGC36/WsqetahlkWoIQoCpTQtv3Z9yHhw==
X-Received: by 2002:aca:e085:: with SMTP id x127mr2267075oig.66.1556971530650; 
	Sat, 04 May 2019 05:05:30 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:18 -0600
Message-Id: <20190504120528.6389-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: [Qemu-devel] [PATCH 0/9] Assembly coroutine backend and x86 CET
 support
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504120518.ikOlB_48oBNqkHK0Sj5rLaEE7CiA321iR8lkL1tzIxo@z>

*** BLURB HERE ***

Paolo Bonzini (10):
  qemugdb: allow adding support for other coroutine backends
  qemugdb: allow adding support for other architectures
  coroutine: add host specific coroutine backend for 64-bit x86
  coroutine: add host specific coroutine backend for 64-bit ARM
  coroutine: add host specific coroutine backend for 64-bit s390
  configure: add control-flow protection support
  tcg: add tcg_out_start
  tcg/i386: add support for IBT
  linux-user: add IBT support to x86 safe-syscall.S
  coroutine-asm: add x86 CET shadow stack support

 Makefile.target                           |   5 +
 configure                                 |  62 ++++
 include/qemu/cpuid.h                      |   5 +
 linux-user/host/i386/safe-syscall.inc.S   |  19 ++
 linux-user/host/x86_64/safe-syscall.inc.S |  19 ++
 scripts/qemugdb/coroutine.py              | 107 ++----
 scripts/qemugdb/coroutine_asm.py          |  24 ++
 scripts/qemugdb/coroutine_ucontext.py     |  69 ++++
 tcg/aarch64/tcg-target.inc.c              |   4 +
 tcg/arm/tcg-target.inc.c                  |   4 +
 tcg/i386/tcg-target.inc.c                 |  23 ++
 tcg/mips/tcg-target.inc.c                 |   4 +
 tcg/ppc/tcg-target.inc.c                  |   4 +
 tcg/riscv/tcg-target.inc.c                |   4 +
 tcg/s390/tcg-target.inc.c                 |   4 +
 tcg/sparc/tcg-target.inc.c                |   4 +
 tcg/tcg.c                                 |   2 +
 tcg/tci/tcg-target.inc.c                  |   4 +
 util/Makefile.objs                        |  10 +
 util/coroutine-asm.c                      | 387 ++++++++++++++++++++++
 20 files changed, 689 insertions(+), 75 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_asm.py
 create mode 100644 scripts/qemugdb/coroutine_ucontext.py
 create mode 100644 util/coroutine-asm.c

-- 
2.21.0


