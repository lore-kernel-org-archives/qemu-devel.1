Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF91C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBE820658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCzi2gOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBE820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Ss7-0004P1-8F
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sqh-0002qO-Nc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sqe-0001vA-1e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:10 -0400
Received: by mail-pg1-x541.google.com with SMTP id j21so11792909pgi.9
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=V9nJrsd8JiF+VgbSMGAG3E/1ioxtLa3h0cElJSac/HA=;
 b=eCzi2gOLnRb4jN0Jbdbsff625hwbR3Tbc4o/Q04zY9C8Jz7QyM6ABnDGw1LtSp8ump
 8y99W6ZaBsW9qQRmhZDr3tuUQ6SruLRHeBQFzHv+2iKMOHA47kSlxAkrwK6ppwR9l69r
 /7Bo/in3ANMDO0XAYnvMBUfSkVowUW2BUmdQDWH5P43yUv0JaCvI9tsz+utJaHp4rNiv
 F5GRMzhP9qk7/6wLa5ytVjebKWARZRBsb4IThFLN2NfrIHcmGdLj9S4ji86tckjdpvla
 O3+hbywCBdH9OROQwlUbD0UWzeTxLEkSNbj/D9k0UqHuqjzXTBMq1gsCmGOcyq19cSAR
 7vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=V9nJrsd8JiF+VgbSMGAG3E/1ioxtLa3h0cElJSac/HA=;
 b=R/ORxCkHTEYkYyP3VhSFNe7yGPK2rDz7bV6ubez+tEGlU8Qg460Xlehp0zUdbbJOMa
 X3kRMg6eS/76EAYfoVpVM3nPDEDaQ8IEWn6B/vTPZHoyyuBkK47xXUSzmM1iNjVZma4F
 izm6Jh39UComlueYP3Hp/hTiV0JflFTvuF5yLN+gKCwo99FW+D3u5yDIoZ9iNZF32O+j
 XXzbMuTBEI2MSsVMX67aaDaV4dm/U7m6dx+1DizsjKxgDARvbqI63Yp+XG//Pe2b0sbF
 17bij+JTeCF7ZUmeUpOfikyBwVqRhQMfkWmOiSjjSPs8Blyjcpkwi+zhpblgyjtBqQJ5
 YGwQ==
X-Gm-Message-State: AOAM533pt0DDIzJ8ffx6zUGZLDyXQYt2noq2OadcWXT498AAZDAb6A8f
 gU0xTBAHEoih15F281al/sVu1JWi99Eeco0r
X-Google-Smtp-Source: ABdhPJzPBbhswtDn5AHjXr8ie/fPILYgAUqCAD7575zlnOI2ab+ar3zfLMbMgvs7jEFaPfHB4FForg==
X-Received: by 2002:aa7:9813:: with SMTP id e19mr20211458pfl.285.1597861804845; 
 Wed, 19 Aug 2020 11:30:04 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:04 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] accel/tcg: remove implied BQL from
 cpu_handle_interrupt/exception path
Date: Wed, 19 Aug 2020 14:28:49 -0400
Message-Id: <20200819182856.4893-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>,
 Marek Vasut <marex@denx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, robert.foley@linaro.org,
 Michael Rolnik <mrolnik@gmail.com>, pbonzini@redhat.com,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 peter.puhov@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this change is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

The BQL is a bottleneck in scaling to more cores.
And this cpu_handle_interrupt/exception path is one of
the key BQL users as measured by the QEMU sync profiling (qsp).

As the first step in removing the BQL from this path, we will make
changes to the core/common functions of cpu_handle_interrupt/exception
to drop the holding of the BQL. The holding of the BQL is pushed down
to the per-arch implementation code.

This patch goes through several transitions of the code in order to
maintain correctness (bisectability).  In order to maintain
bisectability across these steps some patches need to touch many
files across different arches, however most of the changes are trivial.

The general order of the changes is below where each step
represents one patch.

1) rename all *_do_interrupt functions to *_do_interrupt_locked

2) add a new function *_do_interrupt that takes the BQL and calls
*_do_interrupt_locked, point ->do_interrupt to it, and remove 
the BQL from cpu-exec.c's cpu_handle_exception.

3) modify the BQL critical sections around
->cpu_exec_interrupt, so that the BQL critical section covers just the
call to ->cpu_exec_interrupt. 

4/5) same as 1/2 for ->cpu_exec_interrupt.  This removes the BQL
from cpu_handle_exception.

This approach of pushing the BQL down to the per arch functions was
suggested by Paolo Bonzini.
For reference, here are several key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

This patch series is based on the per-CPU locks patch:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05314.html

Our most recent WIP tree is here: 
https://github.com/rf972/qemu/tree/interrupts_v2.7

Robert Foley (7):
  target: rename all *_do_interupt functions to _do_interrupt_locked
  target/arm: add ARMCPUClass->do_interrupt_locked
  target/cris: add CRISCPUClass->do_interrupt_locked
  target: Push BQL on ->do_interrupt down into per-arch implementation
  accel/tcg: Change BQL critical section in cpu_handle_interrupt
  target: rename all *_cpu_exec_interrupt functions to
    *_cpu_exec_interrupt_locked
  target: Push BQL on ->cpu_exec_interrupt down into per-arch
    implementation

 accel/tcg/cpu-exec.c        |  8 +-------
 hw/ppc/spapr_events.c       |  2 +-
 target/alpha/helper.c       | 22 +++++++++++++++++++---
 target/arm/cpu-qom.h        |  3 +++
 target/arm/cpu.c            | 16 +++++++++++++---
 target/arm/cpu.h            |  2 ++
 target/arm/cpu_tcg.c        | 19 +++++++++++++++----
 target/arm/helper.c         | 10 +++++++++-
 target/arm/m_helper.c       |  2 +-
 target/avr/helper.c         | 27 ++++++++++++++++++++++-----
 target/cris/cpu-qom.h       |  3 +++
 target/cris/cpu.c           | 11 ++++++-----
 target/cris/cpu.h           |  3 ++-
 target/cris/helper.c        | 35 ++++++++++++++++++++++++++---------
 target/hppa/int_helper.c    | 22 +++++++++++++++++++---
 target/i386/seg_helper.c    | 20 ++++++++++++++++++--
 target/lm32/helper.c        | 22 +++++++++++++++++++---
 target/m68k/op_helper.c     | 22 +++++++++++++++++++---
 target/microblaze/helper.c  | 24 ++++++++++++++++++++----
 target/mips/helper.c        | 22 +++++++++++++++++++---
 target/moxie/cpu.c          |  2 +-
 target/moxie/cpu.h          |  2 +-
 target/moxie/helper.c       |  2 +-
 target/nios2/cpu.c          | 13 +++++++++++--
 target/nios2/cpu.h          |  1 +
 target/nios2/helper.c       | 13 +++++++++++--
 target/openrisc/interrupt.c | 23 ++++++++++++++++++++---
 target/ppc/cpu.h            |  1 +
 target/ppc/excp_helper.c    | 22 +++++++++++++++++++---
 target/ppc/kvm.c            |  2 +-
 target/riscv/cpu_helper.c   | 24 +++++++++++++++++++++---
 target/rx/cpu.h             |  1 +
 target/rx/helper.c          | 22 +++++++++++++++++++---
 target/s390x/excp_helper.c  | 24 ++++++++++++++++++++----
 target/s390x/internal.h     |  1 +
 target/sh4/helper.c         | 25 +++++++++++++++++++++----
 target/sparc/cpu.c          | 13 +++++++++++--
 target/sparc/cpu.h          |  1 +
 target/sparc/int32_helper.c |  9 ++++++++-
 target/sparc/int64_helper.c |  9 ++++++++-
 target/tilegx/cpu.c         | 23 ++++++++++++++++++++---
 target/unicore32/cpu.h      |  1 +
 target/unicore32/helper.c   | 13 +++++++++++--
 target/unicore32/softmmu.c  |  9 ++++++++-
 target/xtensa/exc_helper.c  | 25 +++++++++++++++++++++----
 45 files changed, 476 insertions(+), 100 deletions(-)

-- 
2.17.1


