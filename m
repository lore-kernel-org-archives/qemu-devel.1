Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BCDCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473EC2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbUx/JmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473EC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOfr-0007FM-RO
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeA-0005Tc-Fj
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOe8-00018k-Mu
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOe8-000182-J1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nUG/+ZOkPSt35J8LWxbFu8iSAcgIibxxicQfwa6V3mU=;
 b=MbUx/JmIVVLEvruT3q3ypSgRft1gDRzA8xS9L4KrbRJ+aeUZ9zAd17EeT/EU7/kwAChYT0
 yp8kSw3B/10LhDANc6bEeXB1smiV8xMEPzXRqOQPyyewLLAYAFo+ykuBIHRdzhyI10dckW
 rz4BXM2bsoztRtb3mNZzeSPafz+ixqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-XYrOk4NgN4i_2jb2hospNA-1; Tue, 29 Oct 2019 06:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7156A180496F
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A2575C1D8
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E28811385C9; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] QAPI patches for 2019-10-29
Date: Tue, 29 Oct 2019 11:22:09 +0100
Message-Id: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: XYrOk4NgN4i_2jb2hospNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aaffb853359829a37daaf883c773e8320b55c723=
:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-10-28=
' into staging (2019-10-28 14:40:01 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-10-29

for you to fetch changes up to e151941d1b691402f7914750e025209b7839a1c0:

  qapi: Check feature documentation against the schema (2019-10-29 07:35:16=
 +0100)

----------------------------------------------------------------
QAPI patches for 2019-10-29

----------------------------------------------------------------
Markus Armbruster (19):
      tests/qapi-schema: Demonstrate feature and enum doc comment bugs
      tests/qapi-schema: Demonstrate command and event doc comment bugs
      tests/qapi-schema: Cover alternate documentation comments
      tests/qapi-schema: Fix feature documentation testing
      qemu-doc: Belatedly document QMP command deprecation
      qapi: Implement boxed event argument documentation
      qapi: De-duplicate entity documentation generation code
      qapi: Split .connect_doc(), .check_doc() off .check()
      qapi: Fix enum doc comment checking
      qapi: Clean up doc comment checking for implicit union base
      qapi: Fix doc comment checking for commands and events
      qapi: Simplify ._make_implicit_object_type()
      qapi: Eliminate .check_doc() overrides
      qapi: Fold normalize_if() into check_if()
      qapi: Fold normalize_features() into check_features()
      qapi: Fold normalize_enum() into check_enum()
      qapi: Lift features into QAPISchemaEntity
      qapi: Polish reporting of bogus member documentation
      qapi: Check feature documentation against the schema

 qemu-deprecated.texi                             | 12 ++++
 tests/qapi-schema/doc-good.texi                  | 27 ++++++++
 qapi/net.json                                    |  2 -
 scripts/qapi/doc.py                              | 75 +++++++++++---------=
-
 scripts/qapi/expr.py                             | 32 ++-------
 scripts/qapi/parser.py                           | 29 ++++++--
 scripts/qapi/schema.py                           | 97 ++++++++++++++++----=
-------
 tests/Makefile.include                           |  5 ++
 tests/qapi-schema/doc-bad-alternate-member.err   |  2 +-
 tests/qapi-schema/doc-bad-boxed-command-arg.err  |  1 +
 tests/qapi-schema/doc-bad-boxed-command-arg.json | 14 ++++
 tests/qapi-schema/doc-bad-boxed-command-arg.out  |  0
 tests/qapi-schema/doc-bad-command-arg.err        |  2 +-
 tests/qapi-schema/doc-bad-enum-member.err        |  1 +
 tests/qapi-schema/doc-bad-enum-member.json       |  8 +++
 tests/qapi-schema/doc-bad-enum-member.out        |  0
 tests/qapi-schema/doc-bad-event-arg.err          |  1 +
 tests/qapi-schema/doc-bad-event-arg.json         |  7 ++
 tests/qapi-schema/doc-bad-event-arg.out          |  0
 tests/qapi-schema/doc-bad-feature.err            |  1 +
 tests/qapi-schema/doc-bad-feature.json           |  9 +++
 tests/qapi-schema/doc-bad-feature.out            |  0
 tests/qapi-schema/doc-bad-union-member.err       |  2 +-
 tests/qapi-schema/doc-good.json                  | 14 ++++
 tests/qapi-schema/doc-good.out                   | 27 ++++++++
 tests/qapi-schema/doc-undoc-feature.err          |  2 +
 tests/qapi-schema/doc-undoc-feature.json         |  9 +++
 tests/qapi-schema/doc-undoc-feature.out          |  0
 tests/qapi-schema/test-qapi.py                   |  2 +
 29 files changed, 270 insertions(+), 111 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-boxed-command-arg.err
 create mode 100644 tests/qapi-schema/doc-bad-boxed-command-arg.json
 create mode 100644 tests/qapi-schema/doc-bad-boxed-command-arg.out
 create mode 100644 tests/qapi-schema/doc-bad-enum-member.err
 create mode 100644 tests/qapi-schema/doc-bad-enum-member.json
 create mode 100644 tests/qapi-schema/doc-bad-enum-member.out
 create mode 100644 tests/qapi-schema/doc-bad-event-arg.err
 create mode 100644 tests/qapi-schema/doc-bad-event-arg.json
 create mode 100644 tests/qapi-schema/doc-bad-event-arg.out
 create mode 100644 tests/qapi-schema/doc-bad-feature.err
 create mode 100644 tests/qapi-schema/doc-bad-feature.json
 create mode 100644 tests/qapi-schema/doc-bad-feature.out
 create mode 100644 tests/qapi-schema/doc-undoc-feature.err
 create mode 100644 tests/qapi-schema/doc-undoc-feature.json
 create mode 100644 tests/qapi-schema/doc-undoc-feature.out

--=20
2.21.0


