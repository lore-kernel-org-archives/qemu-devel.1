Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8CC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A537206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+lVH6kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A537206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR42B-0002SQ-63
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR412-00013R-Lz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR411-0000zd-MN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:41719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR411-0000tK-7n
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id b8so213990pfp.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x0b4PqdTMF5zRPeYKjESDuEyQ8nHgeEm0Ry9kzGJgjo=;
 b=x+lVH6kq8fEgr4dDMgDEbiq9CXGQ7ke9wcWW9Zqe8ut8CyCmr7v8PqW68RmQgWxeM0
 qm7rn9YwePnY7NgQyMc/yq9frdqTOp1MPxoMEkzPxX/+PQA51n2yvKyUT0Wf4Bu7BNMo
 WfW2Uqq3Qfwm/8sAkZnovqDoSLDntcrF5RMuICOLQnYK85a561w6WiuaiWf7x+sJYoTH
 ONETIyXyKmNYIA9wYRm7VhRPZunVg2ADdUNsiacdNpDbl0YZ3yHdSv81x3RhYCdfHSVv
 6Z6fTznWS4mC0ML+uqyu4su27+1Kv/40oM/jV74soTNWOZxikvHrDh2DN4B+ZdqsC6q4
 isYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x0b4PqdTMF5zRPeYKjESDuEyQ8nHgeEm0Ry9kzGJgjo=;
 b=SrQ1+w4AsR6Mmav8lokYN0zBsbMUoUy7ZNzqoyUL89Ng25T7wFVfZt8aPxaqfIVZcX
 bsiDvsvHVcyV9qvLkI2HdxdN5ZXMClqUvGTBmQUZmxpEXrb6WxB0cidhWEDZAgcQqOuE
 ZE4BcwQhAahHVD5PYiknogkjuHQOQEz3wBqR3zEarBhLCxMDDTA57ZXQuU3Qv4jFk03M
 opxEhSXeN2cmiJ35DlRrI9T73lTK1kOcNS+/w9grHWlZqhFbgFt/FNLgHBJdcmfK5E0Y
 9ql+5K8dEjaKInCcghCsZZZJy5E3beN2gT/eaOCIBqKLHJLWpnckfVVqc9VFtMrV3Spg
 ERFg==
X-Gm-Message-State: AGi0PuY6pjeaX6TFexiVvX5jBeMM54mxVZiw7O3Wgwp5H7idPgIF0rsa
 rNSGl03DM5mKmN321bx9jth7OSI2zag=
X-Google-Smtp-Source: APiQypJ/g0fvVfP+eBtMPVbjZwOg99/tcleoecdI5lQYXYPIT6PBfXAkjWDpYzQvk0Hr4QSKCbVaAQ==
X-Received: by 2002:a63:f101:: with SMTP id f1mr25362875pgi.204.1587518244756; 
 Tue, 21 Apr 2020 18:17:24 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/36] tcg 5.1 omnibus patch set
Date: Tue, 21 Apr 2020 18:16:46 -0700
Message-Id: <20200422011722.13287-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For v1, I had split this into 4 logically distinct parts.  But
apparently there are minor interdependencies, because the later
sets would not apply standalone, says Alex.

Rather than tease them apart, and then have to undo that work
in order to actually apply them later, I'll just lump them.

So:

  Part 1, patches 1-7, tcg_gen_gvec_dup_imm, is reviewed.

  Part 2, patch 8, vector tail clearing, is reviewed, and I have
          moved the target/arm patches into a different queue.

  Part 3, patches 9-25, TYPE_CONST temporaries, is mostly unreviewed.

  Part 4, patch 26, load_dest for GVecGen2, a support patch for SVE2.

  Part 5, patches 27-36, add vector rotate patterns, is brand new.
          I include two demonstrators for target/ppc and target/s390x.
          It will also be used by SVE2.


r~

Richard Henderson (36):
  tcg: Add tcg_gen_gvec_dup_imm
  target/s390x: Use tcg_gen_gvec_dup_imm
  target/ppc: Use tcg_gen_gvec_dup_imm
  target/arm: Use tcg_gen_gvec_dup_imm
  tcg: Use tcg_gen_gvec_dup_imm in logical simplifications
  tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
  tcg: Add tcg_gen_gvec_dup_tl
  tcg: Improve vector tail clearing
  tcg: Consolidate 3 bits into enum TCGTempKind
  tcg: Add temp_readonly
  tcg: Introduce TYPE_CONST temporaries
  tcg: Use tcg_constant_i32 with icount expander
  tcg: Use tcg_constant_{i32,i64} with tcg int expanders
  tcg: Use tcg_constant_{i32,vec} with tcg vec expanders
  tcg: Use tcg_constant_{i32,i64} with tcg plugins
  tcg: Rename struct tcg_temp_info to TempOptInfo
  tcg/optimize: Adjust TempOptInfo allocation
  tcg/optimize: Use tcg_constant_internal with constant folding
  tcg/tci: Add special tci_movi_{i32,i64} opcodes
  tcg: Remove movi and dupi opcodes
  tcg: Use tcg_out_dupi_vec from temp_load
  tcg: Increase tcg_out_dupi_vec immediate to int64_t
  tcg: Add tcg_reg_alloc_dup2
  tcg/i386: Use tcg_constant_vec with tcg vec expanders
  tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
  tcg: Add load_dest parameter to GVecGen2
  tcg: Fix integral argument type to tcg_gen_rot[rl]i_i{32,64}
  tcg: Implement gvec support for rotate by immediate
  tcg: Implement gvec support for rotate by vector
  tcg: Remove expansion to shift by vector from do_shifts
  tcg: Implement gvec support for rotate by scalar
  tcg/i386: Implement INDEX_op_rotl[is]_vec
  tcg/aarch64: Implement INDEX_op_rotli_vec
  tcg/ppc: Implement INDEX_op_rot[lr]v_vec
  target/ppc: Use tcg_gen_gvec_rotlv
  target/s390x: Use tcg_gen_gvec_rotl{i,s,v}

 accel/tcg/tcg-runtime.h             |  15 ++
 include/exec/gen-icount.h           |  25 +-
 include/tcg/tcg-op-gvec.h           |  25 +-
 include/tcg/tcg-op.h                |  30 +--
 include/tcg/tcg-opc.h               |  15 +-
 include/tcg/tcg.h                   |  53 +++-
 target/ppc/helper.h                 |   4 -
 target/s390x/helper.h               |   4 -
 tcg/aarch64/tcg-target.h            |   3 +
 tcg/aarch64/tcg-target.opc.h        |   1 +
 tcg/i386/tcg-target.h               |   3 +
 tcg/ppc/tcg-target.h                |   3 +
 tcg/ppc/tcg-target.opc.h            |   1 -
 accel/tcg/plugin-gen.c              |  49 ++--
 accel/tcg/tcg-runtime-gvec.c        | 144 +++++++++++
 target/arm/translate-a64.c          |  10 +-
 target/arm/translate-sve.c          |  12 +-
 target/arm/translate.c              |   9 +-
 target/ppc/int_helper.c             |  17 --
 target/ppc/translate/vmx-impl.inc.c |  40 +--
 target/ppc/translate/vsx-impl.inc.c |   2 +-
 target/s390x/translate_vx.inc.c     | 107 ++------
 target/s390x/vec_int_helper.c       |  31 ---
 tcg/aarch64/tcg-target.inc.c        |  32 ++-
 tcg/arm/tcg-target.inc.c            |   1 -
 tcg/i386/tcg-target.inc.c           | 195 ++++++++++-----
 tcg/mips/tcg-target.inc.c           |   2 -
 tcg/optimize.c                      | 204 +++++++--------
 tcg/ppc/tcg-target.inc.c            |  47 ++--
 tcg/riscv/tcg-target.inc.c          |   2 -
 tcg/s390/tcg-target.inc.c           |   2 -
 tcg/sparc/tcg-target.inc.c          |   2 -
 tcg/tcg-op-gvec.c                   | 374 +++++++++++++++++++++++-----
 tcg/tcg-op-vec.c                    | 218 +++++++++++-----
 tcg/tcg-op.c                        | 232 ++++++++---------
 tcg/tcg.c                           | 347 ++++++++++++++++++++------
 tcg/tci.c                           |   4 +-
 tcg/tci/tcg-target.inc.c            |   6 +-
 target/s390x/insn-data.def          |   4 +-
 tcg/README                          |   7 +-
 40 files changed, 1490 insertions(+), 792 deletions(-)

-- 
2.20.1


