Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE98C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5DC20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5DC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTrw-0006JU-5I
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:13:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTn0-0002Fj-Kz
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTmy-00046h-Kf
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTmr-0003jo-TB; Wed, 22 May 2019 12:08:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MPGNn-1hH1yB1VvR-00PcMA; Wed, 22 May 2019 18:07:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:14 +0200
Message-Id: <20190522160723.31484-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bc2EQXWxgmeghpRKB3zkJhvJEjMpMfWWLtnCIuVfcpGVVQ23w3/
	6Ygxh3oFk4y5KXx83nvOwSsqyoFGtv6L35Uc9K8xP8Ji8Dam/IhOIODRNDRLd6CLCqV7kyd
	CXZVTINNcXkO+HVydsLrmdjh33kbbH3NF6ydYPwS3+MXxPYvzBO9xJB8KjE98LCFjYLYbUJ
	ffEbxE+wU7DBLlHlrFDqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UwZULjNLaGI=:IHDUcH55imgHeAkqXc7ZyR
	2KHfWpAsF+CrGUExkRPByKMZLF9M3kHYCrUanGjoQidXGGLe6poZfFrVRi133xDC2dE3w6b7G
	mkztjfeZHUH52+yNMxB+NM+CkwUr8juloK7VulgQFvGDjPeVA37Xrv+ZsAu16Fg4n2vDnwSsn
	hqPGnzMIXDstswnwoZZT52kMu6Lq87GZOT9rzKt9Zj3KQhbnFznOzvQQZa3hkhTcTCXkMiaOL
	R75hPhZctqclNFt8/7R2EnphSMdFuf56xKQMgo8P1ON9JCDa9k82BsfPFvUFvGta62ROj7S01
	UG5SQJpXT4xNUW+fIp5+PqKLxjPcQeKuFj/pq+wm7mSqqhV/16xX0QHWVLg+fCs19mMWZtZTe
	huZXBzRZBTy6VzDsobQ/7Gmp3GP3AdmaW4InyDi4Xwd88PYFB8sm3fR/6BntZTEqBF+rwWsSX
	zGiACA4//Agxmw6BuWwoMQFmbseo+q4yN7TfGCcx9ADN9SY+wm+i1JbyInvGpRTyCX8OjOWyu
	1EirDMpZ6bnW6f1gXzWKIVBjVuk+pcN5qrsFP/N53FI2eoqB9bcyxLgrZGpAXo9OmZ/qQVsTy
	fYFRGhIhrMk2pi/iTWCksrc5N3gm5mxrtzXPXP5PE6fo71mvmhNJDPBLGP+PbdD3nYbwzzNG6
	ZQqz8+FQBxA/L9E8ipoIAUkmNZHws1G3mNcaANwh/sEDBqsl/oSF0XoUMecnl1yVVAzdTVAxW
	hA2CeV6tHt2KIYn6qhXYZAZrf+ie3Yz3vtT86MukcBpo2cmef+1p6zI6FtQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 0/9] Trivial branch patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 2d9574bdbed69b374116c59259f6bd14f7dfad7f:

  pci: msix: move 'MSIX_CAP_LENGTH' to header file (2019-05-22 17:35:27 +0200)

----------------------------------------------------------------
typo fixes, TYPE_XXX usage cleanup, comments update,
virtio-mmio trace functions cleanup

----------------------------------------------------------------

Boxuan Li (1):
  hw/virtio/virtio-mmio: Convert DPRINTF to trace and log

Greg Kurz (1):
  migration: Fix typo in migrate_add_blocker() error message

Li Qiang (4):
  vfio: pci: make "vfio-pci-nohotplug" as MACRO
  hw: vfio: drop TYPE_FOO MACRO in VMStateDescription
  vfio: platform: fix a typo
  pci: msix: move 'MSIX_CAP_LENGTH' to header file

Markus Armbruster (1):
  configure: Fix spelling of sdl-image in --help

Philippe Mathieu-Daudé (2):
  roms: Correct the EDK2_BASETOOLS_OPTFLAGS variable description
  roms: List and describe the Makefile 'clean' rule

 configure               |  2 +-
 hw/pci/msix.c           |  2 --
 hw/vfio/amd-xgbe.c      |  2 +-
 hw/vfio/ap.c            |  2 +-
 hw/vfio/calxeda-xgmac.c |  2 +-
 hw/vfio/ccw.c           |  2 +-
 hw/vfio/pci.c           |  8 ++++----
 hw/vfio/platform.c      |  6 +++---
 hw/virtio/trace-events  |  7 +++++++
 hw/virtio/virtio-mmio.c | 44 ++++++++++++++++++++---------------------
 include/hw/pci/msix.h   |  2 ++
 migration/migration.c   |  2 +-
 roms/Makefile           |  6 ++++--
 13 files changed, 47 insertions(+), 40 deletions(-)

-- 
2.20.1


