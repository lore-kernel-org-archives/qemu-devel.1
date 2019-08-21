Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E9D22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E9D22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0P7p-0004fs-GK
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfX-0005EY-Dl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfW-0006iW-57
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:47 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56447)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0Oex-0006Ib-Eu; Wed, 21 Aug 2019 07:20:11 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1xZX-1iOU3W0Wgz-012Fkp; Wed, 21 Aug 2019 13:19:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:33 +0200
Message-Id: <20190821111947.26580-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CwXLgJTeGqkHU4donMSo/o4WF+pmod01SbtIm67Fh6aEFuqYFK9
 sh3byMLoslHL9Jg742dcaGLAr9ueO71pP6cLEIhTN87ztx4EktsJrP+IQDeVK9arek9uRtV
 vyy1GaLtEqQDWznXol1dKMcC9ThtpwscF1RDsZ0/N4dwzUBXcynxY9LAxgrCAwuWn4Lwn7z
 o5h+2wAdrYEgENBiw3KQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GU2dcO62q0Q=:p0YWQtu9RaMtDVEyWv9daD
 ZbK20Iiurvn3jibUVPiERStMBGTuw0ruNuGBKJaP3YmAf/se+UyU9T31wIldFWqEZnk7pF0L2
 l5ncc8HLRglxQKMhVfsmialtKsP0NCl/2Z97YGJsjyDHLivGLHHTrNlrW2UvrTrQs1FnyUjEk
 F018Ju1E5eV4gWH68YWBxHCdTJmOQF+ynylf842vuBKSmiGBzZr5SfUi8NSb0bm8WPTOPt4yq
 oCta0e05MU8Zkqq74cldSpeljvLc7eHNDzZKm5QBtThm3CSlb3aUfdlzauTjzNcpiLmmaV5wQ
 j1HUXPlDCSSDvYVeTQw6FXPGXsaxDhwF91zqJ8Qtd02CId38uP1FXsYo+gAZrxlGLss7ejqsM
 194+onIf4R3/f4uMQbiUd0CltqtKLTQ9QpbP3n/lpFL9HYyqsUVZNajqTh11y46aBi1HQmLsB
 dnVLdEmooHsFOAMjREBBeFSHmBkfI4YlldgEABWX9k86LV7WLMFMJ9ANui4AN0dftYUxwgUA8
 yUN6E4kUR6/gTQvQ4Rcyfd6lSOBYuIbU6Ir3lca5gQzqx6oD/YHTY9hvZLRiOxqI4obJg5s24
 uIphD7hySL/DsyBRuh6TozOhv4HY1g4h9K5yPPsKTBhhi5WM4PbTR84D/v0dl2elvfG+hKGp6
 T+K6lrstAaqIpsAGRLCov69VaLNhAhSTFOMFoLHr3cBSwSIed/60z5avQEFee8cuNarpm7NwH
 ll/M5YsEzyNlKLy0t57kB2+Rox0E4epIDXTca7iqKfrsqENEyZTrHSruCFw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 00/14] Trivial branch patches
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
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 8a9224a250094222e9ff302b95e379c3e71d3c8a:

  hw/display: Compile various display devices as common object (2019-08-21 13:17:22 +0200)

----------------------------------------------------------------
Various trivial fixes

----------------------------------------------------------------

Carlo Marcelo Arenas Belón (2):
  configure: remove obsoleted $sparc_cpu variable
  configure: fix sdl detection using sdl2-config

Marc-André Lureau (1):
  misc: fix naming scheme of compatiblity arrays

Michal Privoznik (1):
  .gitignore: ignore some vhost-user* related files

Philippe Mathieu-Daudé (9):
  hw/net/e1000: Fix erroneous comment
  json: Move switch 'fall through' comment to correct place
  hw/dma/omap_dma: Move switch 'fall through' comment to correct place
  hw/ipmi: Rewrite a fall through comment
  target/ppc: Rewrite a fall through comment
  vl: Rewrite a fall through comment
  spapr_events: Rewrite a fall through comment
  hw/display/sm501: Remove unused include
  hw/display: Compile various display devices as common object

tony.nguyen@bt.com (1):
  test: Use g_strndup instead of plain strndup

 .gitignore                |  3 +++
 configure                 | 12 ++++--------
 docs/devel/migration.rst  |  2 +-
 hw/display/Makefile.objs  | 18 +++++++++---------
 hw/display/sm501.c        |  1 -
 hw/dma/omap_dma.c         |  2 +-
 hw/i386/pc_piix.c         |  2 +-
 hw/ipmi/ipmi_bmc_extern.c |  3 +--
 hw/net/e1000.c            |  2 +-
 hw/ppc/spapr_events.c     |  2 +-
 qobject/json-parser.c     |  2 +-
 target/ppc/mmu_helper.c   |  6 +++---
 tests/check-qjson.c       |  2 +-
 tests/migration/stress.c  |  8 ++++----
 vl.c                      |  2 +-
 15 files changed, 32 insertions(+), 35 deletions(-)

-- 
2.21.0


