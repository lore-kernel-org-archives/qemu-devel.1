Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D4C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3633820896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3633820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6a7-0003LB-HZ
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6UK-0007Qq-9d
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6UG-0006CV-7C
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hb6UC-00069b-OO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5BA29308795D
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0744160BF1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8677D1138648; Wed, 12 Jun 2019 18:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 18:52:18 +0200
Message-Id: <20190612165229.26976-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/11] QAPI patches for 2019-06-12
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

The following changes since commit a050901d4b40092dc356b59912c6df39e389c7=
b9:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612=
' into staging (2019-06-12 14:43:47 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-06-12

for you to fetch changes up to 157dd363955b961ef378eb1f7817c31a7fa94d10:

  qapi: Simplify how QAPIDoc implements its state machine (2019-06-12 18:=
37:17 +0200)

----------------------------------------------------------------
QAPI patches for 2019-06-12

----------------------------------------------------------------
Kevin Wolf (6):
      qapi: Add feature flags to struct types
      tests/qapi-schema: Test for good feature lists in structs
      tests/qapi-schema: Error case tests for features in structs
      qapi: Disentangle QAPIDoc code
      qapi: Allow documentation for features
      file-posix: Add dynamic-auto-read-only QAPI feature

Markus Armbruster (2):
      qdev: Delete unused LostTickPolicy "merge"
      qapi: Simplify how QAPIDoc implements its state machine

Stefano Garzarella (3):
      qapi/block-core: update documentation of preallocation parameter
      block/file-posix: update .help of BLOCK_OPT_PREALLOC option
      block/gluster: update .help of BLOCK_OPT_PREALLOC option

 block/file-posix.c                             |   6 +-
 block/gluster.c                                |   9 +-
 docs/devel/qapi-code-gen.txt                   |  38 ++++
 qapi/block-core.json                           |  33 +++-
 qapi/introspect.json                           |   6 +-
 qapi/misc.json                                 |   6 +-
 scripts/qapi/common.py                         | 243 +++++++++++++++++++=
++----
 scripts/qapi/doc.py                            |  15 +-
 scripts/qapi/introspect.py                     |   6 +-
 scripts/qapi/types.py                          |   3 +-
 scripts/qapi/visit.py                          |   3 +-
 tests/Makefile.include                         |   6 +
 tests/qapi-schema/double-type.err              |   2 +-
 tests/qapi-schema/features-bad-type.err        |   1 +
 tests/qapi-schema/features-bad-type.exit       |   1 +
 tests/qapi-schema/features-bad-type.json       |   3 +
 tests/qapi-schema/features-bad-type.out        |   0
 tests/qapi-schema/features-duplicate-name.err  |   1 +
 tests/qapi-schema/features-duplicate-name.exit |   1 +
 tests/qapi-schema/features-duplicate-name.json |   3 +
 tests/qapi-schema/features-duplicate-name.out  |   0
 tests/qapi-schema/features-missing-name.err    |   1 +
 tests/qapi-schema/features-missing-name.exit   |   1 +
 tests/qapi-schema/features-missing-name.json   |   3 +
 tests/qapi-schema/features-missing-name.out    |   0
 tests/qapi-schema/features-name-bad-type.err   |   1 +
 tests/qapi-schema/features-name-bad-type.exit  |   1 +
 tests/qapi-schema/features-name-bad-type.json  |   3 +
 tests/qapi-schema/features-name-bad-type.out   |   0
 tests/qapi-schema/features-no-list.err         |   1 +
 tests/qapi-schema/features-no-list.exit        |   1 +
 tests/qapi-schema/features-no-list.json        |   3 +
 tests/qapi-schema/features-no-list.out         |   0
 tests/qapi-schema/features-unknown-key.err     |   2 +
 tests/qapi-schema/features-unknown-key.exit    |   1 +
 tests/qapi-schema/features-unknown-key.json    |   3 +
 tests/qapi-schema/features-unknown-key.out     |   0
 tests/qapi-schema/qapi-schema-test.json        |  39 ++++
 tests/qapi-schema/qapi-schema-test.out         |  43 +++++
 tests/qapi-schema/test-qapi.py                 |   7 +-
 tests/qapi-schema/unknown-expr-key.err         |   2 +-
 tests/test-qmp-cmds.c                          |   8 +
 42 files changed, 447 insertions(+), 59 deletions(-)
 create mode 100644 tests/qapi-schema/features-bad-type.err
 create mode 100644 tests/qapi-schema/features-bad-type.exit
 create mode 100644 tests/qapi-schema/features-bad-type.json
 create mode 100644 tests/qapi-schema/features-bad-type.out
 create mode 100644 tests/qapi-schema/features-duplicate-name.err
 create mode 100644 tests/qapi-schema/features-duplicate-name.exit
 create mode 100644 tests/qapi-schema/features-duplicate-name.json
 create mode 100644 tests/qapi-schema/features-duplicate-name.out
 create mode 100644 tests/qapi-schema/features-missing-name.err
 create mode 100644 tests/qapi-schema/features-missing-name.exit
 create mode 100644 tests/qapi-schema/features-missing-name.json
 create mode 100644 tests/qapi-schema/features-missing-name.out
 create mode 100644 tests/qapi-schema/features-name-bad-type.err
 create mode 100644 tests/qapi-schema/features-name-bad-type.exit
 create mode 100644 tests/qapi-schema/features-name-bad-type.json
 create mode 100644 tests/qapi-schema/features-name-bad-type.out
 create mode 100644 tests/qapi-schema/features-no-list.err
 create mode 100644 tests/qapi-schema/features-no-list.exit
 create mode 100644 tests/qapi-schema/features-no-list.json
 create mode 100644 tests/qapi-schema/features-no-list.out
 create mode 100644 tests/qapi-schema/features-unknown-key.err
 create mode 100644 tests/qapi-schema/features-unknown-key.exit
 create mode 100644 tests/qapi-schema/features-unknown-key.json
 create mode 100644 tests/qapi-schema/features-unknown-key.out

--=20
2.21.0


