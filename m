Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7ECC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3241C204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kuwna6KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3241C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7XU-0005Pb-DW
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vp-0003Kw-AI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:53 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41721)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vo-0007gg-4M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:52 -0400
Received: by mail-pl1-x644.google.com with SMTP id y17so1414223plb.8
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gQQj1sipgdOMwp2GOB85OYS6IIBkkX4MNoYnTOJv3F8=;
 b=Kuwna6KQHzCAx6RRTO36pRZ+F9Ae3OYCK5+QW8UyYDjzy1/KK672NKQE9MhGB6tFkl
 POwOLmAwjuUHR+2f/kAE93aNu6lZr/CD9BFSDKg7PLJyiummUZmZjCoQd4KUCg1Et87H
 U4iBbox/EFFuJ5AVud/vjI/6m1e9KdHQ8IwzKMm5ADSBUKZfPM+ACEHJfbiUt3yZH9BI
 ZzSP8bUe/FbKQ6ikr6qC3PpNINLPqtEIKg/hTc1jwQ8e3YL2Rkx4Xx9tOrl0BJQoBzlF
 XVcRHAeNRGmS+DuhrnJ+q47wOY45ofa8EIzbEWklwk19/Efolx9Wyzoz3QE1zoJUBiqN
 grRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gQQj1sipgdOMwp2GOB85OYS6IIBkkX4MNoYnTOJv3F8=;
 b=Yvh9lA+nhNTvRTH/NFp4hgOAdF3ZxN0Xbg2pqFeYGm6ugZVFLkwN0Tjg+ntZb2cbyH
 N7fhtmtTEnix/D9tuf4IXkYbdqGWsDPH/m+H0/MP+ZpuWuzfiMJA8jh9sXIT3oRZV3zw
 LrePnbrqG24i0tpFIxPMht5VsDSFkkkriszbX6uPs8vv5WHGQzQPYHKACK9HhfdM3nV6
 yl2naJHeMO6q8mqMYUk1o3LfIpbSJoh9I8zB7ZPZmnyuTts+Ars4PtyPO1yjF/nWv3CA
 /ITB6sXPWdzjawg34oZGnuq2nquMwYstS3XApk2nbSGju7A19YjO3+RGEl9mAGoSuRFc
 JLsA==
X-Gm-Message-State: AOAM530i2rvYLxsHFMcDVbIkGkq/ji5Q9fNSzT7u8v5zrLvhpRfeiVrG
 dmyTOTOzMN+u2mkTfYXWIeO/VyZL4UU=
X-Google-Smtp-Source: ABdhPJxNv20Tb6FAVAQEg/+V86OLNTb5WheGnYnaJYV6RZ0Ic/Df6uYzsuOJpr926uEfr0h5Dh870w==
X-Received: by 2002:a17:902:b685:: with SMTP id
 c5mr4716670pls.154.1591821583751; 
 Wed, 10 Jun 2020 13:39:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g6sm740648pfb.164.2020.06.10.13.39.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:39:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] Vs clang-10 and gcc-9 warnings
Date: Wed, 10 Jun 2020 13:39:37 -0700
Message-Id: <20200610203942.887374-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Three of these patches are for cleaning up warnings vs clang-10.

The -Wtautological-type-limit-compare patch has been improved
as suggested by Eric Blake.

The final patch is for a "new" warning from gcc-9 on aarch64 hosts.
Our build box has been upgraded from bionic, so the warning is new
to me, anyway.


r~


Philippe Mathieu-Daudé (1):
  fpu/softfloat: Silence 'bitwise negation of boolean expression'
    warning

Richard Henderson (3):
  configure: Clean up warning flag lists
  configure: Disable -Wtautological-type-limit-compare
  configure: Add -Wno-psabi

Wei Wang (1):
  migration: fix xbzrle encoding rate calculation

 configure       | 42 ++++++++++++++++++++++++++++++++----------
 fpu/softfloat.c | 33 ++++++++++++++++++++++++---------
 migration/ram.c |  4 +---
 3 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.25.1


