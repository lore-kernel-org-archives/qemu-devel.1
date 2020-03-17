Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9437C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792A0206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMZfFQAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792A0206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE40q-00023k-Kr
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE3zt-00007N-TA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE3zs-0007ey-Ox
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45169)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE3zs-0007dp-Lz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584419912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OyfV+phLIVnDK8cSbzyTqJ4Uu3e1QiDLRfdpREnCi/M=;
 b=RMZfFQABpbR4tSaT82cyWpRDVCLe+XQwKxxJhX1ONnRv5miCQo0g7/xA571gT6MzI5Ebzh
 djy2/SbnVnO0goZIHJlDQ0Rzv/UoIdSA1ycVjhgZYAsRojfEXaieQbF70kXASkjIcta2/l
 NNM+0n5GRwv4HztAIB9t1V9jnaaX5OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-XbchxwwsOsizqpIYVp-aMQ-1; Tue, 17 Mar 2020 00:38:28 -0400
X-MC-Unique: XbchxwwsOsizqpIYVp-aMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C61800D6C;
 Tue, 17 Mar 2020 04:38:27 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB1A91001B07;
 Tue, 17 Mar 2020 04:38:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 jsnow@redhat.com
Subject: [PULL 00/10] Bitmaps patches
Date: Tue, 17 Mar 2020 00:38:09 -0400
Message-Id: <20200317043819.20197-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6e8a73e911f066527e775e04b98f31ebd19db600=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-03-11 14:41:27 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 34b456d485a4df3a88116fb5ef0c418f2f12990d:

  block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty (2020-03-12 16:36:46=
 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Vladimir Sementsov-Ogievskiy (10):
  hbitmap: assert that we don't create bitmap larger than INT64_MAX
  hbitmap: move hbitmap_iter_next_word to hbitmap.c
  hbitmap: unpublish hbitmap_iter_skip_words
  hbitmap: drop meta bitmaps as they are unused
  block/dirty-bitmap: switch _next_dirty_area and _next_zero to int64_t
  block/dirty-bitmap: add _next_dirty API
  block/dirty-bitmap: improve _next_dirty_area API
  nbd/server: introduce NBDExtentArray
  nbd/server: use bdrv_dirty_bitmap_next_dirty_area
  block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty

 include/block/dirty-bitmap.h |   9 +-
 include/qemu/hbitmap.h       |  95 +++--------
 block/dirty-bitmap.c         |  16 +-
 block/qcow2-bitmap.c         |  15 +-
 nbd/server.c                 | 251 ++++++++++++++--------------
 tests/test-hbitmap.c         | 316 +++++++++++++----------------------
 util/hbitmap.c               | 134 +++++++++------
 7 files changed, 375 insertions(+), 461 deletions(-)

--=20
2.21.1


