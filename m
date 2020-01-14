Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2133C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E89124670
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbDi7BxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E89124670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJLh-0003oV-3O
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irJJn-0001nU-LZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irJJj-0006R9-WC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:21:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irJJj-0006Qs-SY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578997259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FSDIlE4oVhfC0gyiPEzrdWhDQjxBFY4XLmYuD0RNutc=;
 b=FbDi7BxRhBr2IME+2kmNkUPEH+Q0Qrc3Z2eNSq4ZOqdWb40dh1pDycUNB6OUA7eWbJmHM2
 n20f7HHFcZhUnLN9J4x5qramjukRA6rxJ7VlEhXL51YOe8MDkSZxW/wuPfL/a84DBW4qT5
 96YW3o2XKKXoAgFrfbHBo5VbpeOevUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-qpBEZaeTMSm4Nu9-Dqr8jw-1; Tue, 14 Jan 2020 05:20:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA448045F3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:20:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0140380F57
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:20:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60F681138600; Tue, 14 Jan 2020 11:20:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] QAPI patches for 2020-01-14
Date: Tue, 14 Jan 2020 11:20:49 +0100
Message-Id: <20200114102055.24058-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qpBEZaeTMSm4Nu9-Dqr8jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

My previous pull request failed tests with Python 2, which is now
gone.  Try again.

The following changes since commit dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d=
:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' =
into staging (2020-01-10 16:15:04 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-01-14

for you to fetch changes up to 3bef3aaec91815b75a78a4c12ca92ac3cec53faf:

  qapi: Simplify QAPISchemaModularCVisitor (2020-01-14 11:01:58 +0100)

----------------------------------------------------------------
QAPI patches for 2020-01-14

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
2.21.1


