Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DEB20672
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hAlhCvz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DEB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15G9-0000qn-Lg
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 05:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k15Er-0008K7-LU
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:52:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k15Ep-0000d4-SP
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:52:37 -0400
Received: by mail-pl1-x643.google.com with SMTP id m16so13585416pls.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vCoG+ztVSwCxxwzBdEr+Idws45vA2SXXrCmuJf3XgXY=;
 b=hAlhCvz7x04uPFhqoV5CHt56toz9FZ+9mBZopR8NJt3yj6Naa4lLbvTS5ToWd8RIeM
 apxTIopMVcrKkfi7MPKS6Zpbs/hosTKsmq7EAC81qC95wgfLdDeCBEvLXLcqKGk1YjQc
 Y1IUtBZDTb2JJwurGksxUbWyeb00UJLTwn8HSSYe8kILsh1lUTI64ZaKYbHq/Vr2wGyg
 LNZhbY65aRMw53Sf7i27kc2j0XbxdyaV94Ow3MErKCW00HG7BuBWOSFAlIoVzIoL+oJ3
 jbP5oo8UZjC8GHFEE5i73rLrGjzwBlvGaCyaeAYOvNL/qgBnRIrPUbsP+uOSKm2dDUK3
 aXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vCoG+ztVSwCxxwzBdEr+Idws45vA2SXXrCmuJf3XgXY=;
 b=RawvYaybRsk/CKq+X7hkB5CHn7TJrMER+Ffcb6JQ4G6C5wIO+FVk0WcEmuz13c+Jlo
 h3mGWUsMumSs+48sp3Vuhhl3jW27a3Nqc+7hpNQaibeaV5wDkfJueCIWFFazrfLzoVLE
 V86qbWCdy8GZCq2aWeRtqCZ46/qNYOy3wj7+Xpnx2saAdU6C5YNDT+kWqXjJOiFFUAf4
 5U9tAYTUNKjmzvqxoMW6mAFG2CnyD/5zKDP0dVRav4ogAhcAZbHnvEM+d0h+9P41KTXk
 Jznf1zRSFuWU85v/klOlvRDJ2ndRkk0Ml6NWaqtGdC1lOLTQe+4GHyIWVUOLjpm2L6sc
 eNzA==
X-Gm-Message-State: AOAM530f8NLyi7bwF4f3VrVGmoXa+2BUuX2sHJ82G14zTycEJse16JZa
 fr0FzuES1KJ0KZJ2C5M2pu+SBSljh469/Q==
X-Google-Smtp-Source: ABdhPJx//wwKm3qx6SqHBy4DtL/s0vPUXttEk4e9E1nmZmsCuA5Gjf2BTiSLMpGPHynE0sWqXwQGPg==
X-Received: by 2002:a63:9dcd:: with SMTP id
 i196mr32918759pgd.378.1596102753580; 
 Thu, 30 Jul 2020 02:52:33 -0700 (PDT)
Received: from gamma11.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id e5sm5040654pjy.26.2020.07.30.02.52.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Jul 2020 02:52:33 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 0/3] float16 APIs and alternative sNaN handling
Date: Thu, 30 Jul 2020 02:52:21 -0700
Message-Id: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chihmin.chao@sifive.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches are separated from riscv vector extension 0.9 patchset.
The set includes 
   1. alternative NaN handlding
   2. float16 comparision APIs.
   3. float16 to int8/uint8 conversion APIs

Chih-Min Chao (1):
  softfloat: add APIs to handle alternative sNaN propagation

Frank Chang (1):
  softfloat: add fp16 and uint8/int8 interconvert functions

Kito Cheng (1):
  softfloat: target/riscv: implement full set fp16 comparision

 fpu/softfloat.c              | 109 ++++++++++++++++++++++++++++++++-----------
 include/fpu/softfloat.h      |  55 ++++++++++++++++++++++
 target/riscv/vector_helper.c |  25 ----------
 3 files changed, 137 insertions(+), 52 deletions(-)

-- 
2.7.4


