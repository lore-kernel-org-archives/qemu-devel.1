Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C14CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6D2205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvgqPS+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6D2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO59q-0008RD-UO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iO56x-0002yW-N6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iO56s-0003vA-8T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:18:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iO56s-0003ur-02
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572031133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EGm4IB7QsZrRpoJhJBu4SNax9LQtjAoS4p7d+8vKPgs=;
 b=dvgqPS+AOmrbymaGLPwfD1+Avh1pJ+wtmE/yCZemgh2hgckAESHepD3ECeNB6RSqytVxsM
 8L3/Mfr38xBs1YKTdKHUQ2DNg+hgR8RbaWj1i5tGhiJkzZpoWZG+rTUvIqD4EgwocHdgpr
 jB7Q1tYK0w8JzSbHOpCtPRdwr9Jaa0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-31UhpQK0OdSgmqlzU1zVAw-1; Fri, 25 Oct 2019 15:18:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E12107AD31;
 Fri, 25 Oct 2019 19:18:46 +0000 (UTC)
Received: from localhost (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 819E95C1B5;
 Fri, 25 Oct 2019 19:18:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Block patches
Date: Fri, 25 Oct 2019 21:18:37 +0200
Message-Id: <20191025191839.1215-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 31UhpQK0OdSgmqlzU1zVAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2=
:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' =
into staging (2019-10-24 16:22:58 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to d154ef37ff885918fa3e512fd7a8e42870291667:

  yield_until_fd_readable: make it work with any AioContect (2019-10-25 14:=
38:29 +0200)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Dietmar Maurer (1):
  yield_until_fd_readable: make it work with any AioContect

Julia Suvorova (1):
  virtio-blk: Add blk_drain() to virtio_blk_device_unrealize()

 hw/block/virtio-blk.c    | 1 +
 util/qemu-coroutine-io.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

--=20
2.21.0


