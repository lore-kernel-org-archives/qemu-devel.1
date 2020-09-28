Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B28C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E07206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E07206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpKv-0000Sc-2w
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGZ-0003p6-RX; Mon, 28 Sep 2020 05:16:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGV-0002Vx-9u; Mon, 28 Sep 2020 05:16:15 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9ZRc-1kJY0I1yg0-005ZpY; Mon, 28 Sep 2020 11:16:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Trivial branch for 5.2 patches
Date: Mon, 28 Sep 2020 11:15:54 +0200
Message-Id: <20200928091602.383870-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJL1WKLlklttVz9H5VoBhwdgplly6dQFyqrny4G2V+AK3Ogz/8X
 h+ysfzPXFeEumWZRKVa1Siepr6/LNB+B2lsVzqzeLFZ4VOTu1YljheUUkm5F6Oy0uK3yxGL
 buaYXqri90PqkNLpjvPib/hw7kn+qCXV8NNBQ6Fgzu8pKuzkyo9n2AZJb1aP0y7If4mkz/b
 bsu6gkZ930LB+/Tj+pr4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6gXmBrqpW7I=:M6AU5LHhlQJzuXVq2oD6SS
 fOr+kRuynZ5nECMioRNf5bkIX8AT2P5OuOPEizs1MAIQ2yz86hQTFoPZmQnZQAhrGKhiQQ0LX
 nec5rrmty0uCxcRogqdpTsTj/2dgFzOnUsf7uSqvk0jE/ahfpv6/6zDEU4zVUWHDEJPqPzwmI
 DoIi9SizGGtZyVo+WZ0+aX63uAWCX+OGeuk+IFXWuI3N7qfsRlaOAyJtl1VPjlfZmhcmW8ppL
 PBz4CSJfcer69COME0ae+PcY1bcWJU8Tr3pVyR2PQ/e51nHmqdTBQWDalAHT1tIYSOKSyFr4P
 9UpRH5tG1LHtrQLBe1KqfAJYB7hI0VWXnTrHrkMqycjVCOov+QMdrmLOZtg/Oa24HzXiXbhHx
 GXqHunubiziVZHseqRtc49KOSxOiSGrCYb4ft4HR5gfFaxfbXqP+0IloCZOKgSZ2ztJp9oCuc
 xymmU2W0hrX+wPB4PEGy7RDXAEMLe9Zy0LxqwgSDu3sZeioT9UpqMIthBqgkH8YSfo+X/KKt+
 +wre/LYqNaBZBK9qc7NtWNDefciejr56nDdARbl7XhQAWLhUO6qY79U5qSexWnBy+WeUFye1n
 SocmhCnaUZwHH7nxlP9Rxr8AoKzoSNT1H1zkzgIgsYAJUZ7YJnIwC2+eTQa2rW7LSn013g/VP
 Im93LcDF8SIvG87vFZcHoKnRevQcV2Ue1dRj2wRdVCxAKyVo9m7eaL4DgRd37HsJ0PUvs0Dvg
 1bQpU8304I6AVgoZ+A5giWX3YR/YL60BVP786NITncBQvPxPnxLIMbcqX8qCXudy7NKEbRsn2
 +VfvlckP19Ykg8ucBEEk4DcqflgAYt70SZgyb6waXrMoAC/K2XeFVD7FT8TSo8mLTwGc+2e
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c122bca9cd7b986be4d473240a4fec6315b7a2c2=
:=0D
=0D
  Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-09-21'=
 i=3D=0D
nto staging (2020-09-23 15:11:38 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request=
=0D
=0D
for you to fetch changes up to c66790b5dfc2430c04bf5876cf485e1f538af7f2:=0D
=0D
  docs/system/deprecated: Move lm32 and unicore32 to the right section (202=
0-=3D=0D
09-23 19:19:57 +0200)=0D
=0D
----------------------------------------------------------------=0D
Trivial Patches Pull request 20200928=0D
=0D
----------------------------------------------------------------=0D
=0D
Laurent Vivier (2):=0D
  meson: fix static flag summary=0D
  vhost-vdpa: remove useless variable=0D
=0D
Li Qiang (1):=0D
  virtio: vdpa: omit check return of g_malloc=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (2):=0D
  timer: Fix timer_mod_anticipate() documentation=0D
  migration/multifd: Remove superfluous semicolons=0D
=0D
Stefano Garzarella (1):=0D
  vhost-vdpa: fix indentation in vdpa_ops=0D
=0D
Thomas Huth (2):=0D
  Add *.pyc back to the .gitignore file=0D
  docs/system/deprecated: Move lm32 and unicore32 to the right section=0D
=0D
 .gitignore                 |  1 +=0D
 docs/system/deprecated.rst | 32 ++++++++++++++++----------------=0D
 hw/virtio/vhost-vdpa.c     | 20 ++++++--------------=0D
 include/qemu/timer.h       |  2 +-=0D
 meson.build                |  2 +-=0D
 migration/multifd.c        |  2 +-=0D
 6 files changed, 26 insertions(+), 33 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

