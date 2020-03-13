Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E7C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B0C206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8ZjeQrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B0C206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYXm-0005Hm-R8
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coreyw7@fb.com>) id 1jCYCp-00046U-Er
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coreyw7@fb.com>) id 1jCYCn-00028R-DC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:29:38 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:49147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <coreyw7@fb.com>)
 id 1jCYCm-00023W-FY; Thu, 12 Mar 2020 20:29:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id 7219659B;
 Thu, 12 Mar 2020 20:29:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 12 Mar 2020 20:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fsRtuS8klfa5SD3pP
 frMomknIQY0F1oVMbRs0q2bW/Q=; b=P8ZjeQrTAhzmJC80KaQ+eiKahCp276w6G
 YzF4bl50Tet9kjOtFl1K2WYvRQPS2kLtjsCMCpN/o3EhUuVRyGOCjcpWEfyYICLb
 etmeTndnIMKoKY6ZoVLjg4Ku10Q7OL/DrZTxw5RleMuFtfaHUB6kk4WSOCmrk5H+
 WyrzM1ulVPmr8um9EcXJ82X4kXD9uYK37kBJ4rTatqkVOGp8Ti6Y1PXqdTKElGpU
 SXzzPQT/YOJVP4tzXgYnCpIFG4JX7MBRwZovKeiijfDnl0NqmLMl5U1LimtMLnhV
 JXH7yB28nJ++GdLKGNPQj1ok2GvRdP2QJxszeBcJxfzvYWLuzT/2w==
X-ME-Sender: <xms:7NNqXjVBbyFumCcT6kZxajmRoLb51uT13KaGL_ycH4Vm-Wg6Kc9SAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddviedgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevohhrvgihucgh
 hhgrrhhtohhnuceotghorhgvhiifjeesfhgsrdgtohhmqeenucfkphepudeifedrudduge
 drudefvddruddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpegtohhrvgihfiejsehfsgdrtghomh
X-ME-Proxy: <xmx:7NNqXk7RvSeYussFh5v5HfTIxM7ZqwYxo4iy5xCFBVMPHpr6WWvjcA>
 <xmx:7NNqXmoBPHQvpT-dzWVD0G3llO6j8UamnCi-tpnrbYwoJWbxTYmrSg>
 <xmx:7NNqXvn0uS8u5niQgnv5XxXzfltHAfIc3Admy6JPv1_44ygGxEmdZA>
 <xmx:7dNqXv8FO8e5idrhK8Zkxf9x_uck7My3KHYI8g-gIiCXZvNs4GREmaJVAfU>
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com (unknown
 [163.114.132.128])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2003F3061363;
 Thu, 12 Mar 2020 20:29:31 -0400 (EDT)
From: Corey Wharton <coreyw7@fb.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 0/2] Support different CPU types for the sifive_e machine
Date: Thu, 12 Mar 2020 17:29:21 -0700
Message-Id: <20200313002923.30905-1-coreyw7@fb.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.26
X-Mailman-Approved-At: Thu, 12 Mar 2020 20:50:33 -0400
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Corey Wharton <coreyw7@fb.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this patch set is to allow the sifive_e machine to run
with different CPU targets to enable different ISA entensions. To that
end it also introduces a new sifive-e34 CPU type which provides the
same ISA as sifive-e31, with the addition of the single precision
floating-point extension (f). The default CPU for the sifive_e machine
is unchanged.

A user can change the default CPU type by specifying it with the '-cpu'
option on the command line.

Corey Wharton (2):
  riscv: sifive_e: Support changing CPU type
  target/riscv: Add a sifive-e34 cpu type

 hw/riscv/sifive_e.c |  3 ++-
 target/riscv/cpu.c  | 10 ++++++++++
 target/riscv/cpu.h  |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.21.1


