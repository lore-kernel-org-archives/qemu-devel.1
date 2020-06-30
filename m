Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5542B20768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R8bhpvOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5542B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMm3-0006lt-KV
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl1-0005R3-Gh; Tue, 30 Jun 2020 16:21:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMkz-0007iT-7w; Tue, 30 Jun 2020 16:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593548489; x=1625084489;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QOv9nM/VesXLszTyxe9l3IRHIbE95zueZzkg4ysKinM=;
 b=R8bhpvOvEW08PSMykrX0HPhbSNa3xQN0hC8+va48ffDu1Ac/e2K7X9ZU
 815rZssPKGGpsKIPhLP1KpGTYcJQMcX8gvndozAun2HNQ8YufV7ugNuAg
 jbSF+rCPYEGejG7zqLOnowL0UdlFpsymwJqW/i6kfXRSiZyg99lhgs6wS
 FD537+GpYrnB6muO4yw8IGJSj2WrspsfncOH3tJGdga8wEh2dvwye/gFi
 OOxcczWCDA4dtTBOFAhHQxC5LECW0lReMCbhxmW9jV9lfkd5xFgct8Z52
 qV0d731XQ+x2e9fL42CAfj6I+sQccjuv9mefqcGI6i683EnNVrnfZZC7a A==;
IronPort-SDR: 6Lo7j7ZpXlh3pnOxDEHrro/CLNkdcijrqLY/HdiDEoKqL/nWGNmaiTnGsjOvsLsiYDRMV6wtge
 ijkyNidCVtn8BHOWGe65gZLT8ix6C93bvWgYB++bHQGwR+ea+CV9SuHw4+Qi3rfDSXGlpgvrYI
 t4Z8zl9C88p3UHg6eN1vU+299/++xRDOi28PJsQ+TQPudgfldLnw44iR2IM5RCwPpPxzITk6dm
 ozKvKpVv45RIVQRLcDsoqdhwg2/osHtOCn9M1hGkqsxcbyIdxDOw3VPevdrEh31o1QHBgnKc4N
 h98=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="142665037"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 04:21:24 +0800
IronPort-SDR: C76hkaKbJ505QO98OR67bLbrY1KzAaBpGTzh94zZ3j/fLKXr1IQBav8/3xJFgWoAa8ezzaxXiy
 aAJtv88dah+R3b+ygirJTBdzFo9W02gVc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 13:10:15 -0700
IronPort-SDR: 6pVlwR4xMbToOkXnKBVBFlB4jZyu7t91TvIuBMk5H933AkprWLvtWPcg7LS29lZKvMH9oKp2H+
 FShKHwv3FyrQ==
WDCIronportException: Internal
Received: from us6fgspc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.109])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2020 13:21:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/3]  A few RISC-V fixes
Date: Tue, 30 Jun 2020 13:12:05 -0700
Message-Id: <cover.1593547870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=44328bdba=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 16:21:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This series has a few fixes for RISC-V.



Alistair Francis (3):
  hw/char: Convert the Ibex UART to use the qdev Clock model
  hw/riscv: Allow 64 bit access to SiFive CLINT
  target/riscv: Regen floating point rounding mode in dynamic mode

 include/hw/char/ibex_uart.h |  2 ++
 hw/char/ibex_uart.c         | 19 ++++++++++++++++++-
 hw/riscv/sifive_clint.c     |  2 +-
 target/riscv/translate.c    |  2 +-
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.27.0


