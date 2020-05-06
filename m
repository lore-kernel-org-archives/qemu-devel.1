Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C7C4725A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2463720714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1l2epmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2463720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFNu-0006Rw-9x
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMm-0004d1-2s; Wed, 06 May 2020 04:25:20 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMk-0006um-Ho; Wed, 06 May 2020 04:25:19 -0400
Received: by mail-lf1-x144.google.com with SMTP id j14so581139lfg.9;
 Wed, 06 May 2020 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wdCuBlsJ7sHwtpHL3l2lAB6bzmZNZ9HRKt/MjxMKcSk=;
 b=g1l2epmPeGRoLRWNR1spEHlu2/9Ohy4WxIrbxDPSAMJbpYKe4zaAPHQXAlPmURJ/yc
 NxmFbGy4s6SPfYspUUU931lCvJiI3mDnGOS9doA2owHO4p2oKs11BYvVObk9jp8sLjrx
 j2DbprBBk+xD1jS+uhRk8ooR8VbquoVgwZy/b80Pehw5XZCNN2U7NwE3Fm30Df0TmW3P
 W2ONQ5b9GqeZVlZtSTJ+m8RESx1oiSBxMrbkAsS55NMxeG1AXL7qODm00MS85IXdN6ji
 274ui0uWXXDkskkeTnT6Oq4NCJPi0Kge2Rz3QPZOYHJqrG1UjnHnCaM00U/T8jB9TNw4
 +fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wdCuBlsJ7sHwtpHL3l2lAB6bzmZNZ9HRKt/MjxMKcSk=;
 b=t5bq9Q5GENreLryGjCgmVIxkJwWRq/GKUVkJD5fWsshc9O9j7Uhw6yjwNqxl/9vtGW
 13iBqR48jy0E4nU02KHF5/xF1ZQ9EC4giH1f7lTxiVjpqEglC7CJJvxNDwaSO9CayTX8
 Wcr3PjGgujEneMusOxTiw/DUkfVFYhRkLn0t1D6EgsKZoAzh9t45lWCdjQjQDWihNg2G
 UNICaw4EeSAryoVGOSATN1Frx5p9MvTT2E9DovXFtukurw1Q7H2hCF9asKB4t8fSkYf7
 aSlXnoMQ50xJpwq2sHfirc9S/REME6Mz+HOp//DXhZ7lOjDCF/7jWYzLnpmVitsBqWBC
 2iEQ==
X-Gm-Message-State: AGi0PuYH79iz1XsfpZpqQxmoy5zpl2mcHfYfsBndH+Lv6K8eFmpDpHam
 CjmSqARelO/LwVZffQs0TBe7nuKc/Ow=
X-Google-Smtp-Source: APiQypK9UZe7Qow4N4rkh1CxonWWPVzMJTSB0CQ4HdWOroIlLkl3bWKk1LRuGFUfqNGeF3MQlkuXyg==
X-Received: by 2002:ac2:4910:: with SMTP id n16mr4403959lfi.35.1588753515338; 
 Wed, 06 May 2020 01:25:15 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id h6sm825569ljj.29.2020.05.06.01.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] hw/core: stream: Add end-of-packet flag
Date: Wed,  6 May 2020 10:25:04 +0200
Message-Id: <20200506082513.18751-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

When modeling pipelines of processing nodes that communicate
through streaming interfaces (e.g AXI-Stream), some of these
nodes send packets while others may just stream unpacketized data.

The purpose of this series is to add an end-of-packet flag, e.g
what AXI-Stream calls tlast. This is in preparation for modeling
future nodes that may use huge packets that we wouldn't be able
to buffer and also to handle nodes that don't use packets.

Along the way I fixed a few things in the petalinux-ml605 eth setup.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Check that packets fit c_txmem

Edgar E. Iglesias (9):
  hw/net/xilinx_axienet: Auto-clear PHY Autoneg
  hw/net/xilinx_axienet: Cleanup stream->push assignment
  hw/net/xilinx_axienet: Remove unncessary cast
  hw/dma/xilinx_axidma: Add DMA memory-region property
  hw/core: stream: Add an end-of-packet flag
  hw/net/xilinx_axienet: Handle fragmented packets from DMA
  hw/dma/xilinx_axidma: mm2s: Stream descriptor by descriptor
  hw/dma/xilinx_axidma: s2mm: Support stream fragments
  MAINTAINERS: Add myself as streams maintainer

 include/hw/stream.h     |  5 +--
 hw/core/stream.c        |  4 +--
 hw/dma/xilinx_axidma.c  | 75 ++++++++++++++++++++++++++---------------
 hw/net/xilinx_axienet.c | 70 ++++++++++++++++++++++++++++----------
 hw/ssi/xilinx_spips.c   |  2 +-
 MAINTAINERS             |  6 ++++
 6 files changed, 113 insertions(+), 49 deletions(-)

-- 
2.20.1


