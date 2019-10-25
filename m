Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223612053B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223612053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2lr-0000zS-Rk
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2iX-0004jt-5c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2iV-0002DS-FU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60592 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2iV-0001XM-8h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 4F3C91A21E9;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 3448A1A21CC;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] MIPS queue for October 24th, 2019 - v2
Date: Fri, 25 Oct 2019 18:44:02 +0200
Message-Id: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 03bf012e523ecdf047ac56b205795024725606=
4d:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-10-25 14:59:53 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-oct-24-2019-v2

for you to fetch changes up to 220ad858d3baf8b772cfddb8b657f9c799e98ddd:

  tests/ssh_linux_malta: Fix 64-bit target tests (2019-10-25 18:37:01 +02=
00)

----------------------------------------------------------------

MIPS queue for October 24th, 2019 - v2

  - update of MIPS-specific acceptance tests
  - other mostly cosmetic changes
  - in v2, an offending patch (causing clang build error) is removed

----------------------------------------------------------------

Aleksandar Markovic (13):
  target/mips: Clean up helper.c
  target/mips: Clean up op_helper.c
  MAINTAINERS: Update mail address of Aleksandar Rikalo
  target/mips: msa: Split helpers for <MAX|MIN>_A.<B|H|W|D>
  target/mips: msa: Split helpers for <MAX|MIN>_<S|U>.<B|H|W|D>
  target/mips: msa: Split helpers for ILV<EV|OD|L|R>.<B|H|W|D>
  target/mips: msa: Split helpers for ADD<_A|S_A|S_S|S_U|V>.<B|H|W|D>
  target/mips: msa: Split helpers for HADD_<S|U>.<H|W|D>
  target/mips: msa: Split helpers for S<LL|RA|RAR|RL|RLR>.<B|H|W|D>
  target/mips: msa: Split helpers for PCK<EV|OD>.<B|H|W|D>
  target/mips: msa: Split helpers for HSUB_<S|U>.<H|W|D>
  target/mips: msa: Split helpers for ASUB_<S|U>.<B|H|W|D>
  target/mips: Demacro LMI decoder

Filip Bozuta (2):
  target/mips: Refactor handling of vector compare 'equal' instructions
  target/mips: Refactor handling of vector compare 'less than' (signed)
    instructions

Philippe Mathieu-Daud=C3=A9 (5):
  tests/ssh_linux_malta: Run tests using a snapshot image
  tests/ssh_linux_malta: Remove duplicated test
  tests/ssh_linux_malta: Match stricter console output
  tests/ssh_linux_malta: Refactor how to get image/kernel info
  tests/ssh_linux_malta: Fix 64-bit target tests

 .mailmap                                 |    5 +-
 MAINTAINERS                              |   18 +-
 target/mips/helper.c                     |  123 +-
 target/mips/helper.h                     |  155 +-
 target/mips/msa_helper.c                 | 4651 ++++++++++++++++++++----=
------
 target/mips/op_helper.c                  | 1010 ++++---
 target/mips/translate.c                  |  760 ++++-
 tests/acceptance/linux_ssh_mips_malta.py |  106 +-
 8 files changed, 4605 insertions(+), 2223 deletions(-)

--=20
2.7.4


