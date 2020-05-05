Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BDDC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 23:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87884206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 23:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lzcU5FLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87884206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW6pw-0002zY-Lv
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 19:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=387c5e0cc=alistair.francis@wdc.com>)
 id 1jW6pC-0001tJ-Df
 for qemu-devel@nongnu.org; Tue, 05 May 2020 19:18:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=387c5e0cc=alistair.francis@wdc.com>)
 id 1jW6p9-0007G7-E6
 for qemu-devel@nongnu.org; Tue, 05 May 2020 19:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588720684; x=1620256684;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UkXZM1PqAJve1e5XjR0sy+0NLnU1uhiIAmHhIxkd4qA=;
 b=lzcU5FLzeqgfLKWW1xuJVlpc59cnmqgJQ1LgK83Ku0MzwD0RFuPRMZ4A
 b8wz8ReQ02JpPmT1C4WUi6PF3oSuSuJnGZUMiwucbb5vQR8JgafAa50EO
 b8QdnK2k0nEk0jCDUjxFmRze8FLASA6Diska8B80bVXw3zeLsu6lXFYMD
 j+dJMFczVDIRCpw/UF/Rf6EmM7SykwzT1kg7DzyXJQdWtoNrHIe5siXM+
 dV7u3T3IoGL0cb/74dcfIwYsK2m56FCK74MEzAEY8R7aPAv7DQc80A/qo
 joP6x7WKBaZdXB2QfCCk3FPdMFbceWmCYDIPI/3sCQ/byaxoNOLRlROT7 A==;
IronPort-SDR: SDNXntO06ndU6mmeDyoWXPWcarO6YISy7qCwfq0b+Lav6Xt86gQaW021uGLdylk5d0CxWSHW+u
 MNR0ylei/UhyAZppVCg5seUYqAdYK5hQ3JIj8N6h09FVLpJOxoZ4Bt7hxi6Z8jIl+C8YOA4klk
 gMJ94+tPu7nPBOtqT0PXCx+mqFhDClU7+Md6HJnaV97/l0b9qmldySa1KUee22fKO2LGOBygt5
 YOOwaEmwXN0twisW5QDnTF72G9LDmK+jJIuKJpYhwZxvBdyPNV8zHrAH7hLitCDYKywYG49Fhg
 mcc=
X-IronPort-AV: E=Sophos;i="5.73,357,1583164800"; d="scan'208";a="137331070"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 07:17:59 +0800
IronPort-SDR: BTtWmSj5Wq9rxZailTR9OOlnh+4Ww9c/R54ow4egApZ5r4NMbbAJN2iuAWD4oHebYRoC2wMi8D
 Q3uKX1cV5QvuKjQDzg1ubw0lutEfuygL4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 16:07:52 -0700
IronPort-SDR: 7bJHDSczy4GmazrAGrxmSVzVXspaozkI4n8uSc/CgVcMsTPz2fnUw77rCfZPD/Bhpz67Ki1mxW
 QlXFrIfoJwMg==
WDCIronportException: Internal
Received: from use204286.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.224])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 May 2020 16:17:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 0/1] Register API Queue
Date: Tue,  5 May 2020 16:09:40 -0700
Message-Id: <20200505230941.3984108-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=387c5e0cc=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 19:17:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f19d118bed77bb95681b07f4e76dbb700c16918d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-05-04' into staging (2020-05-05 15:47:44 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-reg-to-apply-20200505

for you to fetch changes up to f08085f49fb66a5cdc86653bd896d0e728bcee50:

  hw/core/register: Add register_init_block8 helper. (2020-05-05 13:37:51 -0700)

----------------------------------------------------------------
Pull request for RegisterAPI

This is a single patch to add support to the RegisterAPI for different
data sizes.

----------------------------------------------------------------
Joaquin de Andres (1):
      hw/core/register: Add register_init_block8 helper.

 hw/core/register.c    | 46 ++++++++++++++++++++++++++++++++++++----------
 include/hw/register.h |  8 ++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

