Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1644C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89708206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMtSFjBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89708206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxFX-00017N-HK
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9r-00019H-7B
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9q-0000l3-54
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gkvgUElP7UESnDi+s7292BJabMns1afDGA4Z3NlhtCk=;
 b=CMtSFjBbO9JjNYEdoYxPsmZnBxejkTFBcMkvorD/Q+uUoApVDusaweGc0wJz76FV6TXTrP
 lQhU5+rLWjjIaIuTg+jwR69OFYOSVeCX1yNW016BCtsYn9dmyC+OejITyylLvXtdxquXjJ
 RhwgjH78pXU414zVbHpocDdAHf2vjog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-lX3r4-_CMOqDPuHoemsS1A-1; Tue, 05 May 2020 08:58:29 -0400
X-MC-Unique: lX3r4-_CMOqDPuHoemsS1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 633C5107ACCA;
 Tue,  5 May 2020 12:58:28 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0676B63F97;
 Tue,  5 May 2020 12:58:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/24] Block patches
Date: Tue,  5 May 2020 14:58:02 +0200
Message-Id: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

The following changes since commit 5375af3cd7b8adcc10c18d8083b7be63976c9645=
:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging=
 (2020-05-04 15:51:09 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-05-05

for you to fetch changes up to 4ce5dd3e9b5ee0fac18625860eb3727399ee965e:

  block/block-copy: use aio-task-pool API (2020-05-05 14:03:28 +0200)

----------------------------------------------------------------
Block patches:
- Asynchronous copying for block-copy (i.e., the backup job)
- Allow resizing of qcow2 images when they have internal snapshots
- iotests: Logging improvements for Python tests
- iotest 153 fix, and block comment cleanups

----------------------------------------------------------------
Eric Blake (4):
  block: Add blk_new_with_bs() helper
  qcow2: Allow resize of images with internal snapshots
  qcow2: Tweak comment about bitmaps vs. resize
  block: Comment cleanups

John Snow (14):
  iotests: do a light delinting
  iotests: don't use 'format' for drive_add
  iotests: ignore import warnings from pylint
  iotests: replace mutable list default args
  iotests: add pylintrc file
  iotests: alphabetize standard imports
  iotests: drop pre-Python 3.4 compatibility code
  iotests: touch up log function signature
  iotests: limit line length to 79 chars
  iotests: add hmp helper with logging
  iotests: add script_initialize
  iotest 258: use script_main
  iotests: Mark verify functions as private
  iotests: use python logging for iotests.log()

Maxim Levitsky (1):
  Fix iotest 153

Vladimir Sementsov-Ogievskiy (5):
  block/block-copy: rename in-flight requests to tasks
  block/block-copy: alloc task on each iteration
  block/block-copy: add state pointer to BlockCopyTask
  block/block-copy: refactor task creation
  block/block-copy: use aio-task-pool API

 include/sysemu/block-backend.h |   2 +
 block/block-backend.c          |  23 +++
 block/block-copy.c             | 279 +++++++++++++++++--------
 block/crypto.c                 |   9 +-
 block/io.c                     |   3 +-
 block/parallels.c              |   8 +-
 block/qcow.c                   |   8 +-
 block/qcow2-refcount.c         |   2 +-
 block/qcow2-snapshot.c         |  20 +-
 block/qcow2.c                  |  45 ++--
 block/qed.c                    |   8 +-
 block/sheepdog.c               |  10 +-
 block/vdi.c                    |   8 +-
 block/vhdx.c                   |   8 +-
 block/vmdk.c                   |   9 +-
 block/vpc.c                    |   8 +-
 block/vvfat.c                  |  10 +-
 blockdev.c                     |   8 +-
 blockjob.c                     |   7 +-
 tests/qemu-iotests/001         |   2 +-
 tests/qemu-iotests/030         |   4 +-
 tests/qemu-iotests/052         |   2 +-
 tests/qemu-iotests/055         |   3 +-
 tests/qemu-iotests/061         |  35 ++++
 tests/qemu-iotests/061.out     |  28 +++
 tests/qemu-iotests/134         |   2 +-
 tests/qemu-iotests/149         |   3 +-
 tests/qemu-iotests/153         |   2 +-
 tests/qemu-iotests/153.out     |  12 +-
 tests/qemu-iotests/155         |   2 +-
 tests/qemu-iotests/188         |   2 +-
 tests/qemu-iotests/194         |   4 +-
 tests/qemu-iotests/202         |   4 +-
 tests/qemu-iotests/203         |   4 +-
 tests/qemu-iotests/206         |   2 +-
 tests/qemu-iotests/207         |   6 +-
 tests/qemu-iotests/208         |   2 +-
 tests/qemu-iotests/209         |   2 +-
 tests/qemu-iotests/210         |   6 +-
 tests/qemu-iotests/211         |   6 +-
 tests/qemu-iotests/212         |   6 +-
 tests/qemu-iotests/213         |   6 +-
 tests/qemu-iotests/216         |   4 +-
 tests/qemu-iotests/218         |   2 +-
 tests/qemu-iotests/219         |   2 +-
 tests/qemu-iotests/222         |   7 +-
 tests/qemu-iotests/224         |   4 +-
 tests/qemu-iotests/228         |   6 +-
 tests/qemu-iotests/234         |   4 +-
 tests/qemu-iotests/235         |   4 +-
 tests/qemu-iotests/236         |   2 +-
 tests/qemu-iotests/237         |   2 +-
 tests/qemu-iotests/238         |   2 +
 tests/qemu-iotests/242         |   2 +-
 tests/qemu-iotests/245         |   1 +
 tests/qemu-iotests/245.out     |  10 +-
 tests/qemu-iotests/246         |   2 +-
 tests/qemu-iotests/248         |   2 +-
 tests/qemu-iotests/254         |   2 +-
 tests/qemu-iotests/255         |   2 +-
 tests/qemu-iotests/256         |   2 +-
 tests/qemu-iotests/258         |  10 +-
 tests/qemu-iotests/260         |   4 +-
 tests/qemu-iotests/262         |   4 +-
 tests/qemu-iotests/264         |   4 +-
 tests/qemu-iotests/274         |   4 +-
 tests/qemu-iotests/277         |   2 +
 tests/qemu-iotests/280         |   8 +-
 tests/qemu-iotests/283         |   4 +-
 tests/qemu-iotests/iotests.py  | 366 ++++++++++++++++++++-------------
 tests/qemu-iotests/pylintrc    |  26 +++
 71 files changed, 728 insertions(+), 386 deletions(-)
 create mode 100644 tests/qemu-iotests/pylintrc

--=20
2.26.2


