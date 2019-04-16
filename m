Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E8C282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3323E20870
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fL7F5URT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3323E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJWv-0003QX-7u
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:33:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJVV-0002rv-0a
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJVT-0006Fc-VX
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:56 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:35768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGJVT-0006CT-Ir
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id g8so9991863pgf.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=58c5T72JhXU7KTjU0vC9upc1wTUu8WeZ8Lk/ZdEQRsw=;
	b=fL7F5URT7S2PzMotrVGP45T6fUWcYiPtst6dbAuO2lT5CpGZ3V5p1uZnojRJ1nOiVq
	hfMFrLbM7lkwWs30O/neQ8B4AZUeHCUNfGw7mieckn4CQqUVR0owoWGFb2JTbMZ7G1DY
	bQz8/aKzvvPuF8Onua0pnjsr1tyd1uFe8ZW1YUOcHRtAWDQpbKjRAyVfIEdXhXQBZkTJ
	+daJ+l98DdgRtadlbg0qcEqha1edrxYj/Rg7/5SUPAu+6IDd5QQ0Ffn3tvXRm/AsZI+I
	rZGpYK8n3lCzrAc1gQh2/azkV2b2FvyoPhL+FF8yF0NXU/tddbr3lnVwfLnQuwemFOmG
	hClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=58c5T72JhXU7KTjU0vC9upc1wTUu8WeZ8Lk/ZdEQRsw=;
	b=AzY0KD0vuJbfFbx2cSKDbGuQ+SHHPntNg1OrgDlm9uoTPgrcqJpOx7x1i4gPuv/MJc
	S6CmcP8U/VU+ekczGMa8JRzGiY2bdNxpAT7CCEdCuR7nv7/9dCocYpeuQFyKJGKgPBcI
	CGGkyhszD0KhC3LVC+tdpA8rzjxwGncUHYQCRFJ1ZIf3F6ZWkPyVc8l2GeFfEcmMGzCF
	SRsJ2s4CxiLH4UW3bkuKVtmD8kc4JLWIUvPJcNnpL9uZEk/8tW3aNJv0EnQ+DQm2exO1
	O/pkILsXAF36Kq7FRFdMN2xVLczOFggEvWa2/uvOlVrKqMf6o1td2IvuM7DmV+0NTMHA
	iFWw==
X-Gm-Message-State: APjAAAVok55CJfLMJ+/91JPupkGLDAH8s8IlOBw1ImVRHDvJVh28yHUk
	cgm8zDdPOn2xZlNrkwd1WRdzxj3yoFU=
X-Google-Smtp-Source: APXvYqzgdCqFi31sBnGHM5UGRXxhNjMgv23amygGvE0Bs4uqlGKltnhsumT4VdFz1F1Nz/v4lFChVQ==
X-Received: by 2002:a63:185a:: with SMTP id 26mr48540170pgy.337.1555403513627; 
	Tue, 16 Apr 2019 01:31:53 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	m23sm76992727pfa.117.2019.04.16.01.31.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 01:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 22:31:48 -1000
Message-Id: <20190416083150.19649-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416083148.l2nXJEQvCsRDAXWHUPqEk_i-ufOJBiIzUvt3Kg5YL5E@z>

This is a case where we generate more than 64k code for a mere 231
guest instructions.  This hits some assertions within TCG that we're
not overflowing the uint16_t that we use for representing our
unwind info.

Fix this by returning an error indication, rather than asserting.
This lets us try again from tb_gen_code with a lower max_insns.

This should resolve the problem for x86 as a host.  There are other
failure modes wrt out-of-range relocations that might affect the
RISC hosts.  I'm going to leave those for a different patch set.


r~


Richard Henderson (2):
  tcg: Hoist max_insns computation to tb_gen_code
  tcg: Restart after TB code generation overflow

 include/exec/exec-all.h       |  4 +--
 include/exec/translator.h     |  3 +-
 accel/tcg/translate-all.c     | 54 +++++++++++++++++++++++++++++------
 accel/tcg/translator.c        | 15 ++--------
 target/alpha/translate.c      |  4 +--
 target/arm/translate.c        |  4 +--
 target/cris/translate.c       | 10 +------
 target/hppa/translate.c       |  5 ++--
 target/i386/translate.c       |  4 +--
 target/lm32/translate.c       | 10 +------
 target/m68k/translate.c       |  4 +--
 target/microblaze/translate.c | 10 +------
 target/mips/translate.c       |  4 +--
 target/moxie/translate.c      | 11 ++-----
 target/nios2/translate.c      | 14 ++-------
 target/openrisc/translate.c   |  4 +--
 target/ppc/translate.c        |  4 +--
 target/riscv/translate.c      |  4 +--
 target/s390x/translate.c      |  4 +--
 target/sh4/translate.c        |  4 +--
 target/sparc/translate.c      |  4 +--
 target/tilegx/translate.c     | 12 +-------
 target/tricore/translate.c    | 16 ++---------
 target/unicore32/translate.c  | 10 +------
 target/xtensa/translate.c     |  4 +--
 tcg/tcg.c                     |  4 +++
 26 files changed, 93 insertions(+), 133 deletions(-)

-- 
2.17.1


