Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AC6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072B9214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072B9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCk8o-0007Jl-OO
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0j-0001IR-Fu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0g-0006sW-6I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0f-0006rA-T9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C1BB3090FC6
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D19F13D8E
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32644113864E; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] QAPI patches for 2019-09-24
Date: Tue, 24 Sep 2019 14:32:57 +0200
Message-Id: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 24 Sep 2019 12:33:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

The following changes since commit 2f93a3ecdd3bb060bd04f698ccafe66efd9856=
3a:

  Merge remote-tracking branch 'remotes/davidhildenbrand/tags/s390x-tcg-2=
019-09-23' into staging (2019-09-23 15:44:52 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-09-24

for you to fetch changes up to 56176412e7fcfae1c69e4426d94e856b75358231:

  qapi: Assert .visit() and .check_clash() run only after .check() (2019-=
09-24 14:07:23 +0200)

----------------------------------------------------------------
QAPI patches for 2019-09-24

----------------------------------------------------------------
Andrey Shinkevich (1):
      make check-unit: use after free in test-opts-visitor

Markus Armbruster (36):
      qapi: Make visit_next_list()'s comment less confusing
      scripts/git.orderfile: Match QAPI schema more precisely
      qapi: Drop check_type()'s redundant parameter @allow_optional
      qapi: Drop support for boxed alternate arguments
      docs/devel/qapi-code-gen: Minor specification fixes
      tests/qapi-schema: Demonstrate bad reporting of funny characters
      qapi: Restrict strings to printable ASCII
      qapi: Drop support for escape sequences other than \\
      qapi: Permit 'boxed' with empty type
      qapi: Permit alternates with just one branch
      qapi: Permit omitting all flat union branches
      qapi: Adjust frontend errors to say enum value, not member
      docs/devel/qapi-code-gen: Reorder sections for readability
      docs/devel/qapi-code-gen: Rewrite compatibility considerations
      docs/devel/qapi-code-gen: Rewrite introduction to schema
      docs/devel/qapi-code-gen: Improve QAPI schema language doc
      qapi: Tweak code to match docs/devel/qapi-code-gen.txt
      tests/qapi-schema: Cover unknown pragma
      tests/qapi-schema: Delete two redundant tests
      tests/qapi-schema: Demonstrate misleading optional tag error
      tests/qapi-schema: Demonstrate broken discriminator errors
      tests/qapi-schema: Demonstrate insufficient 'if' checking
      tests/qapi-schema: Demonstrate suboptimal lexical errors
      qapi: Use quotes more consistently in frontend error messages
      qapi: Improve reporting of lexical errors
      qapi: Remove null from schema language
      qapi: Fix broken discriminator error messages
      qapi: Reject blank 'if' conditions in addition to empty ones
      qapi: Fix missing 'if' checks in struct, union, alternate 'data'
      qapi: Normalize 'if' in check_exprs(), like other sugar
      qapi: Simplify check_keys()
      qapi: Clean up around check_known_keys()
      qapi: Delete useless check_exprs() code for simple union kind
      qapi: Fix to .check() empty structs just once
      qapi: Fix excessive QAPISchemaEntity.check() recursion
      qapi: Assert .visit() and .check_clash() run only after .check()

 docs/devel/qapi-code-gen.txt                       | 1075 +++++++++++---=
------
 include/qapi/visitor.h                             |    8 +-
 qapi/opts-visitor.c                                |   26 +-
 tests/test-qmp-cmds.c                              |    4 +
 scripts/git.orderfile                              |    4 +-
 scripts/qapi/commands.py                           |    4 +-
 scripts/qapi/common.py                             |  380 ++++---
 scripts/qapi/events.py                             |   12 +-
 tests/Makefile.include                             |   16 +-
 tests/qapi-schema/alternate-branch-if-invalid.err  |    1 +
 ...empty.exit =3D> alternate-branch-if-invalid.exit} |    0
 tests/qapi-schema/alternate-branch-if-invalid.json |    3 +
 ...d-empty.out =3D> alternate-branch-if-invalid.out} |    0
 tests/qapi-schema/alternate-empty.err              |    2 +-
 tests/qapi-schema/alternate-empty.json             |    4 +-
 tests/qapi-schema/args-boxed-empty.err             |    1 -
 tests/qapi-schema/args-boxed-empty.json            |    3 -
 tests/qapi-schema/args-invalid.err                 |    2 +-
 tests/qapi-schema/bad-if-list.err                  |    2 +-
 tests/qapi-schema/bad-if-list.json                 |    2 +-
 tests/qapi-schema/bad-type-int.err                 |    2 +-
 tests/qapi-schema/bad-type-int.json                |    2 +-
 tests/qapi-schema/doc-missing-colon.err            |    2 +-
 tests/qapi-schema/doc-missing.err                  |    2 +-
 tests/qapi-schema/doc-no-symbol.err                |    2 +-
 tests/qapi-schema/double-data.err                  |    1 -
 tests/qapi-schema/double-data.json                 |    2 -
 tests/qapi-schema/duplicate-key.err                |    2 +-
 tests/qapi-schema/duplicate-key.json               |    2 +-
 tests/qapi-schema/enum-bad-name.err                |    2 +-
 tests/qapi-schema/enum-bad-name.json               |    3 +-
 tests/qapi-schema/enum-clash-member.err            |    2 +-
 tests/qapi-schema/enum-dict-member-unknown.err     |    2 +-
 tests/qapi-schema/enum-int-member.err              |    2 +-
 tests/qapi-schema/enum-member-case.err             |    2 +-
 tests/qapi-schema/escape-outside-string.err        |    2 +-
 tests/qapi-schema/escape-outside-string.json       |    3 -
 tests/qapi-schema/escape-too-big.err               |    1 -
 tests/qapi-schema/escape-too-big.json              |    3 -
 tests/qapi-schema/escape-too-short.err             |    1 -
 tests/qapi-schema/escape-too-short.json            |    3 -
 tests/qapi-schema/features-if-invalid.err          |    1 +
 .../{double-data.exit =3D> features-if-invalid.exit} |    0
 tests/qapi-schema/features-if-invalid.json         |    4 +
 .../{double-data.out =3D> features-if-invalid.out}   |    0
 .../flat-union-discriminator-bad-name.err          |    1 +
 ...exit =3D> flat-union-discriminator-bad-name.exit} |    0
 .../flat-union-discriminator-bad-name.json         |   11 +
 ...g.out =3D> flat-union-discriminator-bad-name.out} |    0
 tests/qapi-schema/flat-union-empty.err             |    2 +-
 tests/qapi-schema/flat-union-empty.json            |    2 +-
 .../flat-union-invalid-discriminator.err           |    2 +-
 .../flat-union-invalid-discriminator.json          |    5 +-
 .../flat-union-invalid-if-discriminator.err        |    2 +-
 .../flat-union-invalid-if-discriminator.json       |    5 +-
 .../flat-union-optional-discriminator.err          |    2 +-
 .../flat-union-optional-discriminator.json         |    3 +-
 tests/qapi-schema/funny-char.err                   |    2 +-
 tests/qapi-schema/funny-word.err                   |    1 +
 .../{escape-too-big.exit =3D> funny-word.exit}       |    0
 tests/qapi-schema/funny-word.json                  |    1 +
 .../{escape-too-big.out =3D> funny-word.out}         |    0
 tests/qapi-schema/ident-with-escape.err            |    1 +
 tests/qapi-schema/ident-with-escape.exit           |    2 +-
 tests/qapi-schema/ident-with-escape.json           |    2 +-
 tests/qapi-schema/ident-with-escape.out            |   16 -
 tests/qapi-schema/include-before-err.err           |    2 +-
 tests/qapi-schema/include-format-err.err           |    1 -
 tests/qapi-schema/include-format-err.json          |    2 -
 tests/qapi-schema/include-nested-err.err           |    2 +-
 tests/qapi-schema/leading-comma-list.err           |    2 +-
 tests/qapi-schema/leading-comma-object.err         |    2 +-
 tests/qapi-schema/missing-colon.err                |    2 +-
 tests/qapi-schema/missing-comma-list.err           |    2 +-
 tests/qapi-schema/missing-comma-object.err         |    2 +-
 tests/qapi-schema/non-objects.err                  |    2 +-
 .../pragma-name-case-whitelist-crap.json           |    2 +-
 tests/qapi-schema/pragma-non-dict.err              |    2 +-
 tests/qapi-schema/pragma-unknown.err               |    1 +
 .../{escape-too-short.exit =3D> pragma-unknown.exit} |    0
 tests/qapi-schema/pragma-unknown.json              |    1 +
 .../{escape-too-short.out =3D> pragma-unknown.out}   |    0
 tests/qapi-schema/qapi-schema-test.json            |   13 +-
 tests/qapi-schema/qapi-schema-test.out             |   21 +-
 tests/qapi-schema/quoted-structural-chars.err      |    2 +-
 tests/qapi-schema/string-code-point-127.err        |    1 +
 ...-format-err.exit =3D> string-code-point-127.exit} |    0
 tests/qapi-schema/string-code-point-127.json       |    2 +
 ...de-format-err.out =3D> string-code-point-127.out} |    0
 tests/qapi-schema/string-code-point-31.err         |    1 +
 ...{unicode-str.exit =3D> string-code-point-31.exit} |    0
 tests/qapi-schema/string-code-point-31.json        |    2 +
 .../{unicode-str.out =3D> string-code-point-31.out}  |    0
 tests/qapi-schema/struct-data-invalid.err          |    2 +-
 tests/qapi-schema/struct-member-if-invalid.err     |    1 +
 tests/qapi-schema/struct-member-if-invalid.exit    |    1 +
 tests/qapi-schema/struct-member-if-invalid.json    |    3 +
 tests/qapi-schema/struct-member-if-invalid.out     |    0
 tests/qapi-schema/trailing-comma-list.err          |    2 +-
 tests/qapi-schema/unclosed-list.err                |    2 +-
 tests/qapi-schema/unclosed-object.err              |    2 +-
 tests/qapi-schema/unicode-str.err                  |    1 -
 tests/qapi-schema/unicode-str.json                 |    2 -
 tests/qapi-schema/union-base-empty.err             |    2 +-
 tests/qapi-schema/union-branch-if-invalid.err      |    1 +
 tests/qapi-schema/union-branch-if-invalid.exit     |    1 +
 tests/qapi-schema/union-branch-if-invalid.json     |    6 +
 tests/qapi-schema/union-branch-if-invalid.out      |    0
 tests/qapi-schema/union-empty.err                  |    2 +-
 tests/qapi-schema/union-empty.json                 |    2 +-
 tests/qapi-schema/unknown-escape.json              |    2 +-
 111 files changed, 971 insertions(+), 785 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-branch-if-invalid.err
 rename tests/qapi-schema/{args-boxed-empty.exit =3D> alternate-branch-if=
-invalid.exit} (100%)
 create mode 100644 tests/qapi-schema/alternate-branch-if-invalid.json
 rename tests/qapi-schema/{args-boxed-empty.out =3D> alternate-branch-if-=
invalid.out} (100%)
 delete mode 100644 tests/qapi-schema/args-boxed-empty.err
 delete mode 100644 tests/qapi-schema/args-boxed-empty.json
 delete mode 100644 tests/qapi-schema/double-data.err
 delete mode 100644 tests/qapi-schema/double-data.json
 delete mode 100644 tests/qapi-schema/escape-outside-string.json
 delete mode 100644 tests/qapi-schema/escape-too-big.err
 delete mode 100644 tests/qapi-schema/escape-too-big.json
 delete mode 100644 tests/qapi-schema/escape-too-short.err
 delete mode 100644 tests/qapi-schema/escape-too-short.json
 create mode 100644 tests/qapi-schema/features-if-invalid.err
 rename tests/qapi-schema/{double-data.exit =3D> features-if-invalid.exit=
} (100%)
 create mode 100644 tests/qapi-schema/features-if-invalid.json
 rename tests/qapi-schema/{double-data.out =3D> features-if-invalid.out} =
(100%)
 create mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.e=
rr
 rename tests/qapi-schema/{escape-outside-string.exit =3D> flat-union-dis=
criminator-bad-name.exit} (100%)
 create mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.j=
son
 rename tests/qapi-schema/{escape-outside-string.out =3D> flat-union-disc=
riminator-bad-name.out} (100%)
 create mode 100644 tests/qapi-schema/funny-word.err
 rename tests/qapi-schema/{escape-too-big.exit =3D> funny-word.exit} (100=
%)
 create mode 100644 tests/qapi-schema/funny-word.json
 rename tests/qapi-schema/{escape-too-big.out =3D> funny-word.out} (100%)
 delete mode 100644 tests/qapi-schema/include-format-err.err
 delete mode 100644 tests/qapi-schema/include-format-err.json
 create mode 100644 tests/qapi-schema/pragma-unknown.err
 rename tests/qapi-schema/{escape-too-short.exit =3D> pragma-unknown.exit=
} (100%)
 create mode 100644 tests/qapi-schema/pragma-unknown.json
 rename tests/qapi-schema/{escape-too-short.out =3D> pragma-unknown.out} =
(100%)
 create mode 100644 tests/qapi-schema/string-code-point-127.err
 rename tests/qapi-schema/{include-format-err.exit =3D> string-code-point=
-127.exit} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-127.json
 rename tests/qapi-schema/{include-format-err.out =3D> string-code-point-=
127.out} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-31.err
 rename tests/qapi-schema/{unicode-str.exit =3D> string-code-point-31.exi=
t} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-31.json
 rename tests/qapi-schema/{unicode-str.out =3D> string-code-point-31.out}=
 (100%)
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.err
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.exit
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.json
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.out
 delete mode 100644 tests/qapi-schema/unicode-str.err
 delete mode 100644 tests/qapi-schema/unicode-str.json
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.err
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.exit
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.json
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.out

--=20
2.21.0


