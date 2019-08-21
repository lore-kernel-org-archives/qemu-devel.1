Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D67C41514
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC76322D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC76322D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RX4-0005B6-SC
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0RVo-0003hI-7I
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0RVm-00089C-RB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:55 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:61425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0RVm-00086g-Gk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:54 -0400
IronPort-SDR: e8gQwmaXBQZc6SsldtmCq2PQP6dZYUMyD63G8UAsBR8yC4fRQ5jPaoH9b3heEZejuiidtUxZNS
 74Aw10dsAMV0cYmrU1zMiYXnUp5KMBBWkDKaqmZ/hGlDLzEtYqnRKW1t7Y28CPBz4AzINEr3ub
 hu3F7vHrhGpSbWyWIEVzo7tceKLsXvT1vpykIqvpyF65BvGVs6YSlreCG36k6zbNaWsxfMrqFe
 oUglhn5F2UZYUM5HIE9yeMwr99MpukkUICHiJV0T2OOaj2kOlVOXzLtmD0DH616FR3YAQW6GcE
 6iI=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="42443943"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 21 Aug 2019 06:22:49 -0800
IronPort-SDR: n/yvgwtbgGbwJPJz5HHa70ZzAVcvWcRdfj3Hdik8lido3BcjRy8Ss5QKZ69DdYG5/1xzE8VvDv
 wdytnxmXhwJSWj3B+nmeyTpbvUTY4u5suZUbe61SgJlKGnUzHZzOknfWaJg0uckAI+cGtSuG9K
 Ht99Zmc3TpD+fq2cIHWKigDwEjA9R79sb5W4vVpS/vNMT773oGSkMVolnlUOb88bJGeLsIC5PU
 5kDDgtFPfrAe59DzuvRkK4F+OUeHVuus/00kBuui9+06GYD8s+ZrhwL8KAqXRB9PoqFiwc6USh
 iNM=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 08:21:49 -0600
Message-ID: <20190821142151.19995-1-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.129.153
Subject: [Qemu-devel] [PATCH 0/2] Fix bug in nios2 and m68k semihosting
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I noticed recently that the exit semihosting call on nios2 was
ignoring its parameter and always returning status 0 instead.  It
turns out the handler was retrieving the value of the wrong register.
Since the nios2 semihosting implementation was basically
cut-and-pasted from that for m68k, I checked m68k also and it had the
same bug.  This set of patches fixes both of them.

Sandra Loosemore (2):
  target/nios2: Fix bug in semihosted exit handling
  target/m68k: Fix bug in semihosted exit handling

 target/m68k/m68k-semi.c   | 4 ++--
 target/nios2/nios2-semi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.8.1


