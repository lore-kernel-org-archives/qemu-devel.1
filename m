Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55918C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E03B20645
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E03B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45359 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMcMS-00027v-7h
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:52:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMcKr-0001Dz-9x
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMcKp-0007Pu-JD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:51:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54736 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hMcKp-0007MZ-D3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:50:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id D5A981A200D;
	Fri,  3 May 2019 19:50:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id B607F1A1F9B;
	Fri,  3 May 2019 19:50:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 19:50:41 +0200
Message-Id: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 0/5] linux-user: A set of miscellaneous
 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, thuth@redhat.com, jcmvbkbc@gmail.com,
	arikalo@wavecomp.com, daniel.santos@pobox.com,
	amarkovic@wavecomp.com, nchen@wavecomp.com, philmd@redhat.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503175041.UYQwwkoeuOucesqnjWobkYqXebSs2Sucoy2473q4Fxs@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This is a collection of misc patches for Linux user that I recently
accumulated from variuous sources. All of them originate from problems
observed on mips target. However, these changes actually affect and fix
problems on multiple targets.

v3->v4:

  - improved commit messages (fixed some typos, improved relevance)

v2->v3:

  - updated and improved commit messages
  - added IPV6_DROP_MEMBERSHIP support to the patch on setsockopt()'s
    option

v1->v2:

  - added the patch on setsockopt()'s option IPV6_ADD_MEMBERSHIP
  - improved the commit message of interp_info sanitizing patch

Aleksandar Markovic (2):
  linux-user: Fix support for the SIOCATMARK and SIOCGPGRP ioctls for
    xtensa
  linux-user: Add support for the SIOCSPGRP ioctl for all targets

Daniel Santos (1):
  linux-user: Sanitize interp_info and, for mips only, init field fp_abi

Neng Chen (2):
  linux-user: Add support the SIOC<G|S>IFPFLAGS ioctls for all targets
  linux-user: Add support for setsockopt() options
    IPV6_<ADD|DROP>_MEMBERSHIP

 linux-user/elfload.c      |  5 +++++
 linux-user/ioctls.h       |  3 +++
 linux-user/syscall.c      | 19 +++++++++++++++++++
 linux-user/syscall_defs.h |  8 +++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.7.4


