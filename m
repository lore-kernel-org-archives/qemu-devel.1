Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74661C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8B1206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8B1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTozo-00072x-Dl
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:47:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowt-0004Bw-99
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTows-0006A1-7m
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowq-00066W-K0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:02 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MLRI3-1hC16t3ou3-00IWOV; Thu, 23 May 2019 16:43:41 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:26 +0200
Message-Id: <20190523144336.13960-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HRooP9euUCJlkR+ci8KlUc0bMHht5F1NMkLaQyYItDitp1OSzZk
	KsCOOInlqkw9ELToGuKqH9ON4tkUH3odW3moRJHJEvFlIQzDAxGtd6ZKB2LVOka1bUISM62
	AAHJeeT24FyDGYeldCOSRdObSmlk4DIAf0frZN6dw8zdYH3twbbB/BAPbpXrXE3qBCHWVxI
	YPyt/mrP4LSfz5v12SNEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qbxw/nq8opw=:ukNkV8XSDnIog9YR6iD/+u
	afJFp2y7kph5artMswpVUzC9VTDL2jcrUDlMjb/gX8uXRuJA/JwoIjvIN7y0ZPndWc1agWZYc
	3vuwwo2QBRi3dG9JpicFy1jceW4tBecHFIiz2PyqJbZ4D/wPO42AdsSSGRR8tULqLoGWB4kci
	oIf/5p3QOdaMcBqlG51P/HHZBfA2TifDz9+w5Sj/P4rmquykJrSnRE13AgCHMZtg+2vp48mBI
	D7cx8GxJNdHP++vRaMl308xRLi1j934P42oM0Pggw5sBM4C0EDdkMa841p3gMZAxIUYUF/hSN
	85hlAWPKapyToXLhRlMqKPKKZNOXc8jvjHM7evrA6HVzFOyEZKkJIRc832JEO7c7zdpCepFbR
	jhUHerxIwJ/wxiIEg121PmCylPk1TC10gTpcrsHipk/yW/n5+N3XHFPmuIkzv6FhrF660Ip6B
	XWJ2jkB9gmPxBF5bgMToEqIOTlxGJ1PHJNuZLID4Aet4XKi7wK60kWmu6Xh/g/e5MqKeyHYvC
	yxWFMOkZuk18K6j10Tsx6SBpL29o8szi4Vg6r8B14YWVh3duqO7G3qI1dNPTX0TYQl1YeyAPT
	c+ZebXEMaIB1wiANl7MaZ8LslV+DymZmwpIald3BY3CMJC2Ldq8vDZDRVu/ZE/DpjXp/5lC/i
	xQp6EprIc1OZfj/L0HygqZHmzWmChZQ1OdQni+Nlq1G8JmL2fmRY0aI0moARG1HRwkCtMrgC5
	JcMQGoBR7JoTWDKdLNhjb02Omckyp5iSwROUW0D2SnI6j2O9fJPtx7cNc/0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL 00/10] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to 069a1504ee1e2943964d0357d798e11b66afd351:

  linux-user: Pass through nanosecond timestamp components for stat syscalls (2019-05-22 20:50:55 +0200)

----------------------------------------------------------------
Add /proc/hardware and /proc/cpuinfo,
update SIOCXXX ioctls,
update IPV6 options,
fix shmat emulation,
add nanoseconds in stat,
init field fp_abi on mips

----------------------------------------------------------------

Aleksandar Markovic (2):
  linux-user: Fix support for SIOCATMARK and SIOCGPGRP ioctls for xtensa
  linux-user: Add support for SIOCSPGRP ioctl for all targets

Chen-Yu Tsai (1):
  linux-user: Pass through nanosecond timestamp components for stat
    syscalls

Daniel Santos (1):
  linux-user: Sanitize interp_info and, for mips only, init field fp_abi

Laurent Vivier (2):
  linux-user: add pseudo /proc/cpuinfo for sparc
  linux-user: add pseudo /proc/hardware for m68k

Neng Chen (2):
  linux-user: Add support for SIOC<G|S>IFPFLAGS ioctls for all targets
  linux-user: Add support for setsockopt() options
    IPV6_<ADD|DROP>_MEMBERSHIP

Richard Henderson (2):
  linux-user: Fix shmat emulation by honoring host SHMLBA
  linux-user: Align mmap_find_vma to host page size

 linux-user/elfload.c      | 22 ++++++++----
 linux-user/ioctls.h       |  3 ++
 linux-user/mmap.c         | 72 +++++++++++++++++++++------------------
 linux-user/qemu.h         |  2 +-
 linux-user/syscall.c      | 72 +++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h | 57 ++++++++++++++++++++-----------
 6 files changed, 166 insertions(+), 62 deletions(-)

-- 
2.20.1


