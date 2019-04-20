Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176FC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA42208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKB88QD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA42208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkYF-0001Jd-Nm
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:36:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWP-0008K7-En
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWO-0007dC-9r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:40779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWO-0007cW-2i
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id c207so3461582pfc.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=28U1yuEjflYiIwbx3DTYg0cUH3EvvcBgSD66F5p8rn4=;
	b=GKB88QD1s8tYdJ3Cp/2B//Yxm0VmYTvWcJa7F55WMwxM7I+9sZoeXYq3SBTGimxN3/
	1aYC0X1mBpV8ZA2AabbLkiT2rnZ9NTV35223V6u4pPz5tCZbreWvQyY3UTRFV/c0mdnY
	zTtZhxAKWMRvhJljvXW7AkFGCHDFlS+1vmoslabxSXVcMkUKATBMxvGhqo/v5qcHcCiT
	/vR8+GKqOLMNSrhUu4RYjlXH+J8BMmwAJpErMsi13bLfl4XLwXu5bRbgZv5EYooNHrTs
	pZMuNgdh4EHKRCspNzRrRzU8BA1uiBRw5RntNL6piBJK8M5WGrPfxhZttV/aKd2nRj6P
	N/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=28U1yuEjflYiIwbx3DTYg0cUH3EvvcBgSD66F5p8rn4=;
	b=KL6t4/KCWQcH/d4iezae7q8o/7RlcHfiyRrNLgwWbMAB6ysAZWx28P4g75JL1lj8xR
	cF9/RKZDutTDHJWIDFoxGla1vl3mFxeYGFyXCYwLDuGBbzKtokfb75wyA637Ur08nHWO
	3xwHyeHrMQrju3YLK443Fi9trTEyWLEH4Fc6dcUUjBcFiSfxUNXphkI1qYNMNlL7fAto
	IEqes5Nm0AIcJB1V4X8XEXBFnDYHp5kzg8iyrscWzFmCxXjmlUuftjLc//LalKNR1mTr
	IVD0sJ04sGoV1OwJ/RqMgwuVYyVISY3vzlDjJILix7wA3xp7pCaxWIzm2cQUjyEsUwO/
	P6Bw==
X-Gm-Message-State: APjAAAXKMBIslUpsLPo68wTFkUA5FZ0BYi+heMc3bIbUxxBYUV/1yEAT
	wBenbERPUiPFyzJ6Nwdo7Gw5YbuVQXo=
X-Google-Smtp-Source: APXvYqzm4Sj5k+jeJa1ztCFgiSeLpYAPI3duIO7lGhmnKZB+Q60/gx4N8cxQvIj5o0HN6C+1ghslNQ==
X-Received: by 2002:a63:6988:: with SMTP id e130mr8150615pgc.150.1555745686082;
	Sat, 20 Apr 2019 00:34:46 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:04 -1000
Message-Id: <20190420073442.7488-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: [Qemu-devel] [PATCH 00/38] tcg vector improvements
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073404.Ac6kU5xVGO0dovn-zuUq1jWq4dUPYdLUGZSq-KyFUu8@z>

Based-on: tcg-next, which at present is only tcg_gen_extract2.

The dupm patches have been on list before, with a larger context
of supporting tcg/ppc.  The rest of the set was written to support
David's s390 vector patches.  In particular:

(1) Add vector absolute value.
(2) Add vector shift by non-constant scalar.
(3) Add vector shift by vector.
(4) Add vector select.
(5) Be more precise in handling target-specific vector expansions.

And then there's a set of bugs that I encountered while working
on this across x86, aa64, and ppc hosts.  Tested primarily with
aa64 as the guest, via RISU.


r~


David Hildenbrand (1):
  tcg: Implement tcg_gen_gvec_3i()

Richard Henderson (37):
  target/arm: Fill in .opc for cmtst_op
  tcg: Assert fixed_reg is read-only
  tcg: Return bool success from tcg_out_mov
  tcg: Support cross-class moves without instruction support
  tcg: Allow add_vec, sub_vec, neg_vec, not_vec to be expanded
  tcg: Promote tcg_out_{dup,dupi}_vec to backend interface
  tcg: Manually expand INDEX_op_dup_vec
  tcg: Add tcg_out_dupm_vec to the backend interface
  tcg/i386: Implement tcg_out_dupm_vec
  tcg/aarch64: Implement tcg_out_dupm_vec
  tcg: Add INDEX_op_dup_mem_vec
  tcg: Add gvec expanders for variable shift
  tcg/i386: Support vector variable shift opcodes
  tcg/aarch64: Support vector variable shift opcodes
  tcg: Specify optional vector requirements with a list
  tcg: Add gvec expanders for vector shift by scalar
  tcg/i386: Support vector scalar shift opcodes
  tcg: Add support for integer absolute value
  tcg: Add support for vector absolute value
  target/arm: Use tcg_gen_abs_i64 and tcg_gen_gvec_abs
  target/cris: Use tcg_gen_abs_tl
  target/ppc: Use tcg_gen_abs_tl
  target/s390x: Use tcg_gen_abs_i64
  target/xtensa: Use tcg_gen_abs_i32
  tcg/i386: Support vector absolute value
  tcg/aarch64: Support vector absolute value
  tcg: Add support for vector comparison select
  tcg/i386: Support vector comparison select value
  tcg/aarch64: Support vector comparison select value
  target/ppc: Use vector variable shifts for VS{L,R,RA}{B,H,W,D}
  target/arm: Vectorize USHL and SSHL
  tcg/aarch64: Do not advertise minmax for MO_64
  tcg: Do not recreate INDEX_op_neg_vec unless supported
  tcg: Introduce do_op3_nofail for vector expansion
  tcg: Expand vector minmax using cmp+cmpsel
  tcg/aarch64: Use MVNI for expansion of dupi
  tcg/aarch64: Use ORRI and BICI for vector logical operations

 accel/tcg/tcg-runtime.h             |  20 +
 target/arm/helper.h                 |  17 +-
 target/arm/translate.h              |   6 +
 target/ppc/helper.h                 |  24 +-
 tcg/aarch64/tcg-target.h            |   4 +-
 tcg/aarch64/tcg-target.opc.h        |   2 +
 tcg/i386/tcg-target.h               |   6 +-
 tcg/i386/tcg-target.opc.h           |   1 -
 tcg/tcg-op-gvec.h                   |  60 +-
 tcg/tcg-op.h                        |  16 +
 tcg/tcg-opc.h                       |   3 +
 tcg/tcg.h                           |  20 +
 accel/tcg/tcg-runtime-gvec.c        | 180 ++++++
 target/arm/neon_helper.c            |  38 --
 target/arm/translate-a64.c          |  59 +-
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 432 ++++++++++---
 target/arm/vec_helper.c             | 176 ++++++
 target/cris/translate.c             |   9 +-
 target/ppc/int_helper.c             |   6 +-
 target/ppc/translate.c              |  80 +--
 target/ppc/translate/vmx-impl.inc.c | 175 +++++-
 target/s390x/translate.c            |   8 +-
 target/xtensa/translate.c           |   9 +-
 tcg/aarch64/tcg-target.inc.c        | 227 ++++++-
 tcg/arm/tcg-target.inc.c            |   7 +-
 tcg/i386/tcg-target.inc.c           | 176 +++++-
 tcg/mips/tcg-target.inc.c           |   3 +-
 tcg/optimize.c                      |   8 +-
 tcg/ppc/tcg-target.inc.c            |   3 +-
 tcg/riscv/tcg-target.inc.c          |   5 +-
 tcg/s390/tcg-target.inc.c           |   3 +-
 tcg/sparc/tcg-target.inc.c          |   3 +-
 tcg/tcg-op-gvec.c                   | 917 +++++++++++++++++++++++-----
 tcg/tcg-op-vec.c                    | 259 +++++++-
 tcg/tcg-op.c                        |  20 +
 tcg/tcg.c                           | 256 ++++++--
 tcg/tci/tcg-target.inc.c            |   3 +-
 tcg/README                          |  16 +
 39 files changed, 2699 insertions(+), 567 deletions(-)

-- 
2.17.1


