Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D0C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60E7206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHWtrOj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60E7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhT6-0007WP-07
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:07:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRG-0006Kq-FE
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRB-0002ml-Tn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRB-0002mP-N6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id n8so7743370plp.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W7dMLs9xpvO28pv1fCklnXo40vBBPmy9BmzHgMTS02Q=;
	b=RHWtrOj5EckKl8+PDm7/s0jhtr1oSkJpnZM4i9Wq/mgsdfx76X9f1OOHmjtOXxBACe
	NVOxRJXz7jK22L8CuMHZABxvYMQ+oy4TdiX4GcgMYcwqwxS0VoTtBdMeRgyfLQoitpeU
	pW+pbGnnizHu0eGG+jl6Xvlab463f91SCNOgojWfS49dnX9WnERAn/t760iOVtKGE53P
	Rz99yma5y7u1M+D27c35OXC5JzjWX1V9VLLfWWcZinjDxeUjV5ayvFSNPhjV6VgcuO6Q
	u/HXZd1RD+5upCDYqqo96VqKwSskn0JyWQQZk3E4ri8TgqD3F+gBYJFyrGLotjER3p6A
	OsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W7dMLs9xpvO28pv1fCklnXo40vBBPmy9BmzHgMTS02Q=;
	b=Bd9CEiKId1Nqk9BjA1kIaPkCSnHaPLRY3rBDpktCru+CliW7J48OSyaWt6ui0TzPK/
	nhrKl9JwpJpyDnC/5ANuRTZR4vkc300WC1vB9v3NITR4T1iOBA2lST9H/swloc8M3XG5
	scGBdcR2U2zH8fsAnXG/od1vtTt/ED/kgajFT2REJGFlUn4Qx8MRzl+7kg9OkcEHC2mp
	+Q1ukIMu6tFBIfpL9AlT5ezIm5wfJbUkpsn88MfdnVNDUlL4Ep1vUzmxTOioFWfqjIm8
	6T7wIad2Qqs0+wUcn020O69e6RdHhTvLyDQDwv4Q3yYLeanHKfWozth2JnkB2r/+YBzR
	eMyg==
X-Gm-Message-State: APjAAAUrkGPAGYhl2f7tZZBlGecmocOBgRcTETlN38/VEWtq2ID38uYj
	FSlEaaQvzg01HwuRldMuZxHS8vg0ikE=
X-Google-Smtp-Source: APXvYqwp4FhsDUAENvoEbWr3+jZ2JIojJV3dUIGa3CChfwf/cuPa1NrPskA82/qxDlJBpJUj/UL1CA==
X-Received: by 2002:a17:902:b48a:: with SMTP id
	y10mr16166675plr.86.1556687143856; 
	Tue, 30 Apr 2019 22:05:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:07 -0700
Message-Id: <20190501050536.15580-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [PATCH v2 00/29] tcg vector improvements
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
Message-ID: <20190501050507.BLGuttOGC8N2DhpLZkccam_Pl_cWUi9-zJsu-UITYfI@z>

Changes since v1:
  * Postponing vector select.  I plan to re-work that.
  * Postponing some of the target/* changes.  I plan to submit most of
    those separately via the appropriate trees.  The exception is abs(),
    which I'm still doing here.


r~


David Hildenbrand (1):
  tcg: Implement tcg_gen_gvec_3i()

Philippe Mathieu-Daudé (2):
  target/ppc: Use tcg_gen_abs_i32
  target/tricore: Use tcg_gen_abs_tl

Richard Henderson (26):
  tcg: Do not recreate INDEX_op_neg_vec unless supported
  tcg: Allow add_vec, sub_vec, neg_vec, not_vec to be expanded
  tcg: Specify optional vector requirements with a list
  tcg: Assert fixed_reg is read-only
  tcg: Return bool success from tcg_out_mov
  tcg: Support cross-class moves without instruction support
  tcg: Promote tcg_out_{dup,dupi}_vec to backend interface
  tcg: Manually expand INDEX_op_dup_vec
  tcg: Add tcg_out_dupm_vec to the backend interface
  tcg/i386: Implement tcg_out_dupm_vec
  tcg/aarch64: Implement tcg_out_dupm_vec
  tcg: Add INDEX_op_dup_mem_vec
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

 accel/tcg/tcg-runtime.h             |  20 +
 target/arm/helper.h                 |   2 -
 tcg/aarch64/tcg-target.h            |   3 +-
 tcg/aarch64/tcg-target.opc.h        |   2 +
 tcg/i386/tcg-target.h               |   5 +-
 tcg/tcg-op-gvec.h                   |  64 +-
 tcg/tcg-op.h                        |  14 +
 tcg/tcg-opc.h                       |   2 +
 tcg/tcg.h                           |  21 +
 accel/tcg/tcg-runtime-gvec.c        | 192 ++++++
 target/arm/neon_helper.c            |   5 -
 target/arm/translate-a64.c          |  41 +-
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 144 +++--
 target/cris/translate.c             |   9 +-
 target/ppc/translate.c              |  68 +-
 target/ppc/translate/spe-impl.inc.c |  14 +-
 target/ppc/translate/vmx-impl.inc.c |   7 +-
 target/s390x/translate.c            |   8 +-
 target/tricore/translate.c          |  27 +-
 target/xtensa/translate.c           |   9 +-
 tcg/aarch64/tcg-target.inc.c        | 118 +++-
 tcg/arm/tcg-target.inc.c            |   7 +-
 tcg/i386/tcg-target.inc.c           | 163 ++++-
 tcg/mips/tcg-target.inc.c           |   3 +-
 tcg/optimize.c                      |   8 +-
 tcg/ppc/tcg-target.inc.c            |   3 +-
 tcg/riscv/tcg-target.inc.c          |   5 +-
 tcg/s390/tcg-target.inc.c           |   3 +-
 tcg/sparc/tcg-target.inc.c          |   3 +-
 tcg/tcg-op-gvec.c                   | 935 +++++++++++++++++++++++-----
 tcg/tcg-op-vec.c                    | 270 +++++++-
 tcg/tcg-op.c                        |  20 +
 tcg/tcg.c                           | 262 ++++++--
 tcg/tci/tcg-target.inc.c            |   3 +-
 tcg/README                          |   4 +
 36 files changed, 2002 insertions(+), 471 deletions(-)

-- 
2.17.1


