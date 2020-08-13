Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE05C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037CB20781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037CB20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k675D-0008H2-0g
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673K-0006O3-0v
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673I-0004bh-4C
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:29 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MILru-1jrnhB1Miy-00EQqs; Thu, 13 Aug 2020 08:49:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] Linux user for 5.2 patches
Date: Thu, 13 Aug 2020 08:49:09 +0200
Message-Id: <20200813064923.263565-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QCLS3UvoO/Ba87bnCFZKbu1Sso16I52Q28w1pnUM+LFyjsXF/8H
 W/36EO2M+KVQcgQnrCI34C+2J8L72GAl0dceB9dI3arQK8y29Th+Veb1J2k4Qdu5iE4xIKe
 RteaQpRJMPZD53nNYR8MKugtiBELTFltkh+A5uaobekDzBq2Y4jEhcHM5TIohvuT3dPzEr1
 pNV7nN5g36wCMXmDCWxdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B0GR8nrNQPY=:7fX5gILxsw1SwDOVE84wu3
 Z9h/Mem73Q3D2XysTrq3fVUzBr0jEXqIwbovRwPidcc9JpPO/1kF8280mD4zocQenHeehF5OY
 u0548IYaz0RmaJeln478XtTdspIXA6bo00Hjth1XzJLUTqk/TCXepp1yNg1DIwijsiQWUrlcW
 Q4w+okngqEMH3W2WF2AgVoWmBLcuSTBS811I5BeD8RvtB+sGAMDxlavOS+8Eg1axj1g/XlJae
 yWZn4ZQvGbG6BPPjyAicWurMCMpXEO9/y6dc1yNUXH14V8y7H8GwYobyX4U0TdiyD7w1hBmVG
 Fgxeabe2CQ+2ZlBtl77csQY6EAIIQvCO6u8RjsW4700pMW2zCjbgX5SV3mbJOU3zt1Ba6l6rs
 aprtQ8gFOaYCsv1wyPA0IcbJVYNEe4ICIsAHkZGS0YrE+pbF3bVCFzwk1NAb/fqCXcTvDHCi4
 e5KZLK6J2LtT9c+V2lUC4bdDXYvH9unlEuo0awLUZcNoIK4Lo0sX4ytIh/3XpMTTCY42NzU8c
 Dfu+5PbUrRA5SakMkn//KXOFwKeXS/Tk7QdxBxDwOi4j5tCulW6KQg5wP4NYR5B8jRwWnj3Mr
 KNlCNMTw9uJDYNOmprOpajPSvTXobhGY640AM34aANrRo0xLZgKqtx9R2m2WIU7AzMSXPIZ45
 m4PxU7OntkAs5kiVt9co84bD20fyLOff3YXlBswhsv7/sBNn/BgxLUPVc7sUKb5z8KwoA9wYA
 d64LlNotBAO4kH2mm/xJP7WYmXH1sZz0/rQKc37lWTaza/+/cRNebyDRVJAxmIgUyRPRm6MfS
 L4xr/C9upySdwq7OD5QNo8NUSd6HJWjoh9fxUnvoU3F9+xGX+6Z8lZQ2A8rwItEUII5Av9M
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc=
:=0D
=0D
  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to 04275cad60c8f99e0dd7f56aecda68ceac926da8:=0D
=0D
  linux-user: Fix 'utimensat()' implementation (2020-08-12 10:09:58 +0200)=
=0D
=0D
----------------------------------------------------------------=0D
Add btrfs ioctls=0D
Add clock_getres_time64, timer_gettime64, timer_settime64,=0D
    timerfd_gettime64, timerfd_settime64=0D
Some fixes (page protection, print_fdset, timerspec, itimerspec)=0D
=0D
----------------------------------------------------------------=0D
=0D
Filip Bozuta (12):=0D
  linux-user: Fix "print_fdset()" in "strace.c" to not print ", " after=0D
    last value=0D
  linux-user: Modify 'target_to_host/host_to_target_itimerspec()'=0D
  linux-user: Add support for a group of 2038 safe syscalls=0D
  linux-user: Add support for a group of btrfs ioctls used for=0D
    subvolumes=0D
  linux-user: Add support for a group of btrfs ioctls used for snapshots=0D
  linux-user: Add support for btrfs ioctls used to manipulate with=0D
    devices=0D
  linux-user: Add support for btrfs ioctls used to get/set features=0D
  linux-user: Add support for a group of btrfs inode ioctls=0D
  linux-user: Add support for two btrfs ioctls used for subvolume=0D
  linux-user: Add support for btrfs ioctls used to manage quota=0D
  linux-user: Add support for btrfs ioctls used to scrub a filesystem=0D
  linux-user: Fix 'utimensat()' implementation=0D
=0D
Richard Henderson (2):=0D
  linux-user: Validate mmap/mprotect prot value=0D
  linux-user: Adjust guest page protection for the host=0D
=0D
 configure                  |   9 ++=0D
 linux-user/ioctls.h        | 124 ++++++++++++++++++++++++=0D
 linux-user/mmap.c          | 110 ++++++++++++++-------=0D
 linux-user/strace.c        |   8 +-=0D
 linux-user/syscall.c       | 193 +++++++++++++++++++++++++++++++------=0D
 linux-user/syscall_defs.h  |  42 ++++++++=0D
 linux-user/syscall_types.h | 140 +++++++++++++++++++++++++++=0D
 7 files changed, 563 insertions(+), 63 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

