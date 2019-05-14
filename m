Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16CC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C28B21707
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wS895mmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C28B21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLDA-0006nG-NF
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:22:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL4T-0002wt-QQ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKx3-0002yl-5c
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:44554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKx1-0002pZ-0E
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:05:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id d3so7261622plj.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ZQ1YDg+Qzl3mKc/BMIpSQ76NdqfcVhEXxXk6ITX6eLg=;
	b=wS895mmgTSDOnEYCyqjes1sBOj244tVFOU/M7mqyTUOPmnTIsASL1eyGsOpsDXsGJ7
	EOsDBMSKupoddTDcLIjF0CwnwLLwfZmF+qLnVsvsWhOu8gKzR5ydPBpzxgB2Z4zqt7G3
	aaO0o77FTzRRJhxPFhumw9LWkhyBXV2bv2pOGb68xqTyFxglXSrpr0jLBIbwEkpjR7k0
	0Mklb9XxvPfPIbSYqdVpT2JsmQpCWSqPRUcBtJ6f1W5CGzIk4Vn2wCOAErzqM4ed8j6Y
	vJDmUkPW7LgpfG2GYbmuz32F2IHVe7FazyBfNEi82FAaCZFxXzKnctULXRTpJrb1xLpI
	48nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ZQ1YDg+Qzl3mKc/BMIpSQ76NdqfcVhEXxXk6ITX6eLg=;
	b=EqanK9i7K/15mhYvVTHoyO7KxuyemSR1zSHs8VeI2rDTIGx1yg+xz7CrOXzp+h1C9u
	PY6B3ERs9WhpkcbGEwpQBYX681YnBSOrqcvBI/m9pTtQO8Lb55yrf/CzpYPiooUE/D47
	uMKOUfhYzgFWNaUnT95SuUounll8EVnqQPKMQjngF1DuKiTrjU6SMoT2dbRED9d2MqqI
	tjqbtsuKPWvn2+Eo1ZvI3/lOMj4mx9PROI13FcVzPByEOAa4OqavrPQojsP/waOwgqNH
	+xNkY1+WLY5iGrkYkW0H5/3PuqJ6R+TJKs2+yC/yf6rgB4XDG9nbYpVaSyPKuSDpu1ka
	k41w==
X-Gm-Message-State: APjAAAVAAa7WIRIjqSTNBuJ3p36Etk9Y+YX0txFDIqfAM0DtMg/GGnOv
	fyZvIXGjOKMHSOjXMAvVjUOVJxF/fFE=
X-Google-Smtp-Source: APXvYqyqkH2/ErF6itAGLfQ83ec+ld1D9u+LYDO0D1lOIQvFbyNUUx71HwRFuG+yjsyaZ9TTaPdMhA==
X-Received: by 2002:a17:902:b202:: with SMTP id
	t2mr33523947plr.69.1557792343156; 
	Mon, 13 May 2019 17:05:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:09 -0700
Message-Id: <20190514000540.4313-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::630
Subject: [Qemu-devel] [PULL 00/31] tcg: gvec improvments
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of these patches are in support of David's guest vector
patches for target/s390x.


r~


The following changes since commit e24f44dbeab8e54c72bdaedbd35453fb2a6c38da:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-05-13' into staging (2019-05-13 16:52:56 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190513

for you to fetch changes up to a7b6d286cfb5205b9f5330aefc5727269b3d810f:

  tcg/aarch64: Do not advertise minmax for MO_64 (2019-05-13 22:52:08 +0000)

----------------------------------------------------------------
Improve code generation for vector duplication.
Add vector expansions for shifts by non-constant scalar.
Add vector expansions for shifts by vector.
Add integer and vector expansions for absolute value.
Several patches in preparation for Altivec.
Bug fix for tcg/aarch64 vs min/max.

----------------------------------------------------------------
David Hildenbrand (1):
      tcg: Implement tcg_gen_gvec_3i()

Philippe Mathieu-Daudé (2):
      target/ppc: Use tcg_gen_abs_i32
      target/tricore: Use tcg_gen_abs_tl

Richard Henderson (28):
      tcg: Do not recreate INDEX_op_neg_vec unless supported
      tcg: Allow add_vec, sub_vec, neg_vec, not_vec to be expanded
      tcg: Specify optional vector requirements with a list
      tcg: Assert fixed_reg is read-only
      tcg/arm: Use tcg_out_mov_reg in tcg_out_mov
      tcg: Return bool success from tcg_out_mov
      tcg: Support cross-class moves without instruction support
      tcg: Promote tcg_out_{dup,dupi}_vec to backend interface
      tcg: Manually expand INDEX_op_dup_vec
      tcg: Add tcg_out_dupm_vec to the backend interface
      tcg/i386: Implement tcg_out_dupm_vec
      tcg/aarch64: Implement tcg_out_dupm_vec
      tcg: Add INDEX_op_dupm_vec
      tcg: Add gvec expanders for variable shift
      tcg/i386: Support vector variable shift opcodes
      tcg/aarch64: Support vector variable shift opcodes
      tcg: Add gvec expanders for vector shift by scalar
      tcg/i386: Support vector scalar shift opcodes
      tcg: Add support for integer absolute value
      tcg: Add support for vector absolute value
      tcg/i386: Support vector absolute value
      tcg/aarch64: Support vector absolute value
      target/arm: Use tcg_gen_abs_i64 and tcg_gen_gvec_abs
      target/cris: Use tcg_gen_abs_tl
      target/ppc: Use tcg_gen_abs_tl
      target/s390x: Use tcg_gen_abs_i64
      target/xtensa: Use tcg_gen_abs_i32
      tcg/aarch64: Do not advertise minmax for MO_64

 accel/tcg/tcg-runtime.h             |  20 +
 target/arm/helper.h                 |   2 -
 tcg/aarch64/tcg-target.h            |   3 +-
 tcg/aarch64/tcg-target.opc.h        |   2 +
 tcg/i386/tcg-target.h               |   5 +-
 tcg/tcg-op-gvec.h                   |  64 ++-
 tcg/tcg-op.h                        |  14 +
 tcg/tcg-opc.h                       |   2 +
 tcg/tcg.h                           |  21 +
 accel/tcg/tcg-runtime-gvec.c        | 192 ++++++++
 target/arm/neon_helper.c            |   5 -
 target/arm/translate-a64.c          |  41 +-
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 144 +++---
 target/cris/translate.c             |   9 +-
 target/ppc/translate.c              |  68 +--
 target/ppc/translate/spe-impl.inc.c |  14 +-
 target/ppc/translate/vmx-impl.inc.c |   7 +-
 target/s390x/translate.c            |   8 +-
 target/tricore/translate.c          |  27 +-
 target/xtensa/translate.c           |   9 +-
 tcg/aarch64/tcg-target.inc.c        | 121 ++++-
 tcg/arm/tcg-target.inc.c            |   5 +-
 tcg/i386/tcg-target.inc.c           | 163 ++++++-
 tcg/mips/tcg-target.inc.c           |   3 +-
 tcg/optimize.c                      |   8 +-
 tcg/ppc/tcg-target.inc.c            |   3 +-
 tcg/riscv/tcg-target.inc.c          |   5 +-
 tcg/s390/tcg-target.inc.c           |   3 +-
 tcg/sparc/tcg-target.inc.c          |   3 +-
 tcg/tcg-op-gvec.c                   | 945 ++++++++++++++++++++++++++++++------
 tcg/tcg-op-vec.c                    | 270 ++++++++++-
 tcg/tcg-op.c                        |  20 +
 tcg/tcg.c                           | 271 +++++++++--
 tcg/tci/tcg-target.inc.c            |   3 +-
 tcg/README                          |   4 +
 36 files changed, 2020 insertions(+), 473 deletions(-)

