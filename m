Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB25C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56832073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56832073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUio-0001O9-Sw
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ifUel-0005xA-NF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ifUej-0004Bv-Ov
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:01:51 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ifUeh-00044k-Rr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:01:49 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGygv-1iS2WJ1A8Z-00E8g0; Thu, 12 Dec 2019 21:01:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] q800: update machine emulation
Date: Thu, 12 Dec 2019 21:01:39 +0100
Message-Id: <20191212200142.15688-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KKWhmer8d7YysWnvYm2l2eaUZJpPEg8HKLpIkPl3jWyg0/Fsxka
 PGIMGpGJyhO1c/luITUzOjt5dlFGhujyz2IIMwMVVG8rV0GkXne93U+oseiWYQ5wadyM80r
 MX/N9b913st6cA/QvsvPaFLOVVOS+IBc+uokDm76bY9VvsKqoFxnCJCkMXO37EO5Bm0lPQX
 i6fu/hqyBS6eUUwlh66RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Me2BmnkaOw8=:Ii3C3VX4CL7fwLp9BBqOZB
 pLBlNyS2WKpKTDngFmEEqEJkC8x/pLH16cBhkNG/W3Oqg1JMMOJBqjbLmTPg+MlZuww7k2Nm5
 mOPoNWWaasd3KkrCXoKvNKUOxiPV7hhJwatLzi3r3YE7AlPN+f143HmzsJc5R1BKg8eji6idv
 6KWLVDllmSpscKUaYkEpg/YT4UN9jqhMJ726XFmSnKh35glo7Gh6yVA+hQZa1hTXqx+dliYoY
 D94PqMdBdqbt/d5cARrwf2NNeS0xFv3C94y7qUJPQbpNbQejxhb9y34Ab4n7T4s/lv1HLMTbF
 K0G/R2hC6DOhB2wHXVEtVtsCl93cOti4ncNZl3IGU55gNOeKtYeKcfb6lpligb8kmhBLFbpKn
 IskTJRbG+dB77bEagwhfTXvsbzqe+aq721gOTBKyUGNHYdKXWU9exTstr+NL0SXfNPh/yfmYV
 ahuuRaESoHtDPoqXhx/CcbU5jE0SDLQZbia/b1DNXPmARHN5hYDoEqL8UlWwGM0D4JGL8vSqp
 cgUVS5ROm62ynlG069AcADNoENPD6GiwUlwthAibMRqqMzm3bTKV0LeKMXndUDyZl6CYTAViS
 68qhRfsjmA+HDaLRKHnppeccCZKKzRAw640yWL8W/DhLoOk5c8MxmEGigXc8wBkvxX7ciw22R
 TEZh1eB03l1xvQkC9c71zYcdqoMHO6HGbuuhGMmUeEVsjNKcK3inSEcwPVJHow33LESCCAl59
 Xyk7mEJhZ7P02pgdwsj/KHLeaw6Uulzmphs6zjG+UZ4DnwVjQpSJm4OMCZY2nYPo3MBbK0hvM
 ZTRX23TDXamX/T9mFxpA2HDdv5RTxrK0cNP8n8p0vmzOo0AnKOhogjrb1bmowDitORcsSyVqX
 HY+wCnnwAnDb0N1toBXw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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

On the way to run a MacOS ROM we need a more accurate
emulation of the Quadra 800.

This series fixes the ESCC base address that was wrong but
as the linux kernel uses the one provided by the bootloader
(in our case QEMU) it was not a problem. This value
is hardcoded in the ROM, so QEMU must use the good one.

The two other patches update the description of the machine
by introducing the djMEMC memory controller and the machine id
register.

Laurent Vivier (3):
  q800: fix ESCC base
  q800: add djMEMC memory controller
  q800: add machine id register

 MAINTAINERS              |   2 +
 hw/m68k/Kconfig          |   1 +
 hw/m68k/q800.c           |  85 +++++++++----------
 hw/misc/Kconfig          |   3 +
 hw/misc/Makefile.objs    |   1 +
 hw/misc/djmemc.c         | 176 +++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events     |   4 +
 include/hw/misc/djmemc.h |  34 ++++++++
 8 files changed, 260 insertions(+), 46 deletions(-)
 create mode 100644 hw/misc/djmemc.c
 create mode 100644 include/hw/misc/djmemc.h

-- 
2.23.0


