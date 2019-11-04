Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E22CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60365222CD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VITXjGcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60365222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYJ0-0000g4-Ss
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRYHF-0007MH-0V
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRYHB-0002u8-0Z
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:03:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRYHA-0002sh-GZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572858231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mRKQObjyort/Qz21aDupTRV1GxdYmP9Vmhjsk2YkJjk=;
 b=VITXjGcmglDXSltvLBstRZ6UqUW1mVL13UtokpXNW7SNlby4M8rXxXe6rXdEBynqlAY8Xb
 AM784wg3WrucXEWQOgQcNcvq8IRquOvG/i2sll6HqCYNj5aPZognbhc/4Yver30qkvLWwQ
 s8410/bnNZEIZj+c1evnRvNKqs9S+fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-AWSYpCLyMyaoFBwvjBn6Mw-1; Mon, 04 Nov 2019 04:03:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E21107ACC2;
 Mon,  4 Nov 2019 09:03:49 +0000 (UTC)
Received: from localhost (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE78126FB0;
 Mon,  4 Nov 2019 09:03:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/5] Block patches for 4.2-rc0
Date: Mon,  4 Nov 2019 10:03:42 +0100
Message-Id: <20191104090347.27278-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AWSYpCLyMyaoFBwvjBn6Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408=
:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-s=
f1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-11-04

for you to fetch changes up to 292d06b925b2787ee6f2430996b95651cae42fce:

  block/file-posix: Let post-EOF fallocate serialize (2019-11-04 09:33:51 +=
0100)

----------------------------------------------------------------
Block patches for 4.2-rc0:
- Work around XFS write-zeroes bug in file-posix block driver
- Fix backup job with compression
- Fix to the NVMe block driver header

----------------------------------------------------------------
Klaus Jensen (1):
  nvme: fix NSSRS offset in CAP register

Max Reitz (3):
  block: Make wait/mark serialising requests public
  block: Add bdrv_co_get_self_request()
  block/file-posix: Let post-EOF fallocate serialize

Vladimir Sementsov-Ogievskiy (1):
  block/block-copy: fix s->copy_size for compressed cluster

 include/block/block_int.h |  4 ++++
 include/block/nvme.h      |  2 +-
 block/block-copy.c        |  4 ++--
 block/file-posix.c        | 36 +++++++++++++++++++++++++++++++++
 block/io.c                | 42 ++++++++++++++++++++++++++++-----------
 5 files changed, 73 insertions(+), 15 deletions(-)

--=20
2.21.0


