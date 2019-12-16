Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F470C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2790824673
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCs55jqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2790824673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyfG-0001PS-1N
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb1-0004lD-Gz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyay-0006uF-8V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:07 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:37845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyax-0006u5-W0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:04 -0500
Received: by mail-pg1-x52c.google.com with SMTP id q127so4502036pga.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uClweReSFDUrj6phTjOLn2zSfSBOWmvO4yEJytycYg0=;
 b=mCs55jqotoYkQF8ecIu1vTcxFyBTkUKWeALgKK2Uqw2Jk1Zrhrsv+AkfH13u89ochH
 Kyf1P4R1MuTXyhjIvESwo+lQgzS9WkJgdmVOTZbasLCutctgznABLCJrdszAxmjqWgAp
 qhHgmQJq6P1WZiLLGd3fgiVJnCgHKly+BnqGeHslVuCdCxT1P3hTB7M91v5RI5jg9FYj
 dzK66OKQ71p7aGJEHlfYgGNGP1GjNvTIQV0pi5lQRJB7L3CV05RVOdaBjAMMrpmtZLH8
 9dr7igxp1A6gmKJjjPJT8qlTIP6VdNVgXVjBr2cG7fubUtpY/0+TfltQGwd2vETbijYP
 IRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uClweReSFDUrj6phTjOLn2zSfSBOWmvO4yEJytycYg0=;
 b=eJ8KQHVRQUxz6ZulGToVA0GaNexZecw1LcCtY1N3+bb49ur8y9Ppb04B1HRHEqkGal
 ZlowwtKL8VuJ63MqY8lQhSNRoXcSJW248cB4qKPTKA14i73DQrPihS2geWQR8wIZvDYT
 KwrO/HjhxHosTe6LY1hyNJqAgIyHrxI+oW5a1yf/ityKHLP9quAV1QaCkhyGBo+WOsnK
 78NvK3h0WG+2H3SGORv4jjUtm/TN3l+fFK06firtUFljQKtoG/mGYNuboheoex1G169O
 t6inUYTskU8imcVr66M0/7C2fa2kbKR7zH9k5HFqo+OCpKmwPmU1bixqsF0F8Gz+wY1P
 WYCw==
X-Gm-Message-State: APjAAAXYlY+y+3ZupTij2wA3FD7n+OY2/+cdnb/mqu153JWYLOsT01aw
 8P4TcyuFGQ05gjtm8mZaPoMG6YZwp28=
X-Google-Smtp-Source: APXvYqzvqKd9p2ZPBNGVxkIl5ssU9AyETLattr9nm30BDZbmlyLIdagAIHxk0DTPe8eFjqHZrc7qFA==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr19275148pfn.202.1576534322153; 
 Mon, 16 Dec 2019 14:12:02 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/28] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Mon, 16 Dec 2019 12:11:30 -1000
Message-Id: <20191216221158.29572-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a project to raise the limit on NB_MMU_MODES.

One of those is in cpu_ldst.h, in support of MMU_MODE*_SUFFIX.
While this could be extended, it's not the best interface for
such things.  Better is a single interface that allows a variable
mmu_idx.  The best exemplars of that is the usage in target/mips
and target/ppc.

In the process, I tried to clean up the implementation of these
functions for softmmu and user-only.

Aleksander asked about code size changes.  They vary between
a minor size increase (e.g. for qemu-system-alpha, where there
are in fact no uses of the functions, which are now present as
out-of-line functions rather than eliminated inline functions),
to a minor size decrease (e.g. -79k/-1.6% for qemu-system-i386).
See below for details.

Changes for v2:
  * Significantly revised docs/devel/loads-stores.rst.
  * m68k and s390x dropped #defines and use *_mmuidx_ra directly.


r~


Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: David Hildenbrand <david@redhat.com>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Marek Vasut <marex@denx.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>


Richard Henderson (28):
  target/xtensa: Use probe_access for itlb_hit_test
  cputlb: Use trace_mem_get_info instead of trace_mem_build_info
  trace: Remove trace_mem_build_info_no_se_[bl]e
  cputlb: Move body of cpu_ldst_template.h out of line
  translator: Use cpu_ld*_code instead of open-coding
  cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
  cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
  target/i386: Use cpu_*_mmuidx_ra instead of templates
  target/s390x: Include tcg.h in mem_helper.c
  target/arm: Include tcg.h in sve_helper.c
  accel/tcg: Include tcg.h in tcg-runtime.c
  linux-user: Include tcg.h in syscall.c
  linux-user: Include trace-root.h in syscall-trace.h
  cputlb: Expand cpu_ldst_useronly_template.h in user-exec.c
  target/nios2: Remove MMU_MODE{0,1}_SUFFIX
  target/alpha: Remove MMU_MODE{0,1}_SUFFIX
  target/cris: Remove MMU_MODE{0,1}_SUFFIX
  target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
  target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
  target/sh4: Remove MMU_MODE{0,1}_SUFFIX
  target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
  target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
  target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,1}_SUFFIX
  target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
  target/s390x: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
  target/ppc: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
  cputlb: Remove support for MMU_MODE*_SUFFIX
  cputlb: Expand cpu_ldst_template.h in cputlb.c

 accel/tcg/atomic_template.h               |  67 ++--
 include/exec/cpu_ldst.h                   | 444 +++++++---------------
 include/exec/cpu_ldst_template.h          | 211 ----------
 include/exec/cpu_ldst_useronly_template.h | 159 --------
 include/exec/translator.h                 |  48 +--
 include/user/syscall-trace.h              |   2 +
 target/alpha/cpu.h                        |   2 -
 target/cris/cpu.h                         |   2 -
 target/i386/cpu.h                         |   3 -
 target/m68k/cpu.h                         |   2 -
 target/microblaze/cpu.h                   |   3 -
 target/mips/cpu.h                         |   4 -
 target/nios2/cpu.h                        |   2 -
 target/ppc/cpu.h                          |   2 -
 target/s390x/cpu.h                        |   5 -
 target/sh4/cpu.h                          |   2 -
 target/unicore32/cpu.h                    |   2 -
 target/xtensa/cpu.h                       |   4 -
 tcg/tcg.h                                 |  29 --
 trace/mem-internal.h                      |  17 -
 accel/tcg/cputlb.c                        | 315 +++++++++++----
 accel/tcg/tcg-runtime.c                   |   1 +
 accel/tcg/user-exec.c                     | 236 ++++++++++++
 linux-user/syscall.c                      |   1 +
 target/arm/sve_helper.c                   |   1 +
 target/i386/seg_helper.c                  |  56 +--
 target/m68k/op_helper.c                   |  77 ++--
 target/mips/op_helper.c                   | 182 +++------
 target/ppc/mem_helper.c                   |  11 +-
 target/s390x/mem_helper.c                 |  22 +-
 target/xtensa/mmu_helper.c                |   5 +-
 docs/devel/loads-stores.rst               | 215 ++++++++---
 32 files changed, 966 insertions(+), 1166 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h
 delete mode 100644 include/exec/cpu_ldst_useronly_template.h

-- 
2.20.1


orig    new
text    text
size    size    change  %change binary
------- ------- ------- ------- -----------------
2097672	2101864	4192	0.20%	qemu-aarch64
2102760	2107304	4544	0.22%	qemu-aarch64_be
961464	965960	4496	0.47%	qemu-alpha
1463736	1468200	4464	0.30%	qemu-arm
1470072	1474632	4560	0.31%	qemu-armeb
990584	995224	4640	0.47%	qemu-cris
1009656	1012792	3136	0.31%	qemu-hppa
1295728	1250064	-45664	-3.52%	qemu-i386
1091560	1091928	368	0.03%	qemu-m68k
965720	970232	4512	0.47%	qemu-microblaze
961000	965496	4496	0.47%	qemu-microblazeel
1959864	1957224	-2640	-0.13%	qemu-mips
2001688	2003768	2080	0.10%	qemu-mips64
1996184	1998232	2048	0.10%	qemu-mips64el
1954648	1951928	-2720	-0.14%	qemu-mipsel
2004936	2006888	1952	0.10%	qemu-mipsn32
1999272	1999320	48	0.00%	qemu-mipsn32el
933400	937896	4496	0.48%	qemu-nios2
964024	969176	5152	0.53%	qemu-or1k
1643400	1643272	-128	-0.01%	qemu-ppc
1670168	1669192	-976	-0.06%	qemu-ppc64
1693048	1691784	-1264	-0.07%	qemu-ppc64abi32
1667880	1667080	-800	-0.05%	qemu-ppc64le
973416	978024	4608	0.47%	qemu-riscv32
970664	975112	4448	0.46%	qemu-riscv64
1176952	1159928	-17024	-1.45%	qemu-s390x
970600	974808	4208	0.43%	qemu-sh4
975368	979656	4288	0.44%	qemu-sh4eb
981992	986424	4432	0.45%	qemu-sparc
1020168	1024008	3840	0.38%	qemu-sparc32plus
1022264	1026072	3808	0.37%	qemu-sparc64
926616	930872	4256	0.46%	qemu-tilegx
1300464	1249504	-50960	-3.92%	qemu-x86_64
1236648	1240952	4304	0.35%	qemu-xtensa
1241896	1246360	4464	0.36%	qemu-xtensaeb

orig    new
text    text
size    size    change  %change binary
------- ------- ------- ------- -----------------
6324680	6327256	2576	0.04%	qemu-system-aarch64
3961000	3966200	5200	0.13%	qemu-system-alpha
5580408	5583768	3360	0.06%	qemu-system-arm
2816936	2822072	5136	0.18%	qemu-system-cris
3969576	3971624	2048	0.05%	qemu-system-hppa
4856824	4777432	-79392	-1.63%	qemu-system-i386
2936584	2940984	4400	0.15%	qemu-system-lm32
3010216	3002088	-8128	-0.27%	qemu-system-m68k
2817400	2822264	4864	0.17%	qemu-system-microblaze
2817160	2821912	4752	0.17%	qemu-system-microblazeel
5098264	5101288	3024	0.06%	qemu-system-mips
5205096	5206408	1312	0.03%	qemu-system-mips64
5222424	5223704	1280	0.02%	qemu-system-mips64el
5094216	5097048	2832	0.06%	qemu-system-mipsel
2729320	2733448	4128	0.15%	qemu-system-moxie
2750200	2755048	4848	0.18%	qemu-system-nios2
2777656	2782840	5184	0.19%	qemu-system-or1k
5020408	5018312	-2096	-0.04%	qemu-system-ppc
5401848	5396936	-4912	-0.09%	qemu-system-ppc64
4029464	4034520	5056	0.13%	qemu-system-riscv32
4030632	4035320	4688	0.12%	qemu-system-riscv64
3576984	3523992	-52992	-1.48%	qemu-system-s390x
3952872	3958376	5504	0.14%	qemu-system-sh4
3957032	3962680	5648	0.14%	qemu-system-sh4eb
3003368	3009048	5680	0.19%	qemu-system-sparc
4013240	4018040	4800	0.12%	qemu-system-sparc64
2936472	2923080	-13392	-0.46%	qemu-system-tricore
2824456	2829560	5104	0.18%	qemu-system-unicore32
4886520	4816088	-70432	-1.44%	qemu-system-x86_64
4160168	4165400	5232	0.13%	qemu-system-xtensa
4164232	4169528	5296	0.13%	qemu-system-xtensaeb


