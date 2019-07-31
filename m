Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F14BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A06206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A06206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstDS-0003ub-Lm
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50558)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hstCZ-0002Bl-Ff
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hstCY-0001Dw-Hz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:51 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41986 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hstCY-0001Ci-BQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0D2C91A22A8;
 Wed, 31 Jul 2019 20:19:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E85651A2252;
 Wed, 31 Jul 2019 20:19:45 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 20:19:26 +0200
Message-Id: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v4 00/12] linux-user: Misc patches for
 4.2
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

A set of misc linux user patches for 4.2.

v2->v3:

  - reworked the patch on semtimedop()
  - added five patches containing support for ten additional
    ioctls
  - minor improvements of code formatting

v2->v3:

  - minor code formatting improvements
  - added a patch on semtimedop()

v1->v2:

  - updated commit messages
  - minor improvements of code formatting
  - added three patches containing support for ten additional
    ioctls

Aleksandar Markovic (10):
  linux-user: Add support for FDMSGON and FDMSGOFF ioctls
  linux-user: Add support for FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT
    ioctls
  linux-user: Add support for FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls
  linux-user: Add support for FDSETEMSGTRESH, FDSETMAXERRS, and
    FDGETMAXERRS ioctls
  linux-user: Add support for HDIO_GET_NICE and HDIO_SET_NICE ioctls
  linux-user: Add support for HDIO_GET_WCACHE and HDIO_SET_WCACHE ioctls
  linux-user: Add support for HDIO_GET_ACOUSTIC and HDIO_SET_ACOUSTIC
    ioctls
  linux-user: Add support for HDIO_GET_ADDRESS and HDIO_SET_ADDRESS
    ioctls
  linux-user: Add support for HDIO_GET_BUSSTATE and HDIO_SET_BUSSTATE
    ioctls
  linux-user: Add support for RNDRESEEDCRNG ioctl

Aleksandar Rikalo (1):
  linux-user: Add support for semtimedop() syscall

Yunqiang Su (1):
  linux user: Add support for FDFLUSH ioctl

 linux-user/ioctls.h        | 26 ++++++++++++++++++++++++++
 linux-user/syscall.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 43 +++++++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_types.h | 12 ++++++++++++
 4 files changed, 122 insertions(+)

-- 
2.7.4


