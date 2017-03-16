Received: from eggs.gnu.org ([2001:4830:134:3::10]:54652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065Y-DL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtN-0006zj-CS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtN-0006xY-1V
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1348A3DBE7
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BDBF4FA20
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:16 +0100
Message-Id: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 00/49] QAPI patches for 2017-03-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Significant improvements to QMP documentation, fixing its regression.

Note: only QAPI *generator* code changes, except for trailing space
removal in generated qmp-marshal.c and doc comments in QAPI schemas.

The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f6=
42:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-03-15 18:44:05 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-03-16

for you to fetch changes up to 012b126de2ded4e93b5ed069be5544ad8a2e6c15:

  qapi: Fix a misleading parser error message (2017-03-16 07:13:04 +0100)

----------------------------------------------------------------
QAPI patches for 2017-03-16

----------------------------------------------------------------
Daniel P. Berrange (1):
      qmp: allow setting properties to empty string in qmp-shell

Marc-Andr=C3=A9 Lureau (1):
      qapi2texi: change texi formatters

Markus Armbruster (47):
      qapi: Factor QAPISchemaParser._include() out of .__init__()
      qapi: Make doc comments optional where we don't need them
      qapi: Back out doc comments added just to please qapi.py
      docs/qapi-code-gen.txt: Drop confusing reference to 'gen'
      qapi: Have each QAPI schema declare its returns white-list
      qapi: Have each QAPI schema declare its name rule violations
      qapi: Clean up build of generated documentation
      tests/qapi-schema: Cover empty union base
      qapi: Fix to reject empty union base gracefully
      qapi2texi: Fix up output around #optional
      qapi: Avoid unwanted blank lines in QAPIDoc
      qapi/rocker: Fix up doc comment notes on optional members
      qapi: Fix QAPISchemaEnumType.is_implicit() for 'QType'
      qapi: Prepare for requiring more complete documentation
      qapi: Conjure up QAPIDoc.ArgSection for undocumented members
      qapi2texi: Convert to QAPISchemaVisitor
      qapi: The #optional tag is redundant, drop
      qapi: Use raw strings for regular expressions consistently
      qapi: Prefer single-quoted strings more consistently
      qapi2texi: Plainer enum value and member name formatting
      qapi2texi: Present the table of members more clearly
      qapi2texi: Explain enum value undocumentedness more clearly
      qapi2texi: Don't hide undocumented members and arguments
      qapi2texi: Implement boxed argument documentation
      qapi2texi: Include member type in generated documentation
      qapi2texi: Generate reference to base type members
      qapi2texi: Generate documentation for variant members
      qapi2texi: Generate descriptions for simple union tags
      qapi2texi: Use category "Object" for all object types
      tests/qapi-schema: Improve doc / expression mismatch coverage
      qapi: Fix detection of doc / expression mismatch
      qapi: Move detection of doc / expression name mismatch
      qapi: Improve error message on @NAME: in free-form doc
      qapi: Move empty doc section checking to doc parser
      tests/qapi-schema: Rename doc-bad-args to doc-bad-command-arg
      tests/qapi-schema: Improve coverage of bogus member docs
      qapi: Fix detection of bogus member documentation
      qapi: Eliminate check_docs() and drop QAPIDoc.expr
      qapi: Drop unused variable events
      qapi: Simplify what gets stored in enum_types
      qapi: Factor add_name() calls out of the meta conditional
      qapi: enum_types is a list used like a dict, make it one
      qapi: struct_types is a list used like a dict, make it one
      qapi: union_types is a list used like a dict, make it one
      qapi: Drop unused .check_clash() parameter schema
      qapi: Make pylint a bit happier
      qapi: Fix a misleading parser error message

 .gitignore                                         |  10 +-
 Makefile                                           |  27 +-
 docs/qapi-code-gen.txt                             |  80 ++-
 docs/qemu-qmp-ref.texi                             |   2 +-
 docs/writing-qmp-commands.txt                      |   4 +-
 qapi-schema.json                                   | 403 +++++++------
 qapi/block-core.json                               | 422 +++++++-------
 qapi/block.json                                    |   8 +-
 qapi/crypto.json                                   |  22 +-
 qapi/event.json                                    |  10 +-
 qapi/introspect.json                               |   6 +-
 qapi/rocker.json                                   |  88 +--
 qapi/trace.json                                    |   6 +-
 qga/qapi-schema.json                               |  55 +-
 rules.mak                                          |   2 +-
 scripts/qapi-commands.py                           |   6 +-
 scripts/qapi-event.py                              |   2 +-
 scripts/qapi-introspect.py                         |   4 +-
 scripts/qapi-types.py                              |   4 +-
 scripts/qapi-visit.py                              |   5 +-
 scripts/qapi.py                                    | 637 ++++++++++-----=
------
 scripts/qapi2texi.py                               | 310 +++++-----
 scripts/qmp/qmp-shell                              |   4 +-
 tests/Makefile.include                             |  16 +-
 tests/qapi-schema/alternate-any.err                |   2 +-
 tests/qapi-schema/alternate-any.json               |   4 -
 tests/qapi-schema/alternate-array.err              |   2 +-
 tests/qapi-schema/alternate-array.json             |   7 -
 tests/qapi-schema/alternate-base.err               |   2 +-
 tests/qapi-schema/alternate-base.json              |   7 -
 tests/qapi-schema/alternate-clash.err              |   2 +-
 tests/qapi-schema/alternate-clash.json             |   4 -
 tests/qapi-schema/alternate-conflict-dict.err      |   2 +-
 tests/qapi-schema/alternate-conflict-dict.json     |  10 -
 tests/qapi-schema/alternate-conflict-string.err    |   2 +-
 tests/qapi-schema/alternate-conflict-string.json   |   7 -
 tests/qapi-schema/alternate-empty.err              |   2 +-
 tests/qapi-schema/alternate-empty.json             |   4 -
 tests/qapi-schema/alternate-nested.err             |   2 +-
 tests/qapi-schema/alternate-nested.json            |   7 -
 tests/qapi-schema/alternate-unknown.err            |   2 +-
 tests/qapi-schema/alternate-unknown.json           |   4 -
 tests/qapi-schema/args-alternate.err               |   2 +-
 tests/qapi-schema/args-alternate.json              |   8 -
 tests/qapi-schema/args-any.err                     |   2 +-
 tests/qapi-schema/args-any.json                    |   4 -
 tests/qapi-schema/args-array-empty.err             |   2 +-
 tests/qapi-schema/args-array-empty.json            |   4 -
 tests/qapi-schema/args-array-unknown.err           |   2 +-
 tests/qapi-schema/args-array-unknown.json          |   4 -
 tests/qapi-schema/args-bad-boxed.err               |   2 +-
 tests/qapi-schema/args-bad-boxed.json              |   4 -
 tests/qapi-schema/args-boxed-anon.err              |   2 +-
 tests/qapi-schema/args-boxed-anon.json             |   4 -
 tests/qapi-schema/args-boxed-empty.err             |   2 +-
 tests/qapi-schema/args-boxed-empty.json            |   8 -
 tests/qapi-schema/args-boxed-string.err            |   2 +-
 tests/qapi-schema/args-boxed-string.json           |   4 -
 tests/qapi-schema/args-int.err                     |   2 +-
 tests/qapi-schema/args-int.json                    |   4 -
 tests/qapi-schema/args-invalid.err                 |   2 +-
 tests/qapi-schema/args-invalid.json                |   3 -
 tests/qapi-schema/args-member-array-bad.err        |   2 +-
 tests/qapi-schema/args-member-array-bad.json       |   4 -
 tests/qapi-schema/args-member-case.err             |   2 +-
 tests/qapi-schema/args-member-case.json            |   4 -
 tests/qapi-schema/args-member-unknown.err          |   2 +-
 tests/qapi-schema/args-member-unknown.json         |   4 -
 tests/qapi-schema/args-name-clash.err              |   2 +-
 tests/qapi-schema/args-name-clash.json             |   4 -
 tests/qapi-schema/args-union.err                   |   2 +-
 tests/qapi-schema/args-union.json                  |   7 -
 tests/qapi-schema/args-unknown.err                 |   2 +-
 tests/qapi-schema/args-unknown.json                |   4 -
 tests/qapi-schema/bad-base.err                     |   2 +-
 tests/qapi-schema/bad-base.json                    |   7 -
 tests/qapi-schema/bad-data.err                     |   2 +-
 tests/qapi-schema/bad-data.json                    |   4 -
 tests/qapi-schema/bad-ident.err                    |   2 +-
 tests/qapi-schema/bad-ident.json                   |   4 -
 tests/qapi-schema/bad-type-bool.err                |   2 +-
 tests/qapi-schema/bad-type-bool.json               |   4 -
 tests/qapi-schema/bad-type-dict.err                |   2 +-
 tests/qapi-schema/bad-type-dict.json               |   4 -
 tests/qapi-schema/base-cycle-direct.err            |   2 +-
 tests/qapi-schema/base-cycle-direct.json           |   4 -
 tests/qapi-schema/base-cycle-indirect.err          |   2 +-
 tests/qapi-schema/base-cycle-indirect.json         |   7 -
 tests/qapi-schema/command-int.err                  |   2 +-
 tests/qapi-schema/command-int.json                 |   4 -
 tests/qapi-schema/comments.json                    |   4 -
 tests/qapi-schema/comments.out                     |   1 -
 tests/qapi-schema/doc-bad-alternate-member.err     |   1 +
 ...optional.exit =3D> doc-bad-alternate-member.exit} |   0
 tests/qapi-schema/doc-bad-alternate-member.json    |   9 +
 ...c-optional.out =3D> doc-bad-alternate-member.out} |   0
 tests/qapi-schema/doc-bad-args.err                 |   1 -
 tests/qapi-schema/doc-bad-command-arg.err          |   1 +
 ...{doc-bad-args.exit =3D> doc-bad-command-arg.exit} |   0
 ...{doc-bad-args.json =3D> doc-bad-command-arg.json} |   0
 .../{doc-bad-args.out =3D> doc-bad-command-arg.out}  |   0
 tests/qapi-schema/doc-bad-symbol.err               |   2 +-
 tests/qapi-schema/doc-bad-union-member.err         |   1 +
 tests/qapi-schema/doc-bad-union-member.exit        |   1 +
 tests/qapi-schema/doc-bad-union-member.json        |  19 +
 tests/qapi-schema/doc-bad-union-member.out         |   0
 tests/qapi-schema/doc-before-include.err           |   1 +
 tests/qapi-schema/doc-before-include.exit          |   1 +
 tests/qapi-schema/doc-before-include.json          |   7 +
 tests/qapi-schema/doc-before-include.out           |   0
 tests/qapi-schema/doc-before-pragma.err            |   1 +
 tests/qapi-schema/doc-before-pragma.exit           |   1 +
 tests/qapi-schema/doc-before-pragma.json           |   7 +
 tests/qapi-schema/doc-before-pragma.out            |   0
 tests/qapi-schema/doc-empty-section.err            |   2 +-
 tests/qapi-schema/doc-invalid-section.err          |   2 +-
 tests/qapi-schema/doc-missing-expr.err             |   2 +-
 tests/qapi-schema/doc-missing.err                  |   1 +
 tests/qapi-schema/doc-missing.exit                 |   1 +
 tests/qapi-schema/doc-missing.json                 |   5 +
 tests/qapi-schema/doc-missing.out                  |   0
 tests/qapi-schema/doc-no-symbol.err                |   1 +
 tests/qapi-schema/doc-no-symbol.exit               |   1 +
 tests/qapi-schema/doc-no-symbol.json               |   6 +
 tests/qapi-schema/doc-no-symbol.out                |   0
 tests/qapi-schema/doc-optional.err                 |   1 -
 tests/qapi-schema/doc-optional.json                |   7 -
 tests/qapi-schema/double-type.err                  |   2 +-
 tests/qapi-schema/double-type.json                 |   4 -
 tests/qapi-schema/enum-bad-name.err                |   2 +-
 tests/qapi-schema/enum-bad-name.json               |   4 -
 tests/qapi-schema/enum-bad-prefix.err              |   2 +-
 tests/qapi-schema/enum-bad-prefix.json             |   4 -
 tests/qapi-schema/enum-clash-member.err            |   2 +-
 tests/qapi-schema/enum-clash-member.json           |   4 -
 tests/qapi-schema/enum-dict-member.err             |   2 +-
 tests/qapi-schema/enum-dict-member.json            |   4 -
 tests/qapi-schema/enum-member-case.err             |   2 +-
 tests/qapi-schema/enum-member-case.json            |   8 +-
 tests/qapi-schema/enum-missing-data.err            |   2 +-
 tests/qapi-schema/enum-missing-data.json           |   4 -
 tests/qapi-schema/enum-wrong-data.err              |   2 +-
 tests/qapi-schema/enum-wrong-data.json             |   4 -
 tests/qapi-schema/event-boxed-empty.err            |   2 +-
 tests/qapi-schema/event-boxed-empty.json           |   4 -
 tests/qapi-schema/event-case.json                  |   4 -
 tests/qapi-schema/event-case.out                   |   1 -
 tests/qapi-schema/event-nest-struct.err            |   2 +-
 tests/qapi-schema/event-nest-struct.json           |   4 -
 tests/qapi-schema/flat-union-array-branch.err      |   2 +-
 tests/qapi-schema/flat-union-array-branch.json     |  12 -
 tests/qapi-schema/flat-union-bad-base.err          |   2 +-
 tests/qapi-schema/flat-union-bad-base.json         |  13 -
 tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
 .../qapi-schema/flat-union-bad-discriminator.json  |  16 -
 tests/qapi-schema/flat-union-base-any.err          |   2 +-
 tests/qapi-schema/flat-union-base-any.json         |  13 -
 tests/qapi-schema/flat-union-base-union.err        |   2 +-
 tests/qapi-schema/flat-union-base-union.json       |  16 -
 tests/qapi-schema/flat-union-clash-member.err      |   2 +-
 tests/qapi-schema/flat-union-clash-member.json     |  16 -
 tests/qapi-schema/flat-union-empty.err             |   2 +-
 tests/qapi-schema/flat-union-empty.json            |  10 -
 tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
 .../qapi-schema/flat-union-incomplete-branch.json  |  10 -
 tests/qapi-schema/flat-union-inline.err            |   2 +-
 tests/qapi-schema/flat-union-inline.json           |  10 -
 tests/qapi-schema/flat-union-int-branch.err        |   2 +-
 tests/qapi-schema/flat-union-int-branch.json       |  13 -
 .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
 .../qapi-schema/flat-union-invalid-branch-key.json |  15 -
 .../flat-union-invalid-discriminator.err           |   2 +-
 .../flat-union-invalid-discriminator.json          |  15 -
 tests/qapi-schema/flat-union-no-base.err           |   2 +-
 tests/qapi-schema/flat-union-no-base.json          |  13 -
 .../flat-union-optional-discriminator.err          |   2 +-
 .../flat-union-optional-discriminator.json         |  13 -
 .../flat-union-string-discriminator.err            |   2 +-
 .../flat-union-string-discriminator.json           |  15 -
 tests/qapi-schema/ident-with-escape.json           |   4 -
 tests/qapi-schema/ident-with-escape.out            |   1 -
 tests/qapi-schema/include-extra-junk.err           |   1 +
 tests/qapi-schema/include-extra-junk.exit          |   1 +
 tests/qapi-schema/include-extra-junk.json          |   3 +
 tests/qapi-schema/include-extra-junk.out           |   0
 tests/qapi-schema/include-relpath-sub.json         |   3 -
 tests/qapi-schema/include-relpath.out              |   1 -
 tests/qapi-schema/include-repetition.out           |   1 -
 tests/qapi-schema/include-simple-sub.json          |   3 -
 tests/qapi-schema/include-simple.out               |   1 -
 tests/qapi-schema/indented-expr.json               |   6 -
 tests/qapi-schema/indented-expr.out                |   2 -
 tests/qapi-schema/missing-type.err                 |   2 +-
 tests/qapi-schema/missing-type.json                |   4 -
 tests/qapi-schema/nested-struct-data.err           |   2 +-
 tests/qapi-schema/nested-struct-data.json          |   4 -
 tests/qapi-schema/pragma-doc-required-crap.err     |   1 +
 tests/qapi-schema/pragma-doc-required-crap.exit    |   1 +
 tests/qapi-schema/pragma-doc-required-crap.json    |   3 +
 tests/qapi-schema/pragma-doc-required-crap.out     |   0
 tests/qapi-schema/pragma-extra-junk.err            |   1 +
 tests/qapi-schema/pragma-extra-junk.exit           |   1 +
 tests/qapi-schema/pragma-extra-junk.json           |   3 +
 tests/qapi-schema/pragma-extra-junk.out            |   0
 .../pragma-name-case-whitelist-crap.err            |   1 +
 .../pragma-name-case-whitelist-crap.exit           |   1 +
 .../pragma-name-case-whitelist-crap.json           |   3 +
 .../pragma-name-case-whitelist-crap.out            |   0
 tests/qapi-schema/pragma-non-dict.err              |   1 +
 tests/qapi-schema/pragma-non-dict.exit             |   1 +
 tests/qapi-schema/pragma-non-dict.json             |   3 +
 tests/qapi-schema/pragma-non-dict.out              |   0
 .../qapi-schema/pragma-returns-whitelist-crap.err  |   1 +
 .../qapi-schema/pragma-returns-whitelist-crap.exit |   1 +
 .../qapi-schema/pragma-returns-whitelist-crap.json |   3 +
 .../qapi-schema/pragma-returns-whitelist-crap.out  |   0
 tests/qapi-schema/qapi-schema-test.json            | 218 +------
 tests/qapi-schema/qapi-schema-test.out             | 130 -----
 tests/qapi-schema/redefined-builtin.err            |   2 +-
 tests/qapi-schema/redefined-builtin.json           |   4 -
 tests/qapi-schema/redefined-command.err            |   2 +-
 tests/qapi-schema/redefined-command.json           |   7 -
 tests/qapi-schema/redefined-event.err              |   2 +-
 tests/qapi-schema/redefined-event.json             |   7 -
 tests/qapi-schema/redefined-type.err               |   2 +-
 tests/qapi-schema/redefined-type.json              |   7 -
 tests/qapi-schema/reserved-command-q.err           |   2 +-
 tests/qapi-schema/reserved-command-q.json          |   7 -
 tests/qapi-schema/reserved-enum-q.err              |   2 +-
 tests/qapi-schema/reserved-enum-q.json             |   4 -
 tests/qapi-schema/reserved-member-has.err          |   2 +-
 tests/qapi-schema/reserved-member-has.json         |   4 -
 tests/qapi-schema/reserved-member-q.err            |   2 +-
 tests/qapi-schema/reserved-member-q.json           |   4 -
 tests/qapi-schema/reserved-member-u.err            |   2 +-
 tests/qapi-schema/reserved-member-u.json           |   4 -
 tests/qapi-schema/reserved-member-underscore.err   |   2 +-
 tests/qapi-schema/reserved-member-underscore.json  |   4 -
 tests/qapi-schema/reserved-type-kind.err           |   2 +-
 tests/qapi-schema/reserved-type-kind.json          |   4 -
 tests/qapi-schema/reserved-type-list.err           |   2 +-
 tests/qapi-schema/reserved-type-list.json          |   4 -
 tests/qapi-schema/returns-alternate.err            |   2 +-
 tests/qapi-schema/returns-alternate.json           |   7 -
 tests/qapi-schema/returns-array-bad.err            |   2 +-
 tests/qapi-schema/returns-array-bad.json           |   4 -
 tests/qapi-schema/returns-dict.err                 |   2 +-
 tests/qapi-schema/returns-dict.json                |   4 -
 tests/qapi-schema/returns-unknown.err              |   2 +-
 tests/qapi-schema/returns-unknown.json             |   4 -
 tests/qapi-schema/returns-whitelist.err            |   2 +-
 tests/qapi-schema/returns-whitelist.json           |  18 +-
 tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
 tests/qapi-schema/struct-base-clash-deep.json      |  10 -
 tests/qapi-schema/struct-base-clash.err            |   2 +-
 tests/qapi-schema/struct-base-clash.json           |   7 -
 tests/qapi-schema/struct-data-invalid.err          |   2 +-
 tests/qapi-schema/struct-data-invalid.json         |   3 -
 tests/qapi-schema/struct-member-invalid.err        |   2 +-
 tests/qapi-schema/struct-member-invalid.json       |   3 -
 tests/qapi-schema/test-qapi.py                     |  14 -
 tests/qapi-schema/trailing-comma-list.err          |   2 +-
 tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
 tests/qapi-schema/type-bypass-bad-gen.json         |   4 -
 tests/qapi-schema/unicode-str.err                  |   2 +-
 tests/qapi-schema/unicode-str.json                 |   4 -
 tests/qapi-schema/union-base-empty.err             |   1 +
 tests/qapi-schema/union-base-empty.exit            |   1 +
 tests/qapi-schema/union-base-empty.json            |   9 +
 tests/qapi-schema/union-base-empty.out             |   0
 tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
 tests/qapi-schema/union-base-no-discriminator.json |  12 -
 tests/qapi-schema/union-branch-case.err            |   2 +-
 tests/qapi-schema/union-branch-case.json           |   4 -
 tests/qapi-schema/union-clash-branches.err         |   2 +-
 tests/qapi-schema/union-clash-branches.json        |   4 -
 tests/qapi-schema/union-empty.err                  |   2 +-
 tests/qapi-schema/union-empty.json                 |   4 -
 tests/qapi-schema/union-invalid-base.err           |   2 +-
 tests/qapi-schema/union-invalid-base.json          |  10 -
 tests/qapi-schema/union-optional-branch.err        |   2 +-
 tests/qapi-schema/union-optional-branch.json       |   4 -
 tests/qapi-schema/union-unknown.err                |   2 +-
 tests/qapi-schema/union-unknown.json               |   4 -
 tests/qapi-schema/unknown-escape.err               |   2 +-
 tests/qapi-schema/unknown-escape.json              |   4 -
 tests/qapi-schema/unknown-expr-key.err             |   2 +-
 tests/qapi-schema/unknown-expr-key.json            |   4 -
 288 files changed, 1316 insertions(+), 2116 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-alternate-member.err
 rename tests/qapi-schema/{doc-optional.exit =3D> doc-bad-alternate-membe=
r.exit} (100%)
 create mode 100644 tests/qapi-schema/doc-bad-alternate-member.json
 rename tests/qapi-schema/{doc-optional.out =3D> doc-bad-alternate-member=
.out} (100%)
 delete mode 100644 tests/qapi-schema/doc-bad-args.err
 create mode 100644 tests/qapi-schema/doc-bad-command-arg.err
 rename tests/qapi-schema/{doc-bad-args.exit =3D> doc-bad-command-arg.exi=
t} (100%)
 rename tests/qapi-schema/{doc-bad-args.json =3D> doc-bad-command-arg.jso=
n} (100%)
 rename tests/qapi-schema/{doc-bad-args.out =3D> doc-bad-command-arg.out}=
 (100%)
 create mode 100644 tests/qapi-schema/doc-bad-union-member.err
 create mode 100644 tests/qapi-schema/doc-bad-union-member.exit
 create mode 100644 tests/qapi-schema/doc-bad-union-member.json
 create mode 100644 tests/qapi-schema/doc-bad-union-member.out
 create mode 100644 tests/qapi-schema/doc-before-include.err
 create mode 100644 tests/qapi-schema/doc-before-include.exit
 create mode 100644 tests/qapi-schema/doc-before-include.json
 create mode 100644 tests/qapi-schema/doc-before-include.out
 create mode 100644 tests/qapi-schema/doc-before-pragma.err
 create mode 100644 tests/qapi-schema/doc-before-pragma.exit
 create mode 100644 tests/qapi-schema/doc-before-pragma.json
 create mode 100644 tests/qapi-schema/doc-before-pragma.out
 create mode 100644 tests/qapi-schema/doc-missing.err
 create mode 100644 tests/qapi-schema/doc-missing.exit
 create mode 100644 tests/qapi-schema/doc-missing.json
 create mode 100644 tests/qapi-schema/doc-missing.out
 create mode 100644 tests/qapi-schema/doc-no-symbol.err
 create mode 100644 tests/qapi-schema/doc-no-symbol.exit
 create mode 100644 tests/qapi-schema/doc-no-symbol.json
 create mode 100644 tests/qapi-schema/doc-no-symbol.out
 delete mode 100644 tests/qapi-schema/doc-optional.err
 delete mode 100644 tests/qapi-schema/doc-optional.json
 create mode 100644 tests/qapi-schema/include-extra-junk.err
 create mode 100644 tests/qapi-schema/include-extra-junk.exit
 create mode 100644 tests/qapi-schema/include-extra-junk.json
 create mode 100644 tests/qapi-schema/include-extra-junk.out
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.err
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.exit
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.json
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.out
 create mode 100644 tests/qapi-schema/pragma-extra-junk.err
 create mode 100644 tests/qapi-schema/pragma-extra-junk.exit
 create mode 100644 tests/qapi-schema/pragma-extra-junk.json
 create mode 100644 tests/qapi-schema/pragma-extra-junk.out
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.err
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.exi=
t
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.jso=
n
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.out
 create mode 100644 tests/qapi-schema/pragma-non-dict.err
 create mode 100644 tests/qapi-schema/pragma-non-dict.exit
 create mode 100644 tests/qapi-schema/pragma-non-dict.json
 create mode 100644 tests/qapi-schema/pragma-non-dict.out
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.err
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.exit
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.json
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.out
 create mode 100644 tests/qapi-schema/union-base-empty.err
 create mode 100644 tests/qapi-schema/union-base-empty.exit
 create mode 100644 tests/qapi-schema/union-base-empty.json
 create mode 100644 tests/qapi-schema/union-base-empty.out

--=20
2.7.4
