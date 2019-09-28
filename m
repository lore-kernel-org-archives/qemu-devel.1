Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34537C32793
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C4B20863
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C4B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHic-0005dz-73
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 14:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHd6-0008Pf-5s
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd3-0003pR-LG
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd3-0003mb-By
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5325C3083394
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCF0E5D6B0
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2859B113864E; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] QAPI patches for 2019-09-28
Date: Sat, 28 Sep 2019 20:39:07 +0200
Message-Id: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Sat, 28 Sep 2019 18:39:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

The following changes since commit c6f5012ba5fa834cbd5274b1b8369e2c5d2f59=
33:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-26=
0919-1' into staging (2019-09-27 15:43:41 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-09-28

for you to fetch changes up to c615550df306a7b16e75d21f65ee38898c756bac:

  qapi: Improve source file read error handling (2019-09-28 17:17:48 +020=
0)

----------------------------------------------------------------
QAPI patches for 2019-09-28

----------------------------------------------------------------
Markus Armbruster (26):
      qapi: Tighten QAPISchemaFOO.check() assertions
      qapi: Rename .owner to .defined_in
      qapi: New QAPISourceInfo, replacing dict
      qapi: Prefix frontend errors with an "in definition" line
      qapi: Clean up member name case checking
      qapi: Change frontend error messages to start with lower case
      qapi: Improve reporting of member name clashes
      qapi: Reorder check_FOO() parameters for consistency
      qapi: Improve reporting of invalid name errors
      qapi: Use check_name_str() where it suffices
      qapi: Report invalid '*' prefix like any other invalid name
      qapi: Move check for reserved names out of add_name()
      qapi: Make check_type()'s array case a bit more obvious
      qapi: Plumb info to the QAPISchemaMember
      qapi: Inline check_name() into check_union()
      qapi: Move context-sensitive checking to the proper place
      qapi: Move context-free checking to the proper place
      qapi: Improve reporting of invalid 'if' errors
      qapi: Improve reporting of invalid flags
      qapi: Improve reporting of missing / unknown definition keys
      qapi: Avoid redundant definition references in error messages
      qapi: Improve reporting of invalid 'if' further
      qapi: Eliminate check_keys(), rename check_known_keys()
      qapi: Improve reporting of missing documentation comment
      qapi: Improve reporting of redefinition
      qapi: Improve source file read error handling

Michal Privoznik (1):
      qmp-dispatch: Use CommandNotFound error for disabled commands

 qapi/qapi-schema.json                              |    2 +-
 qapi/qmp-dispatch.c                                |    5 +-
 tests/test-qga.c                                   |    4 +-
 scripts/qapi/common.py                             | 1052 ++++++++++----=
------
 scripts/qapi/events.py                             |    2 +-
 tests/qapi-schema/allow-preconfig-test.err         |    3 +-
 tests/qapi-schema/alternate-any.err                |    3 +-
 tests/qapi-schema/alternate-array.err              |    3 +-
 tests/qapi-schema/alternate-base.err               |    3 +-
 tests/qapi-schema/alternate-branch-if-invalid.err  |    3 +-
 tests/qapi-schema/alternate-clash.err              |    3 +-
 .../qapi-schema/alternate-conflict-bool-string.err |    3 +-
 tests/qapi-schema/alternate-conflict-dict.err      |    3 +-
 tests/qapi-schema/alternate-conflict-enum-bool.err |    3 +-
 tests/qapi-schema/alternate-conflict-enum-int.err  |    3 +-
 .../qapi-schema/alternate-conflict-num-string.err  |    3 +-
 tests/qapi-schema/alternate-conflict-string.err    |    3 +-
 tests/qapi-schema/alternate-empty.err              |    3 +-
 tests/qapi-schema/alternate-invalid-dict.err       |    3 +-
 tests/qapi-schema/alternate-nested.err             |    3 +-
 tests/qapi-schema/alternate-unknown.err            |    3 +-
 tests/qapi-schema/args-alternate.err               |    3 +-
 tests/qapi-schema/args-any.err                     |    3 +-
 tests/qapi-schema/args-array-empty.err             |    3 +-
 tests/qapi-schema/args-array-unknown.err           |    3 +-
 tests/qapi-schema/args-bad-boxed.err               |    3 +-
 tests/qapi-schema/args-boxed-anon.err              |    3 +-
 tests/qapi-schema/args-boxed-string.err            |    3 +-
 tests/qapi-schema/args-int.err                     |    3 +-
 tests/qapi-schema/args-invalid.err                 |    3 +-
 tests/qapi-schema/args-member-array-bad.err        |    3 +-
 tests/qapi-schema/args-member-case.err             |    3 +-
 tests/qapi-schema/args-member-case.json            |    2 +-
 tests/qapi-schema/args-member-unknown.err          |    3 +-
 tests/qapi-schema/args-name-clash.err              |    3 +-
 tests/qapi-schema/args-union.err                   |    3 +-
 tests/qapi-schema/args-unknown.err                 |    3 +-
 tests/qapi-schema/bad-base.err                     |    3 +-
 tests/qapi-schema/bad-data.err                     |    3 +-
 tests/qapi-schema/bad-ident.err                    |    3 +-
 tests/qapi-schema/bad-if-empty-list.err            |    3 +-
 tests/qapi-schema/bad-if-empty.err                 |    3 +-
 tests/qapi-schema/bad-if-list.err                  |    3 +-
 tests/qapi-schema/bad-if.err                       |    3 +-
 tests/qapi-schema/bad-type-bool.err                |    2 +-
 tests/qapi-schema/bad-type-dict.err                |    2 +-
 tests/qapi-schema/bad-type-int.err                 |    2 +-
 tests/qapi-schema/base-cycle-direct.err            |    3 +-
 tests/qapi-schema/base-cycle-indirect.err          |    3 +-
 tests/qapi-schema/command-int.err                  |    3 +-
 tests/qapi-schema/doc-bad-alternate-member.err     |    2 +-
 tests/qapi-schema/doc-bad-command-arg.err          |    2 +-
 tests/qapi-schema/doc-bad-symbol.err               |    3 +-
 tests/qapi-schema/doc-bad-union-member.err         |    2 +-
 tests/qapi-schema/doc-before-include.err           |    2 +-
 tests/qapi-schema/doc-before-pragma.err            |    2 +-
 tests/qapi-schema/doc-duplicated-return.err        |    2 +-
 tests/qapi-schema/doc-duplicated-since.err         |    2 +-
 tests/qapi-schema/doc-empty-arg.err                |    2 +-
 tests/qapi-schema/doc-empty-section.err            |    2 +-
 tests/qapi-schema/doc-empty-symbol.err             |    2 +-
 tests/qapi-schema/doc-invalid-end.err              |    2 +-
 tests/qapi-schema/doc-invalid-end2.err             |    2 +-
 tests/qapi-schema/doc-invalid-start.err            |    2 +-
 tests/qapi-schema/doc-missing-colon.err            |    2 +-
 tests/qapi-schema/doc-missing-expr.err             |    2 +-
 tests/qapi-schema/doc-missing-space.err            |    2 +-
 tests/qapi-schema/doc-missing.err                  |    3 +-
 tests/qapi-schema/doc-no-symbol.err                |    2 +-
 tests/qapi-schema/double-type.err                  |    3 +-
 tests/qapi-schema/duplicate-key.err                |    2 +-
 tests/qapi-schema/enum-bad-member.err              |    3 +-
 tests/qapi-schema/enum-bad-name.err                |    3 +-
 tests/qapi-schema/enum-bad-prefix.err              |    3 +-
 tests/qapi-schema/enum-clash-member.err            |    3 +-
 tests/qapi-schema/enum-dict-member-unknown.err     |    3 +-
 tests/qapi-schema/enum-if-invalid.err              |    3 +-
 tests/qapi-schema/enum-int-member.err              |    2 +-
 tests/qapi-schema/enum-member-case.err             |    3 +-
 tests/qapi-schema/enum-missing-data.err            |    3 +-
 tests/qapi-schema/enum-wrong-data.err              |    3 +-
 tests/qapi-schema/escape-outside-string.err        |    2 +-
 tests/qapi-schema/event-boxed-empty.err            |    3 +-
 tests/qapi-schema/event-member-invalid-dict.err    |    3 +-
 tests/qapi-schema/event-nest-struct.err            |    3 +-
 tests/qapi-schema/features-bad-type.err            |    3 +-
 tests/qapi-schema/features-duplicate-name.err      |    3 +-
 tests/qapi-schema/features-if-invalid.err          |    3 +-
 tests/qapi-schema/features-missing-name.err        |    3 +-
 tests/qapi-schema/features-name-bad-type.err       |    3 +-
 tests/qapi-schema/features-no-list.err             |    3 +-
 tests/qapi-schema/features-unknown-key.err         |    3 +-
 tests/qapi-schema/flat-union-array-branch.err      |    3 +-
 tests/qapi-schema/flat-union-bad-base.err          |    3 +-
 tests/qapi-schema/flat-union-bad-discriminator.err |    3 +-
 tests/qapi-schema/flat-union-base-any.err          |    3 +-
 tests/qapi-schema/flat-union-base-union.err        |    3 +-
 tests/qapi-schema/flat-union-clash-member.err      |    3 +-
 .../flat-union-discriminator-bad-name.err          |    3 +-
 .../flat-union-discriminator-bad-name.json         |    1 -
 tests/qapi-schema/flat-union-empty.err             |    3 +-
 .../qapi-schema/flat-union-inline-invalid-dict.err |    3 +-
 tests/qapi-schema/flat-union-inline.err            |    3 +-
 tests/qapi-schema/flat-union-int-branch.err        |    3 +-
 .../qapi-schema/flat-union-invalid-branch-key.err  |    3 +-
 .../flat-union-invalid-discriminator.err           |    3 +-
 .../flat-union-invalid-if-discriminator.err        |    3 +-
 tests/qapi-schema/flat-union-no-base.err           |    3 +-
 .../flat-union-optional-discriminator.err          |    3 +-
 .../flat-union-optional-discriminator.json         |    1 -
 .../flat-union-string-discriminator.err            |    3 +-
 tests/qapi-schema/funny-char.err                   |    2 +-
 tests/qapi-schema/funny-word.err                   |    2 +-
 tests/qapi-schema/ident-with-escape.err            |    2 +-
 tests/qapi-schema/include-before-err.err           |    2 +-
 tests/qapi-schema/include-cycle.err                |    2 +-
 tests/qapi-schema/include-extra-junk.err           |    2 +-
 tests/qapi-schema/include-nested-err.err           |    2 +-
 tests/qapi-schema/include-no-file.err              |    2 +-
 tests/qapi-schema/include-non-file.err             |    2 +-
 tests/qapi-schema/include-self-cycle.err           |    2 +-
 tests/qapi-schema/leading-comma-list.err           |    2 +-
 tests/qapi-schema/leading-comma-object.err         |    2 +-
 tests/qapi-schema/missing-colon.err                |    2 +-
 tests/qapi-schema/missing-comma-list.err           |    2 +-
 tests/qapi-schema/missing-comma-object.err         |    2 +-
 tests/qapi-schema/missing-type.err                 |    2 +-
 .../nested-struct-data-invalid-dict.err            |    3 +-
 tests/qapi-schema/nested-struct-data.err           |    3 +-
 tests/qapi-schema/non-objects.err                  |    2 +-
 tests/qapi-schema/oob-test.err                     |    3 +-
 tests/qapi-schema/pragma-doc-required-crap.err     |    2 +-
 tests/qapi-schema/pragma-extra-junk.err            |    2 +-
 .../pragma-name-case-whitelist-crap.err            |    2 +-
 tests/qapi-schema/pragma-non-dict.err              |    2 +-
 .../qapi-schema/pragma-returns-whitelist-crap.err  |    2 +-
 tests/qapi-schema/pragma-unknown.err               |    2 +-
 tests/qapi-schema/quoted-structural-chars.err      |    2 +-
 tests/qapi-schema/redefined-builtin.err            |    3 +-
 tests/qapi-schema/redefined-command.err            |    5 +-
 tests/qapi-schema/redefined-event.err              |    5 +-
 tests/qapi-schema/redefined-type.err               |    5 +-
 tests/qapi-schema/reserved-command-q.err           |    3 +-
 tests/qapi-schema/reserved-enum-q.err              |    3 +-
 tests/qapi-schema/reserved-member-has.err          |    3 +-
 tests/qapi-schema/reserved-member-q.err            |    3 +-
 tests/qapi-schema/reserved-member-u.err            |    3 +-
 tests/qapi-schema/reserved-member-underscore.err   |    3 +-
 tests/qapi-schema/reserved-type-kind.err           |    3 +-
 tests/qapi-schema/reserved-type-list.err           |    3 +-
 tests/qapi-schema/returns-alternate.err            |    3 +-
 tests/qapi-schema/returns-array-bad.err            |    3 +-
 tests/qapi-schema/returns-dict.err                 |    3 +-
 tests/qapi-schema/returns-unknown.err              |    3 +-
 tests/qapi-schema/returns-whitelist.err            |    3 +-
 tests/qapi-schema/string-code-point-127.err        |    2 +-
 tests/qapi-schema/string-code-point-31.err         |    2 +-
 tests/qapi-schema/struct-base-clash-deep.err       |    3 +-
 tests/qapi-schema/struct-base-clash.err            |    3 +-
 tests/qapi-schema/struct-data-invalid.err          |    3 +-
 tests/qapi-schema/struct-member-if-invalid.err     |    3 +-
 tests/qapi-schema/struct-member-invalid-dict.err   |    3 +-
 tests/qapi-schema/struct-member-invalid.err        |    3 +-
 tests/qapi-schema/trailing-comma-list.err          |    2 +-
 tests/qapi-schema/trailing-comma-object.err        |    2 +-
 tests/qapi-schema/type-bypass-bad-gen.err          |    3 +-
 tests/qapi-schema/unclosed-list.err                |    2 +-
 tests/qapi-schema/unclosed-object.err              |    2 +-
 tests/qapi-schema/unclosed-string.err              |    2 +-
 tests/qapi-schema/union-base-empty.err             |    3 +-
 tests/qapi-schema/union-base-no-discriminator.err  |    3 +-
 tests/qapi-schema/union-branch-case.err            |    3 +-
 tests/qapi-schema/union-branch-case.json           |    4 +-
 tests/qapi-schema/union-branch-if-invalid.err      |    3 +-
 tests/qapi-schema/union-branch-invalid-dict.err    |    3 +-
 tests/qapi-schema/union-clash-branches.err         |    3 +-
 tests/qapi-schema/union-empty.err                  |    3 +-
 tests/qapi-schema/union-invalid-base.err           |    3 +-
 tests/qapi-schema/union-optional-branch.err        |    3 +-
 tests/qapi-schema/union-unknown.err                |    3 +-
 tests/qapi-schema/union-unknown.json               |    2 +-
 tests/qapi-schema/unknown-escape.err               |    2 +-
 tests/qapi-schema/unknown-expr-key.err             |    3 +-
 183 files changed, 847 insertions(+), 698 deletions(-)

--=20
2.21.0


