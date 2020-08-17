Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085E12065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6raCCzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085E12065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fjE-0004vb-2U
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fhu-0003GE-Ps; Mon, 17 Aug 2020 10:01:50 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fht-0001Vw-14; Mon, 17 Aug 2020 10:01:50 -0400
Received: by mail-lj1-x241.google.com with SMTP id h19so17581186ljg.13;
 Mon, 17 Aug 2020 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rFDNys71dgTDc8zx+0/nANNqkjvau89gJkLMGwhQhgs=;
 b=l6raCCzOvUFPuI5nl8ARg3TRYRmzPZjNEJvFegsOVEg3ELpbb9SJXARRw9ak8WDRfQ
 eKIkdiDGdjcm+uTtOpslF8Foteu/wpN9byG4Bt0DRFGQhFKLMfHzJzs9VuZAvZ3Ol/cN
 iQTLQXnS1ONSGO4DGXceorVwkeSkFo3H5tXT6081b09zYAC0lHx3Llb8fKWDJlyRRIKz
 Bv2CF8FiSJYb941Jd2fhk15IJG9qpnfe0k0kEMB4KMCV2g9jWlBLRrYAufMl7CID1ONp
 jxPxA9pPlHZmCOUEYWkilX8ltjeKq9kW+57egt/14mOmvCS36aOAZ25CJRMkx1sJ9RRz
 H68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rFDNys71dgTDc8zx+0/nANNqkjvau89gJkLMGwhQhgs=;
 b=QBykhoU0f/DKeCS8KwIVAKLKqW39mIUpob/smmQFoaTYSuVCsdhhxlo1u7Xr24lZ97
 6BeVDZpGRBLLDxtt+0q7Jqc1jiKkBOrLhPFkINJviNT+0CFs+e3dOF7AW/pdzZVm+1Vj
 cQ5RVC/Vje5nCXyPca2l4nO3Klf1yN4weu3HWgG8Ff8FsZC3OtFtYCT2UtDPv00p39//
 bPn+YvYYzbB7eFuSQcTY2Bc6ULF0tWJ/yrQc4EAq2ffqYGuAyyvsrUJRcbj+X+3ySVEg
 cfNBip3173XglvJYLDLH36o8nmDQIZBg0lSGltJ9zcTVQhwCy/Jf60xMsCwNdL7OVL7f
 AzMw==
X-Gm-Message-State: AOAM530YX4FOdm9PtQBeLL7l9q0LDSDGv8G8vK5vswNDnl+vq/rKq0E3
 yXu8yul5ytoHxvb/Lc5y5ONykt/PBCNrrv7I
X-Google-Smtp-Source: ABdhPJyRvMFPwqGwMsku+NXxPUcZ7YVoOVoP+yId0wFsRDxrOUSkmoI/KNUx/VSALoHBhgKFYXIVjg==
X-Received: by 2002:a2e:b5a5:: with SMTP id f5mr7800879ljn.114.1597672905999; 
 Mon, 17 Aug 2020 07:01:45 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r8sm5522419lfm.42.2020.08.17.07.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:01:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] target/microblaze: Enable MTTCG
Date: Mon, 17 Aug 2020 16:01:39 +0200
Message-Id: <20200817140144.373403-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series adds translation for memory barrier instructions and
changes the store-exclusive implementation to use cmpxhg rather
than relying on single-threaded TCG.

This is primarily in preparation for future AMP machines.

Cheers,
Edgar

Edgar E. Iglesias (5):
  target/microblaze: mbar: Transfer dc->rd to mbar_imm
  target/microblaze: mbar: Move LOG_DIS to before sleep
  target/microblaze: mbar: Add support for data-access barriers
  target/microblaze: swx: Use atomic_cmpxchg
  configure: microblaze: Enable mttcg

 configure                     |  1 +
 target/microblaze/translate.c | 33 +++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.25.1


