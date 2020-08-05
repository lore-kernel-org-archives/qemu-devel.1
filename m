Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E851CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23E52084D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bplCDNbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23E52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3NzS-0004oQ-56
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyI-0003YZ-D0
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:43260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyG-0006QC-DF
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id y206so12926672pfb.10
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=dq3GvKctsAmqyIzIi3C1iw6FGeURXVH1wQzj+QQMI2Y=;
 b=bplCDNbcCDOQF6exySUwLOezuuMtf+F3pdtNdVXfpRZmtspzisbnw9TANuq0voG0VG
 trvzKxEv5qcdLiACyZ5mpOaHO/rEEm5x5cLntLe1xe512KUWi6tz3+uE9QUhJ3Bwa7Ic
 4s9YBlOGbgkT9XYyjuUVOo0Fp1S/cb4HD3S6fBmkLnUaxszwW0+BrgAY6BIKtzJ54u4y
 KXcQ3R791MFM5FlxsC0zEdO1d0UlVyZVCcE9jnVkHY4nRsDDlg9CIROSIc5leofVVlnA
 5gnyoRaztYJFJxJ0U/oILjrpkaMMQJuZP34GMeX3Po+2F+erHWyVeLxZm9rzpGTETjri
 4Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dq3GvKctsAmqyIzIi3C1iw6FGeURXVH1wQzj+QQMI2Y=;
 b=ErXpU5KqcYFhttadE0gbMcd8RHDkungde7QMwtaU1X0Dj64L94lz6STq1eBLAzXhOs
 neYwF/N0VbjTdGLIsWUdPFlbwL8ujbtRqT1UFGI5kTll9ZdVKu86V2wsGQ70zkzXf116
 xEsx3iPNLPpZyfa9EDIIex9GFCZ1w3oAh59qq1d9IWpzg471pQIcUENOMgSAEK4sWEcO
 OXsGR+AMDVFlWrWZPq0zVwTfHq8pZx2YfR0E/bXgOKbC1MFsAq/l3b5XLuN9mM64OViy
 YH4ill+SYZcajk9ElTWbULFrE6M26H1onYahXHIfI7KbQJL8e4TLb1AZFBFeKYPs5BJQ
 tdeg==
X-Gm-Message-State: AOAM533LdUjDvb++cdlIsflpRgaf+PpIkjUxQXZOimFXTwggAs+tT7QG
 frrPru4kaW4gzFUuyHwn1Iu3r5U2c4s=
X-Google-Smtp-Source: ABdhPJytgaxS1kzdtWYinlA4YVyQ4v6DshX7HNwt77kkKLh3Msksctxzb9+IwCmLDQqvovz0uId45A==
X-Received: by 2002:a62:7c4f:: with SMTP id x76mr4806195pfc.124.1596651417914; 
 Wed, 05 Aug 2020 11:16:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:16:56 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/21] accel/tcg: remove implied BQL from
 cpu_handle_interrupt/exception path
Date: Wed,  5 Aug 2020 14:12:42 -0400
Message-Id: <20200805181303.7822-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this change is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

The BQL is a bottleneck in scaling to more cores.
And this cpu_handle_interrupt/exception path is one of
the key BQL users as measured by the QEMU sync profiling (qsp).

We have chosen to break up the process of removing
BQL from this path into two pieces:

1) Changes to the core/common functions of cpu_handle_interrupt/exception
   to drop the holding of the BQL. The holding of the BQL is pushed down
   to the per-arch implementation code.
   This set of changes is handled in this patch.

   This approach of pushing the BQL down to the per arch functions was
   suggested by Paolo Bonzini.
   For reference, here are two key posts in the discussion, explaining
   the reasoning/benefits of this approach.
   https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
   https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

2) Removing the BQL from the per-arch functions.
   Since the arch now has the code that grabs the BQL, each arch can
   change its use of the BQL for interrupts independently.
   We leave it up to the arch to make the change at the time that makes sense.

It is worth mentioning that we are working on per-arch changes
in line with 2), and plan to submit these.
In other words, we plan to set the groundwork with this
patch series and then will take advantage of it in later series.

This patch series is based on the per-CPU locks patch:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05314.html

Robert Foley (21):
  accel/tcg:  Change interrupt/exception handling to remove implied BQL
  target/alpha: add BQL to do_interrupt and cpu_exec_interrupt
  target/arm: add BQL to do_interrupt and cpu_exec_interrupt
  target/avr: add BQL to do_interrupt and cpu_exec_interrupt
  target/cris: add BQL to do_interrupt and cpu_exec_interrupt
  target/hppa: add BQL to do_interrupt and cpu_exec_interrupt
  target/i386: add BQL to do_interrupt and cpu_exec_interrupt
  target/lm32: add BQL to do_interrupt and cpu_exec_interrupt
  target/m68k: add BQL to do_interrupt and cpu_exec_interrupt
  target/microblaze: add BQL to do_interrupt and cpu_exec_interrupt
  target/mips: add BQL to do_interrupt and cpu_exec_interrupt
  target/nios2: add BQL to do_interrupt and cpu_exec_interrupt
  target/openrisc: add BQL to do_interrupt and cpu_exec_interrupt
  target/ppc: add BQL to do_interrupt and cpu_exec_interrupt
  target/riscv: add BQL to do_interrupt and cpu_exec_interrupt
  target/rx: add BQL to do_interrupt and cpu_exec_interrupt
  target/s390x: add BQL to do_interrupt and cpu_exec_interrupt
  target/sh4: add BQL to do_interrupt and cpu_exec_interrupt
  target/sparc: add BQL to do_interrupt and cpu_exec_interrupt
  target/unicore32: add BQL to do_interrupt and cpu_exec_interrupt
  target/xtensa: add BQL to do_interrupt and cpu_exec_interrupt

 accel/tcg/cpu-exec.c        | 19 +++++++++++--------
 target/alpha/helper.c       | 15 +++++++++++++--
 target/arm/cpu.c            | 13 ++++++++++---
 target/arm/helper.c         | 17 ++++++++++++++++-
 target/avr/helper.c         | 12 +++++++++++-
 target/cris/helper.c        | 18 ++++++++++++++++++
 target/hppa/int_helper.c    | 25 +++++++++++++++++++------
 target/i386/seg_helper.c    |  7 +++++--
 target/lm32/helper.c        | 10 ++++++++++
 target/m68k/op_helper.c     |  5 +++++
 target/microblaze/helper.c  | 20 ++++++++++++++++++++
 target/mips/helper.c        | 10 ++++++++++
 target/nios2/cpu.c          |  3 +++
 target/nios2/helper.c       |  8 +++++++-
 target/openrisc/interrupt.c | 10 ++++++++++
 target/ppc/excp_helper.c    |  5 +++++
 target/riscv/cpu_helper.c   | 10 ++++++++++
 target/rx/helper.c          | 10 ++++++++++
 target/s390x/excp_helper.c  | 12 +++++++++++-
 target/sh4/helper.c         | 13 +++++++++++--
 target/sparc/cpu.c          |  3 +++
 target/sparc/int32_helper.c | 13 ++++++++++++-
 target/unicore32/helper.c   |  3 +++
 target/unicore32/softmmu.c  |  7 +++++++
 target/xtensa/exc_helper.c  |  2 ++
 25 files changed, 242 insertions(+), 28 deletions(-)

-- 
2.17.1


