Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD1CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A35520873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZg6jMXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A35520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ERM-0007Ny-Ci
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2EQA-0005qG-LK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2EQ7-0007e7-VW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2EQ6-0007d9-QY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mpca1UOHAgXcHXMhQBIGgzVutf8pBBVorv5mb8vL0VA=;
 b=eZg6jMXa4Wg6YvXRHDVtIjOFzbJAU8/yFUpKuobPgjCReiNKGkVs7tEh1TH2PnMRuoGf+C
 8eFlalLeSFFf6MiU0Dd72BMFj2Rm4nAk7gaVipwwpvSNs4nWo3BbOMvyGV0R1k1h0nuJ6i
 2+AowsgFkGfEIyGNz3a0Ie/IAY7ZMp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-KpU1dLeFNBGtH8DeKPAjLg-1; Thu, 13 Feb 2020 08:20:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C13B8010CB
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:20:38 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81F835C1BB;
 Thu, 13 Feb 2020 13:20:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Pull migration patches
Date: Thu, 13 Feb 2020 14:20:24 +0100
Message-Id: <20200213132030.57757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KpU1dLeFNBGtH8DeKPAjLg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730=
:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-=
20200210' into staging (2020-02-10 18:09:14 +0000)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/pull-migration-pull-request

for you to fetch changes up to 1a920d2b633e13df8961328b3b3e128989a34570:

  git: Make submodule check only needed modules (2020-02-13 11:31:58 +0100)

----------------------------------------------------------------
Migration pull request

- don't pause when migration has been cancelled (Zhimin)
- fix memleaks in tests (pan)(
- optimize wait-unplug (keqian)
- improve rdma error handling/messages (dave)
- add some flexibility in autoconverge test (dave)
- git-submodule: allow compiliation from same tree with different
  number of git-submodules (juan)

Please, Apply.

----------------------------------------------------------------

Dr. David Alan Gilbert (2):
  migration/rdma: rdma_accept_incoming_migration fix error handling
  tests/migration: Add some slack to auto converge

Juan Quintela (1):
  git: Make submodule check only needed modules

Keqian Zhu (1):
  migration: Optimization about wait-unplug migration state

Pan Nengyuan (1):
  migration-test: fix some memleaks in migration-test

Zhimin Feng (1):
  migration: Maybe VM is paused when migration is cancelled

 migration/migration.c        | 26 +++++++++++++++++---------
 migration/rdma.c             | 11 +++++++----
 migration/savevm.c           | 24 +++---------------------
 migration/savevm.h           |  1 -
 scripts/git-submodule.sh     | 12 ++++++++----
 tests/qtest/migration-test.c | 17 ++++++++++++++---
 6 files changed, 49 insertions(+), 42 deletions(-)

--=20
2.24.1


