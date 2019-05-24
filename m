Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A439FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D87B217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D87B217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8Uf-000513-Lb
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:36:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Px-0001vv-Ir
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Pw-0003Rs-Id
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:31:21 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Pw-0003R9-9a
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:31:20 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MMoXC-1hBMUE1Xz2-00Ii3v; Fri, 24 May 2019 13:25:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:11 +0200
Message-Id: <20190524112520.17684-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EWFXffn87Sj/ccFFTBy1cmwbNR4kSBEn+xKNG6eYTwnxNfg3Is/
	+p6fF8rKPwfv964D3dfa5CxvcGXV77RRE5sFDReE+CGYMGptWHl0scgn6SF5j04ZXyJc1GK
	+5dwFdS/HCnoissDbcwRaASDu2Gl1HsyHpcF68LUvIbHSxhiu7tXynaHUbKR/NV/dLmPfsY
	pNvMA/B+JeAolmbgIe2MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N8g5UsJ7N4o=:R92f/fp4uuinxVVuWeXQ5z
	KhSkrPJ8xME/dlE1+LiZq3UM1/aTzsD6wSGVCet/Pl/k61UZ6iTAA1dO6Hc0axQsFOekv7hfK
	elQ/MBsvuN/7osmcpAPPskAo5bpxNV2EFZB3xBEIbyiVbNH8t2vwzlebHEceNNylIxrrdus7X
	po3bLPhpjmaUZjorp9XRQtG8HyyvDWT0Y24ynvWFMQkMhZ8slJioRv/+AEgaBR4S5uj5i08U7
	nLll22eBkMggGdKeDdYLz8StgtVpX86q9iA1RmTUBi8RpqtIlPLDRMHTh7KS2yStSHpbjHiiG
	TtnVpqQrW5J0ulQtI9DvufOb8Zl31AR4C1T11lRqpl/yXAVUeOGzHUAoSBXuXwuyhVaf4Ez4b
	92A0wGH87CKcyA2W6WJr/k5fIumK8W7Yi2pPSHAzc13JkL6ffZlmwAKX9uq3Nc+joxtEnjDth
	tyk/JZQ4lC9Co3CrVuiWrg0zpcWqwws/QTV9+ZouVaQwAkogMs8pxnlkHHEadHURnHmlZsTxh
	nVzREE0irnd0lJbgN1xd2lfTDQe+Qtr8/yg4e4aXcIsRCgmzXUXcBQtbNN0tFnZ8tEo8Crufk
	8GdSgZ8/FZI0lrgzsdWVnmAJwSBjj5lUEqmT9pqQoOpiPtkSEM1rEeJaBH4aGkwnvI+ALnFYk
	Sv8K8d/Lpnr/UaBbQ2Q/1IQ8AP6VjEx4p4xdGthAnpT2OlWRF0nhIw5T7Lxoe3r+C+ju1uHEB
	qH7sj0JVassZSQ+ei4qpE9TVmz1l0gTX3BOhQHy1t7kkSHPdaPzGFimiEds=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL v2 0/9] Linux user for 4.1 patches
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
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to 5f992db605e2c9ed0c8816c2b0f68b9bc8698f1b:

  linux-user: Pass through nanosecond timestamp components for stat syscalls (2019-05-24 13:16:21 +0200)

----------------------------------------------------------------
Add /proc/hardware and /proc/cpuinfo,
update SIOCXXX ioctls,
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

Neng Chen (1):
  linux-user: Add support for SIOC<G|S>IFPFLAGS ioctls for all targets

Richard Henderson (2):
  linux-user: Fix shmat emulation by honoring host SHMLBA
  linux-user: Align mmap_find_vma to host page size

 linux-user/elfload.c      | 22 ++++++++----
 linux-user/ioctls.h       |  3 ++
 linux-user/mmap.c         | 72 +++++++++++++++++++++------------------
 linux-user/qemu.h         |  2 +-
 linux-user/syscall.c      | 49 ++++++++++++++++++++++++--
 linux-user/syscall_defs.h | 57 ++++++++++++++++++++-----------
 6 files changed, 143 insertions(+), 62 deletions(-)

-- 
2.20.1


