Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0277C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8122051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbWAxt1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8122051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJPZ-000815-G0
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJL0-0002o2-NT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJKy-0002BW-Du
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJKy-000289-9G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rRmlZdhQWeoUSv+ZM7HXXBceHWchhlaSA7WEALrQvHI=;
 b=TbWAxt1HWI3QcpyUQL7Jy0+G61elj61KmWpI46IGchjwATQo2UTjihELonPANKh2pma4D0
 TSvq6gmFfEswSZ3EbvPgKN+Nlwt9pWg/jkkc/8A2spfj2BWQrVHjqidYuEmy4ZUwuFzRG6
 tAlPoeiYEj2W3O8AikfUEKOvHNRH+XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Rk3A8NzJOVarWjTqpYUWtg-1; Tue, 17 Mar 2020 17:01:18 -0400
X-MC-Unique: Rk3A8NzJOVarWjTqpYUWtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BBC8108BD0D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE1AA93520
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29A191138404; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] QAPI patches for 2020-03-17
Date: Tue, 17 Mar 2020 22:00:45 +0100
Message-Id: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

The following changes since commit 40c67636f67c2a89745f2e698522fe917326a952=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200317-pull-reque=
st' into staging (2020-03-17 14:00:56 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-03-17

for you to fetch changes up to 0d2ff4a9adfdac37495f04441d0dc3100804abae:

  net: Track netdevs in NetClientState rather than QemuOpt (2020-03-17 21:4=
4:02 +0100)

----------------------------------------------------------------
QAPI patches for 2020-03-17

* Fix documentation of deprecated features

* QMP unit test improvements

* QAPI schema language

  - Documentation improvements
  - Support feature flags in more places

* Expose deprecated syntax in query-qmp-schema

* Fix netdev_add

  - Don't ignore arguments dnssearch, hostfwd, and guestfwd
  - Don't exit on "type": "help"
  - Drop undocumented and unwanted argument ipv6
  - Fix type checking

----------------------------------------------------------------
Eric Blake (2):
      net: Complete qapi-fication of netdev_add
      net: Track netdevs in NetClientState rather than QemuOpt

Marc-Andr=C3=A9 Lureau (1):
      qmp: constify QmpCommand and list

Markus Armbruster (27):
      docs/devel/qapi-code-gen: Fix typo in grammar
      qemu-doc: Belatedly document QMP command arg & result deprecation
      qapi: Belatedly update doc comment for @wait deprecation
      docs/devel/qapi-code-gen: Clarify allow-oob introspection
      docs/devel/qapi-code-gen: Document 'features' introspection
      tests/test-qmp-cmds: Factor out qmp_dispatch() test helpers
      tests/test-qmp-cmds: Check responses more thoroughly
      tests/test-qmp-cmds: Simplify test data setup
      tests/test-qmp-event: Simplify test data setup
      tests/test-qmp-event: Use qobject_is_equal()
      tests/test-qmp-event: Check event is actually emitted
      qapi/schema: Clean up around QAPISchemaEntity.connect_doc()
      qapi: Add feature flags to remaining definitions
      qapi: Consistently put @features parameter right after @ifcond
      qapi/introspect: Rename *qlit* to reduce confusion
      qapi/introspect: Factor out _make_tree()
      qapi/schema: Change _make_features() to a take feature list
      qapi/schema: Reorder classes so related ones are together
      qapi/schema: Rename QAPISchemaObjectType{Variant,Variants}
      qapi/schema: Call QAPIDoc.connect_member() in just one place
      qapi: Add feature flags to struct members
      qapi: Inline do_qmp_dispatch() into qmp_dispatch()
      qapi: Simplify how qmp_dispatch() deals with QCO_NO_SUCCESS_RESP
      qapi: Simplify how qmp_dispatch() gets the request ID
      qapi: Replace qmp_dispatch()'s TODO comment by an explanation
      qapi: New special feature flag "deprecated"
      qapi: Mark deprecated QMP parts with feature 'deprecated'

 docs/devel/qapi-code-gen.txt                    |  81 +++-
 docs/system/deprecated.rst                      |  48 ++-
 tests/qapi-schema/doc-good.texi                 |  32 ++
 qapi/block-core.json                            |  48 ++-
 qapi/block.json                                 |  30 +-
 qapi/char.json                                  |   1 +
 qapi/control.json                               |  11 +-
 qapi/introspect.json                            |  26 +-
 qapi/machine.json                               |  34 +-
 qapi/migration.json                             |  36 +-
 qapi/misc.json                                  |  13 +-
 qapi/net.json                                   |  14 +-
 include/net/net.h                               |   2 +-
 include/qapi/qmp/dispatch.h                     |   9 +-
 monitor/monitor-internal.h                      |   2 +-
 monitor/misc.c                                  |   6 +-
 monitor/qmp-cmds-control.c                      |   2 +-
 net/net.c                                       |  39 +-
 qapi/qmp-dispatch.c                             | 134 ++++---
 qapi/qmp-registry.c                             |   6 +-
 qga/commands.c                                  |   2 +-
 qga/main.c                                      |   6 +-
 tests/test-qmp-cmds.c                           | 162 ++++----
 tests/test-qmp-event.c                          | 166 ++------
 scripts/qapi/commands.py                        |   6 +-
 scripts/qapi/doc.py                             |  16 +-
 scripts/qapi/events.py                          |   2 +-
 scripts/qapi/expr.py                            |  14 +-
 scripts/qapi/introspect.py                      | 104 ++---
 scripts/qapi/schema.py                          | 488 +++++++++++++-------=
----
 scripts/qapi/types.py                           |   8 +-
 scripts/qapi/visit.py                           |   8 +-
 tests/Makefile.include                          |   1 +
 tests/qapi-schema/alternate-base.err            |   2 +-
 tests/qapi-schema/doc-good.json                 |  22 +-
 tests/qapi-schema/doc-good.out                  |  18 +
 tests/qapi-schema/features-deprecated-type.err  |   2 +
 tests/qapi-schema/features-deprecated-type.json |   3 +
 tests/qapi-schema/features-deprecated-type.out  |   0
 tests/qapi-schema/qapi-schema-test.json         |  33 +-
 tests/qapi-schema/qapi-schema-test.out          |  30 +-
 tests/qapi-schema/test-qapi.py                  |  26 +-
 42 files changed, 924 insertions(+), 769 deletions(-)
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out
armbru@dusky:~/work/qemu$ git-commit -v --amend
hint: Waiting for your editor to close the file...
Waiting for Emacs...  C-c C-c
[Exit 130 (INT)]
armbru@dusky:~/work/qemu$ git-rebase -i master
hint: Waiting for your editor to close the file...
Waiting for Emacs...
hint: Waiting for your editor to close the file...
Waiting for Emacs...
[detached HEAD db2a380c84] net: Complete qapi-fication of netdev_add
 Author: Eric Blake <eblake@redhat.com>
 Date: Tue Mar 17 15:17:10 2020 -0500
 4 files changed, 4 insertions(+), 19 deletions(-)
Successfully rebased and updated refs/heads/qapi-next.
armbru@dusky:~/work/qemu$ find -name trace-[0-9]\* -delete
armbru@dusky:~/work/qemu$ git-request-pull master public pull-qapi-`date +%=
F`
The following changes since commit 40c67636f67c2a89745f2e698522fe917326a952=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200317-pull-reque=
st' into staging (2020-03-17 14:00:56 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-03-17

for you to fetch changes up to 08712fcb851034228b61f75bd922863a984a4f60:

  net: Track netdevs in NetClientState rather than QemuOpt (2020-03-17 21:5=
0:36 +0100)

----------------------------------------------------------------
QAPI patches for 2020-03-17

----------------------------------------------------------------
Eric Blake (2):
      net: Complete qapi-fication of netdev_add
      net: Track netdevs in NetClientState rather than QemuOpt

Marc-Andr=C3=A9 Lureau (1):
      qmp: constify QmpCommand and list

Markus Armbruster (27):
      docs/devel/qapi-code-gen: Fix typo in grammar
      qemu-doc: Belatedly document QMP command arg & result deprecation
      qapi: Belatedly update doc comment for @wait deprecation
      docs/devel/qapi-code-gen: Clarify allow-oob introspection
      docs/devel/qapi-code-gen: Document 'features' introspection
      tests/test-qmp-cmds: Factor out qmp_dispatch() test helpers
      tests/test-qmp-cmds: Check responses more thoroughly
      tests/test-qmp-cmds: Simplify test data setup
      tests/test-qmp-event: Simplify test data setup
      tests/test-qmp-event: Use qobject_is_equal()
      tests/test-qmp-event: Check event is actually emitted
      qapi/schema: Clean up around QAPISchemaEntity.connect_doc()
      qapi: Add feature flags to remaining definitions
      qapi: Consistently put @features parameter right after @ifcond
      qapi/introspect: Rename *qlit* to reduce confusion
      qapi/introspect: Factor out _make_tree()
      qapi/schema: Change _make_features() to a take feature list
      qapi/schema: Reorder classes so related ones are together
      qapi/schema: Rename QAPISchemaObjectType{Variant,Variants}
      qapi/schema: Call QAPIDoc.connect_member() in just one place
      qapi: Add feature flags to struct members
      qapi: Inline do_qmp_dispatch() into qmp_dispatch()
      qapi: Simplify how qmp_dispatch() deals with QCO_NO_SUCCESS_RESP
      qapi: Simplify how qmp_dispatch() gets the request ID
      qapi: Replace qmp_dispatch()'s TODO comment by an explanation
      qapi: New special feature flag "deprecated"
      qapi: Mark deprecated QMP parts with feature 'deprecated'

 docs/devel/qapi-code-gen.txt                    |  81 +++-
 docs/system/deprecated.rst                      |  48 ++-
 tests/qapi-schema/doc-good.texi                 |  32 ++
 qapi/block-core.json                            |  48 ++-
 qapi/block.json                                 |  30 +-
 qapi/char.json                                  |   1 +
 qapi/control.json                               |  11 +-
 qapi/introspect.json                            |  26 +-
 qapi/machine.json                               |  34 +-
 qapi/migration.json                             |  36 +-
 qapi/misc.json                                  |  13 +-
 qapi/net.json                                   |  14 +-
 include/net/net.h                               |   2 +-
 include/qapi/qmp/dispatch.h                     |   9 +-
 monitor/monitor-internal.h                      |   2 +-
 monitor/misc.c                                  |   6 +-
 monitor/qmp-cmds-control.c                      |   2 +-
 net/net.c                                       |  39 +-
 qapi/qmp-dispatch.c                             | 134 ++++---
 qapi/qmp-registry.c                             |   6 +-
 qga/commands.c                                  |   2 +-
 qga/main.c                                      |   6 +-
 tests/test-qmp-cmds.c                           | 162 ++++----
 tests/test-qmp-event.c                          | 166 ++------
 scripts/qapi/commands.py                        |   6 +-
 scripts/qapi/doc.py                             |  16 +-
 scripts/qapi/events.py                          |   2 +-
 scripts/qapi/expr.py                            |  14 +-
 scripts/qapi/introspect.py                      | 104 ++---
 scripts/qapi/schema.py                          | 488 +++++++++++++-------=
----
 scripts/qapi/types.py                           |   8 +-
 scripts/qapi/visit.py                           |   8 +-
 tests/Makefile.include                          |   1 +
 tests/qapi-schema/alternate-base.err            |   2 +-
 tests/qapi-schema/doc-good.json                 |  22 +-
 tests/qapi-schema/doc-good.out                  |  18 +
 tests/qapi-schema/features-deprecated-type.err  |   2 +
 tests/qapi-schema/features-deprecated-type.json |   3 +
 tests/qapi-schema/features-deprecated-type.out  |   0
 tests/qapi-schema/qapi-schema-test.json         |  33 +-
 tests/qapi-schema/qapi-schema-test.out          |  30 +-
 tests/qapi-schema/test-qapi.py                  |  26 +-
 42 files changed, 924 insertions(+), 769 deletions(-)
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out

--=20
2.21.1


