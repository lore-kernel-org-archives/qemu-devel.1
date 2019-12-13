Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4028C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D51C24679
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVGWaJ2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D51C24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifm1P-0005D3-Jl
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifm0S-0004IT-KW
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifm0Q-0007w3-IS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifm0Q-0007tv-Ec
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576247601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hg83ZnhGHgO+A6W34x1mf413/NvyOQEF+jYZ7+U3csw=;
 b=dVGWaJ2md6b5QKeDMbKYWsBCaIfKQBK7anVtd2SLaL7j3X7ROtNvFrp9dO9hu7WOR9138y
 L8deUIM2VenUFGgTLB6RouX0Peim8C7hs35Di5j+U7ITZj9mwZlPn2mRpK8esK8CzZTvch
 myrsBPynxkIDejo1oXyzGx5M0cthm/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-1A7hKeBdPMCjGCXZoPRZtw-1; Fri, 13 Dec 2019 09:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3924107ACC5;
 Fri, 13 Dec 2019 14:33:17 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A086601A2;
 Fri, 13 Dec 2019 14:33:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Block patches
Date: Fri, 13 Dec 2019 14:33:12 +0000
Message-Id: <20191213143314.1198821-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1A7hKeBdPMCjGCXZoPRZtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f=
:

  Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 86d2a49b41832355ab50cf60cec0cd50680fc0e5:

  iothread: document -object iothread on man page (2019-12-13 11:24:07 +000=
0)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Evgeny Yakovlev (1):
  virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE is advertised

Stefan Hajnoczi (1):
  iothread: document -object iothread on man page

 hw/arm/virt.c                  |  1 +
 hw/block/virtio-blk.c          |  6 +++++-
 hw/core/machine.c              |  5 +++++
 hw/i386/pc_piix.c              |  1 +
 hw/i386/pc_q35.c               |  1 +
 hw/ppc/spapr.c                 |  2 +-
 hw/s390x/s390-virtio-ccw.c     |  1 +
 include/hw/boards.h            |  3 +++
 include/hw/virtio/virtio-blk.h |  1 +
 qemu-options.hx                | 38 ++++++++++++++++++++++++++++++++++
 10 files changed, 57 insertions(+), 2 deletions(-)

--=20
2.23.0


