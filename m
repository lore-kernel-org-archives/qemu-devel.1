Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9A2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17BD206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YF20YSER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17BD206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfcW-0003Of-U5
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfaq-0001ai-2m
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:01 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:39172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfao-0001oX-Vd
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:01:59 -0400
Received: by mail-pg1-x52b.google.com with SMTP id u35so1413618pgk.6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t0ZU42jLV5CNQDGAPX4+ef3ID2A/mEOP7TEnvXfy3F0=;
 b=YF20YSERl2mmAOFrPjpfIyGXL4D8HdDWOTItVFsJIeKvBrAL72ijvUdvKk4WPy/3FA
 6GZh7W9bgoYPhjjIZjX8UilKXVfCTsAi8X/jV0TJvjI1j0mRH+kAn+t31VsR/bIClNj/
 ilaAP32JlgIVjrdW9eqOMWD9DBn8ne4cec7qiXHxuf+fBcbgktEsa3+eT/CKKJwNHOdT
 a1EbVba/HpOGOb4KZwBDvsq7hnzffFkq2XPFrxcFfwJMHjfWiut4HrGkTkTBfFocoN+4
 MfHTzYQaVmFdqVYxLNhyF5y5Tu2gMeREQ7uQThAHGqhoGImg3d5w98TJ09bMwFUBgcV2
 fkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t0ZU42jLV5CNQDGAPX4+ef3ID2A/mEOP7TEnvXfy3F0=;
 b=Fq1JA1M8Lu+ZTAtQcvYalat5cUf3tui2szgacxysBrF3Nhc601ZbY4wmcqgH6et4z+
 t25Gz7u5R7xOAQf7UIpidCRgeGy0QcyttqN/p/BK8eaE3DWmBRhbOo2Q2hxx17Mi7nVK
 rQxwTjP9oqOUsyDWHGg0E+U/ZrI3Grx4BY45NDjCCTljBIUVnANeTl3Ds00FqVxSGboe
 fZu56/tHAE5s5nLl3+TshTT3mWbttprEmJpN9OzfpWHc3A4MHZRYbZk8viXjik8fYnp9
 pcmfCCiFcv9Z8Nyw5/Ez7cbYQj9mGrMEw0ZnD30w3FMSJm+VkXiIhs1q5nPi75ZY70IU
 lrEQ==
X-Gm-Message-State: AOAM533BBMKMrhjkBj6diru6vlkAk0tecUY1ow598lTB6J1u8pMxHjzQ
 WmB+uIzapophLkKnuHXhzJMQSPoNOR0=
X-Google-Smtp-Source: ABdhPJwFLL/JnpIiGUx/F90/G7i0UY52vSQUGfnC5/4/dDIfpck8lWdrWMlp/swzPFDk37sRUwfPzg==
X-Received: by 2002:a62:8c0b:: with SMTP id m11mr5190462pfd.105.1589569315689; 
 Fri, 15 May 2020 12:01:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:01:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] softfloat: misc cleanups
Date: Fri, 15 May 2020 12:01:43 -0700
Message-Id: <20200515190153.6017-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a grab-bag collection of cleanups, at least one of which
have been on the to-do list since day we abandoned compatibility
with upstream softfloat.

The compare changes have near-zero effect for float32/float64, since
that's the way they are implemented now.  For float128, it simply
removes unneeded complexity.

For floatx80, this fixes bugs vs pseudo-denormals which were only
fixed in floatx80_compare_internal.  We could just remove them, as
these interfaces are not used by x87.  But I thought it'd be best
to keep the interface compatibility for now.


r~


Richard Henderson (10):
  softfloat: Use post test for floatN_mul
  softfloat: Replace flag with bool
  softfloat: Change tininess_before_rounding to bool
  softfloat: Name rounding mode enum
  softfloat: Name compare relation enum
  softfloat: Inline float32 compare specializations
  softfloat: Inline float64 compare specializations
  softfloat: Inline float128 compare specializations
  softfloat: Inline floatx80 compare specializations
  softfloat: Return bool from all classification predicates

 include/fpu/softfloat-helpers.h |   27 +-
 include/fpu/softfloat-macros.h  |   24 +-
 include/fpu/softfloat-types.h   |   28 +-
 include/fpu/softfloat.h         |  336 +++++---
 target/i386/ops_sse.h           |    8 +-
 fpu/softfloat-specialize.inc.c  |   32 +-
 fpu/softfloat.c                 | 1305 ++++---------------------------
 target/arm/sve_helper.c         |    8 +-
 target/arm/vfp_helper.c         |   14 +-
 target/hppa/op_helper.c         |    7 +-
 target/i386/fpu_helper.c        |    8 +-
 target/m68k/fpu_helper.c        |    6 +-
 target/m68k/softfloat.c         |   70 +-
 target/mips/msa_helper.c        |   10 +-
 target/openrisc/fpu_helper.c    |    4 +-
 target/ppc/int_helper.c         |   13 +-
 target/s390x/fpu_helper.c       |   22 +-
 target/s390x/vec_fpu_helper.c   |    2 +-
 target/sparc/fop_helper.c       |    4 +-
 target/unicore32/ucf64_helper.c |    6 +-
 target/xtensa/fpu_helper.c      |    6 +-
 tests/fp/fp-test.c              |    2 +-
 22 files changed, 547 insertions(+), 1395 deletions(-)

-- 
2.20.1


