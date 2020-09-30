Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A15C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB8D2074F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB8D2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ7S-0003lh-L0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1N-0006QX-0A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:31:01 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1K-00089D-1h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:31:00 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mw9Hm-1kfunv3doa-00s9y6; Wed, 30 Sep 2020 02:30:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] linux-user: update syscall_nr headers to Linux 5.9-rc7
Date: Wed, 30 Sep 2020 02:30:29 +0200
Message-Id: <20200930003033.554124-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UIMpv4tVrnOQWULfUfCZb3iiCrwqo/EOuJKxe4h/F+Xj4MicAgA
 uoQ5K/nl7r3h4MgubFBE8Lm7QxwBWnWI1Rxrb0UrbMa7on54JGJON9a2JDTzXrhcKwVGlyp
 vO1mWCVIZwTd9WoMLnSGhmpqCQIusKMgBQn06TWMdnyTGOH1tnwW7F7XxSpPSX4hm109PC/
 QQ9+JJpV3UQK4zH574fPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PeFeg2+XtSs=:9jVxeYq2xPpcKfraFZDRQL
 z5cx2tjx+TmtOiyh7QdWD/H7IwapAB+qunbCaGtguwO3qgjgYS+AZWrX0I8b0702RJA/igRDv
 t+U1HKtKVJBxQHOaE1NvMkRgfQtbeuDH4fFA2HFjnR9bKxCkwwyWSQFUA3LmuYs4pA+hFHu/w
 s+q7IhA10bTyE27F73lrNCn7ZDmx+6mhIP2D70VG804hxvTNfEhGKc3XxQRVV5K4jkoqUFdbh
 tFtW0xcyrekWPTEX56EAyIJI6cp/zTdJWv5oKlZkWxgkovkRcSSXJ2dPn1H0iNIkTRY5U2Ftq
 0UhfypCeLzxaCmUme0r/FQM+06eQYrVwyCXVwsshA8WEW/93oI+I0DY4wgTCR2ev66kyRZ4kc
 TZN+vUMjWhBR389aH52HTcrLVLIqH9VyXmpo5LZySC9j7l00YAS32GU2LYthFocDR7kSpFTcf
 F1iyKKsURfWZ7pNlIjAgh2cF56d9G0DC+bo0iKIRZrOQ0CuUt+85+sNaEx3laZSMBEK3phQxb
 xt2O6nl0CSwN+SN8hJ0T5HHRxfRHkvIGHzlqPvoboc16L7dBCeC8ObDgvTOqeP43JKpwvIi0N
 noinEfZwcA0nd/8DaVPUcNZm3DLWRRbdmKRHqk+IKJyAfQCJpdHl5rcTueSOGY7Wa+oi8TOLE
 ERZyB3j17IeCqP1bWuTKsKgGJKrgjjLcIUj36381hNsnxkYTFdjFoSguZuk0A5OZ8Ah6RLOfJ
 FnJ3U4EvAPbVDx3r20ebvubz5TH6J+8XNVUJNbvg82h50sehEdRKDWOIgBdhDac9ufX+ZI48r
 4dVnMZcftCqyMeOXKSzX11+7aBaG0WsLd2snJuUHIstUzLgNMjWkhTmzOGpt4HsF8e/q2+s
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:30:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the changes have been done using:=0D
=0D
scripts/gensyscalls.sh, scripts/update-mips-syscall-args.sh and=0D
scripts/update-syscalltbl.sh=0D
=0D
I've checked syscall_nr.h generated from syscall.tbl are=0D
always correctly generated (there have been massive changes in=0D
x86 targets).=0D
=0D
The series also removes _sysctl from syscall.c as it has been=0D
removed from the kernel (and we didn't emulate it correctly)=0D
=0D
Laurent Vivier (4):=0D
  linux-user: update syscall_nr.h to Linux 5.9-rc7=0D
  linux-user: update mips/syscall-args-o32.c.inc to Linux 5.9-rc7=0D
  linux-user: update syscall.tbl to Linux 5.9-rc7=0D
  linux-user: remove _sysctl=0D
=0D
 linux-user/aarch64/syscall_nr.h        |   7 +-=0D
 linux-user/alpha/syscall.tbl           |   4 +-=0D
 linux-user/arm/syscall.tbl             |   4 +-=0D
 linux-user/hppa/syscall.tbl            |   8 +-=0D
 linux-user/i386/syscall_32.tbl         | 820 +++++++++++++------------=0D
 linux-user/m68k/syscall.tbl            |   4 +-=0D
 linux-user/microblaze/syscall.tbl      |   4 +-=0D
 linux-user/mips/syscall-args-o32.c.inc |   4 +=0D
 linux-user/mips/syscall_o32.tbl        |   8 +-=0D
 linux-user/mips64/syscall_n32.tbl      |   8 +-=0D
 linux-user/mips64/syscall_n64.tbl      |   4 +-=0D
 linux-user/nios2/syscall_nr.h          |   7 +-=0D
 linux-user/openrisc/syscall_nr.h       |   8 +-=0D
 linux-user/ppc/syscall.tbl             |  30 +-=0D
 linux-user/riscv/syscall32_nr.h        |   8 +-=0D
 linux-user/riscv/syscall64_nr.h        |   8 +-=0D
 linux-user/s390x/syscall.tbl           |   8 +-=0D
 linux-user/sh4/syscall.tbl             |   4 +-=0D
 linux-user/sparc/syscall.tbl           |   8 +-=0D
 linux-user/sparc64/syscall.tbl         |   8 +-=0D
 linux-user/syscall.c                   |   6 -=0D
 linux-user/x86_64/syscall_64.tbl       | 742 +++++++++++-----------=0D
 linux-user/xtensa/syscall.tbl          |   4 +-=0D
 scripts/gensyscalls.sh                 |   3 +-=0D
 24 files changed, 889 insertions(+), 830 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

