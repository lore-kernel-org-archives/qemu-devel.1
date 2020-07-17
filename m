Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13BDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743E4208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA7cEVof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743E4208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ1y-0000k9-Nb
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jwPv3-00075R-Ro
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:56:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jwPv2-00006M-AY
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:56:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id q5so10977580wru.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0snM9HRI0+JSg5Zt1iuTkTRirceAJfWdpQ4fjknU2q0=;
 b=BA7cEVof/BPjd95tPhYvTa3QkkbTh7eHTiMVS8HExXXn7xQP0pdhkS6C4TV/TvmITQ
 WsLEc6x8camriUi79rtDXAFtSwZ7v7gwb+YpeLAfzNkKDMnh4E6BnKas5roWHvXgq2Ul
 ZjaAdCTgrMuWJSwWbzUm0Me1lzcmw4Vr91FDMOwIHwA+KCyyLf3BaqLYqBLEGvb+uF+5
 staz7sojKYgYfKJJfR+UaPiJQQJ/nWbJhry29XNwsl8/zyyZaf4ZU5kcouqDWnZlZn1z
 qoF0uqE342Lz9Xe25d83ssqasRvecwvf9ubtBMljQYFay+IaUQFKDaDYLcBR1TN1lToU
 29Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0snM9HRI0+JSg5Zt1iuTkTRirceAJfWdpQ4fjknU2q0=;
 b=CHGPCGz0mL0WSoQBnVprOfq6DLtCXAvrfEPKprGXyoYg1/2/DfVEHXgEqSA6HFwPLg
 WOYaQtzi9dfrwqgtfz5uBVXtoQpatgMFdlIDK23FqZXTTjOIGJe94q2neyKVPI7P8DbX
 5NWYJimOtp2rDF+PYzLvnA3HO4ZzlEr1RCCRGxaO/a2dsuPBqFfFRRZr4g86nr8TP/ZH
 2oYiEhWTGoPeZAmEI8EiDNWZm4HoV/MwlBWu0DwUdH+it5lW+j1N8lm+otiB5B5b1Aqg
 ysUrJ3DqO6bk1o3WOcDZ6/xHqjdHiB+gEatK14X+ER27JOS4uQHtNN/fjSBbyGPIWpJt
 MqFQ==
X-Gm-Message-State: AOAM530CTMOqc/jVvoYGHffqMAIU48rTiDkhMqA3qkCwN6Xv4KX8jTXA
 H4ABbpQrDhKADZcrKea0gokvYbcH
X-Google-Smtp-Source: ABdhPJyvt+VTIWIIPvw9G0lc9wAGGu6nMXckvmKt2NWin3qyDeJORp8fJk5qdkMvIB0UTVuFq7R6uQ==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr10976277wra.118.1594990610074; 
 Fri, 17 Jul 2020 05:56:50 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 g82sm13655710wma.37.2020.07.17.05.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 05:56:49 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] hyperv: Enable SCONTROL if SYNIC is enabled
Date: Fri, 17 Jul 2020 15:56:38 +0300
Message-Id: <20200717125639.1103876-1-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on an analysis of the HyperV firmwares (Gen1 and Gen2) it seems
like the SCONTROL is not being set to the ENABLED state as like we have
thought.

Also from a test done by Vitaly Kuznetsov, running a nested HyperV it
was concluded that the first access to the SCONTROL MSR with a read
resulted with the value of 0x1, aka HV_SYNIC_CONTROL_ENABLE.

It's important to note that this diverges from the value states in the
HyperV TLFS of 0.

Jon Doron (1):
  hyperv: Enable SCONTROL if SYNIC is enabled

 target/i386/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.24.1


