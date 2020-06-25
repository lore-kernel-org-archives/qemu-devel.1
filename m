Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8692AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FA720709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FA720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNwT-0005Xb-Kk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1joNvl-0004k0-Q6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:12:25 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1joNvk-0007GD-4G
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:12:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M3UIe-1jovtI3TqE-000Y91; Thu, 25 Jun 2020 11:12:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] linux-user/sparc64: Translate flushw opcode
Date: Thu, 25 Jun 2020 11:12:02 +0200
Message-Id: <20200625091204.3186186-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S6KutTH0exICu+OIgjCdeHFp2+iKMabSwcPBwHems9hrZL6rZPY
 Y+ZB8/dCU6/o46Q7tZqSkC8rF31xZvg/llL67bDi4qv+WdcTwg6I9A5+K1lh1TLfaRb81pf
 TdYkxC4mAB4NT7FDz3ZLtUe06LnP8ixKMMcG7DfTnIuV12Ia/39FgduKAVt3FrULdVyFqhX
 pF97poGI3FnCu9XlmArYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GqW97pGu5VQ=:1i+vyZUmv5qYYtwKIGNjyy
 iZIjmQQPJH/a20nszgxnCKPK5auNHdCeExoFeHg+NETwVZZdaPVIGHM4HfpIRWJmcK/WhJ+Gj
 CpVzZhNlGW0TyzOfQJfFyqyHidOez4yDDdOI9coY0LTM7mPSINfmvwVUT97rl9loVnr9251Sz
 shMQZyXqh8QbKG5G2I2US/m6wlm0T7qxKn7hTZanVB2jPGPeeEz+zPptHW5HSYrOR7lEpHUjm
 yKq5EQu6DWT9NsLCn5VI+a0+Iv4N+Z6X+BkN0YXYMmU8ZQpu/RObHX16Hz7tzhcIT2Uab79ar
 cWA4njevjixrUG2ZCU1iwx/xf6ghggvoLt88pd2+Qo8yACka+bctmTX8pMk9i8hLePlzeCf2w
 z3RzdkzZQw3tGEy+M6QSloQaMiRcbSj+sUMy1LCnRKjpNJIqWFrI9TVJYHttmGljNOtvV6ZHn
 4Jo40fW7yLH87rpmK/IDUDJBTRvqsEjg3uCHXwIzPNWr9kwfwIQIrfwYOLIFgFtvl+m1nv1pA
 lrcepSm/x+MVCqHSXaB2zwNyCOFi+coDwv2GloET++o20CEQ/i/H/6GmskOOiK1ZzpzAUO0ST
 ILPNTYXWv1Bt58NhuKUoK7RJ8xG+2nBJsYpZFEI2wy9lNA7y/UVwu/Njg5Yly4hqA8l5ZpGoU
 bgCedXgQm6i7QQSbcJkq4AzRJkgY9pM7bnX/qVGojCiajFomjs/3+wUbxw3anzNLHVhREU9hy
 FPrrG+EL9NFNksfulXuDqa7jk3aNPSqFBZ/pHAvCFJOolwuQnZFLWtCrLzKUNBZwlQAsbbvex
 o7GvAxTUpaFETbUjMMhbPJBr0fVY8kbPqrQh1/y9Ak9uVk7tZo=
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 05:12:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I send a modified version according to Richard's comments of the original=0D
series sent by Giuseppe Musacchio <thatlemon@gmail.com> (aka LemonBoy).=0D
=0D
v2: split patch in two patches=0D
    update comment style=0D
=0D
I didn't really test the new patches (except a build and "make check").=0D
But there is no code modification so I don't think I can introduce bugs in=
=0D
this process. Any "Tested-by:" is welcome.=0D
=0D
LemonBoy (2):=0D
  target/sparc: Translate flushw opcode=0D
  linux-user/sparc64: Fix the handling of window spill trap=0D
=0D
 bsd-user/main.c             | 6 +++++-=0D
 linux-user/sparc/cpu_loop.c | 6 +++++-=0D
 target/sparc/translate.c    | 2 ++=0D
 3 files changed, 12 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

