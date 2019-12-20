Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F3B24679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5OG9Zug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F3B24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFUi-0003es-Q9
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iiFTU-0002CF-Tg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iiFTT-0002Y1-9o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:25:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iiFTS-0002TX-V0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576837533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+gobIN26NugsNJo2wt8HVpUOEjOaH3Rrp0aARDbDGlQ=;
 b=h5OG9ZugMyNNlokY/yQ4t5FmWKCZfnaFemit77V3V35zsIF51ObZOfzqXJTKVYbO7ShxcE
 D4Gxb79qNdK/X9n5Oxr7+WPGBtANaMi0wuXxOjS9nt08KcsQJmkt9wjzE73jBSvzSqH9zP
 g0++7pBF/Jqj550EJYI/sGS0c2AvFpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-KASoKuuxMHa_oZNGwYuI0A-1; Fri, 20 Dec 2019 05:25:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA74911EA;
 Fri, 20 Dec 2019 10:25:28 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6A47D9D2;
 Fri, 20 Dec 2019 10:25:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Block patches
Date: Fri, 20 Dec 2019 10:25:17 +0000
Message-Id: <20191220102520.1637190-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KASoKuuxMHa_oZNGwYuI0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681=
:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-=
12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 725fe5d10dbd4259b1853b7d253cef83a3c0d22a:

  virtio-blk: fix out-of-bounds access to bitmap in notify_guest_bh (2019-1=
2-19 16:20:25 +0000)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Li Hangjing (1):
  virtio-blk: fix out-of-bounds access to bitmap in notify_guest_bh

Stefan Hajnoczi (2):
  virtio-blk: deprecate SCSI passthrough
  docs: fix rst syntax errors in unbuilt docs

 docs/arm-cpu-features.rst       |  6 +++---
 docs/virtio-net-failover.rst    |  4 ++--
 docs/virtio-pmem.rst            | 19 ++++++++++---------
 hw/block/dataplane/virtio-blk.c |  2 +-
 qemu-deprecated.texi            | 11 +++++++++++
 5 files changed, 27 insertions(+), 15 deletions(-)

--=20
2.23.0


