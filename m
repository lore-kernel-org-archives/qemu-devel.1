Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026032078D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026032078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0Wa-000173-7c
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ul-0007f6-KA; Wed, 10 Jun 2020 09:10:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50445)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uk-0003XU-EL; Wed, 10 Jun 2020 09:10:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mw9Lw-1it6lF1Vsy-00s8b8; Wed, 10 Jun 2020 15:10:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/16] Trivial branch for 5.1 patches
Date: Wed, 10 Jun 2020 15:09:55 +0200
Message-Id: <20200610131011.1941209-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HeTxU4aFpAXH1FbAg4OVCtd1XgyX0JfG5z82ZY2r87Hdkm6Q133
 uHba02HHxaAELdS7+roi/QTcz+C8r1IcEl//S+OaNiDFqhfNfbfEgegFiURqel5EhqANF0U
 5cftHcQ7poKdaNoobFCbx66fPHP+F3edvqCU4iV1q7Xot2gdW+Ygeo8Ep1PxVwD/RBiIVPE
 NVMe5loz4sHkYTnBnunPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mGWbMxUzaRY=:oqjEl0bFLTOE5JoEJtiWqJ
 T/HkCGIfIBmCwfs5RieW1EtcEtnWtcgMhZHIjwxwvlZnRapy/cY1IEqmkQt+BuoJscQioWXE5
 u5nYogPqTj5XVyVaY3Vv6lte+OvXnc/jZTVhSW2zldH4z+SttdCZl/9IBVBRiOfqjRUvcSpEd
 0/jsCU4sttBdo6rTL7xq1JFkkRGMLHpuH6eZqOWbo18vgOJxMtn/0ABBSOslqER8IoJQFjOIf
 nHk0LYbX9SJpRRgmiPtsXhWlypXufOD09kqX8rq4e9N+YdnkI7iuDU97B+gdHdchcq0YA9Mkw
 R7O9J8ii22YoB+SWvMZM+P0O8aC+fgUbzetbM3on0IX1oHVsyT+PDG8LJ4l+ukKwPBnIuO+Cp
 Rpw+Vmf+FfBjnwiXKmVz2mNbqppIefgqepnz8SwE2OTywFqfp4iFvRaPkNWgDNHI5wO2s62qY
 SbVVPWGtAP7ppLKv590e6BBtSBYEGbMAWgTCtwy33GygPgUPxSFWD0FEgcc6jvfqWtTcVvD5Z
 QW7+PwD05uTQKbNygvDZFGUvn0Q4UdYqzAqbj76RndCGUPWtmy8AvFqWRi9S33FtnNnHFy54z
 EVcBGTxSPG7EPC2A9RwWjhCl5cmliRSJAcEW84x6/DY7JE+MbWSBjXstu1pQ+8cL26sHrojpX
 1WIapqZWSnjhYEMktKg8zPSn9HRJ75Vyx/RqXpMnlDbjTHMKxhTguWunDy5RrSUehIPF4EXY7
 GfHRfBok9CbWYPVrw4g//tjFvChRCcAP3NEW91KBBdRaOptmHoznnlhpFiPGO538AkM9Jic06
 9WvL00veDx9+4YdbvynyA7rv05LSq3iRQzhq3p/CjOCrJmfFSLKkMsorgcY9jGqxYVE4X94
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:15
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pul=
l-=3D=0D
request' into staging (2020-06-08 11:04:57 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request=
=0D
=0D
for you to fetch changes up to fe18e6eecdd45d3dff0c8968cbb07c5e02fbe4c8:=0D
=0D
  semihosting: remove the pthread include which seems unused (2020-06-10 11=
:2=3D=0D
9:44 +0200)=0D
=0D
----------------------------------------------------------------=0D
Trivial branch pull request 20200610=0D
=0D
Convert DPRINTF() to traces or qemu_logs=0D
Use IEC binary prefix definitions=0D
Use qemu_semihosting_log_out() in target/unicore32=0D
Some code and doc cleanup=0D
=0D
----------------------------------------------------------------=0D
=0D
Eric Blake (1):=0D
  qemu-img: Fix doc typo for 'bitmap' subcommand=0D
=0D
KONRAD Frederic (1):=0D
  semihosting: remove the pthread include which seems unused=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (12):=0D
  .mailmap: Update Fred Konrad email address=0D
  hw/unicore32/puv3: Use qemu_log_mask(ERROR) instead of debug printf()=0D
  hw/isa/apm: Convert debug printf()s to trace events=0D
  hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of debug printf=0D
  hw/arm/aspeed: Correct DRAM container region size=0D
  hw/hppa/dino: Use the IEC binary prefix definitions=0D
  hw/i386/xen/xen-hvm: Use the IEC binary prefix definitions=0D
  target/i386/cpu: Use the IEC binary prefix definitions=0D
  target/unicore32: Remove unused headers=0D
  target/unicore32: Replace DPRINTF() by qemu_log_mask(GUEST_ERROR)=0D
  target/unicore32: Prefer qemu_semihosting_log_out() over curses=0D
  hw/openrisc/openrisc_sim: Add assertion to silence GCC warning=0D
=0D
Raphael Norwitz (1):=0D
  Fix parameter type in vhost migration log path=0D
=0D
Thomas Huth (1):=0D
  net: Do not include a newline in the id of -nic devices=0D
=0D
 .mailmap                              |  1 +=0D
 default-configs/unicore32-softmmu.mak |  1 +=0D
 docs/tools/qemu-img.rst               |  2 +-=0D
 hw/arm/aspeed.c                       |  2 +-=0D
 hw/dma/puv3_dma.c                     |  9 +++-=0D
 hw/gpio/puv3_gpio.c                   | 15 ++++--=0D
 hw/hppa/dino.c                        |  4 +-=0D
 hw/i386/xen/xen-hvm.c                 |  3 +-=0D
 hw/intc/puv3_intc.c                   |  9 +++-=0D
 hw/isa/apm.c                          | 15 ++----=0D
 hw/isa/trace-events                   |  4 ++=0D
 hw/misc/auxbus.c                      |  2 +-=0D
 hw/misc/puv3_pm.c                     |  9 +++-=0D
 hw/openrisc/openrisc_sim.c            |  1 +=0D
 hw/semihosting/console.c              |  1 -=0D
 hw/timer/puv3_ost.c                   |  9 +++-=0D
 hw/unicore32/puv3.c                   |  2 -=0D
 hw/virtio/vhost.c                     |  4 +-=0D
 net/net.c                             |  2 +-=0D
 target/i386/cpu.c                     |  2 +-=0D
 target/unicore32/helper.c             | 70 +++++----------------------=0D
 21 files changed, 74 insertions(+), 93 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

