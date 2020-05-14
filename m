Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0257FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB9D20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS6IYaRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB9D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEdr-0000Vg-Tq
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEci-0007Fa-6q
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:08 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:34426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcg-0003lM-Vw
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:07 -0400
Received: by mail-lj1-x235.google.com with SMTP id b6so3733560ljj.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=72ECmrG/08kvuMO0CCNbIeO6GU3AR4WLVgAwouR/APw=;
 b=GS6IYaRiDCj7/XuUMImQ/LFUHvSgBHGePtuwzBvkEGQULobGZ1fGt0YlDXJ5ivDHGA
 fx3/h7tfKRcEoVFXQNq/huIS/EGkVVhR8nMIcCsPLYY/UuLr7xnTAcBZMLNu1e6u/ba7
 20izAg0T8JyP0pNJaVhfSMs2uxerVsOTXgENklvrtGw9uHFr6kX/q8rSW4l8cAF2/CNG
 /bQvo8gV4aUl45aGthtj9DxrJu/chdyDcLMpftjtdjGrE1AvaIh9X0Kpc2gc1hQDFagp
 pNFeBDcHOlU+vOK0Z0eOOe1+8h6wW3rkrmRVu89NWgGixq24BVQLxw7htVus0sn7Dpio
 LPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=72ECmrG/08kvuMO0CCNbIeO6GU3AR4WLVgAwouR/APw=;
 b=XJXPc2EZ9JIFenmpzUCt9FScv05IqXmznc03iw7KfufFlmKPaf6Gg/g5h8WxvaKIZC
 kjMV9z46YzOuOKV6KO1THxIKNcpXob6ge7aYoomzS5F0xMSv91gm9FvgOCrfKc8U7zok
 BksUx/9qAlIJ+oyLTz2a6ousk5rxYAuaLjmD9q6jkEBCq4mEs92VUBDlS8ctZME8gcfH
 x/3etZpeX1GmPakkGghWxsUSR8B7o/52ZC1OZuOjwLKzcs2er2b+jEC3pDB0gJyfHyij
 1NaUrQl9toMqqdzXZMKGftHfOdicYJsNmMQcX0EnEO84JkhoIqQdB2J6qyLBNEfNzMEs
 6kWQ==
X-Gm-Message-State: AOAM533i+fHGnpLnRgRjQ8KTD3dbRPcQ+4mN3cipQLJYTh3p5yZyzEmH
 vQwM/7aC0gmlpxTOcgBrrvKsZa/W5zI=
X-Google-Smtp-Source: ABdhPJxqofVq3HqHwyuGaRN/IMM/e+YdztXL3O/wU9XALfLgcLSBb3vAolmRAHeZukOMQgtPpvgilQ==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr3023256ljc.189.1589465643800; 
 Thu, 14 May 2020 07:14:03 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b8sm1891256lfq.70.2020.05.14.07.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 00/14] Xilinx queue 2020-05-14
Date: Thu, 14 May 2020 16:13:48 +0200
Message-Id: <20200514141402.12498-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit 035b448b84f3557206abc44d786c5d3db2638f7d:

  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-14' into staging (2020-05-14 10:58:30 +0100)

are available in the Git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2020-05-14.for-upstream

for you to fetch changes up to 2ead1b18ca1bbc41c09a82d980e1e5f53afa08eb:

  target/microblaze: monitor: Increase the number of registers reported (2020-05-14 16:01:02 +0200)

----------------------------------------------------------------
Upstream

----------------------------------------------------------------
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

Joe Komlodi (4):
      target/microblaze: Fix FPU2 instruction check
      target/microblaze: gdb: Extend the number of registers presented to GDB
      target/microblaze: gdb: Fix incorrect SReg reporting
      target/microblaze: monitor: Increase the number of registers reported

Tong Ho (1):
      target/microblaze: Add MFS Rd,EDR translation

 include/hw/stream.h           |  5 ++-
 hw/core/stream.c              |  4 +-
 hw/dma/xilinx_axidma.c        | 75 ++++++++++++++++++++++-------------
 hw/net/xilinx_axienet.c       | 70 +++++++++++++++++++++++++--------
 hw/ssi/xilinx_spips.c         |  2 +-
 target/microblaze/cpu.c       |  2 +-
 target/microblaze/gdbstub.c   | 91 +++++++++++++++++++++++++++++++++++++++++--
 target/microblaze/translate.c | 19 +++++++--
 MAINTAINERS                   |  6 +++
 9 files changed, 218 insertions(+), 56 deletions(-)

-- 
2.20.1


