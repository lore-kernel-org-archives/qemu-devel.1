Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF07C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62E120675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBUsR5px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62E120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMndT-0000N0-0l
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:54:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbf-0007eT-5L
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbd-0003yn-7q
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:07 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbc-0003xc-Cx
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:05 -0400
Received: by mail-pg1-x52e.google.com with SMTP id p6so3756918pgh.9
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=VifLxzEklX7uqjNVkBv68D9AJ/YnzoCTfQTaGgCGo84=;
	b=gBUsR5pxmiQ24kKl0sm/Aq5SJvf5oWKGV/OKgz8vzyLO7wvuJAwhL3qKjOqFpvge+2
	lsPAalfh7841rvqgNkPtnIfuuqE9tO5knt4TEfe4yCkDwREwkrZmaGqwgKWlvziqGRTc
	7j85R/oi6c8x0+AqJXF7dOBaTBhsVIulGkH8aJ8pg9ZDyvoMU706Lhf+CMIREs8LCW7K
	E44C3QEo0lVipOnBAYN8bVhE8hhM/61qmQVRiDRWPnupzs6kBjcMzt3d3LZpiIpp8KBj
	BJFYTM2pdz3Rrad4ih++Nptvp3OluYfJuFo/wAiQezIwfywLmZ2vhAbUECk8BUSjwveD
	LyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=VifLxzEklX7uqjNVkBv68D9AJ/YnzoCTfQTaGgCGo84=;
	b=jge/pLuHDjWWWdw34un4p7eLOcMk7i7+9GbJ8785BVtiZVpkDxis7oUBb1cws/lqgV
	GGp8spn3doQ4UT5DhW7NTwSaRLQChZnuYjD7gSZEoiKKH6/zJEQGDVxKIcU6LJh/E3Cd
	i7m9Oy4KNCBS8srYakXXYaShvLuOUgSoXIniS1MUZj26U876FkZEfL3XyfwBE9DkyNfd
	UjWoBWTC7ZR9MFolU5eCDIRvFWGWX69UoD365Azbp/ZhsNV6d0L0KuZJTf6FXABPZ30D
	sb0hCV4tgxhdRrW3kTLieT8q+VlID8nazbBLHfXdxfu2tGppuxGwLp17xBQrLcJ+CFbn
	G+Dg==
X-Gm-Message-State: APjAAAVEZfWuQqVeT6Ruv1FQFqRDchkEz5LK/9j9WJ4nkTJt+7pStrQH
	vnA6HkCCerV7Wfeu6TkIKggzzT8mllI=
X-Google-Smtp-Source: APXvYqxe1s879Xt0cV7GFti2+IT/7Z2NL2uRhMxnYQlxexIsRN0aIFErHyjvU2zqKB0kGqfsVUA0mA==
X-Received: by 2002:a62:f245:: with SMTP id y5mr16855812pfl.12.1556949182610; 
	Fri, 03 May 2019 22:53:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:29 -0700
Message-Id: <20190504055300.18426-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52e
Subject: [Qemu-devel] [PATCH v3 00/31] tcg vector improvements
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055229.hfKdvCd_X7LkCJU8XizbkcYnMoSSlteFACwScpgO-os@z>

Changes since v2 (stsquad review):
  * Split out a tcg/arm/ change to tcg_out_mov.
  * Add some additional commentary for tcg_reg_alloc_foo.

Patches missing ack/review:

0006-tcg-arm-Use-tcg_out_mov_reg-in-tcg_out_mov.patch (new)
0010-tcg-Manually-expand-INDEX_op_dup_vec.patch
0011-tcg-Add-tcg_out_dupm_vec-to-the-backend-interface.patch
0012-tcg-i386-Implement-tcg_out_dupm_vec.patch
0013-tcg-aarch64-Implement-tcg_out_dupm_vec.patch
0016-tcg-i386-Support-vector-variable-shift-opcodes.patch
0018-tcg-Add-gvec-expanders-for-vector-shift-by-scalar.patch
0019-tcg-i386-Support-vector-scalar-shift-opcodes.patch
0022-tcg-i386-Support-vector-absolute-value.patch
0025-target-cris-Use-tcg_gen_abs_tl.patch
0027-target-ppc-Use-tcg_gen_abs_tl.patch
0031-tcg-aarch64-Do-not-advertise-minmax-for-MO_64.patch (new)


r~


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
 tcg/aarch64/tcg-target.inc.c        | 120 +++-
 tcg/arm/tcg-target.inc.c            |   5 +-
 tcg/i386/tcg-target.inc.c           | 163 ++++-
 tcg/mips/tcg-target.inc.c           |   3 +-
 tcg/optimize.c                      |   8 +-
 tcg/ppc/tcg-target.inc.c            |   3 +-
 tcg/riscv/tcg-target.inc.c          |   5 +-
 tcg/s390/tcg-target.inc.c           |   3 +-
 tcg/sparc/tcg-target.inc.c          |   3 +-
 tcg/tcg-op-gvec.c                   | 945 +++++++++++++++++++++++-----
 tcg/tcg-op-vec.c                    | 270 +++++++-
 tcg/tcg-op.c                        |  20 +
 tcg/tcg.c                           | 271 ++++++--
 tcg/tci/tcg-target.inc.c            |   3 +-
 tcg/README                          |   4 +
 36 files changed, 2019 insertions(+), 473 deletions(-)

-- 
2.17.1


