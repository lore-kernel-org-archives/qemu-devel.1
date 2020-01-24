Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384612071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384612071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1Dn-00083v-DF
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1CM-0005YZ-0G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1CK-0006MP-NK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43512 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iv1CK-0005wI-Em
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0E3EA1A20C5;
 Fri, 24 Jan 2020 16:47:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E2D841A1FE9;
 Fri, 24 Jan 2020 16:47:34 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] linux-user: Add support for fs and fd ioctls
Date: Fri, 24 Jan 2020 16:47:15 +0100
Message-Id: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series is a spin-off of v5 of earlier series "linux-user: Misc
patches for 5.0", that became too large to manage. I will submit the
rest of that large series separately.

The only difference between patches in this series and in the former
series is that all Laurent's comments and concerns were addressed.

The summary of the patches is as follows:

Patches 1-3: Adding support for some filesystem-related ioctls
Patch 4: Adding support for a floppy-drive-related ioctls

v1->v2:

  - removed patches that have been already merged
  - recheck that I addressed all Laurent's concerns
  - rebased to the latest upstram code

Aleksandar Markovic (4):
  linux-user: Add support for FS_IOC_FS<GET|SET>XATTR ioctls
  linux-user: Add support for FITRIM ioctl
  linux-user: Add support for FIFREEZE and FITHAW ioctls
  linux-user: Add support for FDGETFDCSTAT ioctl

 linux-user/ioctls.h        | 18 ++++++++++++++++++
 linux-user/syscall_defs.h  | 29 +++++++++++++++++++++++++++++
 linux-user/syscall_types.h | 17 +++++++++++++++++
 3 files changed, 64 insertions(+)

-- 
2.7.4


