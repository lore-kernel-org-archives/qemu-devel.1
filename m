Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC860C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8847320873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVuTxbb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8847320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1wS-0007WA-LP
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1mk-0003jR-7d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1mi-0002NG-Gg
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1mi-0002KJ-C3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZW31GKJvg3FAGTcVAps6bTQosW/WRroO/MgRCFN7IEc=;
 b=ZVuTxbb6cQdI4Hm4iEMc39AorH5zVUYtDLWZg6CKcpXUFTdSP8zGRpO3YYmgqSf46SMmGN
 f9nH0PWUxyHepFSiQbRARNAf46SPKWb6KQi/DkiQ2DEN7ywvM2oBFbAm53JVybgpvq0dA5
 8Wh7qDD3QfLKUf1KkqrRy7Mb4FbnhIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-vEnnakI1PjCJPRavfxde4g-1; Wed, 11 Mar 2020 09:52:16 -0400
X-MC-Unique: vEnnakI1PjCJPRavfxde4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED090107ACC4;
 Wed, 11 Mar 2020 13:52:15 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66BB55D9C5;
 Wed, 11 Mar 2020 13:52:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/19] Block patches
Date: Wed, 11 Mar 2020 14:51:54 +0100
Message-Id: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ba29883206d92a29ad5a466e679ccfc2ee6132ef=
:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20200310' in=
to staging (2020-03-10 16:50:28 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-03-11

for you to fetch changes up to 397f4e9d83e9c0000905f0a988ba1aeda162571c:

  block/block-copy: hide structure definitions (2020-03-11 12:42:30 +0100)

----------------------------------------------------------------
Block patches for the 5.0 softfreeze:
- qemu-img measure for LUKS
- Improve block-copy's performance by reducing inter-request
  dependencies
- Make curl's detection of accept-ranges more robust
- Memleak fixes
- iotest fix

----------------------------------------------------------------
David Edmondson (2):
  block/curl: HTTP header fields allow whitespace around values
  block/curl: HTTP header field names are case insensitive

Eric Blake (1):
  iotests: Fix nonportable use of od --endian

Pan Nengyuan (2):
  block/qcow2: do free crypto_opts in qcow2_close()
  qemu-img: free memory before re-assign

Stefan Hajnoczi (4):
  luks: extract qcrypto_block_calculate_payload_offset()
  luks: implement .bdrv_measure()
  qemu-img: allow qemu-img measure --object without a filename
  iotests: add 288 luks qemu-img measure test

Vladimir Sementsov-Ogievskiy (10):
  block/qcow2-threads: fix qcow2_decompress
  job: refactor progress to separate object
  block/block-copy: fix progress calculation
  block/block-copy: specialcase first copy_range request
  block/block-copy: use block_status
  block/block-copy: factor out find_conflicting_inflight_req
  block/block-copy: refactor interfaces to use bytes instead of end
  block/block-copy: rename start to offset in interfaces
  block/block-copy: reduce intersecting request lock
  block/block-copy: hide structure definitions

 block/backup-top.c               |   6 +-
 block/backup.c                   |  38 ++-
 block/block-copy.c               | 405 ++++++++++++++++++++++++-------
 block/crypto.c                   |  62 +++++
 block/curl.c                     |  32 ++-
 block/qcow2-threads.c            |  12 +-
 block/qcow2.c                    |  75 ++----
 block/trace-events               |   1 +
 blockjob.c                       |  16 +-
 crypto/block.c                   |  36 +++
 include/block/block-copy.h       |  65 +----
 include/crypto/block.h           |  22 ++
 include/qemu/job.h               |  11 +-
 include/qemu/progress_meter.h    |  58 +++++
 job-qmp.c                        |   4 +-
 job.c                            |   6 +-
 qemu-img.c                       |  14 +-
 tests/qemu-iotests/178           |   2 +-
 tests/qemu-iotests/178.out.qcow2 |   8 +-
 tests/qemu-iotests/178.out.raw   |   8 +-
 tests/qemu-iotests/288           |  93 +++++++
 tests/qemu-iotests/288.out       |  30 +++
 tests/qemu-iotests/common.rc     |  22 +-
 tests/qemu-iotests/group         |   1 +
 24 files changed, 749 insertions(+), 278 deletions(-)
 create mode 100644 include/qemu/progress_meter.h
 create mode 100755 tests/qemu-iotests/288
 create mode 100644 tests/qemu-iotests/288.out

--=20
2.24.1


