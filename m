Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD47C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238C22082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz20T-00083E-6G
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz1jg-00079v-0v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz1jf-0001cp-2c
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:39661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz1je-0001Z9-P7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:39 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiagR-1jV4l60rFX-00fn5a; Tue, 04 Feb 2020 18:11:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] linux-user: fix use of SIGRTMIN
Date: Tue,  4 Feb 2020 18:10:49 +0100
Message-Id: <20200204171053.1718013-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2AP/VXVBkj8KSjvdMDyrwKgnbjcgoFgEnqw55K8Es85HLJsNvbn
 dHemIMPhMN85Rteoocq7LVAs4CAroyEYmlFBzeqUNdC1CpnVYei0O2+oTskFx9RMUx/rnkL
 BArbxyy6aLbD9Y79m8N3ag83HoBVAhDtI7A2wbOP/3099PCqpbdN/IithtLTxbczWSNhAaZ
 Ia0zbwbjxYqRhFRoqDUpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O31ic8eqpGo=:sbXwFnsp0ejto39xEMpJCl
 ZcgOxAWzumwtdCj6eBDHcKRLto66gFWbJDduFrCEmgpY0/p3I1X2rv53zoWkZoSlAewsHSP8J
 4nafgl5jeIPRJvguWglzNsviaIsRnioxOT8HgLc4vltge5DPP9rzdlSjNArK/GF95j7ERdlN8
 hSmNbJSOMzOikRI35yt5MEx578Fio4Iv7dJdQqif86kACxCVWrP4F4Z8DAjXE9y11C3Z1k6fV
 EC/8+Ne8ceLDxf0VzJxOxN44S5pdBt5g4jcSTwttn4fZmy59gE0Q1Jdeazq0gwfl1OcnQyFhz
 C9AS5ddI6glFzAvBG3zMuuD9iFtE3VHWqIFUPyRCzwfkXPC5CqujnrINBZj+RpqaAfEyX6E6l
 Vd6IbUlhmp/z+nDeIUn07+TbMNIeQHLx7EaigqdIEnzSz6X3BEhbfUgsyGWIZa2x9N+DHLpaO
 wc7JW8sdm5hP4zjxsoYvQMZnKDK7FtGSv0Cfw133MJFnSt9NPaQ39VQXnOD2HsD/3E7dUbMfW
 NuW0/IybFN1lki2Wl9ua7FkbAPUmJUFWRLl1MmeiNLk/tbrjsO+0Nj+41YhVObTTuphxqLX14
 Ms+W5PTMkUokRwgcqR40EdS4np4HGqnqY/n6t7HQ0wsY7u8q7tcFlL5bMagUv03c5Ecd+0xue
 dn95ma//K0PgcLvC0ESkw+9xLumTY7pVXfUsmQLmekTXeqi7fqTGkmSK3rmDOFEKzyvdgDDsq
 0dMRWQlknCPSweq5HybypjpWFnG1saLn0L/7It7pAoX2BU/AMZfgWcvG6bcYJBhfcF3AAaU8F
 rL2pswyQeqVZf1BY7/He/DGvV9VW29ZpXJff33AWMd/4PpqsP1nlROL2lOj40cWbR/PyxKa
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes the problem of the first real-time signals already
in use by the glibc that are not available for the target glibc.

Instead of reverting the first and last real-time signals we rely on
the value provided by the glibc (SIGRTMIN) to know the first available
signal and we map all the signals from this value to SIGRTMAX on top
of TARGET_SIGRTMIN. So the consequence is we have less available signals
in the target (generally 2) but all seems fine as at least 30 signals are
still available.

This has been tested with Go (golang 1.10.1 linux/arm64, bionic) on x86_64
fedora 31. We can avoid the failure in this case allowing the unsupported
signals when we don't provide the "act" parameters to sigaction, only the
"oldact" one. I have also run the LTP suite with several target and debian
based distros.

v2: tested with golang 1.12.10 linux/arm64, eoan)
    Ignore unsupported signals rather than returning an error
    replace i, j by target_sig, host_sig

Laurent Vivier (4):
  linux-user: add missing TARGET_SIGRTMIN for hppa
  linux-user: cleanup signal.c
  linux-user: fix TARGET_NSIG and _NSIG uses
  linux-user: fix use of SIGRTMIN

 linux-user/hppa/target_signal.h |   1 +
 linux-user/signal.c             | 117 +++++++++++++++++++++++---------
 linux-user/trace-events         |   3 +
 3 files changed, 89 insertions(+), 32 deletions(-)

-- 
2.24.1


