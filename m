Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD5E20656
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgoST-0004Im-Hc
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33601)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgoMF-0006sr-CK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgoME-0000Gw-9j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:43:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46393 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hgoME-0000Dg-35
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:43:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7DCD31A225F;
 Fri, 28 Jun 2019 12:43:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 564C51A2015;
 Fri, 28 Jun 2019 12:43:50 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Fri, 28 Jun 2019 12:43:33 +0200
Message-Id: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v16 0/5] linux-user: A set of miscellaneous
 patches
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This is a collection of misc patches for Linux user that I recently
accumulated from variuous sources. All of them originate from problems
observed on mips target. However, most of these changes actually
affect and fix linux-user problems on multiple targets.

There are three checkpatch warninhs and two checkpatch errors that
sould be ignored in the given circumstances.

NOTE: Two checkpatch errors and three warnings are false alarms.

v15->v16:

  - renamed statx->sys_statx

v14->v15:

  - removed inclusion of sys/stat.h from patch #1
  - a minor correction in the commit message for patch #3
  - amended patch #5 to reflect the kernel behavior wrt FPE

v13->v14:

  - several minor corrections in commit messages

v12->v13:

  - removed two patches that got accepted
  - simplified the patch on statx()
  - added a patch on TARGET_HAVE_ARCH_STRUCT_FLOCK
  - added a patch on fixing EXCP_FPE handling on MIPS

v11->v12:

  - used the preffered Laurent's email address for linux-user
  - added a note on checkpetch warnings and errors in the commit letter
 

v10->v11:

  - patch on <ADD|DROP>_MEMEBERSHIP basically reverted to its first
    version
  - corrected patch on statx()
  - added patch on strace support for statx()
  - added patch on fixing flock structure for MIPS O64 ABI

v9->v10:

  - improved commit messages for patches 2 and 3

v8->v9:

  - fixed build error on some systems related to SOL_ALG

v7->v8:

  - added a patch on setsockopt() option SOL_ALG

v6->v7:

  - fixed a build error for older kernels related to the patch on
    setsockopt() options
  - removed four patches that on the meantime got accepted into the
    main source tree

v5->v6:

  - fixed a mistake in patch #4
  - improved commit messages in patches #4 and #6

v4->v5:

  - added the patch on statx() support
  - improved the patch on IPV6_<ADD|DROP>_MEMBERSHIP to take into
    account the possibility of different names for a field
  - minor corrections in commit messages

v3->v4:

  - improved commit messages (fixed some typos, improved relevance)

v2->v3:

  - updated and improved commit messages
  - added IPV6_DROP_MEMBERSHIP support to the patch on setsockopt()'s
    option

v1->v2:

  - added the patch on setsockopt()'s option IPV6_ADD_MEMBERSHIP
  - improved the commit messages


Aleksandar Markovic (3):
  linux-user: Fix target_flock structure for MIPS O64 ABI
  linux-user: Introduce TARGET_HAVE_ARCH_STRUCT_FLOCK
  linux-user: Handle EXCP_FPE properly for MIPS

Aleksandar Rikalo (1):
  linux-user: Add support for translation of statx() syscall

Jim Wilson (1):
  linux-user: Add support for strace for statx() syscall

 linux-user/generic/fcntl.h     |   8 +--
 linux-user/mips/cpu_loop.c     |  17 ++++++
 linux-user/mips/target_fcntl.h |  17 +++++-
 linux-user/strace.c            |  86 ++++++++++++++++++++++++++++++
 linux-user/strace.list         |   3 ++
 linux-user/syscall.c           | 115 ++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h      |  37 +++++++++++++
 7 files changed, 277 insertions(+), 6 deletions(-)

-- 
2.7.4


