Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15608C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E482077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3GqHnSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E482077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5uh-0007pf-0V
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tj-0006VL-Fm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH5ti-0005rd-GD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH5ti-0005qt-Cz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5WNCRbdIY0/2OuOC21kFX6SisQryhJaZwWHpjFbfzIA=;
 b=Q3GqHnSzrHSQZ5vAnoaCZirzUvU85mo/wTt5TkNYxsdEDNy3lSXgzfoIsHG43bfEM1aehY
 12T6sy8ASLi9pkmxsOpP/V/Qd/5avgodHLB2b4z0hnwuCfAF3DzUFwXcz8tGNtAJIj6niM
 tcEzQ0/J2GMnrJ8XZ22+ZH3VaZU5Djk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-p28B7nM4OUOC4U0ztnfyBA-1; Wed, 25 Mar 2020 09:16:38 -0400
X-MC-Unique: p28B7nM4OUOC4U0ztnfyBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FADA800D4E;
 Wed, 25 Mar 2020 13:16:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0A045C241;
 Wed, 25 Mar 2020 13:16:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pannengyuan@huawei.com,
 maozhongyi@cmss.chinamobile.com, vsementsov@virtuozzo.com,
 imammedo@redhat.com, philmd@redhat.com
Subject: [PULL 0/9] migration queue
Date: Wed, 25 Mar 2020 13:16:23 +0000
Message-Id: <20200325131632.311034-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 736cf607e40674776d752acc201f565723e86045=
:

  Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200325b

for you to fetch changes up to 7cd75cbdb8a45d9e2d5912f774d8194cbafdfa97:

  migration: use "" instead of (null) for tls-authz (2020-03-25 12:31:38 +0=
000)

----------------------------------------------------------------
Combo Migration/HMP/virtiofs pull

Small fixes all around.
Ones that are noticeable:
  a) Igor's migration compatibility fix affecting older machine types
     has been seen in the wild
  b) Philippe's autconverge fix should fix an intermittently
     failing migration test.
  c) Mao's makes a small change to the output of 'info
     migrate_parameters'  for tls-authz.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      hmp/vnc: Fix info vnc list leak

Igor Mammedov (1):
      vl.c: fix migration failure for 3.1 and older machine types

Mao Zhongyi (2):
      xbzrle: update xbzrle doc
      migration: use "" instead of (null) for tls-authz

Pan Nengyuan (1):
      hmp-cmd: fix a missing_break warning

Philippe Mathieu-Daud=C3=A9 (2):
      tests/migration: Reduce autoconverge initial bandwidth
      tools/virtiofsd/passthrough_ll: Fix double close()

Vladimir Sementsov-Ogievskiy (2):
      migration/colo: fix use after free of local_err
      migration/ram: fix use after free of local_err

 docs/xbzrle.txt                  |  7 ++++++-
 migration/colo.c                 |  1 +
 migration/migration.c            |  5 +++--
 migration/ram.c                  |  1 +
 monitor/hmp-cmds.c               | 12 +++++++-----
 softmmu/vl.c                     |  3 +++
 tests/qtest/migration-test.c     |  2 +-
 tools/virtiofsd/passthrough_ll.c |  3 +--
 8 files changed, 23 insertions(+), 11 deletions(-)


