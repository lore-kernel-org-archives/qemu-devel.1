Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 22:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726AF21D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 22:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NngB2bJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726AF21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSSju-0003Wm-I4
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 18:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSShr-0001lS-2S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:23:43 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSShj-0007Ad-0D
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:23:42 -0400
Received: by mail-pj1-x1043.google.com with SMTP id az3so271240pjb.4
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8JndH3BdmGbCuLudGuV5RxFx/lsC8iQrC57BjjstHyU=;
 b=NngB2bJrhOuV54Qr83Sn30e+Qwpii3lv1WUkPROLhNXQVjTxDZ8PSlXa+7tR1tgbof
 Qow+kDEc9z3+2Yy/Hjo1Crmsv8S48t77hRCHtC7Gv5r9szheIjPTBNMo32kNAKhBUw2G
 JK+JOiXFZeXjjsJznpYzY/Qxy3XQFYLenoHsoZK5foFdv4SdtAMUHCuSF2mEPSGkNGD6
 1HVz1gXLcfNceECbzpSiLcG5Q4+Ci6SuxtFO7fl2PI7J+PiypVjPajUSGCmzcAjUNJtk
 /OWilXicmV/tB64a71gPHUkEBAl2O18cSjMl4cLusInDU53JpxnhL8ONIfYCzXbDUWA7
 0vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8JndH3BdmGbCuLudGuV5RxFx/lsC8iQrC57BjjstHyU=;
 b=pe0XRGgH+1ZK8HhkWru8H73us9hoTO/3iFq/Srdno6psLSgZ8ZrgjpjDkiOFgqD/lT
 895KNMG3RgWVqEAfjWA3o2Sc525/u4HUYhFvyR7gTYceuFuYOk8KHGGRmv6lvOfNI4q0
 jhWjeQAHh6nN59E4sWT2ppsSZzx4g9jCyt9f1mbfqXr9g9bYgZepoUsxJpE4T5FUN8je
 WSFF7zZHxBUbtUJevkFMMVsqAoUMHO3MWnKsYIdgESVpUutQOrRbkKyU03pb/HW3Acfl
 bEsCBmgjx8HSP2HG4X+jymspfbTHKmFR5R9uyXI0+0mB4NU+maQ5Tjjsx3VWvWEQDdv4
 dl5Q==
X-Gm-Message-State: AOAM532OARfCjMsmJNvAv6gY6bzouvmfQ8d7LnkcLUdjUA731YsYk110
 L/kE8F5DbjBjnux3CPKrJkrOR2QwNm0utg==
X-Google-Smtp-Source: ABdhPJz810zZzSON3v3TVi7JLWhfVIY0CKZHBxg2RrrkoX4q44sW5D/YPtKo24Wiwuu6ZkryLfQ5KA==
X-Received: by 2002:a17:90a:de90:: with SMTP id
 n16mr441442pjv.215.1602627812888; 
 Tue, 13 Oct 2020 15:23:32 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cu5sm239899pjb.49.2020.10.13.15.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 15:23:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg: optimize across branches
Date: Tue, 13 Oct 2020 15:23:28 -0700
Message-Id: <20201013222330.173525-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In several cases, it's easy to optimize across a non-taken branch
simply by *not* flushing the relevant tables.  This is true both
for value propagation and register allocation.

This comes up in quite a number of cases with arm, most simply in
how conditional execution is implemented.  But it also came up in
discussion of how to implement low-overhead looping for v8.1m.


r~


Richard Henderson (2):
  tcg: Do not kill globals at conditional branches
  tcg/optimize: Flush data at labels not TCG_OPF_BB_END

 include/tcg/tcg-opc.h |  7 +++---
 include/tcg/tcg.h     |  4 +++-
 tcg/optimize.c        | 35 ++++++++++++++-------------
 tcg/tcg.c             | 55 +++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 78 insertions(+), 23 deletions(-)

-- 
2.25.1


