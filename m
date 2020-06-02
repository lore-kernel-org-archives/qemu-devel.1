Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C851BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9385C2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9385C2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8kR-0005RX-RZ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jg8jb-0004XD-5g
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:21:47 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jg8jZ-0008G5-AD
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:21:46 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsI0I-1ir3Db1DZa-00tint; Tue, 02 Jun 2020 17:21:41 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] M68k for 5.1 patches
Date: Tue,  2 Jun 2020 17:21:33 +0200
Message-Id: <20200602152135.774894-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TbfejHmcwJbP4kx9WULJFGcNQ7Q+FhM16STmqALA96J2DnUxJlp
 sy9eipvnrr5bxaoV9HHcW+eDvVK1hz1a2RGZvci8LA/Wj+5/FNXEPCmvRcWxlnALD/RTKhu
 B5kZOzretocUl5013Q6JOzIXftAtSkr4Tg5mZyziPrs3FYYc5n0ZHx5ylvUGQHDKB6cWpBl
 9Wa674Fjv3CNLlSYieJOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WLdFHQ37R4s=:/rexFZsLLldjFyyuciCVRM
 P7tRio/JoIQQaR1W15J1gXlT+GbntSjtJ3QDIiuJxcN7ysj+tjzRSrIy8SHL3C7pORTpE5sjU
 kHkmZb+b0G7yS5vdFWLqZ8+Kv8dTODjvI9GOcTgoCYLncxVA6cKq2I9C1o9dEwIzVFSWTpk8L
 pKsNipHD3h7vWTK9s2GVeIwN6fGTm7UC95LlN8wnu5eAsDPv2ujBUMBq/pvMqNyxjHz+iJQZu
 gcrrywgIvgfQdM6e2tJhJc4gvXKd9QtEXgficMbHp6yLBjE4TYnkOZYogPOE9qgxBfNmQvzJ9
 OroFn30L9a6ilBbYMEkd5iEvJ7TyrWK+AFCkh4Gw8rNjUUFhcTvThTTLMx4RJ/ymecjjw/Jf8
 wSeW6TgLIBpEkTG3CzhWXlFWB7kM4e0BlF2n10iBuvUNCh/4u87vlYUZkl/njiS329dJ69k91
 0WAkpOU+RZK9pHNqlM6eja6h2m2jVkXk3Ub6+RBGJNeeQnKWkFI4NSi8bQ2xEVNho7S+qYqFR
 +Wej01NZ2JGICcLs4xl+5eNKtbtTc/Dc9d48FVHqPMN9bG/ezlFO+Vr5lPr18vfDbCFT1FxY7
 xG/IICl0EjTZwrwEfrFOstXoWOHCODlrPMv5CyWXSgogSesn7vF2VD3913wcgFGZy4VijDiJt
 4xLVpF4NtSTFh2fad96ADO73kAoNa2/iPpPm6OXB2oPB/LfCIPaNw0c6SYAlQjnbf2TwCEFln
 m9uWDaR07uRHYCkLTZLT2a92bb6eFH+3htS5uuLDD6Gz0HwxpM+KeKNt2vZkCWg+IOXRvl7NG
 qskAdOo0Iact7Tac3hWpp9TC5VeWx2SvgeYndWuhfArffFKgPMAdzNnspiCqHlWH6PMIk25
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 11:21:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit 853a60b87024b2f5d7c0c54a432d7798cb679900=
:=0D
=0D
  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-202006=
01a' into staging (2020-06-01 21:34:47 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu-m68k.git tags/m68k-for-5.1-pull-request=0D
=0D
for you to fetch changes up to 250b1da35d579f42319af234f36207902ca4baa4:=0D
=0D
  target/m68k: implement opcode fetoxm1 (2020-06-02 13:59:02 +0200)=0D
=0D
----------------------------------------------------------------=0D
Two fixes for the 68040 FPU=0D
=0D
----------------------------------------------------------------=0D
=0D
Laurent Vivier (2):=0D
  target/m68k: implement fmove.l #<data>,FPCR=0D
  target/m68k: implement opcode fetoxm1=0D
=0D
 target/m68k/helper.h     |  1 +=0D
 target/m68k/fpu_helper.c |  5 +++++=0D
 target/m68k/translate.c  | 17 +++++++++++++++++=0D
 3 files changed, 23 insertions(+)=0D
=0D
-- =0D
2.26.2=0D
=0D

