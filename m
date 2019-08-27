Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8363C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8D020679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8D020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hwD-0007cy-5D
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2hth-0005mf-8I
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2htf-0000UI-NH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2hta-0000Ne-5j; Tue, 27 Aug 2019 16:16:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 661E8C0021D7;
 Tue, 27 Aug 2019 20:16:47 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8EA8600D1;
 Tue, 27 Aug 2019 20:16:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:27 +0100
Message-Id: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 27 Aug 2019 20:16:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/12] Block patches
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit dac03af5d5482ec7ee9c23db467bb7230b33c0=
d9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190825' into =
staging (2019-08-27 10:00:51 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 5396234b96a2ac743f48644529771498e036e698:

  block/qcow2: implement .bdrv_co_pwritev(_compressed)_part (2019-08-27 1=
4:58:42 +0100)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Vladimir Sementsov-Ogievskiy (12):
  util/iov: introduce qemu_iovec_init_extended
  util/iov: improve qemu_iovec_is_zero
  block/io: refactor padding
  block: define .*_part io handlers in BlockDriver
  block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
  block/io: bdrv_co_do_copy_on_readv: lazy allocation
  block/io: bdrv_aligned_preadv: use and support qiov_offset
  block/io: bdrv_aligned_pwritev: use and support qiov_offset
  block/io: introduce bdrv_co_p{read, write}v_part
  block/qcow2: refactor qcow2_co_preadv to use buffer-based io
  block/qcow2: implement .bdrv_co_preadv_part
  block/qcow2: implement .bdrv_co_pwritev(_compressed)_part

 block/qcow2.h             |   1 +
 include/block/block_int.h |  21 ++
 include/qemu/iov.h        |  10 +-
 block/backup.c            |   2 +-
 block/io.c                | 541 +++++++++++++++++++++++---------------
 block/qcow2-cluster.c     |  14 +-
 block/qcow2.c             | 131 +++++----
 qemu-img.c                |   4 +-
 util/iov.c                | 153 +++++++++--
 9 files changed, 568 insertions(+), 309 deletions(-)

--=20
2.21.0


