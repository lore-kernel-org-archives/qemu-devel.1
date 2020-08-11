Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9259C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A29206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EIUgCEv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A29206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5d8T-0003Ku-Nj
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 18:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=485daf1e4=dmitry.fomichev@wdc.com>)
 id 1k5d7J-0001xU-Td; Tue, 11 Aug 2020 18:51:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=485daf1e4=dmitry.fomichev@wdc.com>)
 id 1k5d7H-0004ND-5v; Tue, 11 Aug 2020 18:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597186295; x=1628722295;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9QeqkiImJC18cJbH6V8KsxnKB12z6bB/HRK/yrx13JI=;
 b=EIUgCEv90FE8Q7GEB/FRv8WNhy6s136FZoR7m3WueqBeODRz/vv6vmgV
 K2DJ/PunJy3dsK1jhnkMxXh/mSr6SmZh9bbDHLjYHhY4E5kmyKx5lNmis
 E8n+nuyGCe41lTOBejEH346HAA7Dwyzu/TrIAzCJ+BbAV8SlgPhaPR1bk
 j9L3chXEp2/twK/K/JjmUZ9j96PxwutW7zBr57WVbp96MNBMTKD9kxyec
 lcNSAKN5hs9OWHcrhFIvGMgeoyx0RPVTWvhdq4mjl89frGIFVtm4F1Srt
 qC6ViDkwme+gRc2vyrZ1/ZWW5CQSGK9k5uzG8PzmuQb42U4omAsUm+4vh A==;
IronPort-SDR: 2uJBc7ITauCOvwYswf+2sYL5ruoojvsvfK0iwizU1A2NPFV3jGBUUV75gb+Q1NVf343HvjzXJF
 RIeNHIF4wiCWyAbB7AdS9RBSQBuctEfbENwDzdQRkv80U7th7bTWW2aAKOGJkrDHLBSoc9wgvs
 ZxJbqRU9y1pdBJdMQatuQJgOZiJcIyg8XghaBOA7kn1ND+nrw5rV2taEP7RNF+S1oD4kx1hdsU
 Uz6VcWu4OeFZak/Kx8ZdjJ7qsAaw3C+aKG14AqBz3LtC6lMbPjtb8kjrUjeTcCMHAj6QzzIsmV
 5co=
X-IronPort-AV: E=Sophos;i="5.76,302,1592841600"; d="scan'208";a="144706608"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2020 06:51:29 +0800
IronPort-SDR: 0ZNXIfAMP/oQQZwnf334C6161SjXskbIU8vhOfpvUgMMnk7xweU0Nm0WYCoJiZetLo/sQwgNjG
 NpVMJgOYwpdw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 15:38:39 -0700
IronPort-SDR: 03F7KE/HTH0+3glXegbukjPZet0ZB9QC7KnVWtYnB/tKSU8Fd0Hq6OxnCf5c91wd7yKGnu2C5P
 Y4VVD2adUl+A==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2020 15:51:28 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH 0/2] block;scsi-generic: Fix max transfer size calculation
Date: Wed, 12 Aug 2020 07:51:20 +0900
Message-Id: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=485daf1e4=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 18:51:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a host-managed zoned device is passed through to the
guest system using scsi-generic driver, the maximum i/o size for the
drive at the guest may end up being larger than at the host, causing
i/o errors while accessing the backing zoned drive at the host system.

Two problems prevent correct setting of the maximum i/o transfer size
at the guest in this configuration. One issue is specific to
host-managed zone devices - scsi-generic driver doesn't recognize the
SCSI type of HM-zoned devices. The other problem is that file-posix
code for finding max_segments system value doesn't correctly handle
SG nodes.

The following two patches fix these problems.

Based-on: <20200424084338.26803-16-armbru@redhat.com>

Dmitry Fomichev (2):
  file-posix: Correctly read max_segments of SG nodes
  scsi-generic: Fix HM-zoned device scan

 block/file-posix.c       | 55 +++++++++++++++++++++++-----------------
 hw/scsi/scsi-generic.c   | 10 +++++---
 include/scsi/constants.h |  1 +
 3 files changed, 39 insertions(+), 27 deletions(-)

-- 
2.21.0


