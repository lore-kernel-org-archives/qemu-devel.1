Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7EC2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37769206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5s4zx/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37769206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih829-0002mD-0U
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 03:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih80U-0001AK-VT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih80S-0003Fv-3W
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:15:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32855
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih80R-0003CT-Gt
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576570498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Fk7/UTS2b2MEnc1zoNlT58mEzER8Y43MTMa0IFEta0=;
 b=L5s4zx/yH3V5mOn/WV/pzfKJAn93YJTNf03lUpXNf2bu8mBi9qBDabxwFZjmt6kFrULtX3
 wIabiysxx7uo94rQl2Oi8f+n3P0K0C8dtByY9jogp9nuRQ50BWje8BcgdbbTSBhZj7HJKz
 DUi13TLaanFtf/2zyh0NdRlh56y1Mhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-QmeJXfb6N8GHg4jIZEyKgg-1; Tue, 17 Dec 2019 03:14:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9248E102CE27
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:14:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 639EE60C85
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:14:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFD6F11386A7; Tue, 17 Dec 2019 09:14:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] QAPI patches for 2019-12-17
Date: Tue, 17 Dec 2019 09:14:48 +0100
Message-Id: <20191217081454.8072-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QmeJXfb6N8GHg4jIZEyKgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166304=
:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-20=
19' into staging (2019-12-16 14:07:56 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-12-17

for you to fetch changes up to 328add3012e0b642134afedcd53660c30c758866:

  qapi: Simplify QAPISchemaModularCVisitor (2019-12-17 08:09:28 +0100)

----------------------------------------------------------------
QAPI patches for 2019-12-17

----------------------------------------------------------------
Markus Armbruster (6):
      qapi: Tweak "command returns a nice type" check for clarity
      tests/Makefile.include: Fix missing test-qapi-emit-events.[ch]
      qapi: Generate command registration stuff into separate files
      qapi: Proper intermediate representation for modules
      qapi: Fix code generation for empty modules
      qapi: Simplify QAPISchemaModularCVisitor

 docs/devel/qapi-code-gen.txt             | 19 +++++--
 Makefile                                 |  4 +-
 monitor/misc.c                           |  7 ++-
 qga/main.c                               |  2 +-
 tests/test-qmp-cmds.c                    |  1 +
 .gitignore                               |  1 +
 qapi/Makefile.objs                       |  1 +
 qga/Makefile.objs                        |  1 +
 scripts/qapi/commands.py                 | 17 ++++--
 scripts/qapi/events.py                   |  2 +-
 scripts/qapi/gen.py                      | 28 +++++-----
 scripts/qapi/schema.py                   | 92 ++++++++++++++++++++--------=
----
 scripts/qapi/types.py                    |  5 +-
 scripts/qapi/visit.py                    |  8 +--
 tests/.gitignore                         |  1 +
 tests/Makefile.include                   |  9 +++-
 tests/qapi-schema/empty.out              |  1 +
 tests/qapi-schema/include-repetition.out |  6 +--
 tests/qapi-schema/qapi-schema-test.out   | 24 ++++-----
 19 files changed, 144 insertions(+), 85 deletions(-)

--=20
2.21.0


