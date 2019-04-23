Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F978C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFDD208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFDD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzQz-0003gt-JD
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:42:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hIzMJ-00081S-BM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hIzKY-00086S-Vv
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:35:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49603 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hIzKW-00080M-Ug
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:35:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 7A1811A4145;
	Tue, 23 Apr 2019 19:35:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 5DA7E1A241A;
	Tue, 23 Apr 2019 19:35:32 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 19:35:22 +0200
Message-Id: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 0/4] linux-user: A set of misc patches for 4.1
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
	amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423173522.ss5flsB-r08UZNBexFkZOzR75cpegqVqJQyG2U9j5NM@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This is a collection of misc patches for kinux user that I recently
collected. Most of them originate from problems observed on target
mips. However, all of them actually fix problems on multiple
targets.

Aleksandar Markovic (2):
  linux-user: Fix support for the SIOCATMARK and SIOCGPGRP ioctls for
    eXtensa
  linux-user: Add support for the SIOCSPGRP ioctl

Daniel Santos (1):
  linux-user: Sanitize interp_info and, for mips only, init field fp_abi

Neng Chen (1):
  linux-user: Add support the SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls

 linux-user/elfload.c      | 5 +++++
 linux-user/ioctls.h       | 3 +++
 linux-user/syscall_defs.h | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.7.4


