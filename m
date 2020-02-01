Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B8C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B7120661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B7120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixrup-0003yq-8y
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 07:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ixrss-0001Pd-NL
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ixrsr-0001go-MN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:22 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ixrsr-0001cZ-CZ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:21 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MowT0-1jLcaW1bTi-00qRKY; Sat, 01 Feb 2020 13:27:50 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] linux-user: fix use of SIGRTMIN
Date: Sat,  1 Feb 2020 13:27:42 +0100
Message-Id: <20200201122746.1478003-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MvcdW5ODzkC3aM76VraMhY/6j4AZJ+yznOMF464Yf//BKxBdoGI
 urttOwP+0CfsoABpwKnTwHCxBrldxfXXgGJZDZ2eCUArUaAk342nDNfVwzWW5vT84j5GHIn
 XYVOXw7B4mol7Q2mkRyNJ2qSFFLxvixRBHWYMos+vnK5vpvOMLxzqKOAYk4PgkYHCvfee7f
 vnkjrPIfBcjnS8HKu3hcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rLbAKYhdnDc=:I7Ka+8HckgyyeUu101EcXZ
 v2UYUOhAYQ6ke5EPuhC3f+F3DeN21HwWXm3Q5nw1AG3rIf6CoBZuQXs2P7OiVt1sjDq2Ud7DF
 +YSbedc/N7yWiGXu56NzrByv5c/n38N1XhNa/lcohLboYkw3XPm9Zm5ufwa38t2b7QLCMLIz3
 69XIJZtaL4yVNioCTUetZwHJFDsTZ569L78yp3TUMe28ZJ8EPs8kIAPQoln0jx9KxsebEx5us
 eIlspxQIn3fQqRwo8XIYWI730R3at85nPMKH9XDgQyD5BRFIr+v7lhXp118v6fthCNN4buu7A
 wa1LUNdRp/qlDHsN50JJ8+xpjDx9qJrc79Dutw1+Xf+Qsi0MoJms8xdj+nIwJP7MVVFFkhO0x
 F+oVFY3jLgGD3y1sG21/A528gdge6/WE/95Cxfb4AWg4745+wW69dGxsTxgEXnq4A0nm3neRT
 IJE5+p+qe2lJ8k1aqw4MLwEwNGdV2iARoFcU0utTJ+Nk6ObxpPPZ0QV7f76t+venPEgrmp5LC
 /LHaq0G7BFPnz4VU0fNM4xVZk/iG6KSYHw58zoC7EAIKGj+r0Vgvx51STvFyQl1IdZO/qpvD0
 ieIH4HKwKvZVOKvCdn66nI8DthD7aCeDAYtCyzDNDxMN+lwMExB4pSQmXEzMYuaOOYdq7VHdo
 AXmNstiPPRX50pKuIbmh7xA/XlLQ6mFeVqZG5NGmZULfDUgNMS7AWBpo6OuD9lRBByiVxzAQ/
 MV86RjnHcictL96xL5z8cGLg1DkfSDNGExsyQvV4J9EmU6ifRnwF9z1IqhaTUPInSdVyuzAO7
 wUQbQbLVX/FBj7NtkLdowNYcBpKbqyQGXaGfZNCVnWvFCXfLLWCwrfQJisU4Vt6+KPVSOhX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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

Laurent Vivier (4):
  linux-user: add missing TARGET_SIGRTMIN for hppa
  linux-user: cleanup signal.c
  linux-user: fix TARGET_NSIG and _NSIG uses
  linux-user: fix use of SIGRTMIN

 linux-user/hppa/target_signal.h |   1 +
 linux-user/signal.c             | 110 +++++++++++++++++++++++---------
 linux-user/trace-events         |   3 +
 3 files changed, 85 insertions(+), 29 deletions(-)

-- 
2.24.1


