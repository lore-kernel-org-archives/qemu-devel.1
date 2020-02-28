Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A1C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F77246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKGwq8lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F77246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7btj-0007iv-HO
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7bso-0006BL-T3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7bsn-0003ho-BS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:24:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7bsn-0003hT-2X
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582881872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=099WWQ/QsNMjKwYVzLNMAvwgD2t6RSnfgPyNRuOp8Ss=;
 b=fKGwq8lqm3qM2qk4400Iq/qSR/2h50SeZILfMx7fz8kO6SDC1OYBKd2MO8UZK/VTmfaTHl
 k0BTy0sN7w6+K3KThar8I4cZfV8qZdru3iA5OAEG58xa1Z9NJiWvsPADspj7NydVqUHOKe
 UCzVYi+geIOlj79HOYx/CnizLEbC1QQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-7AJdcKCgMe-uL_4ta2cvBA-1; Fri, 28 Feb 2020 04:24:29 -0500
X-MC-Unique: 7AJdcKCgMe-uL_4ta2cvBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65C5CA0CBF;
 Fri, 28 Feb 2020 09:24:28 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C22160BE0;
 Fri, 28 Feb 2020 09:24:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] Pull migration patches
Date: Fri, 28 Feb 2020 10:24:05 +0100
Message-Id: <20200228092420.103757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8b6b68e05b43f976714ca1d2afe01a64e1d82cba=
:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging=
 (2020-02-27 19:15:15 +0000)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/pull-migration-pull-request

for you to fetch changes up to f51d0b4178738bba87d796eba7444f6cdb3aa0fd:

  savevm: Don't call colo_init_ram_cache twice (2020-02-28 10:13:54 +0100)

----------------------------------------------------------------
Migration pull request

- cleanup redundant initilazation (chen)
- fix memleak in test_load_qlist (chen)
- several colo fixes (hailiang)
- multifd compression (juan)
- release list after use (pan)
- rename BLOCK_SIZE (stefan)

Please apply.

----------------------------------------------------------------

Chen Qun (2):
  migration/vmstate: Remove redundant statement in
    vmstate_save_state_v()
  test-vmstate: Fix memleaks in test_load_qlist

Hailiang Zhang (3):
  migration: fix COLO broken caused by a previous commit
  migration/colo: wrap incoming checkpoint process into new helper
  savevm: Don't call colo_init_ram_cache twice

Juan Quintela (8):
  multifd: Add multifd-compression parameter
  migration: Add support for modules
  multifd: Make no compression operations into its own structure
  multifd: Add multifd-zlib-level parameter
  multifd: Add zlib compression multifd support
  configure: Enable test and libs for zstd
  multifd: Add multifd-zstd-level parameter
  multifd: Add zstd compression multifd support

Pan Nengyuan (1):
  migration/savevm: release gslist after dump_vmstate_json

Stefan Hajnoczi (1):
  migration/block: rename BLOCK_SIZE macro

 .gitlab-ci.yml                                |   1 +
 .travis.yml                                   |   1 +
 configure                                     |  30 ++
 hw/core/qdev-properties.c                     |  13 +
 include/hw/qdev-properties.h                  |   4 +
 include/qemu/module.h                         |   2 +
 migration/Makefile.objs                       |   2 +
 migration/block.c                             |  39 +-
 migration/colo.c                              | 260 +++++++-------
 migration/migration.c                         |  76 +++-
 migration/migration.h                         |   3 +
 migration/multifd-zlib.c                      | 325 +++++++++++++++++
 migration/multifd-zstd.c                      | 339 ++++++++++++++++++
 migration/multifd.c                           | 191 +++++++++-
 migration/multifd.h                           |  31 ++
 migration/ram.c                               |   2 +-
 migration/savevm.c                            |   1 +
 migration/vmstate.c                           |   1 -
 monitor/hmp-cmds.c                            |  21 ++
 qapi/migration.json                           |  80 ++++-
 softmmu/vl.c                                  |   1 +
 tests/docker/dockerfiles/centos7.docker       |   3 +-
 .../dockerfiles/fedora-i386-cross.docker      |   3 +-
 tests/docker/dockerfiles/fedora.docker        |   3 +-
 tests/docker/dockerfiles/ubuntu.docker        |   1 +
 tests/docker/dockerfiles/ubuntu1804.docker    |   1 +
 tests/qtest/migration-test.c                  |  30 +-
 tests/test-vmstate.c                          |   6 +-
 tests/vm/fedora                               |   5 +-
 tests/vm/freebsd                              |   3 +
 tests/vm/netbsd                               |   3 +
 tests/vm/openbsd                              |   3 +
 32 files changed, 1307 insertions(+), 177 deletions(-)
 create mode 100644 migration/multifd-zlib.c
 create mode 100644 migration/multifd-zstd.c

--=20
2.24.1


