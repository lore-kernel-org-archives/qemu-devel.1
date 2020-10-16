Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52203C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F6321655
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYgwZhxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F6321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTWyp-0001g4-Cs
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 17:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTWxE-0000bD-7G
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:08:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:36283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTWxC-0004n0-Lq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:07:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id a1so2178768pjd.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jQCSNzVeKgIz3DsvHFInGHF1+/bkC3/zlpckGJCVxsE=;
 b=OYgwZhxNng5oF5XObhBZpIogT1GpmN2HUH4n9jxalCy6WAhNrZkifG7TAdAaj5gCE/
 xyJ6BqXNgAdGam1lIAsWaNF8HvNymWw7+mrA2oPPgqFkULSsucnP0LhEpsriuhoUc3f5
 X+Q8PhAo6in59qaRzdcvm4URxABoPpztIzcaqICtJgzhvJOAmCRYUy17Ss+uwIAXSd22
 6XkbsudCBLxfH4oQ7UkM8Kh3U6tM1ro3TEqXD+8mQIaDXose3fmox3cm1VTj5GQCAPzD
 AeIDaKskM0FwAzrTi48tG+NZna7Ogc6+3W9R+2lpQtsSE+8jh4mlQuntAtbGu5WM5AaR
 Xqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jQCSNzVeKgIz3DsvHFInGHF1+/bkC3/zlpckGJCVxsE=;
 b=olwZa4EB8PdxJfdcDc6pdSo6y6SDKH9+DD65wuztwL7op2/cVUx+P8ubO1rpEWX7Lo
 9gwt9GPdMQbyy8lX2K27cz2mL7iUNVHej1T1RZ1/yVAqrto5yJPjAViuh0CxqjIRhZo+
 X4cfPaeLtIjewk8osLSdpwJoyZYBxhGy2FyT7+eWMB65sCuSwTFYPGFkvOmtJ0IFrL1v
 Yr0RF9QGv5t4If13ATDHhd47GKXceddoeYrBldklDu01ccA9z5FI2RSrL5Lm1FWfCzKw
 hje1x2zRNnwWZ0TfbWg117L4iX1E8oWBE7cqgLBe+kyKLeKVJvAd69TohEHpMrEpmxY3
 3eQA==
X-Gm-Message-State: AOAM530XQHPS+o/NtPvVxKweeRH4XR0FB4SHVRDIeuJcUjK/5dmTArCx
 JYkZiTJnoFK6j2mdgOm6xNe7JB84oMsv1A==
X-Google-Smtp-Source: ABdhPJyxDYPB5PBzS8u9AZUnD+yFLk5/c89QPEY8P52+Qz1SFfVHn1mcCIP3Cs8c1w7sjOkIum7VLw==
X-Received: by 2002:a17:902:c408:b029:d4:c99a:19e8 with SMTP id
 k8-20020a170902c408b02900d4c99a19e8mr6114985plk.8.1602882476617; 
 Fri, 16 Oct 2020 14:07:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 198sm3682324pfy.41.2020.10.16.14.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:07:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target/arm: Fix tlb flush page vs tbi
Date: Fri, 16 Oct 2020 14:07:52 -0700
Message-Id: <20201016210754.818257-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the FAR_ELx fix at 38d931687fa1, it is reported that
page granularity flushing is broken.

This makes sense, since TCG will record the entire virtual
address in its TLB, not simply the 56 significant bits.
With no other TCG support, the ARM backend should require
256 different page flushes to clear the virtual address of
any possible tag.

So I added a new tcg interface that allows passing the size
of the virtual address.  I thought a simple bit-count was a 
cleaner interface than passing in a mask, since it means that
we couldn't be passed nonsensical masks like 0xdeadbeef.  It
also makes it easy to re-direct special cases.

Changes for v2:
  * Add encode_pbm_to_runon/+decode_runon_to_pbm helpers (pmm).


r~


Richard Henderson (2):
  accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
  target/arm: Use tlb_flush_page_bits_by_mmuidx*

 include/exec/exec-all.h |  36 ++++++
 accel/tcg/cputlb.c      | 275 ++++++++++++++++++++++++++++++++++++++--
 target/arm/helper.c     |  46 ++++++-
 3 files changed, 341 insertions(+), 16 deletions(-)

-- 
2.25.1


