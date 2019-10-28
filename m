Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC89CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4476E20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjfCv4Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4476E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOye0-0000uA-Eb
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 02:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iOycn-0007e0-1C
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iOyck-0007ib-DM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iOyck-0007hn-1D
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572244528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/wk5SRFiic3AseQ/V2y4QVnTZ4nycZnHhGiXfWWV2pY=;
 b=CjfCv4JeYUe/40vNN6h8BcgXwiB6iS+VZH+3Nf5L8Dpy3bigELwecf5qvFJG1x6NnJRe/m
 K49SyL/TEnT0+tBsLVLrU95E5WBC6NBjWcvPuARWjxPql8db1ExTEiEOBjOlB5qem0A951
 QTZPWEqzJNsVfWRQG6qoQn3+JocWpvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-kwki--ofMLCcHVA8DUVFzA-1; Mon, 28 Oct 2019 02:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A94831005509;
 Mon, 28 Oct 2019 06:35:24 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-12.pek2.redhat.com
 [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB58B5C1D6;
 Mon, 28 Oct 2019 06:35:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/4] Net patches
Date: Mon, 28 Oct 2019 14:35:16 +0800
Message-Id: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kwki--ofMLCcHVA8DUVFzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-2510=
19-3' into staging (2019-10-26 10:13:48 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 5af982a47cf6b6cd9beb872e5a9b940e43df5bf9:

  COLO-compare: Fix incorrect `if` logic (2019-10-28 14:28:31 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Fan Yang (1):
      COLO-compare: Fix incorrect `if` logic

Michael S. Tsirkin (1):
      virtio: new post_load hook

Mikhail Sennikovsky (1):
      virtio-net: prevent offloads reset on migration

Sven Schnelle (1):
      net: add tulip (dec21143) driver

 MAINTAINERS                    |    6 +
 hw/net/Kconfig                 |    5 +
 hw/net/Makefile.objs           |    1 +
 hw/net/trace-events            |   14 +
 hw/net/tulip.c                 | 1029 ++++++++++++++++++++++++++++++++++++=
++++
 hw/net/tulip.h                 |  267 +++++++++++
 hw/net/virtio-net.c            |   27 +-
 hw/virtio/virtio.c             |    7 +
 include/hw/pci/pci_ids.h       |    1 +
 include/hw/virtio/virtio-net.h |    2 +
 include/hw/virtio/virtio.h     |    6 +
 net/colo-compare.c             |    6 +-
 12 files changed, 1365 insertions(+), 6 deletions(-)
 create mode 100644 hw/net/tulip.c
 create mode 100644 hw/net/tulip.h



