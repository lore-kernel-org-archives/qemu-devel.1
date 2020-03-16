Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF2C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB132071C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB132071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmuR-0002Dc-Gd
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDlY2-0005lB-T7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDlY1-0003fX-Ke
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDlY1-0003IV-9u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M730b-1jE0Wd1nMF-008YVF; Mon, 16 Mar 2020 09:56:24 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] linux-user: generate syscall_nr.h from linux unistd.h
Date: Mon, 16 Mar 2020 09:56:16 +0100
Message-Id: <20200316085620.309769-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GOZ4C5AVBeyNueFbXnRc+0t8mumemR/aijjymyYfYLXqd7RnupJ
 AWctDb28LchxFjTYFGQiU6TU8rLZRkpGODBm65l/td8uBHo6ECtuaOkXTO2AckQoXnZNnVm
 fSBSRapS2FqN9eeZzm21391Z8CZE0D8FizjWY6xSWHq3NOzvU/AU0LUZpj1tTadBj7AGwie
 g95P4WSwdtmKGl8Mti9vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dJY4cKYwXTQ=:RiIbKqFJlVMnXrJYEKwG6H
 fWpEAnAUvYZO1u5oJ7Hd7p6m8ibLR8CMIYRMMw9YMaueKsAdFDw5iRiseuyh4gs9i2XqnZZsD
 AQNiTKqkWKcm16J++LAqmACWlcnFbd04RaF0ncaXsyrHUjfc1fGffSlk/z1n7i8K6u/8HfrRs
 59lP+MQYryEG/g3Da33i/AlXbBKgyrlj4TkZy1mqrXHYUa/y+jrRJIJsAidqDfqDAsSPwPtgP
 7mqROuj/xJRiPAlitOlFCA5XCpCVERqFQCD6cEcsd3NTNG9bml8xHulYFQtL09gIvfVZ6MM8p
 tO8LtubOLEpkDJFKLgxSB4nrr+V+5fWsnnEZitp3tjeE4t7XSRKjXCZHGsvNkgwyCP/qCz7Pl
 LdrALX5kRcwafeTZfLJp6oLGheP/qa+w76NqHcG7vrb7Yv2GW5Jc5nm48wFjPyI6zQLpxB76f
 EqwbrVSba1GtFZcrtfCeyVsHfKeVgjSb5T8WDi6KzHKdHDjAtF3eRu0/T8BSkeOPif8XO/+1p
 diIFRv9vzUq1LVxRkPKZJKenc8m2R2aweWNWTsJGVCatQrNoiCEQK3LK5Ichm/Uhy20IJ3NKD
 30UM/q2VViBukFnZQVjWD6vo3D3RkE5rgwgbJJPXuPb+s4WK5oeFB5Hd6YEddVihqnqq06H+I
 OWFIxcDwM/7LyfJFoYQ2uTvf1T+QC5sXHHuZ4Qd4YvtwIIZvTkV/L7A+Q/69BzKoHdoCzpubD
 MxY1QiXmnKhmUz2kl0AIDA14mwVCoLlRTKDYWP0rtB4DVpI2tX5t8USMj3nGFpZkN9HlD79SP
 5TUImQTrJ+zrVrGjHx2r+QFmV+UG3z5qY6I0j5RHyrGKwneR6G2VASe5pqBl9d3BfOlmBQV
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a script to generate syscall_nr.h for
architectures that don't use syscall.tbl but asm-generic/unistd.h

The script uses several cpp passes and filters result with a grep/sed/tr sequence.
The result must be checked before being used, so it's why the script is not
automatically run.

I have run the script, checked and added new files for arm64, nios2, openrisc.

I don't include result for riscv as Alistair is already working on a series
for this architecture and it needs some changes in syscall.c as some
syscalls are not defined.

We also need to add the _time64 variant of syscalls added by the update of the
syscall_nr.h.

Based-on: <20200310103403.3284090-1-laurent@vivier.eu>

v3: remove useless upper command
v2: add comments suggested by Taylor

Laurent Vivier (4):
  scripts: add a script to generate syscall_nr.h
  linux-user, aarch64: sync syscall numbers with kernel v5.5
  linux-user,nios2: sync syscall numbers with kernel v5.5
  linux-user, openrisc: sync syscall numbers with kernel v5.5

 linux-user/aarch64/syscall_nr.h  |  34 +-
 linux-user/nios2/syscall_nr.h    | 650 +++++++++++++++----------------
 linux-user/openrisc/syscall_nr.h | 309 +++------------
 scripts/gensyscalls.sh           | 102 +++++
 4 files changed, 513 insertions(+), 582 deletions(-)
 create mode 100755 scripts/gensyscalls.sh

-- 
2.24.1


