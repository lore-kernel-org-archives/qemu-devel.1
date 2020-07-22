Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67274C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F61220787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F61220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIqG-0003jX-GE
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyIpL-00036e-Mp
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:46:47 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyIpJ-0000XT-VH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:46:47 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mlf8e-1kgx242mva-00iir3; Wed, 22 Jul 2020 19:46:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] linux-user: fix clock_nanosleep()
Date: Wed, 22 Jul 2020 19:46:10 +0200
Message-Id: <20200722174612.2917566-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GLJJToiS76Ce2NmYLoEjL4nUuVy7r3e6x/BJa4wpk4QXeC2y7nW
 Yla4FYSrqeYsJAUlD6JrbGtwnd9z7+3kdRKkCr9FgxpIv3vNEk+wDGpkp4yuYUzslJYJF2K
 PEuf9zzoEK22mdnbm+wdEk5Cd8VkftJxmoit0sSd9OtFfQAUm3LZQCTGuzU5oDO8u5J0Nj2
 yGzzUhDGic/5cLXWZcFRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AQfKnoBr+V8=:UhnUF6E/uZVmVTSHVqU1xu
 ZT8V/GVFP3TS0Jr1w/dsVgvoIc3BTpedIkc2ghWnBoAPa7rLtOt9RrMQInLTpxNfFvbuqpnAq
 hLZem1sCEAJpjd8hsldhQl1wr19Xzs+GZKCLCfdPDNoPuPbN8fHkiG47yYowdVakL3WVp6swS
 9zHhR7XiAYJJ2AOjJ+9OcH9jV3ugl/+sOLYbO6slqMHUZb6SSYj3baksmxKDw5SGUVQVsxj9w
 zMOuAbTnwkUr0Rm5sk4Ywmn8FVHG1mhINoK9er7KsCUBAX68rxYblGVg2I65Aej/mtU/zB5xU
 mpEf3q6Y/1KxQ4QzhMQrHelts/IQfq4QSefMWaTEe5x+tuf8M/Ps3zbMnoVl5xIde0glQX+ar
 7Lp69dik9kLiovosH6CuL5y/Y+RTsPtLnNdXf+zvHj2M5eOuj9sGPH0cECHxag3zOEFZszHFT
 +US8ClBqlVjZ/z6ADm4I7nv+VykJyF5YkcXQ/z9L72Y5PdOCM6+lwST2cemyTNAZYsKotmlrN
 wX14c93U5dVR5sq/sKc6afFIOynIZ0ymGH2RZUK1XpHRwSve3ldLTIPcMZx6xh4drPn4fs27m
 C0o+SgZnpHfNdkdp8Jr5XNS6FRRYkXYDhEWMtZXzGus/8ikrVUYjj1KcE4uRhs3i20iDRaUln
 y2QcTkuvhtqU9aSLpZGbEuRVJiyEdmIlE/2qbZ6U6Z7SjBApUQTv2wfae7SCGt7GR+x9lE4wa
 cyQQZTfWhoGt1L0b3oIYqJ0YKdr3JBz2Fg974UUGWpeqXTp3BQb1dKOUI2OjSDUzWAlDCY+Ez
 70U3npYnt+9HAXSWUfZz6DqRHiPRZJkIyA1lF/rRSoYFpvLKJEvDwM+4FfB0VcHmINJCmq2um
 c6qa6c0dcTb8HMVzsD31Lu1+V9LEHnfLmWsO5aHrL2/6pItpPNlRT/HFEEAbfyucR/oioghyG
 HQqO56NltKzf40HnQ1hlKY4DHx41FtsnJ8ZfJCZYNXNUqRD33RuItT7OzS7QOd0ktTAhWqj/Z
 C4O8qEH7UHgF+pcrtoZQ5MZomIqnqMRyfiTWo//gKKux7JmaELadvzZ+RZ50tD9pKhv+Z5EA/
 gljKCWH335mdTJEtdkZZjFqZnFlwK69NXZbVj1cLCuVFjXoBbVSOhiLvrcnTMTyW9BFUfoEPP
 m3iGGSApaIjDwbqLhpdc5ab8ob9wcp+x5s6KjdNhV8YmWxOw==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 13:46:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the "remain" time only if errno is EINTR and flags is TIMER_ABSTIME.=
=0D
=0D
The v2 restores the get_errno() as our safe_clock_nanosleep() uses=0D
errno to return the error value (and not ret).=0D
=0D
As we use errno, we don't need the special case for ppc here, the CRF=0D
bit is correctly managed in cpu_loop.c if ret is -errno.=0D
=0D
Laurent Vivier (2):=0D
  linux-user: fix clock_nanosleep()=0D
  linux-user,ppc: fix clock_nanosleep() for linux-user-ppc=0D
=0D
 linux-user/syscall.c | 15 +++++++--------=0D
 1 file changed, 7 insertions(+), 8 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

