Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B30DCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0D621D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwiw7x12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0D621D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzxP-0002Iz-LY
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzv8-0005Ak-E4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzv7-00005c-Dd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzv7-00005G-AM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QKKEORkjSl3qn9RQobMMzCY1XBdsBF+pWPNJaKID3LM=;
 b=Iwiw7x12bawFJNdRi/gq9tFuw0vDFmTLCu/ub9dCKN4WfuDxGUr+7B4AG4TW/fhII89xZc
 J01KjPYL6MiVTJkgSbS6n6oEuYgXeE69bdjHuH80jrS+vgG4zCWL36pxRngPuS0snAdMaf
 QQJnnKwnbVeOaAb4O4T+AHwIs5/sKVc=
Received: from mimecast-mx01.redhat.com (209.132.183.4 [209.132.183.4])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-hka8nC21M2e-jDb-BbXFYA-1; Fri, 25 Oct 2019 09:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BB847B;
 Fri, 25 Oct 2019 13:46:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99FB15D70E;
 Fri, 25 Oct 2019 13:46:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/7] Block layer patches
Date: Fri, 25 Oct 2019 15:46:04 +0200
Message-Id: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hka8nC21M2e-jDb-BbXFYA-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7bc8f9734213b76e76631a483be13d6737c2adbc=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191=
025' into staging (2019-10-25 13:12:16 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 5e9785505210e2477e590e61b1ab100d0ec22b01:

  qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation() (2019-=
10-25 15:18:55 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2: Fix data corruption bug that is triggered in partial cluster
  allocation with default options
- qapi: add support for blkreplay driver
- doc: Describe missing generic -blockdev options
- iotests: Fix 118 when run as root
- Minor code cleanups

----------------------------------------------------------------
Kevin Wolf (5):
      iotests: Skip read-only cases in 118 when run as root
      blockdev: Use error_report() in hmp_commit()
      doc: Describe missing generic -blockdev options
      coroutine: Add qemu_co_mutex_assert_locked()
      qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation()

Pavel Dovgaluk (1):
      qapi: add support for blkreplay driver

Vladimir Sementsov-Ogievskiy (1):
      block/backup: drop dead code from backup_job_create

 qapi/block-core.json          | 18 ++++++++++++++++--
 include/qemu/coroutine.h      | 15 +++++++++++++++
 block/backup.c                |  5 +----
 block/qcow2-refcount.c        |  2 ++
 block/qcow2.c                 |  3 ++-
 blockdev.c                    |  7 +++----
 qemu-options.hx               | 22 +++++++++++++++++++++-
 tests/qemu-iotests/118        |  3 +++
 tests/qemu-iotests/iotests.py | 10 ++++++++++
 9 files changed, 73 insertions(+), 12 deletions(-)


