Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2493FC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB2D20659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB2D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rbu-0000tB-5H
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1rag-0007Zo-6X
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1raL-0003oA-UU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:06 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1raL-0003mn-LD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:57:45 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTRIi-1iwGUU1kVw-00TjHm; Wed, 12 Feb 2020 13:57:02 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] linux-user: fix use of SIGRTMIN
Date: Wed, 12 Feb 2020 13:56:54 +0100
Message-Id: <20200212125658.644558-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0rjlJ0YODUADJOsQsOeGHZYbE0MCKl2dpUA47BFIpUlRvAgS/CR
 HmNLwW+Zj9ASFAvEQLo33ag6gQa0lLEnFp/+cH6gWOXVEWJvhsMKOO2/YV6r4ZppSmF7AMI
 c0xY1jbauthMkjBuTdiZXg8ZMSPWJMOzfxAe7Quz8vspH2MqMEB6GvhxQO6kc4y7KdKmQvd
 2IEQbrw2mC0t/73PId8yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sw1yLnDobr4=:JInrVZT1YDc4LOpPnRBNEG
 FoT03JE3dzKcZetdgBX170qsxj68OKdnF+TTMb/NazOG4d6WjdjfdSU4XC8IEHU55rkqQ/i48
 eNEH0L8NbLOTNN8aVs4Xnw68tgMnJ/5lAv/Mlo1hE8cRVqMQElwgyrs9opaBPODf6UQYBTSki
 Qe0WngvoQIz/MFShzG3NPEZytFCXYHFPk0ZJdsmJzVrUjbgSJ1L403Q3qZ7mGkdCn0yjybjpr
 KM0NQnU4LlShAd1wuibLqBFUOZUxsNR+Mxab2AjHn2VfecjKXPN8o2RVLoVhcY1/8uTUh2X1m
 42Zkg0hL5ArUQsyqPlqAdvtrlXf66jX6cWEDfNB1z0IFCxdA1Oa7VayXoHP0MgpEA/kuKXWoW
 heJARtrXBlNYofRd9DTF2yFFUaOCHMAdVOznSFXp/0NfflOCzqt6ELwN+/ZKFh3CN3j9Oo0hi
 8A+rB5vW3vsO/jwYGk2Co46mY7FJOHLOOOiEL+VLQg+SAaFQyNJLB6QsLzMqzBcgZNzSlMLqv
 4M3CGagsmSfgA2pkUiYEehCJTShNfty//iQBCIJfn++Xqz6vafsOqrEDCNhUNTBQ3k37PvKwh
 JwAw0hk2zJPRtM/cw51h9C08hYN44wLWLnQ5i9GF+rYmIHb4LMNB54rltDYdSBp7FQQC/ovNp
 47qkGOgB4LcdPRDiXHUKAb5ybBlh52R8DEAq9V8RmhR3f6b05oLCD5iC2PBfti5W2fpOo+r89
 XWieEafmrshYPHw+fNJ5Sy0oKdtEF6ZPJsMBb5TL4bQm6XqAMZE0r7oEhhDdu61bifbq5eDsY
 TnhRVRVUbbBpII7NGDDZyx3YqXADudgd3/z7HSaH5HJlwEDZc+Ov7GWqx4ffHH7jxST3M4S
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

v3: use trace_event_get_state_backends()
    update comments
    Add R-b

v2: tested with golang 1.12.10 linux/arm64, eoan)
    Ignore unsupported signals rather than returning an error
    replace i, j by target_sig, host_sig

Laurent Vivier (4):
  linux-user: add missing TARGET_SIGRTMIN for hppa
  linux-user: cleanup signal.c
  linux-user: fix TARGET_NSIG and _NSIG uses
  linux-user: fix use of SIGRTMIN

 linux-user/hppa/target_signal.h |   1 +
 linux-user/signal.c             | 134 ++++++++++++++++++++++++--------
 linux-user/trace-events         |   3 +
 3 files changed, 106 insertions(+), 32 deletions(-)

-- 
2.24.1


