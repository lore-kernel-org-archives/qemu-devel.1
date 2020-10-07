Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D84C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A242076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="a6c1WyDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A242076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6Pf-00082N-Bx
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6MT-0005Qt-Fx
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6MR-0004UM-Fv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so1449265wrp.8
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+NWx5IEYq/NUxMmoCniXmRWP+qb5Ua3EyPcLkM+WBIk=;
 b=a6c1WyDIqcusrnopqFlftBdNatMKY2XMS6uGer5l+ulK7gE+6aFW+4DEtQnHkEFPgQ
 2bYe6mhB8juE6inlOt4w3XcnKjzNcOuViXukuMZv5ckn6qrApuUd07kdMqJlvl3TRfnm
 YhlwBidoW2Vy/+qyUOjm4Hgko8J3Em75bGR1G2X9Smvzj8i4tAqfdixYGWMlF08mmm6o
 GWWvQGloc2t0zGbYD7unVOQYkmSTnwXeMBPupuCAHejOcSb5/lubcnfwjhnZhbV3AEyR
 cOI+oP3SG+TgLlF2ypsh0YAQ/mHc1FZ5aAUsoKVaOmBe8PpqpvOt1MmVk0twso0AB3f1
 B5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+NWx5IEYq/NUxMmoCniXmRWP+qb5Ua3EyPcLkM+WBIk=;
 b=oVP6h1Fp9JpL7rJcFMyUNG+i0RBzE4PEmtBv/VxUlwfrfZc6fevNjgil5xkwxia+kN
 GQyIxF5Icls2ofq7vVAWrqDg7R5az5MxGnUA+W/p/Iw19rmQfJLGhifkKVDWd9w7eINc
 Ouvm+/3yusYrNd5nAIWlIamtgvA2D5rEOW3tBxyX+5Pe2Sj7pNAEXvBFlg9rgL/IXKLg
 e9X8BtTU6o+naRklUqKBNsgQMlLT6ZsNMcrLdNYp0aDi5vgO6rXjLGvlHvRFU3SRwcbm
 TZs6UAZFRSYn/zYoZc6gR+cDl+82xfFxE6ZKcoHhTDKwukJqc2SviXAaPcH8mlxEsiXl
 sKQg==
X-Gm-Message-State: AOAM532ZJx0L9LDQLfLhvcMd+AHqbvrsg5rYIfibVzlu3DCbS/WxAEh1
 /9hFpitU5Unnsr9ZuySvptYYXg==
X-Google-Smtp-Source: ABdhPJyJUMqI+CQlxPkvciMhoTtB1Vii+RiW0ke49Jyn091IDoEfnT5WanVqNMv/m7S88++IzqZspA==
X-Received: by 2002:adf:f104:: with SMTP id r4mr2668789wro.202.1602065269294; 
 Wed, 07 Oct 2020 03:07:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id y6sm2208504wrt.80.2020.10.07.03.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:07:48 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] hw/arm/sbsa-ref : small fixes to smmuv3 initialisation
Date: Wed,  7 Oct 2020 11:07:30 +0100
Message-Id: <20201007100732.4103790-1-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 rad@semihalf.com, f4bug@amsat.org, qemu-devel@nongnu.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix two issues with the smmuv3 initialisation, first where a previous
patch had transposed an i to a 1. The second an assumption that the
IRQs allocated were meant to be unique and not 0 based.

v1->v2
 - split into two patches
 - previously sent as v1 post split by accident, resending for clarity
 - added Reviewed-by

Graeme Gregory (2):
  hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
  hw/arm/sbsa-ref : allocate IRQs for SMMUv3

 hw/arm/sbsa-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
2.25.1


