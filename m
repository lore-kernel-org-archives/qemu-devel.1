Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE912C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B962078C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqx+ivbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B962078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpCK-0001X3-Mj
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLpBU-00009n-Lq
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLpBT-0006os-Nc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLpBT-0006ob-Ks
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586269595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sGviUk3PDjVjvTtWNhaYKXpwbhW6HWlQ0HsjnlOdaDA=;
 b=Oqx+ivbT6gAqXqWd02h1SrwOsG2x4Z+i9MXMFoOD4NIceazVfdVUxWTMJfM6zDwpa+NCJ9
 yHtdcfz2vXXW4pJHkmMYRQe6kBsfqk83QHs8KGL1i/SQoW0HtwALQI27EjP4mq2zFMqE0P
 b7HaUsthzxSCHcuNTIOxzuGVwJuubs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371--PUT0VxAODia9s1Tbh8lFQ-1; Tue, 07 Apr 2020 10:26:31 -0400
X-MC-Unique: -PUT0VxAODia9s1Tbh8lFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19431149C0;
 Tue,  7 Apr 2020 14:26:30 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0EC5DA60;
 Tue,  7 Apr 2020 14:26:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/7] Block layer patches
Date: Tue,  7 Apr 2020 16:26:09 +0200
Message-Id: <20200407142616.7961-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
406' into staging (2020-04-06 12:36:45 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 3f6de653b946fe849330208becf79d6af7e876cb:

  vpc: Don't round up already aligned BAT sizes (2020-04-07 15:42:08 +0200)

----------------------------------------------------------------
Block layer patches:

- Fix crashes and hangs related to iothreads, bdrv_drain and block jobs:
    - Fix some AIO context locking in jobs
    - Fix blk->in_flight during blk_wait_while_drained()
- vpc: Don't round up already aligned BAT sizes

----------------------------------------------------------------
Kevin Wolf (4):
      block-backend: Reorder flush/pdiscard function definitions
      block: Increase BB.in_flight for coroutine and sync interfaces
      block: Fix blk->in_flight during blk_wait_while_drained()
      vpc: Don't round up already aligned BAT sizes

Stefan Reiter (3):
      job: take each job's lock individually in job_txn_apply
      replication: assert we own context before job_cancel_sync
      backup: don't acquire aio_context in backup_clean

 include/sysemu/block-backend.h |   1 -
 block/backup.c                 |   4 -
 block/block-backend.c          | 206 +++++++++++++++++++++++++------------=
----
 block/replication.c            |   5 +-
 block/vpc.c                    |   2 +-
 blockdev.c                     |   9 ++
 job-qmp.c                      |   9 ++
 job.c                          |  50 ++++++++--
 tests/test-blockjob.c          |   2 +
 9 files changed, 193 insertions(+), 95 deletions(-)


