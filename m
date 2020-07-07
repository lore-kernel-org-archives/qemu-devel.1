Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3385C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A966B206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A966B206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslEW-0002k5-UN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDi-0001Ed-I6; Tue, 07 Jul 2020 06:53:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDg-0000Lg-KM; Tue, 07 Jul 2020 06:53:02 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5mWp-1kzscE2JJb-017HbN; Tue, 07 Jul 2020 12:52:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Trivial branch for 5.1 patches
Date: Tue,  7 Jul 2020 12:52:48 +0200
Message-Id: <20200707105255.362318-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1l5DsXF8ueSUHUSlGRNVVLaomKJW/m/X6je67xnzY9/z8FaJ+nu
 By5/FCnfB3FmuvRtzk2DSoz893CkY9YM32bpDe52ZZUpEGeUf/gUVo94Qz5NkAq/QruXdHb
 c1y7gOAskNxBwy8gXxv3W/9qxIFRkc6J5PQdp+tJVeF2tD0HADXaNah68diVDyoocKVQk89
 yGmye1iBeSyoxKwSwtKCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pd7gfTErXd0=:eizhLW7tyBaXgjnfEjVPjj
 2sjE9JdGvmj9+J7nMGIvkTodtLOltwlKIQc9Vm21yg8So90B3Y/iy6HvmXp21sSIvgaMAi/yM
 2HCHqSa2k+H5MHTx0HQBQFVDx9nsR15wGqzNVG9twKiREdMIlmIWKiG2+Xnd2tVmCKqobG5/H
 c3UUwSOlmuVT7OnEJLSOWXg5I7wKg8M3q4tL1QITuVrkAleoAfCCtRoaQnltzCmkoTNn0tnkt
 qMf8C1jjbQAund61ZjsNZs8g/PnKHWG8msEzgLnHtY73Jh2qNG6dARTgV7/AzfvCngrmMo97C
 IetCvLv5IdSxzUDyrUrRgx55fJMxQ2dKy3kbnGB3khAsaqDvSuw+yn5cEIjsE4eG8VJoamJMm
 dLFXkOw3QpEk6atTPNL+EaCFPc/QSgF8WSFA+vWX8517Eq7/lg5Thsh1AFEDj7KtQgQ0KssiQ
 Z74Lh6qs1DGvxKlj6DRX8GS4YNpsGzjDAT5b6nxC7u9Iwaqq70oOq88zuANntWx1Q1Jvn+DDV
 LJomxAYPTJQfQiBuhCgVLbVP4zQiL5yXvE1/HYRhtS2LX8y1xwxICys7Zjg1NrAkm+yHjVvPI
 gEfZDRMpzX7Ay9KC9EhPc1FtCzoGLfy0k6UYe2i4RO7IPXsAbDEHCqZ/5OmcJ+HUWWecEHvKX
 wKdMkFcwUDlR7NOwHZGzDjFOVGaduwk5FNVtB2IC0QDU//pdyf9e6ikrmF++vEOZANlRuYkLd
 EOmP5qj8za5vpQJwtoeCcw1C54RSM2sDUK2pCASYM48++OohbnH2O1yzW7megxfefS6vG0C78
 Ob3JvuIQEl+kpGeaIh6PkL8x2U9rAS9E+nrplE6V8/tZo01V+aaQe222ZADgkfn4j2SSMS8
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:52:58
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

The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450=
:=0D
=0D
  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
70=3D=0D
3' into staging (2020-07-04 16:08:41 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request=
=0D
=0D
for you to fetch changes up to 89615cfef57e04da0e5a1bd212a62f8696468e79:=0D
=0D
  net/tap-solaris.c: Include qemu-common.h for TFR macro (2020-07-07 12:38:=
50=3D=0D
 +0200)=0D
=0D
----------------------------------------------------------------=0D
trivial branch patches 20200707=0D
=0D
----------------------------------------------------------------=0D
=0D
Christophe de Dinechin (1):=0D
  trivial: Respect alphabetical order of .o files in Makefile.objs=0D
=0D
Lijun Pan (1):=0D
  fix the prototype of muls64/mulu64=0D
=0D
Menno Lageman (1):=0D
  intel_iommu: "aw-bits" error message still refers to "x-aw-bits"=0D
=0D
Peter Maydell (1):=0D
  net/tap-solaris.c: Include qemu-common.h for TFR macro=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (2):=0D
  .mailmap: Update Alexander Graf email address=0D
  util/qemu-option: Document the get_opt_value() function=0D
=0D
Radoslaw Biernacki (1):=0D
  MAINTAINERS: Update Radoslaw Biernacki email address=0D
=0D
 .mailmap                  |  2 ++=0D
 MAINTAINERS               |  2 +-=0D
 hw/i386/intel_iommu.c     |  2 +-=0D
 include/qemu/host-utils.h |  4 ++--=0D
 include/qemu/option.h     | 13 +++++++++++++=0D
 net/tap-solaris.c         |  1 +=0D
 stubs/Makefile.objs       |  2 +-=0D
 7 files changed, 21 insertions(+), 5 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

