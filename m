Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBCAC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61533206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsOzjN7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61533206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtAG-0005i2-Mv
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNt9U-0004xO-Pf
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNt9T-0007z4-Ch
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:05:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNt9T-0007yg-6H
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586761502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RZCKbBLiuFnZdCNkCVsECS8lV70QZ6GPa9l2d2OloCs=;
 b=SsOzjN7c4DrVTnZTBexwhSasjUHnKASESFCYtHX4SBvwVgwWV7fzjvFx51SQMs+h8nFYtU
 y8OIg2vRrB8grMx9VfpsK2TP5eZEBevAJG6jYOzpFlg8W+r7uJ94q8k9NFMENngBUQcaYA
 fR1vp4sYfUfbn97Zcpoky9ptoeFRImA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-G1Mlc2UKPQiUk32VzT3Jmg-1; Mon, 13 Apr 2020 03:04:59 -0400
X-MC-Unique: G1Mlc2UKPQiUk32VzT3Jmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C335118B5FA0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 07:04:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA555D9C9
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 07:04:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/8] Misc patches for QEMU 5.0-rc3
Date: Mon, 13 Apr 2020 03:04:57 -0400
Message-Id: <20200413070457.25499-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
406' into staging (2020-04-06 12:36:45 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 267514b33ffa3f315adc26fc14d89f92e90840f5:

  module: increase dirs array size by one (2020-04-13 02:56:18 -0400)

----------------------------------------------------------------
Bugfixes, and reworking of the atomics documentation.

----------------------------------------------------------------

v1->v2: remove stray roms/SLOF change

Alexander Duyck (1):
      memory: Do not allow direct write access to rom_device regions

Bauerchen (1):
      oslib-posix: take lock before qemu_cond_broadcast

Bruce Rogers (1):
      module: increase dirs array size by one

Igor Mammedov (1):
      vl.c: error out if -mem-path is used together with -M memory-backend

Olaf Hering (1):
      piix: fix xenfv regression, add compat machine xenfv-4.2

Paolo Bonzini (3):
      atomics: convert to reStructuredText
      atomics: update documentation
      rcu: do not mention atomic_mb_read/set in documentation

 docs/devel/atomics.rst               | 507 +++++++++++++++++++++++++++++++=
++++
 docs/devel/atomics.txt               | 403 ----------------------------
 docs/devel/index.rst                 |   1 +
 docs/devel/rcu.txt                   |   4 +-
 hw/i386/pc_piix.c                    |  19 +-
 include/exec/memory.h                |   4 +-
 softmmu/vl.c                         |   5 +
 tests/qtest/device-introspect-test.c |   2 +-
 tests/qtest/qom-test.c               |  42 +--
 tests/qtest/test-hmp.c               |   2 +-
 util/module.c                        |   2 +-
 util/oslib-posix.c                   |   3 +
 12 files changed, 547 insertions(+), 447 deletions(-)
 create mode 100644 docs/devel/atomics.rst
 delete mode 100644 docs/devel/atomics.txt
--=20
2.18.2


