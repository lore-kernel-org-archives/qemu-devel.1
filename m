Received: from eggs.gnu.org ([2001:4830:134:3::10]:32916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I61-00008K-17
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I5x-0001UL-1T
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9I5w-0001SH-Pa
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA7C1EB6E5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 22:31:56 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-194.rdu2.redhat.com [10.10.123.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E70894562
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 22:31:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 19 Apr 2018 17:31:49 -0500
Message-Id: <20180419223151.623174-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] QAPI file renames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02877.html

Since then: rebase to master, drop patch that has already been
incorporated

Eric Blake (2):
  qapi: Rename QMP and QGA schema files
  qapi: Rename .json to .qapi

 docs/devel/blkdebug.txt                            |   2 +-
 docs/devel/qapi-code-gen.txt                       |   6 +-
 docs/devel/testing.rst                             |   4 +-
 docs/devel/writing-qmp-commands.txt                |   6 +-
 docs/interop/live-block-operations.rst             |   4 +-
 docs/interop/qmp-intro.txt                         |   6 +-
 Makefile                                           |  40 +--
 qapi/{block-core.json => block-core.qapi}          |   6 +-
 qapi/{block.json => block.qapi}                    |   2 +-
 qapi/{char.json => char.qapi}                      |   2 +-
 qapi/{common.json => common.qapi}                  |   0
 qapi/{crypto.json => crypto.qapi}                  |   0
 qapi/{introspect.json => introspect.qapi}          |   0
 qapi/{migration.json => migration.qapi}            |   2 +-
 qapi/{misc.json => misc.qapi}                      |   0
 qapi/{net.json => net.qapi}                        |   2 +-
 qga/qapi-schema.json => qapi/qga-schema.qapi       |   0
 qapi/{qapi-schema.json => qmp-schema.qapi}         |  30 +-
 qapi/{rocker.json => rocker.qapi}                  |   0
 qapi/{run-state.json => run-state.qapi}            |   0
 qapi/{sockets.json => sockets.qapi}                |   2 +-
 qapi/{tpm.json => tpm.qapi}                        |   0
 qapi/{trace.json => trace.qapi}                    |   0
 qapi/{transaction.json => transaction.qapi}        |   2 +-
 qapi/{ui.json => ui.qapi}                          |   2 +-
 include/crypto/block.h                             |   2 +-
 include/crypto/cipher.h                            |   2 +-
 include/crypto/hash.h                              |   2 +-
 include/crypto/ivgen.h                             |   2 +-
 MAINTAINERS                                        |  26 +-
 scripts/git.orderfile                              |   2 +-
 tests/Makefile.include                             | 336 ++++++++++-----------
 tests/qapi-schema/alternate-any.err                |   2 +-
 .../{alternate-any.json => alternate-any.qapi}     |   0
 tests/qapi-schema/alternate-array.err              |   2 +-
 .../{alternate-array.json => alternate-array.qapi} |   0
 tests/qapi-schema/alternate-base.err               |   2 +-
 .../{alternate-base.json => alternate-base.qapi}   |   0
 tests/qapi-schema/alternate-clash.err              |   2 +-
 .../{alternate-clash.json => alternate-clash.qapi} |   0
 .../qapi-schema/alternate-conflict-bool-string.err |   2 +-
 ...ng.json => alternate-conflict-bool-string.qapi} |   0
 tests/qapi-schema/alternate-conflict-dict.err      |   2 +-
 ...lict-dict.json => alternate-conflict-dict.qapi} |   0
 tests/qapi-schema/alternate-conflict-enum-bool.err |   2 +-
 ...bool.json => alternate-conflict-enum-bool.qapi} |   0
 tests/qapi-schema/alternate-conflict-enum-int.err  |   2 +-
 ...m-int.json => alternate-conflict-enum-int.qapi} |   0
 .../qapi-schema/alternate-conflict-num-string.err  |   2 +-
 ...ing.json => alternate-conflict-num-string.qapi} |   0
 tests/qapi-schema/alternate-conflict-string.err    |   2 +-
 ...-string.json => alternate-conflict-string.qapi} |   0
 tests/qapi-schema/alternate-empty.err              |   2 +-
 .../{alternate-empty.json => alternate-empty.qapi} |   0
 tests/qapi-schema/alternate-nested.err             |   2 +-
 ...alternate-nested.json => alternate-nested.qapi} |   0
 tests/qapi-schema/alternate-unknown.err            |   2 +-
 ...ternate-unknown.json => alternate-unknown.qapi} |   0
 tests/qapi-schema/args-alternate.err               |   2 +-
 .../{args-alternate.json => args-alternate.qapi}   |   0
 tests/qapi-schema/args-any.err                     |   2 +-
 tests/qapi-schema/{args-any.json => args-any.qapi} |   0
 tests/qapi-schema/args-array-empty.err             |   2 +-
 ...args-array-empty.json => args-array-empty.qapi} |   0
 tests/qapi-schema/args-array-unknown.err           |   2 +-
 ...-array-unknown.json => args-array-unknown.qapi} |   0
 tests/qapi-schema/args-bad-boxed.err               |   2 +-
 .../{args-bad-boxed.json => args-bad-boxed.qapi}   |   0
 tests/qapi-schema/args-boxed-anon.err              |   2 +-
 .../{args-boxed-anon.json => args-boxed-anon.qapi} |   0
 tests/qapi-schema/args-boxed-empty.err             |   2 +-
 ...args-boxed-empty.json => args-boxed-empty.qapi} |   0
 tests/qapi-schema/args-boxed-string.err            |   2 +-
 ...gs-boxed-string.json => args-boxed-string.qapi} |   0
 tests/qapi-schema/args-int.err                     |   2 +-
 tests/qapi-schema/{args-int.json => args-int.qapi} |   0
 tests/qapi-schema/args-invalid.err                 |   2 +-
 .../{args-invalid.json => args-invalid.qapi}       |   0
 tests/qapi-schema/args-member-array-bad.err        |   2 +-
 ...r-array-bad.json => args-member-array-bad.qapi} |   0
 tests/qapi-schema/args-member-case.err             |   2 +-
 ...args-member-case.json => args-member-case.qapi} |   0
 tests/qapi-schema/args-member-unknown.err          |   2 +-
 ...ember-unknown.json => args-member-unknown.qapi} |   0
 tests/qapi-schema/args-name-clash.err              |   2 +-
 .../{args-name-clash.json => args-name-clash.qapi} |   0
 tests/qapi-schema/args-union.err                   |   2 +-
 .../{args-union.json => args-union.qapi}           |   0
 tests/qapi-schema/args-unknown.err                 |   2 +-
 .../{args-unknown.json => args-unknown.qapi}       |   0
 tests/qapi-schema/bad-base.err                     |   2 +-
 tests/qapi-schema/{bad-base.json => bad-base.qapi} |   0
 tests/qapi-schema/bad-data.err                     |   2 +-
 tests/qapi-schema/{bad-data.json => bad-data.qapi} |   0
 tests/qapi-schema/bad-ident.err                    |   2 +-
 .../qapi-schema/{bad-ident.json => bad-ident.qapi} |   0
 tests/qapi-schema/bad-type-bool.err                |   2 +-
 .../{bad-type-bool.json => bad-type-bool.qapi}     |   0
 tests/qapi-schema/bad-type-dict.err                |   2 +-
 .../{bad-type-dict.json => bad-type-dict.qapi}     |   0
 tests/qapi-schema/bad-type-int.err                 |   2 +-
 .../{bad-type-int.json => bad-type-int.qapi}       |   0
 tests/qapi-schema/base-cycle-direct.err            |   2 +-
 ...se-cycle-direct.json => base-cycle-direct.qapi} |   0
 tests/qapi-schema/base-cycle-indirect.err          |   2 +-
 ...ycle-indirect.json => base-cycle-indirect.qapi} |   0
 tests/qapi-schema/command-int.err                  |   2 +-
 .../{command-int.json => command-int.qapi}         |   0
 tests/qapi-schema/comments.out                     |   2 +-
 tests/qapi-schema/{comments.json => comments.qapi} |   0
 tests/qapi-schema/doc-bad-alternate-member.err     |   2 +-
 ...e-member.json => doc-bad-alternate-member.qapi} |   0
 tests/qapi-schema/doc-bad-command-arg.err          |   2 +-
 ...d-command-arg.json => doc-bad-command-arg.qapi} |   0
 tests/qapi-schema/doc-bad-section.out              |   2 +-
 .../{doc-bad-section.json => doc-bad-section.qapi} |   0
 tests/qapi-schema/doc-bad-symbol.err               |   2 +-
 .../{doc-bad-symbol.json => doc-bad-symbol.qapi}   |   0
 tests/qapi-schema/doc-bad-union-member.err         |   2 +-
 ...union-member.json => doc-bad-union-member.qapi} |   0
 tests/qapi-schema/doc-before-include.err           |   2 +-
 ...before-include.json => doc-before-include.qapi} |   2 +-
 tests/qapi-schema/doc-before-pragma.err            |   2 +-
 ...c-before-pragma.json => doc-before-pragma.qapi} |   0
 tests/qapi-schema/doc-duplicated-arg.err           |   2 +-
 ...duplicated-arg.json => doc-duplicated-arg.qapi} |   0
 tests/qapi-schema/doc-duplicated-return.err        |   2 +-
 ...ated-return.json => doc-duplicated-return.qapi} |   0
 tests/qapi-schema/doc-duplicated-since.err         |   2 +-
 ...icated-since.json => doc-duplicated-since.qapi} |   0
 tests/qapi-schema/doc-empty-arg.err                |   2 +-
 .../{doc-empty-arg.json => doc-empty-arg.qapi}     |   0
 tests/qapi-schema/doc-empty-section.err            |   2 +-
 ...c-empty-section.json => doc-empty-section.qapi} |   0
 tests/qapi-schema/doc-empty-symbol.err             |   2 +-
 ...doc-empty-symbol.json => doc-empty-symbol.qapi} |   0
 tests/qapi-schema/doc-good.out                     |   2 +-
 tests/qapi-schema/{doc-good.json => doc-good.qapi} |   0
 tests/qapi-schema/doc-interleaved-section.err      |   2 +-
 ...d-section.json => doc-interleaved-section.qapi} |   0
 tests/qapi-schema/doc-invalid-end.err              |   2 +-
 .../{doc-invalid-end.json => doc-invalid-end.qapi} |   0
 tests/qapi-schema/doc-invalid-end2.err             |   2 +-
 ...doc-invalid-end2.json => doc-invalid-end2.qapi} |   0
 tests/qapi-schema/doc-invalid-return.err           |   2 +-
 ...invalid-return.json => doc-invalid-return.qapi} |   0
 tests/qapi-schema/doc-invalid-section.err          |   2 +-
 ...valid-section.json => doc-invalid-section.qapi} |   0
 tests/qapi-schema/doc-invalid-start.err            |   2 +-
 ...c-invalid-start.json => doc-invalid-start.qapi} |   0
 tests/qapi-schema/doc-missing-colon.err            |   2 +-
 ...c-missing-colon.json => doc-missing-colon.qapi} |   0
 tests/qapi-schema/doc-missing-expr.err             |   2 +-
 ...doc-missing-expr.json => doc-missing-expr.qapi} |   0
 tests/qapi-schema/doc-missing-space.err            |   2 +-
 ...c-missing-space.json => doc-missing-space.qapi} |   0
 tests/qapi-schema/doc-missing.err                  |   2 +-
 .../{doc-missing.json => doc-missing.qapi}         |   0
 tests/qapi-schema/doc-no-symbol.err                |   2 +-
 .../{doc-no-symbol.json => doc-no-symbol.qapi}     |   0
 tests/qapi-schema/double-data.err                  |   2 +-
 .../{double-data.json => double-data.qapi}         |   0
 tests/qapi-schema/double-type.err                  |   2 +-
 .../{double-type.json => double-type.qapi}         |   0
 tests/qapi-schema/duplicate-key.err                |   2 +-
 .../{duplicate-key.json => duplicate-key.qapi}     |   0
 tests/qapi-schema/{empty.json => empty.qapi}       |   0
 tests/qapi-schema/enum-bad-name.err                |   2 +-
 .../{enum-bad-name.json => enum-bad-name.qapi}     |   0
 tests/qapi-schema/enum-bad-prefix.err              |   2 +-
 .../{enum-bad-prefix.json => enum-bad-prefix.qapi} |   0
 tests/qapi-schema/enum-clash-member.err            |   2 +-
 ...um-clash-member.json => enum-clash-member.qapi} |   0
 tests/qapi-schema/enum-dict-member.err             |   2 +-
 ...enum-dict-member.json => enum-dict-member.qapi} |   0
 tests/qapi-schema/enum-int-member.err              |   2 +-
 .../{enum-int-member.json => enum-int-member.qapi} |   0
 tests/qapi-schema/enum-member-case.err             |   2 +-
 ...enum-member-case.json => enum-member-case.qapi} |   0
 tests/qapi-schema/enum-missing-data.err            |   2 +-
 ...um-missing-data.json => enum-missing-data.qapi} |   0
 tests/qapi-schema/enum-wrong-data.err              |   2 +-
 .../{enum-wrong-data.json => enum-wrong-data.qapi} |   0
 tests/qapi-schema/escape-outside-string.err        |   2 +-
 ...side-string.json => escape-outside-string.qapi} |   0
 tests/qapi-schema/escape-too-big.err               |   2 +-
 .../{escape-too-big.json => escape-too-big.qapi}   |   0
 tests/qapi-schema/escape-too-short.err             |   2 +-
 ...escape-too-short.json => escape-too-short.qapi} |   0
 tests/qapi-schema/event-boxed-empty.err            |   2 +-
 ...ent-boxed-empty.json => event-boxed-empty.qapi} |   0
 tests/qapi-schema/event-case.out                   |   2 +-
 .../{event-case.json => event-case.qapi}           |   0
 tests/qapi-schema/event-nest-struct.err            |   2 +-
 ...ent-nest-struct.json => event-nest-struct.qapi} |   0
 tests/qapi-schema/flat-union-array-branch.err      |   2 +-
 ...ay-branch.json => flat-union-array-branch.qapi} |   0
 tests/qapi-schema/flat-union-bad-base.err          |   2 +-
 ...nion-bad-base.json => flat-union-bad-base.qapi} |   0
 tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
 ...ator.json => flat-union-bad-discriminator.qapi} |   0
 tests/qapi-schema/flat-union-base-any.err          |   2 +-
 ...nion-base-any.json => flat-union-base-any.qapi} |   0
 tests/qapi-schema/flat-union-base-union.err        |   2 +-
 ...-base-union.json => flat-union-base-union.qapi} |   0
 tests/qapi-schema/flat-union-clash-member.err      |   2 +-
 ...sh-member.json => flat-union-clash-member.qapi} |   0
 tests/qapi-schema/flat-union-empty.err             |   2 +-
 ...flat-union-empty.json => flat-union-empty.qapi} |   0
 tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
 ...anch.json => flat-union-incomplete-branch.qapi} |   0
 tests/qapi-schema/flat-union-inline.err            |   2 +-
 ...at-union-inline.json => flat-union-inline.qapi} |   0
 tests/qapi-schema/flat-union-int-branch.err        |   2 +-
 ...-int-branch.json => flat-union-int-branch.qapi} |   0
 .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
 ...key.json => flat-union-invalid-branch-key.qapi} |   0
 .../flat-union-invalid-discriminator.err           |   2 +-
 ....json => flat-union-invalid-discriminator.qapi} |   0
 tests/qapi-schema/flat-union-no-base.err           |   2 +-
 ...-union-no-base.json => flat-union-no-base.qapi} |   0
 .../flat-union-optional-discriminator.err          |   2 +-
 ...json => flat-union-optional-discriminator.qapi} |   0
 .../flat-union-string-discriminator.err            |   2 +-
 ...r.json => flat-union-string-discriminator.qapi} |   0
 tests/qapi-schema/funny-char.err                   |   2 +-
 .../{funny-char.json => funny-char.qapi}           |   0
 tests/qapi-schema/ident-with-escape.out            |   2 +-
 ...ent-with-escape.json => ident-with-escape.qapi} |   0
 tests/qapi-schema/include-before-err.err           |   2 +-
 tests/qapi-schema/include-before-err.json          |   2 -
 tests/qapi-schema/include-before-err.qapi          |   2 +
 tests/qapi-schema/include-cycle-b.json             |   1 -
 tests/qapi-schema/include-cycle-b.qapi             |   1 +
 tests/qapi-schema/include-cycle-c.json             |   1 -
 tests/qapi-schema/include-cycle-c.qapi             |   1 +
 tests/qapi-schema/include-cycle.err                |   6 +-
 tests/qapi-schema/include-cycle.json               |   1 -
 tests/qapi-schema/include-cycle.qapi               |   1 +
 tests/qapi-schema/include-extra-junk.err           |   2 +-
 tests/qapi-schema/include-extra-junk.json          |   3 -
 tests/qapi-schema/include-extra-junk.qapi          |   3 +
 tests/qapi-schema/include-format-err.err           |   2 +-
 tests/qapi-schema/include-format-err.json          |   2 -
 tests/qapi-schema/include-format-err.qapi          |   2 +
 tests/qapi-schema/include-nested-err.err           |   4 +-
 tests/qapi-schema/include-nested-err.json          |   1 -
 tests/qapi-schema/include-nested-err.qapi          |   1 +
 tests/qapi-schema/include-no-file.err              |   2 +-
 tests/qapi-schema/include-no-file.json             |   1 -
 tests/qapi-schema/include-no-file.qapi             |   1 +
 tests/qapi-schema/include-non-file.err             |   2 +-
 ...include-non-file.json => include-non-file.qapi} |   0
 ...e-relpath-sub.json => include-relpath-sub.qapi} |   0
 tests/qapi-schema/include-relpath.json             |   1 -
 tests/qapi-schema/include-relpath.out              |  10 +-
 tests/qapi-schema/include-relpath.qapi             |   1 +
 tests/qapi-schema/include-repetition-sub.json      |   2 -
 tests/qapi-schema/include-repetition-sub.qapi      |   2 +
 tests/qapi-schema/include-repetition.json          |   3 -
 tests/qapi-schema/include-repetition.out           |  20 +-
 tests/qapi-schema/include-repetition.qapi          |   3 +
 tests/qapi-schema/include-self-cycle.err           |   2 +-
 tests/qapi-schema/include-self-cycle.json          |   1 -
 tests/qapi-schema/include-self-cycle.qapi          |   1 +
 ...ude-simple-sub.json => include-simple-sub.qapi} |   0
 tests/qapi-schema/include-simple.json              |   1 -
 tests/qapi-schema/include-simple.out               |   6 +-
 tests/qapi-schema/include-simple.qapi              |   1 +
 tests/qapi-schema/include/relpath.json             |   1 -
 tests/qapi-schema/include/relpath.qapi             |   1 +
 tests/qapi-schema/indented-expr.out                |   2 +-
 .../{indented-expr.json => indented-expr.qapi}     |   0
 tests/qapi-schema/leading-comma-list.err           |   2 +-
 ...ing-comma-list.json => leading-comma-list.qapi} |   0
 tests/qapi-schema/leading-comma-object.err         |   2 +-
 ...comma-object.json => leading-comma-object.qapi} |   0
 tests/qapi-schema/missing-colon.err                |   2 +-
 .../{missing-colon.json => missing-colon.qapi}     |   0
 tests/qapi-schema/missing-comma-list.err           |   2 +-
 ...ing-comma-list.json => missing-comma-list.qapi} |   0
 tests/qapi-schema/missing-comma-object.err         |   2 +-
 ...comma-object.json => missing-comma-object.qapi} |   0
 tests/qapi-schema/missing-type.err                 |   2 +-
 .../{missing-type.json => missing-type.qapi}       |   0
 tests/qapi-schema/nested-struct-data.err           |   2 +-
 ...ed-struct-data.json => nested-struct-data.qapi} |   0
 tests/qapi-schema/non-objects.err                  |   2 +-
 .../{non-objects.json => non-objects.qapi}         |   0
 tests/qapi-schema/oob-test.err                     |   2 +-
 tests/qapi-schema/{oob-test.json => oob-test.qapi} |   0
 tests/qapi-schema/pragma-doc-required-crap.err     |   2 +-
 ...red-crap.json => pragma-doc-required-crap.qapi} |   0
 tests/qapi-schema/pragma-extra-junk.err            |   2 +-
 ...agma-extra-junk.json => pragma-extra-junk.qapi} |   0
 .../pragma-name-case-whitelist-crap.err            |   2 +-
 ...p.json => pragma-name-case-whitelist-crap.qapi} |   0
 tests/qapi-schema/pragma-non-dict.err              |   2 +-
 .../{pragma-non-dict.json => pragma-non-dict.qapi} |   0
 .../qapi-schema/pragma-returns-whitelist-crap.err  |   2 +-
 ...rap.json => pragma-returns-whitelist-crap.qapi} |   0
 tests/qapi-schema/qapi-schema-test.out             |   2 +-
 ...qapi-schema-test.json => qapi-schema-test.qapi} |   0
 tests/qapi-schema/quoted-structural-chars.err      |   2 +-
 ...ral-chars.json => quoted-structural-chars.qapi} |   0
 tests/qapi-schema/redefined-builtin.err            |   2 +-
 ...defined-builtin.json => redefined-builtin.qapi} |   0
 tests/qapi-schema/redefined-command.err            |   2 +-
 ...defined-command.json => redefined-command.qapi} |   0
 tests/qapi-schema/redefined-event.err              |   2 +-
 .../{redefined-event.json => redefined-event.qapi} |   0
 tests/qapi-schema/redefined-type.err               |   2 +-
 .../{redefined-type.json => redefined-type.qapi}   |   0
 tests/qapi-schema/reserved-command-q.err           |   2 +-
 ...rved-command-q.json => reserved-command-q.qapi} |   0
 tests/qapi-schema/reserved-enum-q.err              |   2 +-
 .../{reserved-enum-q.json => reserved-enum-q.qapi} |   0
 tests/qapi-schema/reserved-member-has.err          |   2 +-
 ...ed-member-has.json => reserved-member-has.qapi} |   0
 tests/qapi-schema/reserved-member-q.err            |   2 +-
 ...served-member-q.json => reserved-member-q.qapi} |   0
 tests/qapi-schema/reserved-member-u.err            |   2 +-
 ...served-member-u.json => reserved-member-u.qapi} |   0
 tests/qapi-schema/reserved-member-underscore.err   |   2 +-
 ...rscore.json => reserved-member-underscore.qapi} |   0
 tests/qapi-schema/reserved-type-kind.err           |   2 +-
 ...rved-type-kind.json => reserved-type-kind.qapi} |   0
 tests/qapi-schema/reserved-type-list.err           |   2 +-
 ...rved-type-list.json => reserved-type-list.qapi} |   0
 tests/qapi-schema/returns-alternate.err            |   2 +-
 ...turns-alternate.json => returns-alternate.qapi} |   0
 tests/qapi-schema/returns-array-bad.err            |   2 +-
 ...turns-array-bad.json => returns-array-bad.qapi} |   0
 tests/qapi-schema/returns-dict.err                 |   2 +-
 .../{returns-dict.json => returns-dict.qapi}       |   0
 tests/qapi-schema/returns-unknown.err              |   2 +-
 .../{returns-unknown.json => returns-unknown.qapi} |   0
 tests/qapi-schema/returns-whitelist.err            |   2 +-
 ...turns-whitelist.json => returns-whitelist.qapi} |   0
 tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
 ...clash-deep.json => struct-base-clash-deep.qapi} |   0
 tests/qapi-schema/struct-base-clash.err            |   2 +-
 ...ruct-base-clash.json => struct-base-clash.qapi} |   0
 tests/qapi-schema/struct-data-invalid.err          |   2 +-
 ...-data-invalid.json => struct-data-invalid.qapi} |   0
 tests/qapi-schema/struct-member-invalid.err        |   2 +-
 ...ber-invalid.json => struct-member-invalid.qapi} |   0
 tests/qapi-schema/trailing-comma-list.err          |   2 +-
 ...ng-comma-list.json => trailing-comma-list.qapi} |   0
 tests/qapi-schema/trailing-comma-object.err        |   2 +-
 ...omma-object.json => trailing-comma-object.qapi} |   0
 tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
 ...ypass-bad-gen.json => type-bypass-bad-gen.qapi} |   0
 tests/qapi-schema/unclosed-list.err                |   2 +-
 .../{unclosed-list.json => unclosed-list.qapi}     |   0
 tests/qapi-schema/unclosed-object.err              |   2 +-
 .../{unclosed-object.json => unclosed-object.qapi} |   0
 tests/qapi-schema/unclosed-string.err              |   2 +-
 .../{unclosed-string.json => unclosed-string.qapi} |   0
 tests/qapi-schema/unicode-str.err                  |   2 +-
 .../{unicode-str.json => unicode-str.qapi}         |   0
 tests/qapi-schema/union-base-empty.err             |   2 +-
 ...union-base-empty.json => union-base-empty.qapi} |   0
 tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
 ...nator.json => union-base-no-discriminator.qapi} |   0
 tests/qapi-schema/union-branch-case.err            |   2 +-
 ...ion-branch-case.json => union-branch-case.qapi} |   0
 tests/qapi-schema/union-clash-branches.err         |   2 +-
 ...ash-branches.json => union-clash-branches.qapi} |   0
 tests/qapi-schema/union-empty.err                  |   2 +-
 .../{union-empty.json => union-empty.qapi}         |   0
 tests/qapi-schema/union-invalid-base.err           |   2 +-
 ...n-invalid-base.json => union-invalid-base.qapi} |   0
 tests/qapi-schema/union-optional-branch.err        |   2 +-
 ...onal-branch.json => union-optional-branch.qapi} |   0
 tests/qapi-schema/union-unknown.err                |   2 +-
 .../{union-unknown.json => union-unknown.qapi}     |   0
 tests/qapi-schema/unknown-escape.err               |   2 +-
 .../{unknown-escape.json => unknown-escape.qapi}   |   0
 tests/qapi-schema/unknown-expr-key.err             |   2 +-
 ...unknown-expr-key.json => unknown-expr-key.qapi} |   0
 381 files changed, 449 insertions(+), 449 deletions(-)
 rename qapi/{block-core.json => block-core.qapi} (99%)
 rename qapi/{block.json => block.qapi} (99%)
 rename qapi/{char.json => char.qapi} (99%)
 rename qapi/{common.json => common.qapi} (100%)
 rename qapi/{crypto.json => crypto.qapi} (100%)
 rename qapi/{introspect.json => introspect.qapi} (100%)
 rename qapi/{migration.json => migration.qapi} (99%)
 rename qapi/{misc.json => misc.qapi} (100%)
 rename qapi/{net.json => net.qapi} (99%)
 rename qga/qapi-schema.json => qapi/qga-schema.qapi (100%)
 rename qapi/{qapi-schema.json => qmp-schema.qapi} (88%)
 rename qapi/{rocker.json => rocker.qapi} (100%)
 rename qapi/{run-state.json => run-state.qapi} (100%)
 rename qapi/{sockets.json => sockets.qapi} (99%)
 rename qapi/{tpm.json => tpm.qapi} (100%)
 rename qapi/{trace.json => trace.qapi} (100%)
 rename qapi/{transaction.json => transaction.qapi} (99%)
 rename qapi/{ui.json => ui.qapi} (99%)
 rename tests/qapi-schema/{alternate-any.json => alternate-any.qapi} (100%)
 rename tests/qapi-schema/{alternate-array.json => alternate-array.qapi} (100%)
 rename tests/qapi-schema/{alternate-base.json => alternate-base.qapi} (100%)
 rename tests/qapi-schema/{alternate-clash.json => alternate-clash.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-bool-string.json => alternate-conflict-bool-string.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-dict.json => alternate-conflict-dict.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-enum-bool.json => alternate-conflict-enum-bool.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-enum-int.json => alternate-conflict-enum-int.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-num-string.json => alternate-conflict-num-string.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-string.json => alternate-conflict-string.qapi} (100%)
 rename tests/qapi-schema/{alternate-empty.json => alternate-empty.qapi} (100%)
 rename tests/qapi-schema/{alternate-nested.json => alternate-nested.qapi} (100%)
 rename tests/qapi-schema/{alternate-unknown.json => alternate-unknown.qapi} (100%)
 rename tests/qapi-schema/{args-alternate.json => args-alternate.qapi} (100%)
 rename tests/qapi-schema/{args-any.json => args-any.qapi} (100%)
 rename tests/qapi-schema/{args-array-empty.json => args-array-empty.qapi} (100%)
 rename tests/qapi-schema/{args-array-unknown.json => args-array-unknown.qapi} (100%)
 rename tests/qapi-schema/{args-bad-boxed.json => args-bad-boxed.qapi} (100%)
 rename tests/qapi-schema/{args-boxed-anon.json => args-boxed-anon.qapi} (100%)
 rename tests/qapi-schema/{args-boxed-empty.json => args-boxed-empty.qapi} (100%)
 rename tests/qapi-schema/{args-boxed-string.json => args-boxed-string.qapi} (100%)
 rename tests/qapi-schema/{args-int.json => args-int.qapi} (100%)
 rename tests/qapi-schema/{args-invalid.json => args-invalid.qapi} (100%)
 rename tests/qapi-schema/{args-member-array-bad.json => args-member-array-bad.qapi} (100%)
 rename tests/qapi-schema/{args-member-case.json => args-member-case.qapi} (100%)
 rename tests/qapi-schema/{args-member-unknown.json => args-member-unknown.qapi} (100%)
 rename tests/qapi-schema/{args-name-clash.json => args-name-clash.qapi} (100%)
 rename tests/qapi-schema/{args-union.json => args-union.qapi} (100%)
 rename tests/qapi-schema/{args-unknown.json => args-unknown.qapi} (100%)
 rename tests/qapi-schema/{bad-base.json => bad-base.qapi} (100%)
 rename tests/qapi-schema/{bad-data.json => bad-data.qapi} (100%)
 rename tests/qapi-schema/{bad-ident.json => bad-ident.qapi} (100%)
 rename tests/qapi-schema/{bad-type-bool.json => bad-type-bool.qapi} (100%)
 rename tests/qapi-schema/{bad-type-dict.json => bad-type-dict.qapi} (100%)
 rename tests/qapi-schema/{bad-type-int.json => bad-type-int.qapi} (100%)
 rename tests/qapi-schema/{base-cycle-direct.json => base-cycle-direct.qapi} (100%)
 rename tests/qapi-schema/{base-cycle-indirect.json => base-cycle-indirect.qapi} (100%)
 rename tests/qapi-schema/{command-int.json => command-int.qapi} (100%)
 rename tests/qapi-schema/{comments.json => comments.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-alternate-member.json => doc-bad-alternate-member.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-command-arg.json => doc-bad-command-arg.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-section.json => doc-bad-section.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-symbol.json => doc-bad-symbol.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-union-member.json => doc-bad-union-member.qapi} (100%)
 rename tests/qapi-schema/{doc-before-include.json => doc-before-include.qapi} (81%)
 rename tests/qapi-schema/{doc-before-pragma.json => doc-before-pragma.qapi} (100%)
 rename tests/qapi-schema/{doc-duplicated-arg.json => doc-duplicated-arg.qapi} (100%)
 rename tests/qapi-schema/{doc-duplicated-return.json => doc-duplicated-return.qapi} (100%)
 rename tests/qapi-schema/{doc-duplicated-since.json => doc-duplicated-since.qapi} (100%)
 rename tests/qapi-schema/{doc-empty-arg.json => doc-empty-arg.qapi} (100%)
 rename tests/qapi-schema/{doc-empty-section.json => doc-empty-section.qapi} (100%)
 rename tests/qapi-schema/{doc-empty-symbol.json => doc-empty-symbol.qapi} (100%)
 rename tests/qapi-schema/{doc-good.json => doc-good.qapi} (100%)
 rename tests/qapi-schema/{doc-interleaved-section.json => doc-interleaved-section.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-end.json => doc-invalid-end.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-end2.json => doc-invalid-end2.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-return.json => doc-invalid-return.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-section.json => doc-invalid-section.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-start.json => doc-invalid-start.qapi} (100%)
 rename tests/qapi-schema/{doc-missing-colon.json => doc-missing-colon.qapi} (100%)
 rename tests/qapi-schema/{doc-missing-expr.json => doc-missing-expr.qapi} (100%)
 rename tests/qapi-schema/{doc-missing-space.json => doc-missing-space.qapi} (100%)
 rename tests/qapi-schema/{doc-missing.json => doc-missing.qapi} (100%)
 rename tests/qapi-schema/{doc-no-symbol.json => doc-no-symbol.qapi} (100%)
 rename tests/qapi-schema/{double-data.json => double-data.qapi} (100%)
 rename tests/qapi-schema/{double-type.json => double-type.qapi} (100%)
 rename tests/qapi-schema/{duplicate-key.json => duplicate-key.qapi} (100%)
 rename tests/qapi-schema/{empty.json => empty.qapi} (100%)
 rename tests/qapi-schema/{enum-bad-name.json => enum-bad-name.qapi} (100%)
 rename tests/qapi-schema/{enum-bad-prefix.json => enum-bad-prefix.qapi} (100%)
 rename tests/qapi-schema/{enum-clash-member.json => enum-clash-member.qapi} (100%)
 rename tests/qapi-schema/{enum-dict-member.json => enum-dict-member.qapi} (100%)
 rename tests/qapi-schema/{enum-int-member.json => enum-int-member.qapi} (100%)
 rename tests/qapi-schema/{enum-member-case.json => enum-member-case.qapi} (100%)
 rename tests/qapi-schema/{enum-missing-data.json => enum-missing-data.qapi} (100%)
 rename tests/qapi-schema/{enum-wrong-data.json => enum-wrong-data.qapi} (100%)
 rename tests/qapi-schema/{escape-outside-string.json => escape-outside-string.qapi} (100%)
 rename tests/qapi-schema/{escape-too-big.json => escape-too-big.qapi} (100%)
 rename tests/qapi-schema/{escape-too-short.json => escape-too-short.qapi} (100%)
 rename tests/qapi-schema/{event-boxed-empty.json => event-boxed-empty.qapi} (100%)
 rename tests/qapi-schema/{event-case.json => event-case.qapi} (100%)
 rename tests/qapi-schema/{event-nest-struct.json => event-nest-struct.qapi} (100%)
 rename tests/qapi-schema/{flat-union-array-branch.json => flat-union-array-branch.qapi} (100%)
 rename tests/qapi-schema/{flat-union-bad-base.json => flat-union-bad-base.qapi} (100%)
 rename tests/qapi-schema/{flat-union-bad-discriminator.json => flat-union-bad-discriminator.qapi} (100%)
 rename tests/qapi-schema/{flat-union-base-any.json => flat-union-base-any.qapi} (100%)
 rename tests/qapi-schema/{flat-union-base-union.json => flat-union-base-union.qapi} (100%)
 rename tests/qapi-schema/{flat-union-clash-member.json => flat-union-clash-member.qapi} (100%)
 rename tests/qapi-schema/{flat-union-empty.json => flat-union-empty.qapi} (100%)
 rename tests/qapi-schema/{flat-union-incomplete-branch.json => flat-union-incomplete-branch.qapi} (100%)
 rename tests/qapi-schema/{flat-union-inline.json => flat-union-inline.qapi} (100%)
 rename tests/qapi-schema/{flat-union-int-branch.json => flat-union-int-branch.qapi} (100%)
 rename tests/qapi-schema/{flat-union-invalid-branch-key.json => flat-union-invalid-branch-key.qapi} (100%)
 rename tests/qapi-schema/{flat-union-invalid-discriminator.json => flat-union-invalid-discriminator.qapi} (100%)
 rename tests/qapi-schema/{flat-union-no-base.json => flat-union-no-base.qapi} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.json => flat-union-optional-discriminator.qapi} (100%)
 rename tests/qapi-schema/{flat-union-string-discriminator.json => flat-union-string-discriminator.qapi} (100%)
 rename tests/qapi-schema/{funny-char.json => funny-char.qapi} (100%)
 rename tests/qapi-schema/{ident-with-escape.json => ident-with-escape.qapi} (100%)
 delete mode 100644 tests/qapi-schema/include-before-err.json
 create mode 100644 tests/qapi-schema/include-before-err.qapi
 delete mode 100644 tests/qapi-schema/include-cycle-b.json
 create mode 100644 tests/qapi-schema/include-cycle-b.qapi
 delete mode 100644 tests/qapi-schema/include-cycle-c.json
 create mode 100644 tests/qapi-schema/include-cycle-c.qapi
 delete mode 100644 tests/qapi-schema/include-cycle.json
 create mode 100644 tests/qapi-schema/include-cycle.qapi
 delete mode 100644 tests/qapi-schema/include-extra-junk.json
 create mode 100644 tests/qapi-schema/include-extra-junk.qapi
 delete mode 100644 tests/qapi-schema/include-format-err.json
 create mode 100644 tests/qapi-schema/include-format-err.qapi
 delete mode 100644 tests/qapi-schema/include-nested-err.json
 create mode 100644 tests/qapi-schema/include-nested-err.qapi
 delete mode 100644 tests/qapi-schema/include-no-file.json
 create mode 100644 tests/qapi-schema/include-no-file.qapi
 rename tests/qapi-schema/{include-non-file.json => include-non-file.qapi} (100%)
 rename tests/qapi-schema/{include-relpath-sub.json => include-relpath-sub.qapi} (100%)
 delete mode 100644 tests/qapi-schema/include-relpath.json
 create mode 100644 tests/qapi-schema/include-relpath.qapi
 delete mode 100644 tests/qapi-schema/include-repetition-sub.json
 create mode 100644 tests/qapi-schema/include-repetition-sub.qapi
 delete mode 100644 tests/qapi-schema/include-repetition.json
 create mode 100644 tests/qapi-schema/include-repetition.qapi
 delete mode 100644 tests/qapi-schema/include-self-cycle.json
 create mode 100644 tests/qapi-schema/include-self-cycle.qapi
 rename tests/qapi-schema/{include-simple-sub.json => include-simple-sub.qapi} (100%)
 delete mode 100644 tests/qapi-schema/include-simple.json
 create mode 100644 tests/qapi-schema/include-simple.qapi
 delete mode 100644 tests/qapi-schema/include/relpath.json
 create mode 100644 tests/qapi-schema/include/relpath.qapi
 rename tests/qapi-schema/{indented-expr.json => indented-expr.qapi} (100%)
 rename tests/qapi-schema/{leading-comma-list.json => leading-comma-list.qapi} (100%)
 rename tests/qapi-schema/{leading-comma-object.json => leading-comma-object.qapi} (100%)
 rename tests/qapi-schema/{missing-colon.json => missing-colon.qapi} (100%)
 rename tests/qapi-schema/{missing-comma-list.json => missing-comma-list.qapi} (100%)
 rename tests/qapi-schema/{missing-comma-object.json => missing-comma-object.qapi} (100%)
 rename tests/qapi-schema/{missing-type.json => missing-type.qapi} (100%)
 rename tests/qapi-schema/{nested-struct-data.json => nested-struct-data.qapi} (100%)
 rename tests/qapi-schema/{non-objects.json => non-objects.qapi} (100%)
 rename tests/qapi-schema/{oob-test.json => oob-test.qapi} (100%)
 rename tests/qapi-schema/{pragma-doc-required-crap.json => pragma-doc-required-crap.qapi} (100%)
 rename tests/qapi-schema/{pragma-extra-junk.json => pragma-extra-junk.qapi} (100%)
 rename tests/qapi-schema/{pragma-name-case-whitelist-crap.json => pragma-name-case-whitelist-crap.qapi} (100%)
 rename tests/qapi-schema/{pragma-non-dict.json => pragma-non-dict.qapi} (100%)
 rename tests/qapi-schema/{pragma-returns-whitelist-crap.json => pragma-returns-whitelist-crap.qapi} (100%)
 rename tests/qapi-schema/{qapi-schema-test.json => qapi-schema-test.qapi} (100%)
 rename tests/qapi-schema/{quoted-structural-chars.json => quoted-structural-chars.qapi} (100%)
 rename tests/qapi-schema/{redefined-builtin.json => redefined-builtin.qapi} (100%)
 rename tests/qapi-schema/{redefined-command.json => redefined-command.qapi} (100%)
 rename tests/qapi-schema/{redefined-event.json => redefined-event.qapi} (100%)
 rename tests/qapi-schema/{redefined-type.json => redefined-type.qapi} (100%)
 rename tests/qapi-schema/{reserved-command-q.json => reserved-command-q.qapi} (100%)
 rename tests/qapi-schema/{reserved-enum-q.json => reserved-enum-q.qapi} (100%)
 rename tests/qapi-schema/{reserved-member-has.json => reserved-member-has.qapi} (100%)
 rename tests/qapi-schema/{reserved-member-q.json => reserved-member-q.qapi} (100%)
 rename tests/qapi-schema/{reserved-member-u.json => reserved-member-u.qapi} (100%)
 rename tests/qapi-schema/{reserved-member-underscore.json => reserved-member-underscore.qapi} (100%)
 rename tests/qapi-schema/{reserved-type-kind.json => reserved-type-kind.qapi} (100%)
 rename tests/qapi-schema/{reserved-type-list.json => reserved-type-list.qapi} (100%)
 rename tests/qapi-schema/{returns-alternate.json => returns-alternate.qapi} (100%)
 rename tests/qapi-schema/{returns-array-bad.json => returns-array-bad.qapi} (100%)
 rename tests/qapi-schema/{returns-dict.json => returns-dict.qapi} (100%)
 rename tests/qapi-schema/{returns-unknown.json => returns-unknown.qapi} (100%)
 rename tests/qapi-schema/{returns-whitelist.json => returns-whitelist.qapi} (100%)
 rename tests/qapi-schema/{struct-base-clash-deep.json => struct-base-clash-deep.qapi} (100%)
 rename tests/qapi-schema/{struct-base-clash.json => struct-base-clash.qapi} (100%)
 rename tests/qapi-schema/{struct-data-invalid.json => struct-data-invalid.qapi} (100%)
 rename tests/qapi-schema/{struct-member-invalid.json => struct-member-invalid.qapi} (100%)
 rename tests/qapi-schema/{trailing-comma-list.json => trailing-comma-list.qapi} (100%)
 rename tests/qapi-schema/{trailing-comma-object.json => trailing-comma-object.qapi} (100%)
 rename tests/qapi-schema/{type-bypass-bad-gen.json => type-bypass-bad-gen.qapi} (100%)
 rename tests/qapi-schema/{unclosed-list.json => unclosed-list.qapi} (100%)
 rename tests/qapi-schema/{unclosed-object.json => unclosed-object.qapi} (100%)
 rename tests/qapi-schema/{unclosed-string.json => unclosed-string.qapi} (100%)
 rename tests/qapi-schema/{unicode-str.json => unicode-str.qapi} (100%)
 rename tests/qapi-schema/{union-base-empty.json => union-base-empty.qapi} (100%)
 rename tests/qapi-schema/{union-base-no-discriminator.json => union-base-no-discriminator.qapi} (100%)
 rename tests/qapi-schema/{union-branch-case.json => union-branch-case.qapi} (100%)
 rename tests/qapi-schema/{union-clash-branches.json => union-clash-branches.qapi} (100%)
 rename tests/qapi-schema/{union-empty.json => union-empty.qapi} (100%)
 rename tests/qapi-schema/{union-invalid-base.json => union-invalid-base.qapi} (100%)
 rename tests/qapi-schema/{union-optional-branch.json => union-optional-branch.qapi} (100%)
 rename tests/qapi-schema/{union-unknown.json => union-unknown.qapi} (100%)
 rename tests/qapi-schema/{unknown-escape.json => unknown-escape.qapi} (100%)
 rename tests/qapi-schema/{unknown-expr-key.json => unknown-expr-key.qapi} (100%)

-- 
2.14.3
