Received: from eggs.gnu.org ([2001:4830:134:3::10]:33022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I6M-0000MK-Ie
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I64-0001en-60
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9I63-0001e9-O7
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 19 Apr 2018 17:31:51 -0500
Message-Id: <20180419223151.623174-3-eblake@redhat.com>
In-Reply-To: <20180419223151.623174-1-eblake@redhat.com>
References: <20180419223151.623174-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] qapi: Rename .json to .qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Our QAPI input files aren't quite true JSON (comments being one obvious
difference); naming things .json doesn't make that obvious.  Use a new
suffix .qapi that makes it easy to identify our files.

This change is mostly mechanical, but it is not just a global
search-and-replace as some instances of '.json' really do refer
to JSON files, or to a URL that can't change, and so on.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to master
---
 docs/devel/blkdebug.txt                            |   2 +-
 docs/devel/qapi-code-gen.txt                       |   6 +-
 docs/devel/testing.rst                             |   4 +-
 docs/devel/writing-qmp-commands.txt                |   4 +-
 docs/interop/live-block-operations.rst             |   4 +-
 docs/interop/qmp-intro.txt                         |   2 +-
 Makefile                                           |  32 +-
 qapi/{block-core.json =3D> block-core.qapi}          |   6 +-
 qapi/{block.json =3D> block.qapi}                    |   2 +-
 qapi/{char.json =3D> char.qapi}                      |   2 +-
 qapi/{common.json =3D> common.qapi}                  |   0
 qapi/{crypto.json =3D> crypto.qapi}                  |   0
 qapi/{introspect.json =3D> introspect.qapi}          |   0
 qapi/{migration.json =3D> migration.qapi}            |   2 +-
 qapi/{misc.json =3D> misc.qapi}                      |   0
 qapi/{net.json =3D> net.qapi}                        |   2 +-
 qapi/{qga-schema.json =3D> qga-schema.qapi}          |   0
 qapi/{qmp-schema.json =3D> qmp-schema.qapi}          |  30 +-
 qapi/{rocker.json =3D> rocker.qapi}                  |   0
 qapi/{run-state.json =3D> run-state.qapi}            |   0
 qapi/{sockets.json =3D> sockets.qapi}                |   2 +-
 qapi/{tpm.json =3D> tpm.qapi}                        |   0
 qapi/{trace.json =3D> trace.qapi}                    |   0
 qapi/{transaction.json =3D> transaction.qapi}        |   2 +-
 qapi/{ui.json =3D> ui.qapi}                          |   2 +-
 include/crypto/block.h                             |   2 +-
 include/crypto/cipher.h                            |   2 +-
 include/crypto/hash.h                              |   2 +-
 include/crypto/ivgen.h                             |   2 +-
 MAINTAINERS                                        |  26 +-
 scripts/git.orderfile                              |   2 +-
 tests/Makefile.include                             | 336 ++++++++++-----=
------
 tests/qapi-schema/alternate-any.err                |   2 +-
 .../{alternate-any.json =3D> alternate-any.qapi}     |   0
 tests/qapi-schema/alternate-array.err              |   2 +-
 .../{alternate-array.json =3D> alternate-array.qapi} |   0
 tests/qapi-schema/alternate-base.err               |   2 +-
 .../{alternate-base.json =3D> alternate-base.qapi}   |   0
 tests/qapi-schema/alternate-clash.err              |   2 +-
 .../{alternate-clash.json =3D> alternate-clash.qapi} |   0
 .../qapi-schema/alternate-conflict-bool-string.err |   2 +-
 ...ng.json =3D> alternate-conflict-bool-string.qapi} |   0
 tests/qapi-schema/alternate-conflict-dict.err      |   2 +-
 ...lict-dict.json =3D> alternate-conflict-dict.qapi} |   0
 tests/qapi-schema/alternate-conflict-enum-bool.err |   2 +-
 ...bool.json =3D> alternate-conflict-enum-bool.qapi} |   0
 tests/qapi-schema/alternate-conflict-enum-int.err  |   2 +-
 ...m-int.json =3D> alternate-conflict-enum-int.qapi} |   0
 .../qapi-schema/alternate-conflict-num-string.err  |   2 +-
 ...ing.json =3D> alternate-conflict-num-string.qapi} |   0
 tests/qapi-schema/alternate-conflict-string.err    |   2 +-
 ...-string.json =3D> alternate-conflict-string.qapi} |   0
 tests/qapi-schema/alternate-empty.err              |   2 +-
 .../{alternate-empty.json =3D> alternate-empty.qapi} |   0
 tests/qapi-schema/alternate-nested.err             |   2 +-
 ...alternate-nested.json =3D> alternate-nested.qapi} |   0
 tests/qapi-schema/alternate-unknown.err            |   2 +-
 ...ternate-unknown.json =3D> alternate-unknown.qapi} |   0
 tests/qapi-schema/args-alternate.err               |   2 +-
 .../{args-alternate.json =3D> args-alternate.qapi}   |   0
 tests/qapi-schema/args-any.err                     |   2 +-
 tests/qapi-schema/{args-any.json =3D> args-any.qapi} |   0
 tests/qapi-schema/args-array-empty.err             |   2 +-
 ...args-array-empty.json =3D> args-array-empty.qapi} |   0
 tests/qapi-schema/args-array-unknown.err           |   2 +-
 ...-array-unknown.json =3D> args-array-unknown.qapi} |   0
 tests/qapi-schema/args-bad-boxed.err               |   2 +-
 .../{args-bad-boxed.json =3D> args-bad-boxed.qapi}   |   0
 tests/qapi-schema/args-boxed-anon.err              |   2 +-
 .../{args-boxed-anon.json =3D> args-boxed-anon.qapi} |   0
 tests/qapi-schema/args-boxed-empty.err             |   2 +-
 ...args-boxed-empty.json =3D> args-boxed-empty.qapi} |   0
 tests/qapi-schema/args-boxed-string.err            |   2 +-
 ...gs-boxed-string.json =3D> args-boxed-string.qapi} |   0
 tests/qapi-schema/args-int.err                     |   2 +-
 tests/qapi-schema/{args-int.json =3D> args-int.qapi} |   0
 tests/qapi-schema/args-invalid.err                 |   2 +-
 .../{args-invalid.json =3D> args-invalid.qapi}       |   0
 tests/qapi-schema/args-member-array-bad.err        |   2 +-
 ...r-array-bad.json =3D> args-member-array-bad.qapi} |   0
 tests/qapi-schema/args-member-case.err             |   2 +-
 ...args-member-case.json =3D> args-member-case.qapi} |   0
 tests/qapi-schema/args-member-unknown.err          |   2 +-
 ...ember-unknown.json =3D> args-member-unknown.qapi} |   0
 tests/qapi-schema/args-name-clash.err              |   2 +-
 .../{args-name-clash.json =3D> args-name-clash.qapi} |   0
 tests/qapi-schema/args-union.err                   |   2 +-
 .../{args-union.json =3D> args-union.qapi}           |   0
 tests/qapi-schema/args-unknown.err                 |   2 +-
 .../{args-unknown.json =3D> args-unknown.qapi}       |   0
 tests/qapi-schema/bad-base.err                     |   2 +-
 tests/qapi-schema/{bad-base.json =3D> bad-base.qapi} |   0
 tests/qapi-schema/bad-data.err                     |   2 +-
 tests/qapi-schema/{bad-data.json =3D> bad-data.qapi} |   0
 tests/qapi-schema/bad-ident.err                    |   2 +-
 .../qapi-schema/{bad-ident.json =3D> bad-ident.qapi} |   0
 tests/qapi-schema/bad-type-bool.err                |   2 +-
 .../{bad-type-bool.json =3D> bad-type-bool.qapi}     |   0
 tests/qapi-schema/bad-type-dict.err                |   2 +-
 .../{bad-type-dict.json =3D> bad-type-dict.qapi}     |   0
 tests/qapi-schema/bad-type-int.err                 |   2 +-
 .../{bad-type-int.json =3D> bad-type-int.qapi}       |   0
 tests/qapi-schema/base-cycle-direct.err            |   2 +-
 ...se-cycle-direct.json =3D> base-cycle-direct.qapi} |   0
 tests/qapi-schema/base-cycle-indirect.err          |   2 +-
 ...ycle-indirect.json =3D> base-cycle-indirect.qapi} |   0
 tests/qapi-schema/command-int.err                  |   2 +-
 .../{command-int.json =3D> command-int.qapi}         |   0
 tests/qapi-schema/comments.out                     |   2 +-
 tests/qapi-schema/{comments.json =3D> comments.qapi} |   0
 tests/qapi-schema/doc-bad-alternate-member.err     |   2 +-
 ...e-member.json =3D> doc-bad-alternate-member.qapi} |   0
 tests/qapi-schema/doc-bad-command-arg.err          |   2 +-
 ...d-command-arg.json =3D> doc-bad-command-arg.qapi} |   0
 tests/qapi-schema/doc-bad-section.out              |   2 +-
 .../{doc-bad-section.json =3D> doc-bad-section.qapi} |   0
 tests/qapi-schema/doc-bad-symbol.err               |   2 +-
 .../{doc-bad-symbol.json =3D> doc-bad-symbol.qapi}   |   0
 tests/qapi-schema/doc-bad-union-member.err         |   2 +-
 ...union-member.json =3D> doc-bad-union-member.qapi} |   0
 tests/qapi-schema/doc-before-include.err           |   2 +-
 ...before-include.json =3D> doc-before-include.qapi} |   2 +-
 tests/qapi-schema/doc-before-pragma.err            |   2 +-
 ...c-before-pragma.json =3D> doc-before-pragma.qapi} |   0
 tests/qapi-schema/doc-duplicated-arg.err           |   2 +-
 ...duplicated-arg.json =3D> doc-duplicated-arg.qapi} |   0
 tests/qapi-schema/doc-duplicated-return.err        |   2 +-
 ...ated-return.json =3D> doc-duplicated-return.qapi} |   0
 tests/qapi-schema/doc-duplicated-since.err         |   2 +-
 ...icated-since.json =3D> doc-duplicated-since.qapi} |   0
 tests/qapi-schema/doc-empty-arg.err                |   2 +-
 .../{doc-empty-arg.json =3D> doc-empty-arg.qapi}     |   0
 tests/qapi-schema/doc-empty-section.err            |   2 +-
 ...c-empty-section.json =3D> doc-empty-section.qapi} |   0
 tests/qapi-schema/doc-empty-symbol.err             |   2 +-
 ...doc-empty-symbol.json =3D> doc-empty-symbol.qapi} |   0
 tests/qapi-schema/doc-good.out                     |   2 +-
 tests/qapi-schema/{doc-good.json =3D> doc-good.qapi} |   0
 tests/qapi-schema/doc-interleaved-section.err      |   2 +-
 ...d-section.json =3D> doc-interleaved-section.qapi} |   0
 tests/qapi-schema/doc-invalid-end.err              |   2 +-
 .../{doc-invalid-end.json =3D> doc-invalid-end.qapi} |   0
 tests/qapi-schema/doc-invalid-end2.err             |   2 +-
 ...doc-invalid-end2.json =3D> doc-invalid-end2.qapi} |   0
 tests/qapi-schema/doc-invalid-return.err           |   2 +-
 ...invalid-return.json =3D> doc-invalid-return.qapi} |   0
 tests/qapi-schema/doc-invalid-section.err          |   2 +-
 ...valid-section.json =3D> doc-invalid-section.qapi} |   0
 tests/qapi-schema/doc-invalid-start.err            |   2 +-
 ...c-invalid-start.json =3D> doc-invalid-start.qapi} |   0
 tests/qapi-schema/doc-missing-colon.err            |   2 +-
 ...c-missing-colon.json =3D> doc-missing-colon.qapi} |   0
 tests/qapi-schema/doc-missing-expr.err             |   2 +-
 ...doc-missing-expr.json =3D> doc-missing-expr.qapi} |   0
 tests/qapi-schema/doc-missing-space.err            |   2 +-
 ...c-missing-space.json =3D> doc-missing-space.qapi} |   0
 tests/qapi-schema/doc-missing.err                  |   2 +-
 .../{doc-missing.json =3D> doc-missing.qapi}         |   0
 tests/qapi-schema/doc-no-symbol.err                |   2 +-
 .../{doc-no-symbol.json =3D> doc-no-symbol.qapi}     |   0
 tests/qapi-schema/double-data.err                  |   2 +-
 .../{double-data.json =3D> double-data.qapi}         |   0
 tests/qapi-schema/double-type.err                  |   2 +-
 .../{double-type.json =3D> double-type.qapi}         |   0
 tests/qapi-schema/duplicate-key.err                |   2 +-
 .../{duplicate-key.json =3D> duplicate-key.qapi}     |   0
 tests/qapi-schema/{empty.json =3D> empty.qapi}       |   0
 tests/qapi-schema/enum-bad-name.err                |   2 +-
 .../{enum-bad-name.json =3D> enum-bad-name.qapi}     |   0
 tests/qapi-schema/enum-bad-prefix.err              |   2 +-
 .../{enum-bad-prefix.json =3D> enum-bad-prefix.qapi} |   0
 tests/qapi-schema/enum-clash-member.err            |   2 +-
 ...um-clash-member.json =3D> enum-clash-member.qapi} |   0
 tests/qapi-schema/enum-dict-member.err             |   2 +-
 ...enum-dict-member.json =3D> enum-dict-member.qapi} |   0
 tests/qapi-schema/enum-int-member.err              |   2 +-
 .../{enum-int-member.json =3D> enum-int-member.qapi} |   0
 tests/qapi-schema/enum-member-case.err             |   2 +-
 ...enum-member-case.json =3D> enum-member-case.qapi} |   0
 tests/qapi-schema/enum-missing-data.err            |   2 +-
 ...um-missing-data.json =3D> enum-missing-data.qapi} |   0
 tests/qapi-schema/enum-wrong-data.err              |   2 +-
 .../{enum-wrong-data.json =3D> enum-wrong-data.qapi} |   0
 tests/qapi-schema/escape-outside-string.err        |   2 +-
 ...side-string.json =3D> escape-outside-string.qapi} |   0
 tests/qapi-schema/escape-too-big.err               |   2 +-
 .../{escape-too-big.json =3D> escape-too-big.qapi}   |   0
 tests/qapi-schema/escape-too-short.err             |   2 +-
 ...escape-too-short.json =3D> escape-too-short.qapi} |   0
 tests/qapi-schema/event-boxed-empty.err            |   2 +-
 ...ent-boxed-empty.json =3D> event-boxed-empty.qapi} |   0
 tests/qapi-schema/event-case.out                   |   2 +-
 .../{event-case.json =3D> event-case.qapi}           |   0
 tests/qapi-schema/event-nest-struct.err            |   2 +-
 ...ent-nest-struct.json =3D> event-nest-struct.qapi} |   0
 tests/qapi-schema/flat-union-array-branch.err      |   2 +-
 ...ay-branch.json =3D> flat-union-array-branch.qapi} |   0
 tests/qapi-schema/flat-union-bad-base.err          |   2 +-
 ...nion-bad-base.json =3D> flat-union-bad-base.qapi} |   0
 tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
 ...ator.json =3D> flat-union-bad-discriminator.qapi} |   0
 tests/qapi-schema/flat-union-base-any.err          |   2 +-
 ...nion-base-any.json =3D> flat-union-base-any.qapi} |   0
 tests/qapi-schema/flat-union-base-union.err        |   2 +-
 ...-base-union.json =3D> flat-union-base-union.qapi} |   0
 tests/qapi-schema/flat-union-clash-member.err      |   2 +-
 ...sh-member.json =3D> flat-union-clash-member.qapi} |   0
 tests/qapi-schema/flat-union-empty.err             |   2 +-
 ...flat-union-empty.json =3D> flat-union-empty.qapi} |   0
 tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
 ...anch.json =3D> flat-union-incomplete-branch.qapi} |   0
 tests/qapi-schema/flat-union-inline.err            |   2 +-
 ...at-union-inline.json =3D> flat-union-inline.qapi} |   0
 tests/qapi-schema/flat-union-int-branch.err        |   2 +-
 ...-int-branch.json =3D> flat-union-int-branch.qapi} |   0
 .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
 ...key.json =3D> flat-union-invalid-branch-key.qapi} |   0
 .../flat-union-invalid-discriminator.err           |   2 +-
 ....json =3D> flat-union-invalid-discriminator.qapi} |   0
 tests/qapi-schema/flat-union-no-base.err           |   2 +-
 ...-union-no-base.json =3D> flat-union-no-base.qapi} |   0
 .../flat-union-optional-discriminator.err          |   2 +-
 ...json =3D> flat-union-optional-discriminator.qapi} |   0
 .../flat-union-string-discriminator.err            |   2 +-
 ...r.json =3D> flat-union-string-discriminator.qapi} |   0
 tests/qapi-schema/funny-char.err                   |   2 +-
 .../{funny-char.json =3D> funny-char.qapi}           |   0
 tests/qapi-schema/ident-with-escape.out            |   2 +-
 ...ent-with-escape.json =3D> ident-with-escape.qapi} |   0
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
 ...include-non-file.json =3D> include-non-file.qapi} |   0
 ...e-relpath-sub.json =3D> include-relpath-sub.qapi} |   0
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
 ...ude-simple-sub.json =3D> include-simple-sub.qapi} |   0
 tests/qapi-schema/include-simple.json              |   1 -
 tests/qapi-schema/include-simple.out               |   6 +-
 tests/qapi-schema/include-simple.qapi              |   1 +
 tests/qapi-schema/include/relpath.json             |   1 -
 tests/qapi-schema/include/relpath.qapi             |   1 +
 tests/qapi-schema/indented-expr.out                |   2 +-
 .../{indented-expr.json =3D> indented-expr.qapi}     |   0
 tests/qapi-schema/leading-comma-list.err           |   2 +-
 ...ing-comma-list.json =3D> leading-comma-list.qapi} |   0
 tests/qapi-schema/leading-comma-object.err         |   2 +-
 ...comma-object.json =3D> leading-comma-object.qapi} |   0
 tests/qapi-schema/missing-colon.err                |   2 +-
 .../{missing-colon.json =3D> missing-colon.qapi}     |   0
 tests/qapi-schema/missing-comma-list.err           |   2 +-
 ...ing-comma-list.json =3D> missing-comma-list.qapi} |   0
 tests/qapi-schema/missing-comma-object.err         |   2 +-
 ...comma-object.json =3D> missing-comma-object.qapi} |   0
 tests/qapi-schema/missing-type.err                 |   2 +-
 .../{missing-type.json =3D> missing-type.qapi}       |   0
 tests/qapi-schema/nested-struct-data.err           |   2 +-
 ...ed-struct-data.json =3D> nested-struct-data.qapi} |   0
 tests/qapi-schema/non-objects.err                  |   2 +-
 .../{non-objects.json =3D> non-objects.qapi}         |   0
 tests/qapi-schema/oob-test.err                     |   2 +-
 tests/qapi-schema/{oob-test.json =3D> oob-test.qapi} |   0
 tests/qapi-schema/pragma-doc-required-crap.err     |   2 +-
 ...red-crap.json =3D> pragma-doc-required-crap.qapi} |   0
 tests/qapi-schema/pragma-extra-junk.err            |   2 +-
 ...agma-extra-junk.json =3D> pragma-extra-junk.qapi} |   0
 .../pragma-name-case-whitelist-crap.err            |   2 +-
 ...p.json =3D> pragma-name-case-whitelist-crap.qapi} |   0
 tests/qapi-schema/pragma-non-dict.err              |   2 +-
 .../{pragma-non-dict.json =3D> pragma-non-dict.qapi} |   0
 .../qapi-schema/pragma-returns-whitelist-crap.err  |   2 +-
 ...rap.json =3D> pragma-returns-whitelist-crap.qapi} |   0
 tests/qapi-schema/qapi-schema-test.out             |   2 +-
 ...qapi-schema-test.json =3D> qapi-schema-test.qapi} |   0
 tests/qapi-schema/quoted-structural-chars.err      |   2 +-
 ...ral-chars.json =3D> quoted-structural-chars.qapi} |   0
 tests/qapi-schema/redefined-builtin.err            |   2 +-
 ...defined-builtin.json =3D> redefined-builtin.qapi} |   0
 tests/qapi-schema/redefined-command.err            |   2 +-
 ...defined-command.json =3D> redefined-command.qapi} |   0
 tests/qapi-schema/redefined-event.err              |   2 +-
 .../{redefined-event.json =3D> redefined-event.qapi} |   0
 tests/qapi-schema/redefined-type.err               |   2 +-
 .../{redefined-type.json =3D> redefined-type.qapi}   |   0
 tests/qapi-schema/reserved-command-q.err           |   2 +-
 ...rved-command-q.json =3D> reserved-command-q.qapi} |   0
 tests/qapi-schema/reserved-enum-q.err              |   2 +-
 .../{reserved-enum-q.json =3D> reserved-enum-q.qapi} |   0
 tests/qapi-schema/reserved-member-has.err          |   2 +-
 ...ed-member-has.json =3D> reserved-member-has.qapi} |   0
 tests/qapi-schema/reserved-member-q.err            |   2 +-
 ...served-member-q.json =3D> reserved-member-q.qapi} |   0
 tests/qapi-schema/reserved-member-u.err            |   2 +-
 ...served-member-u.json =3D> reserved-member-u.qapi} |   0
 tests/qapi-schema/reserved-member-underscore.err   |   2 +-
 ...rscore.json =3D> reserved-member-underscore.qapi} |   0
 tests/qapi-schema/reserved-type-kind.err           |   2 +-
 ...rved-type-kind.json =3D> reserved-type-kind.qapi} |   0
 tests/qapi-schema/reserved-type-list.err           |   2 +-
 ...rved-type-list.json =3D> reserved-type-list.qapi} |   0
 tests/qapi-schema/returns-alternate.err            |   2 +-
 ...turns-alternate.json =3D> returns-alternate.qapi} |   0
 tests/qapi-schema/returns-array-bad.err            |   2 +-
 ...turns-array-bad.json =3D> returns-array-bad.qapi} |   0
 tests/qapi-schema/returns-dict.err                 |   2 +-
 .../{returns-dict.json =3D> returns-dict.qapi}       |   0
 tests/qapi-schema/returns-unknown.err              |   2 +-
 .../{returns-unknown.json =3D> returns-unknown.qapi} |   0
 tests/qapi-schema/returns-whitelist.err            |   2 +-
 ...turns-whitelist.json =3D> returns-whitelist.qapi} |   0
 tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
 ...clash-deep.json =3D> struct-base-clash-deep.qapi} |   0
 tests/qapi-schema/struct-base-clash.err            |   2 +-
 ...ruct-base-clash.json =3D> struct-base-clash.qapi} |   0
 tests/qapi-schema/struct-data-invalid.err          |   2 +-
 ...-data-invalid.json =3D> struct-data-invalid.qapi} |   0
 tests/qapi-schema/struct-member-invalid.err        |   2 +-
 ...ber-invalid.json =3D> struct-member-invalid.qapi} |   0
 tests/qapi-schema/trailing-comma-list.err          |   2 +-
 ...ng-comma-list.json =3D> trailing-comma-list.qapi} |   0
 tests/qapi-schema/trailing-comma-object.err        |   2 +-
 ...omma-object.json =3D> trailing-comma-object.qapi} |   0
 tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
 ...ypass-bad-gen.json =3D> type-bypass-bad-gen.qapi} |   0
 tests/qapi-schema/unclosed-list.err                |   2 +-
 .../{unclosed-list.json =3D> unclosed-list.qapi}     |   0
 tests/qapi-schema/unclosed-object.err              |   2 +-
 .../{unclosed-object.json =3D> unclosed-object.qapi} |   0
 tests/qapi-schema/unclosed-string.err              |   2 +-
 .../{unclosed-string.json =3D> unclosed-string.qapi} |   0
 tests/qapi-schema/unicode-str.err                  |   2 +-
 .../{unicode-str.json =3D> unicode-str.qapi}         |   0
 tests/qapi-schema/union-base-empty.err             |   2 +-
 ...union-base-empty.json =3D> union-base-empty.qapi} |   0
 tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
 ...nator.json =3D> union-base-no-discriminator.qapi} |   0
 tests/qapi-schema/union-branch-case.err            |   2 +-
 ...ion-branch-case.json =3D> union-branch-case.qapi} |   0
 tests/qapi-schema/union-clash-branches.err         |   2 +-
 ...ash-branches.json =3D> union-clash-branches.qapi} |   0
 tests/qapi-schema/union-empty.err                  |   2 +-
 .../{union-empty.json =3D> union-empty.qapi}         |   0
 tests/qapi-schema/union-invalid-base.err           |   2 +-
 ...n-invalid-base.json =3D> union-invalid-base.qapi} |   0
 tests/qapi-schema/union-optional-branch.err        |   2 +-
 ...onal-branch.json =3D> union-optional-branch.qapi} |   0
 tests/qapi-schema/union-unknown.err                |   2 +-
 .../{union-unknown.json =3D> union-unknown.qapi}     |   0
 tests/qapi-schema/unknown-escape.err               |   2 +-
 .../{unknown-escape.json =3D> unknown-escape.qapi}   |   0
 tests/qapi-schema/unknown-expr-key.err             |   2 +-
 ...unknown-expr-key.json =3D> unknown-expr-key.qapi} |   0
 381 files changed, 442 insertions(+), 442 deletions(-)
 rename qapi/{block-core.json =3D> block-core.qapi} (99%)
 rename qapi/{block.json =3D> block.qapi} (99%)
 rename qapi/{char.json =3D> char.qapi} (99%)
 rename qapi/{common.json =3D> common.qapi} (100%)
 rename qapi/{crypto.json =3D> crypto.qapi} (100%)
 rename qapi/{introspect.json =3D> introspect.qapi} (100%)
 rename qapi/{migration.json =3D> migration.qapi} (99%)
 rename qapi/{misc.json =3D> misc.qapi} (100%)
 rename qapi/{net.json =3D> net.qapi} (99%)
 rename qapi/{qga-schema.json =3D> qga-schema.qapi} (100%)
 rename qapi/{qmp-schema.json =3D> qmp-schema.qapi} (88%)
 rename qapi/{rocker.json =3D> rocker.qapi} (100%)
 rename qapi/{run-state.json =3D> run-state.qapi} (100%)
 rename qapi/{sockets.json =3D> sockets.qapi} (99%)
 rename qapi/{tpm.json =3D> tpm.qapi} (100%)
 rename qapi/{trace.json =3D> trace.qapi} (100%)
 rename qapi/{transaction.json =3D> transaction.qapi} (99%)
 rename qapi/{ui.json =3D> ui.qapi} (99%)
 rename tests/qapi-schema/{alternate-any.json =3D> alternate-any.qapi} (1=
00%)
 rename tests/qapi-schema/{alternate-array.json =3D> alternate-array.qapi=
} (100%)
 rename tests/qapi-schema/{alternate-base.json =3D> alternate-base.qapi} =
(100%)
 rename tests/qapi-schema/{alternate-clash.json =3D> alternate-clash.qapi=
} (100%)
 rename tests/qapi-schema/{alternate-conflict-bool-string.json =3D> alter=
nate-conflict-bool-string.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-dict.json =3D> alternate-co=
nflict-dict.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-enum-bool.json =3D> alterna=
te-conflict-enum-bool.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-enum-int.json =3D> alternat=
e-conflict-enum-int.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-num-string.json =3D> altern=
ate-conflict-num-string.qapi} (100%)
 rename tests/qapi-schema/{alternate-conflict-string.json =3D> alternate-=
conflict-string.qapi} (100%)
 rename tests/qapi-schema/{alternate-empty.json =3D> alternate-empty.qapi=
} (100%)
 rename tests/qapi-schema/{alternate-nested.json =3D> alternate-nested.qa=
pi} (100%)
 rename tests/qapi-schema/{alternate-unknown.json =3D> alternate-unknown.=
qapi} (100%)
 rename tests/qapi-schema/{args-alternate.json =3D> args-alternate.qapi} =
(100%)
 rename tests/qapi-schema/{args-any.json =3D> args-any.qapi} (100%)
 rename tests/qapi-schema/{args-array-empty.json =3D> args-array-empty.qa=
pi} (100%)
 rename tests/qapi-schema/{args-array-unknown.json =3D> args-array-unknow=
n.qapi} (100%)
 rename tests/qapi-schema/{args-bad-boxed.json =3D> args-bad-boxed.qapi} =
(100%)
 rename tests/qapi-schema/{args-boxed-anon.json =3D> args-boxed-anon.qapi=
} (100%)
 rename tests/qapi-schema/{args-boxed-empty.json =3D> args-boxed-empty.qa=
pi} (100%)
 rename tests/qapi-schema/{args-boxed-string.json =3D> args-boxed-string.=
qapi} (100%)
 rename tests/qapi-schema/{args-int.json =3D> args-int.qapi} (100%)
 rename tests/qapi-schema/{args-invalid.json =3D> args-invalid.qapi} (100=
%)
 rename tests/qapi-schema/{args-member-array-bad.json =3D> args-member-ar=
ray-bad.qapi} (100%)
 rename tests/qapi-schema/{args-member-case.json =3D> args-member-case.qa=
pi} (100%)
 rename tests/qapi-schema/{args-member-unknown.json =3D> args-member-unkn=
own.qapi} (100%)
 rename tests/qapi-schema/{args-name-clash.json =3D> args-name-clash.qapi=
} (100%)
 rename tests/qapi-schema/{args-union.json =3D> args-union.qapi} (100%)
 rename tests/qapi-schema/{args-unknown.json =3D> args-unknown.qapi} (100=
%)
 rename tests/qapi-schema/{bad-base.json =3D> bad-base.qapi} (100%)
 rename tests/qapi-schema/{bad-data.json =3D> bad-data.qapi} (100%)
 rename tests/qapi-schema/{bad-ident.json =3D> bad-ident.qapi} (100%)
 rename tests/qapi-schema/{bad-type-bool.json =3D> bad-type-bool.qapi} (1=
00%)
 rename tests/qapi-schema/{bad-type-dict.json =3D> bad-type-dict.qapi} (1=
00%)
 rename tests/qapi-schema/{bad-type-int.json =3D> bad-type-int.qapi} (100=
%)
 rename tests/qapi-schema/{base-cycle-direct.json =3D> base-cycle-direct.=
qapi} (100%)
 rename tests/qapi-schema/{base-cycle-indirect.json =3D> base-cycle-indir=
ect.qapi} (100%)
 rename tests/qapi-schema/{command-int.json =3D> command-int.qapi} (100%)
 rename tests/qapi-schema/{comments.json =3D> comments.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-alternate-member.json =3D> doc-bad-alt=
ernate-member.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-command-arg.json =3D> doc-bad-command-=
arg.qapi} (100%)
 rename tests/qapi-schema/{doc-bad-section.json =3D> doc-bad-section.qapi=
} (100%)
 rename tests/qapi-schema/{doc-bad-symbol.json =3D> doc-bad-symbol.qapi} =
(100%)
 rename tests/qapi-schema/{doc-bad-union-member.json =3D> doc-bad-union-m=
ember.qapi} (100%)
 rename tests/qapi-schema/{doc-before-include.json =3D> doc-before-includ=
e.qapi} (81%)
 rename tests/qapi-schema/{doc-before-pragma.json =3D> doc-before-pragma.=
qapi} (100%)
 rename tests/qapi-schema/{doc-duplicated-arg.json =3D> doc-duplicated-ar=
g.qapi} (100%)
 rename tests/qapi-schema/{doc-duplicated-return.json =3D> doc-duplicated=
-return.qapi} (100%)
 rename tests/qapi-schema/{doc-duplicated-since.json =3D> doc-duplicated-=
since.qapi} (100%)
 rename tests/qapi-schema/{doc-empty-arg.json =3D> doc-empty-arg.qapi} (1=
00%)
 rename tests/qapi-schema/{doc-empty-section.json =3D> doc-empty-section.=
qapi} (100%)
 rename tests/qapi-schema/{doc-empty-symbol.json =3D> doc-empty-symbol.qa=
pi} (100%)
 rename tests/qapi-schema/{doc-good.json =3D> doc-good.qapi} (100%)
 rename tests/qapi-schema/{doc-interleaved-section.json =3D> doc-interlea=
ved-section.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-end.json =3D> doc-invalid-end.qapi=
} (100%)
 rename tests/qapi-schema/{doc-invalid-end2.json =3D> doc-invalid-end2.qa=
pi} (100%)
 rename tests/qapi-schema/{doc-invalid-return.json =3D> doc-invalid-retur=
n.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-section.json =3D> doc-invalid-sect=
ion.qapi} (100%)
 rename tests/qapi-schema/{doc-invalid-start.json =3D> doc-invalid-start.=
qapi} (100%)
 rename tests/qapi-schema/{doc-missing-colon.json =3D> doc-missing-colon.=
qapi} (100%)
 rename tests/qapi-schema/{doc-missing-expr.json =3D> doc-missing-expr.qa=
pi} (100%)
 rename tests/qapi-schema/{doc-missing-space.json =3D> doc-missing-space.=
qapi} (100%)
 rename tests/qapi-schema/{doc-missing.json =3D> doc-missing.qapi} (100%)
 rename tests/qapi-schema/{doc-no-symbol.json =3D> doc-no-symbol.qapi} (1=
00%)
 rename tests/qapi-schema/{double-data.json =3D> double-data.qapi} (100%)
 rename tests/qapi-schema/{double-type.json =3D> double-type.qapi} (100%)
 rename tests/qapi-schema/{duplicate-key.json =3D> duplicate-key.qapi} (1=
00%)
 rename tests/qapi-schema/{empty.json =3D> empty.qapi} (100%)
 rename tests/qapi-schema/{enum-bad-name.json =3D> enum-bad-name.qapi} (1=
00%)
 rename tests/qapi-schema/{enum-bad-prefix.json =3D> enum-bad-prefix.qapi=
} (100%)
 rename tests/qapi-schema/{enum-clash-member.json =3D> enum-clash-member.=
qapi} (100%)
 rename tests/qapi-schema/{enum-dict-member.json =3D> enum-dict-member.qa=
pi} (100%)
 rename tests/qapi-schema/{enum-int-member.json =3D> enum-int-member.qapi=
} (100%)
 rename tests/qapi-schema/{enum-member-case.json =3D> enum-member-case.qa=
pi} (100%)
 rename tests/qapi-schema/{enum-missing-data.json =3D> enum-missing-data.=
qapi} (100%)
 rename tests/qapi-schema/{enum-wrong-data.json =3D> enum-wrong-data.qapi=
} (100%)
 rename tests/qapi-schema/{escape-outside-string.json =3D> escape-outside=
-string.qapi} (100%)
 rename tests/qapi-schema/{escape-too-big.json =3D> escape-too-big.qapi} =
(100%)
 rename tests/qapi-schema/{escape-too-short.json =3D> escape-too-short.qa=
pi} (100%)
 rename tests/qapi-schema/{event-boxed-empty.json =3D> event-boxed-empty.=
qapi} (100%)
 rename tests/qapi-schema/{event-case.json =3D> event-case.qapi} (100%)
 rename tests/qapi-schema/{event-nest-struct.json =3D> event-nest-struct.=
qapi} (100%)
 rename tests/qapi-schema/{flat-union-array-branch.json =3D> flat-union-a=
rray-branch.qapi} (100%)
 rename tests/qapi-schema/{flat-union-bad-base.json =3D> flat-union-bad-b=
ase.qapi} (100%)
 rename tests/qapi-schema/{flat-union-bad-discriminator.json =3D> flat-un=
ion-bad-discriminator.qapi} (100%)
 rename tests/qapi-schema/{flat-union-base-any.json =3D> flat-union-base-=
any.qapi} (100%)
 rename tests/qapi-schema/{flat-union-base-union.json =3D> flat-union-bas=
e-union.qapi} (100%)
 rename tests/qapi-schema/{flat-union-clash-member.json =3D> flat-union-c=
lash-member.qapi} (100%)
 rename tests/qapi-schema/{flat-union-empty.json =3D> flat-union-empty.qa=
pi} (100%)
 rename tests/qapi-schema/{flat-union-incomplete-branch.json =3D> flat-un=
ion-incomplete-branch.qapi} (100%)
 rename tests/qapi-schema/{flat-union-inline.json =3D> flat-union-inline.=
qapi} (100%)
 rename tests/qapi-schema/{flat-union-int-branch.json =3D> flat-union-int=
-branch.qapi} (100%)
 rename tests/qapi-schema/{flat-union-invalid-branch-key.json =3D> flat-u=
nion-invalid-branch-key.qapi} (100%)
 rename tests/qapi-schema/{flat-union-invalid-discriminator.json =3D> fla=
t-union-invalid-discriminator.qapi} (100%)
 rename tests/qapi-schema/{flat-union-no-base.json =3D> flat-union-no-bas=
e.qapi} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.json =3D> fl=
at-union-optional-discriminator.qapi} (100%)
 rename tests/qapi-schema/{flat-union-string-discriminator.json =3D> flat=
-union-string-discriminator.qapi} (100%)
 rename tests/qapi-schema/{funny-char.json =3D> funny-char.qapi} (100%)
 rename tests/qapi-schema/{ident-with-escape.json =3D> ident-with-escape.=
qapi} (100%)
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
 rename tests/qapi-schema/{include-non-file.json =3D> include-non-file.qa=
pi} (100%)
 rename tests/qapi-schema/{include-relpath-sub.json =3D> include-relpath-=
sub.qapi} (100%)
 delete mode 100644 tests/qapi-schema/include-relpath.json
 create mode 100644 tests/qapi-schema/include-relpath.qapi
 delete mode 100644 tests/qapi-schema/include-repetition-sub.json
 create mode 100644 tests/qapi-schema/include-repetition-sub.qapi
 delete mode 100644 tests/qapi-schema/include-repetition.json
 create mode 100644 tests/qapi-schema/include-repetition.qapi
 delete mode 100644 tests/qapi-schema/include-self-cycle.json
 create mode 100644 tests/qapi-schema/include-self-cycle.qapi
 rename tests/qapi-schema/{include-simple-sub.json =3D> include-simple-su=
b.qapi} (100%)
 delete mode 100644 tests/qapi-schema/include-simple.json
 create mode 100644 tests/qapi-schema/include-simple.qapi
 delete mode 100644 tests/qapi-schema/include/relpath.json
 create mode 100644 tests/qapi-schema/include/relpath.qapi
 rename tests/qapi-schema/{indented-expr.json =3D> indented-expr.qapi} (1=
00%)
 rename tests/qapi-schema/{leading-comma-list.json =3D> leading-comma-lis=
t.qapi} (100%)
 rename tests/qapi-schema/{leading-comma-object.json =3D> leading-comma-o=
bject.qapi} (100%)
 rename tests/qapi-schema/{missing-colon.json =3D> missing-colon.qapi} (1=
00%)
 rename tests/qapi-schema/{missing-comma-list.json =3D> missing-comma-lis=
t.qapi} (100%)
 rename tests/qapi-schema/{missing-comma-object.json =3D> missing-comma-o=
bject.qapi} (100%)
 rename tests/qapi-schema/{missing-type.json =3D> missing-type.qapi} (100=
%)
 rename tests/qapi-schema/{nested-struct-data.json =3D> nested-struct-dat=
a.qapi} (100%)
 rename tests/qapi-schema/{non-objects.json =3D> non-objects.qapi} (100%)
 rename tests/qapi-schema/{oob-test.json =3D> oob-test.qapi} (100%)
 rename tests/qapi-schema/{pragma-doc-required-crap.json =3D> pragma-doc-=
required-crap.qapi} (100%)
 rename tests/qapi-schema/{pragma-extra-junk.json =3D> pragma-extra-junk.=
qapi} (100%)
 rename tests/qapi-schema/{pragma-name-case-whitelist-crap.json =3D> prag=
ma-name-case-whitelist-crap.qapi} (100%)
 rename tests/qapi-schema/{pragma-non-dict.json =3D> pragma-non-dict.qapi=
} (100%)
 rename tests/qapi-schema/{pragma-returns-whitelist-crap.json =3D> pragma=
-returns-whitelist-crap.qapi} (100%)
 rename tests/qapi-schema/{qapi-schema-test.json =3D> qapi-schema-test.qa=
pi} (100%)
 rename tests/qapi-schema/{quoted-structural-chars.json =3D> quoted-struc=
tural-chars.qapi} (100%)
 rename tests/qapi-schema/{redefined-builtin.json =3D> redefined-builtin.=
qapi} (100%)
 rename tests/qapi-schema/{redefined-command.json =3D> redefined-command.=
qapi} (100%)
 rename tests/qapi-schema/{redefined-event.json =3D> redefined-event.qapi=
} (100%)
 rename tests/qapi-schema/{redefined-type.json =3D> redefined-type.qapi} =
(100%)
 rename tests/qapi-schema/{reserved-command-q.json =3D> reserved-command-=
q.qapi} (100%)
 rename tests/qapi-schema/{reserved-enum-q.json =3D> reserved-enum-q.qapi=
} (100%)
 rename tests/qapi-schema/{reserved-member-has.json =3D> reserved-member-=
has.qapi} (100%)
 rename tests/qapi-schema/{reserved-member-q.json =3D> reserved-member-q.=
qapi} (100%)
 rename tests/qapi-schema/{reserved-member-u.json =3D> reserved-member-u.=
qapi} (100%)
 rename tests/qapi-schema/{reserved-member-underscore.json =3D> reserved-=
member-underscore.qapi} (100%)
 rename tests/qapi-schema/{reserved-type-kind.json =3D> reserved-type-kin=
d.qapi} (100%)
 rename tests/qapi-schema/{reserved-type-list.json =3D> reserved-type-lis=
t.qapi} (100%)
 rename tests/qapi-schema/{returns-alternate.json =3D> returns-alternate.=
qapi} (100%)
 rename tests/qapi-schema/{returns-array-bad.json =3D> returns-array-bad.=
qapi} (100%)
 rename tests/qapi-schema/{returns-dict.json =3D> returns-dict.qapi} (100=
%)
 rename tests/qapi-schema/{returns-unknown.json =3D> returns-unknown.qapi=
} (100%)
 rename tests/qapi-schema/{returns-whitelist.json =3D> returns-whitelist.=
qapi} (100%)
 rename tests/qapi-schema/{struct-base-clash-deep.json =3D> struct-base-c=
lash-deep.qapi} (100%)
 rename tests/qapi-schema/{struct-base-clash.json =3D> struct-base-clash.=
qapi} (100%)
 rename tests/qapi-schema/{struct-data-invalid.json =3D> struct-data-inva=
lid.qapi} (100%)
 rename tests/qapi-schema/{struct-member-invalid.json =3D> struct-member-=
invalid.qapi} (100%)
 rename tests/qapi-schema/{trailing-comma-list.json =3D> trailing-comma-l=
ist.qapi} (100%)
 rename tests/qapi-schema/{trailing-comma-object.json =3D> trailing-comma=
-object.qapi} (100%)
 rename tests/qapi-schema/{type-bypass-bad-gen.json =3D> type-bypass-bad-=
gen.qapi} (100%)
 rename tests/qapi-schema/{unclosed-list.json =3D> unclosed-list.qapi} (1=
00%)
 rename tests/qapi-schema/{unclosed-object.json =3D> unclosed-object.qapi=
} (100%)
 rename tests/qapi-schema/{unclosed-string.json =3D> unclosed-string.qapi=
} (100%)
 rename tests/qapi-schema/{unicode-str.json =3D> unicode-str.qapi} (100%)
 rename tests/qapi-schema/{union-base-empty.json =3D> union-base-empty.qa=
pi} (100%)
 rename tests/qapi-schema/{union-base-no-discriminator.json =3D> union-ba=
se-no-discriminator.qapi} (100%)
 rename tests/qapi-schema/{union-branch-case.json =3D> union-branch-case.=
qapi} (100%)
 rename tests/qapi-schema/{union-clash-branches.json =3D> union-clash-bra=
nches.qapi} (100%)
 rename tests/qapi-schema/{union-empty.json =3D> union-empty.qapi} (100%)
 rename tests/qapi-schema/{union-invalid-base.json =3D> union-invalid-bas=
e.qapi} (100%)
 rename tests/qapi-schema/{union-optional-branch.json =3D> union-optional=
-branch.qapi} (100%)
 rename tests/qapi-schema/{union-unknown.json =3D> union-unknown.qapi} (1=
00%)
 rename tests/qapi-schema/{unknown-escape.json =3D> unknown-escape.qapi} =
(100%)
 rename tests/qapi-schema/{unknown-expr-key.json =3D> unknown-expr-key.qa=
pi} (100%)

diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
index 43d8e8f9c63..33b56daad1b 100644
--- a/docs/devel/blkdebug.txt
+++ b/docs/devel/blkdebug.txt
@@ -92,7 +92,7 @@ The core events are:

   flush_to_disk - flush the host block device's disk cache

-See qapi/block-core.json:BlkdebugEvent for the full list of events.
+See qapi/block-core.qapi:BlkdebugEvent for the full list of events.
 You may need to grep block driver source code to understand the
 meaning of specific events.

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index a569d247455..4a5af251269 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -293,7 +293,7 @@ Usage: { 'include': STRING }

 The QAPI schema definitions can be modularized using the 'include' direc=
tive:

- { 'include': 'path/to/file.json' }
+ { 'include': 'path/to/file.qapi' }

 The directive is evaluated recursively, and include paths are relative t=
o the
 file using the directive. Multiple includes of the same file are
@@ -961,7 +961,7 @@ list of that type as a parameter, and returns a singl=
e element of that
 type.  The user is responsible for writing the implementation of
 qmp_my_command(); everything else is produced by the generator.

-    $ cat example-schema.json
+    $ cat example-schema.qapi
     { 'struct': 'UserDefOne',
       'data': { 'integer': 'int', '*string': 'str' } }

@@ -977,7 +977,7 @@ We run qapi-gen.py like this:
     --prefix=3D"example-" example-schema.json

 For a more thorough look at generated code, the testsuite includes
-tests/qapi-schema/qapi-schema-tests.json that covers more examples of
+tests/qapi-schema/qapi-schema-tests.qapi that covers more examples of
 what the generator will accept, and compiles the resulting C code as
 part of 'make check-unit'.

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 0ca1a2d4b58..b7a1211591c 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -132,7 +132,7 @@ output.
 The input/output data is managed under the ``tests/qapi-schema`` directo=
ry.
 Each test case includes four files that have a common base name:

-  * ``${casename}.json`` - the file contains the JSON input for feeding =
the
+  * ``${casename}.qapi`` - the file contains the JSON input for feeding =
the
     parser
   * ``${casename}.out`` - the file contains the expected stdout from the=
 parser
   * ``${casename}.err`` - the file contains the expected stderr from the=
 parser
@@ -147,7 +147,7 @@ parser (either fixing a bug or extending/modifying th=
e syntax). To do this:

 2. Add the new test in ``tests/Makefile.include``. For example:

-  ``qapi-schema +=3D foo.json``
+  ``qapi-schema +=3D foo.qapi``

 check-block
 -----------
diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index 1cd3dbf48ac..056b9fa081f 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -89,7 +89,7 @@ Our command will be called "hello-world". It takes no a=
rguments, nor does it
 return any data.

 The first step is defining the command in the appropriate QAPI schema
-module.  We pick module qapi/misc.json, and add the following line at
+module.  We pick module qapi/misc.qapi, and add the following line at
 the bottom:

 { 'command': 'hello-world' }
@@ -239,7 +239,7 @@ There's only one step missing to make "hello-world"'s=
 implementation complete,
 and that's its documentation in the schema file.

 There are many examples of such documentation in the schema file already=
, but
-here goes "hello-world"'s new entry for qapi/misc.json:
+here goes "hello-world"'s new entry for qapi/misc.qapi:

 ##
 # @hello-world
diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-b=
lock-operations.rst
index 734252bc804..f2967ad9514 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -20,7 +20,7 @@ primitives, and some (non-exhaustive list of) examples =
to illustrate
 their use.

 .. note::
-    The file ``qapi/block-core.json`` in the QEMU source tree has the
+    The file ``qapi/block-core.qapi`` in the QEMU source tree has the
     canonical QEMU API (QAPI) schema documentation for the QMP
     primitives discussed here.

@@ -54,7 +54,7 @@ files in a disk image backing chain:
 (1) Directional: 'base' and 'top'.  Given the simple disk image chain
     above, image [A] can be referred to as 'base', and image [B] as
     'top'.  (This terminology can be seen in in QAPI schema file,
-    block-core.json.)
+    block-core.qapi.)

 (2) Relational: 'backing file' and 'overlay'.  Again, taking the same
     simple disk image chain from the above, disk image [A] is referred
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index 19ac6c573b6..705ee520073 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -79,7 +79,7 @@ Escape character is '^]'.
 }

 Please refer to docs/interop/qemu-qmp-ref.* for a complete command
-reference, generated from qapi/qmp-schema.json.
+reference, generated from qapi/qmp-schema.qapi.

 QMP wiki page
 -------------
diff --git a/Makefile b/Makefile
index f5c2ace8b30..428ac423fba 100644
--- a/Makefile
+++ b/Makefile
@@ -571,27 +571,27 @@ qga/qapi-generated/qga-qapi-visit.c qga/qapi-genera=
ted/qga-qapi-visit.h \
 qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-comma=
nds.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qga-gen-timestamp ;
-qga/qapi-generated/qga-gen-timestamp: $(SRC_PATH)/qapi/qga-schema.json $=
(qapi-py)
+qga/qapi-generated/qga-gen-timestamp: $(SRC_PATH)/qapi/qga-schema.qapi $=
(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$(@:%-timestamp=3D%)")
 	@>$@

-qmp-modules =3D $(SRC_PATH)/qapi/qmp-schema.json $(SRC_PATH)/qapi/common=
.json \
-               $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
-               $(SRC_PATH)/qapi/char.json \
-               $(SRC_PATH)/qapi/crypto.json \
-               $(SRC_PATH)/qapi/introspect.json \
-               $(SRC_PATH)/qapi/migration.json \
-               $(SRC_PATH)/qapi/misc.json \
-               $(SRC_PATH)/qapi/net.json \
-               $(SRC_PATH)/qapi/rocker.json \
-               $(SRC_PATH)/qapi/run-state.json \
-               $(SRC_PATH)/qapi/sockets.json \
-               $(SRC_PATH)/qapi/tpm.json \
-               $(SRC_PATH)/qapi/trace.json \
-               $(SRC_PATH)/qapi/transaction.json \
-               $(SRC_PATH)/qapi/ui.json
+qmp-modules =3D $(SRC_PATH)/qapi/qmp-schema.qapi $(SRC_PATH)/qapi/common=
.qapi \
+               $(SRC_PATH)/qapi/block.qapi $(SRC_PATH)/qapi/block-core.q=
api \
+               $(SRC_PATH)/qapi/char.qapi \
+               $(SRC_PATH)/qapi/crypto.qapi \
+               $(SRC_PATH)/qapi/introspect.qapi \
+               $(SRC_PATH)/qapi/migration.qapi \
+               $(SRC_PATH)/qapi/misc.qapi \
+               $(SRC_PATH)/qapi/net.qapi \
+               $(SRC_PATH)/qapi/rocker.qapi \
+               $(SRC_PATH)/qapi/run-state.qapi \
+               $(SRC_PATH)/qapi/sockets.qapi \
+               $(SRC_PATH)/qapi/tpm.qapi \
+               $(SRC_PATH)/qapi/trace.qapi \
+               $(SRC_PATH)/qapi/transaction.qapi \
+               $(SRC_PATH)/qapi/ui.qapi

 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
 qapi/qapi-types.c qapi/qapi-types.h \
diff --git a/qapi/block-core.json b/qapi/block-core.qapi
similarity index 99%
rename from qapi/block-core.json
rename to qapi/block-core.qapi
index c50517bff31..228060a137c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.qapi
@@ -4,9 +4,9 @@
 # =3D=3D Block core (VM unrelated)
 ##

-{ 'include': 'common.json' }
-{ 'include': 'crypto.json' }
-{ 'include': 'sockets.json' }
+{ 'include': 'common.qapi' }
+{ 'include': 'crypto.qapi' }
+{ 'include': 'sockets.qapi' }

 ##
 # @SnapshotInfo:
diff --git a/qapi/block.json b/qapi/block.qapi
similarity index 99%
rename from qapi/block.json
rename to qapi/block.qapi
index c6945240029..da85ef68886 100644
--- a/qapi/block.json
+++ b/qapi/block.qapi
@@ -4,7 +4,7 @@
 # =3D Block devices
 ##

-{ 'include': 'block-core.json' }
+{ 'include': 'block-core.qapi' }

 ##
 # =3D=3D Additional block stuff (VM related)
diff --git a/qapi/char.json b/qapi/char.qapi
similarity index 99%
rename from qapi/char.json
rename to qapi/char.qapi
index ae19dcd1ed1..45901fb4502 100644
--- a/qapi/char.json
+++ b/qapi/char.qapi
@@ -5,7 +5,7 @@
 # =3D Character devices
 ##

-{ 'include': 'sockets.json' }
+{ 'include': 'sockets.qapi' }

 ##
 # @ChardevInfo:
diff --git a/qapi/common.json b/qapi/common.qapi
similarity index 100%
rename from qapi/common.json
rename to qapi/common.qapi
diff --git a/qapi/crypto.json b/qapi/crypto.qapi
similarity index 100%
rename from qapi/crypto.json
rename to qapi/crypto.qapi
diff --git a/qapi/introspect.json b/qapi/introspect.qapi
similarity index 100%
rename from qapi/introspect.json
rename to qapi/introspect.qapi
diff --git a/qapi/migration.json b/qapi/migration.qapi
similarity index 99%
rename from qapi/migration.json
rename to qapi/migration.qapi
index 9d0bf82cf46..dc64952ec4f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.qapi
@@ -5,7 +5,7 @@
 # =3D Migration
 ##

-{ 'include': 'common.json' }
+{ 'include': 'common.qapi' }

 ##
 # @MigrationStats:
diff --git a/qapi/misc.json b/qapi/misc.qapi
similarity index 100%
rename from qapi/misc.json
rename to qapi/misc.qapi
diff --git a/qapi/net.json b/qapi/net.qapi
similarity index 99%
rename from qapi/net.json
rename to qapi/net.qapi
index 9117c569723..b28451758a8 100644
--- a/qapi/net.json
+++ b/qapi/net.qapi
@@ -5,7 +5,7 @@
 # =3D Net devices
 ##

-{ 'include': 'common.json' }
+{ 'include': 'common.qapi' }

 ##
 # @set_link:
diff --git a/qapi/qga-schema.json b/qapi/qga-schema.qapi
similarity index 100%
rename from qapi/qga-schema.json
rename to qapi/qga-schema.qapi
diff --git a/qapi/qmp-schema.json b/qapi/qmp-schema.qapi
similarity index 88%
rename from qapi/qmp-schema.json
rename to qapi/qmp-schema.qapi
index 25bce78352b..067a61fa6f3 100644
--- a/qapi/qmp-schema.json
+++ b/qapi/qmp-schema.qapi
@@ -78,18 +78,18 @@
 # stable order, it's best to include each sub-schema just once, or
 # include it first right here.

-{ 'include': 'common.json' }
-{ 'include': 'sockets.json' }
-{ 'include': 'run-state.json' }
-{ 'include': 'crypto.json' }
-{ 'include': 'block.json' }
-{ 'include': 'char.json' }
-{ 'include': 'net.json' }
-{ 'include': 'rocker.json' }
-{ 'include': 'tpm.json' }
-{ 'include': 'ui.json' }
-{ 'include': 'migration.json' }
-{ 'include': 'transaction.json' }
-{ 'include': 'trace.json' }
-{ 'include': 'introspect.json' }
-{ 'include': 'misc.json' }
+{ 'include': 'common.qapi' }
+{ 'include': 'sockets.qapi' }
+{ 'include': 'run-state.qapi' }
+{ 'include': 'crypto.qapi' }
+{ 'include': 'block.qapi' }
+{ 'include': 'char.qapi' }
+{ 'include': 'net.qapi' }
+{ 'include': 'rocker.qapi' }
+{ 'include': 'tpm.qapi' }
+{ 'include': 'ui.qapi' }
+{ 'include': 'migration.qapi' }
+{ 'include': 'transaction.qapi' }
+{ 'include': 'trace.qapi' }
+{ 'include': 'introspect.qapi' }
+{ 'include': 'misc.qapi' }
diff --git a/qapi/rocker.json b/qapi/rocker.qapi
similarity index 100%
rename from qapi/rocker.json
rename to qapi/rocker.qapi
diff --git a/qapi/run-state.json b/qapi/run-state.qapi
similarity index 100%
rename from qapi/run-state.json
rename to qapi/run-state.qapi
diff --git a/qapi/sockets.json b/qapi/sockets.qapi
similarity index 99%
rename from qapi/sockets.json
rename to qapi/sockets.qapi
index fc81d8d5e8b..e58db0b8b03 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.qapi
@@ -4,7 +4,7 @@
 # =3D Socket data types
 ##

-{ 'include': 'common.json' }
+{ 'include': 'common.qapi' }

 ##
 # @NetworkAddressFamily:
diff --git a/qapi/tpm.json b/qapi/tpm.qapi
similarity index 100%
rename from qapi/tpm.json
rename to qapi/tpm.qapi
diff --git a/qapi/trace.json b/qapi/trace.qapi
similarity index 100%
rename from qapi/trace.json
rename to qapi/trace.qapi
diff --git a/qapi/transaction.json b/qapi/transaction.qapi
similarity index 99%
rename from qapi/transaction.json
rename to qapi/transaction.qapi
index bd312792dae..49118f49f1d 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.qapi
@@ -5,7 +5,7 @@
 # =3D Transactions
 ##

-{ 'include': 'block.json' }
+{ 'include': 'block.qapi' }

 ##
 # @Abort:
diff --git a/qapi/ui.json b/qapi/ui.qapi
similarity index 99%
rename from qapi/ui.json
rename to qapi/ui.qapi
index 5d01ad43045..cb8b7a86d1c 100644
--- a/qapi/ui.json
+++ b/qapi/ui.qapi
@@ -5,7 +5,7 @@
 # =3D Remote desktop
 ##

-{ 'include': 'sockets.json' }
+{ 'include': 'sockets.qapi' }

 ##
 # @set_password:
diff --git a/include/crypto/block.h b/include/crypto/block.h
index cd18f46d56d..ccab4d2df8b 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -27,7 +27,7 @@
 typedef struct QCryptoBlock QCryptoBlock;

 /* See also QCryptoBlockFormat, QCryptoBlockCreateOptions
- * and QCryptoBlockOpenOptions in qapi/crypto.json */
+ * and QCryptoBlockOpenOptions in qapi/crypto.qapi */

 typedef ssize_t (*QCryptoBlockReadFunc)(QCryptoBlock *block,
                                         size_t offset,
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index bce2d4c8e46..287c921874d 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -26,7 +26,7 @@
 typedef struct QCryptoCipher QCryptoCipher;

 /* See also "QCryptoCipherAlgorithm" and "QCryptoCipherMode"
- * enums defined in qapi/crypto.json */
+ * enums defined in qapi/crypto.qapi */

 /**
  * QCryptoCipher:
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 077ac7bea0e..d9ee11f5224 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -23,7 +23,7 @@

 #include "qapi/qapi-types-crypto.h"

-/* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
+/* See also "QCryptoHashAlgorithm" defined in qapi/crypto.qapi */

 /**
  * qcrypto_hash_supports:
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index 0350cd2a930..0609f4f1f94 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -97,7 +97,7 @@

 typedef struct QCryptoIVGen QCryptoIVGen;

-/* See also QCryptoIVGenAlgorithm enum in qapi/crypto.json */
+/* See also QCryptoIVGenAlgorithm enum in qapi/crypto.qapi */


 /**
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a4b7aa2a64..cf2c0de6cd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1380,8 +1380,8 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: blockdev.c
 F: block/qapi.c
-F: qapi/block*.json
-F: qapi/transaction.json
+F: qapi/block*.qapi
+F: qapi/transaction.qapi
 T: git git://repo.or.cz/qemu/armbru.git block-next

 Dirty Bitmaps
@@ -1404,7 +1404,7 @@ M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com>
 S: Maintained
 F: chardev/
 F: include/chardev/
-F: qapi/char.json
+F: qapi/char.qapi

 Character Devices (Braille)
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
@@ -1482,14 +1482,14 @@ F: include/ui/spice-display.h
 F: ui/spice-*.c
 F: audio/spiceaudio.c
 F: hw/display/qxl*
-F: qapi/ui.json
+F: qapi/ui.qapi

 Graphics
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
 F: ui/
 F: include/ui/
-F: qapi/ui.json
+F: qapi/ui.qapi

 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1503,7 +1503,7 @@ F: cpus.c
 F: util/main-loop.c
 F: util/qemu-timer.c
 F: vl.c
-F: qapi/run-state.json
+F: qapi/run-state.qapi

 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
@@ -1520,7 +1520,7 @@ S: Maintained
 F: net/
 F: include/net/
 T: git git://github.com/jasowang/qemu.git net
-F: qapi/net.json
+F: qapi/net.qapi

 Netmap network backend
 M: Luigi Rizzo <rizzo@iet.unipi.it>
@@ -1564,7 +1564,7 @@ M: Markus Armbruster <armbru@redhat.com>
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Supported
 F: qapi/
-X: qapi/*.json
+X: qapi/*.qapi
 F: include/qapi/
 X: include/qapi/qmp/
 F: include/qapi/qmp/dispatch.h
@@ -1581,7 +1581,7 @@ QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-F: qapi/*.json
+F: qapi/*.qapi
 T: git git://repo.or.cz/qemu/armbru.git qapi-next

 QObject
@@ -1602,7 +1602,7 @@ QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
-F: qapi/qga-schema.json
+F: qapi/qga-schema.qapi
 F: qemu-ga.texi
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
@@ -1669,7 +1669,7 @@ F: stubs/tpm.c
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
-F: qapi/tpm.json
+F: qapi/tpm.qapi
 F: backends/tpm.c
 F: tests/*tpm*
 T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
@@ -1688,7 +1688,7 @@ F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
 F: tests/migration-test.c
 F: docs/devel/migration.txt
-F: qapi/migration.json
+F: qapi/migration.qapi

 Seccomp
 M: Eduardo Otubo <otubo@redhat.com>
@@ -1732,7 +1732,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/sockets.h
 F: util/qemu-sockets.c
-F: qapi/sockets.json
+F: qapi/sockets.qapi

 Throttling infrastructure
 M: Alberto Garcia <berto@igalia.com>
diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index ac699700b18..1549511d877 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -19,7 +19,7 @@ Makefile*
 *.mak

 # qapi schema
-*.json
+*.qapi

 # headers
 *.h
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2c..21abab15acd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -404,171 +404,171 @@ check-qtest-generic-y +=3D tests/machine-none-tes=
t$(EXESUF)
 check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
 check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)

-qapi-schema +=3D alternate-any.json
-qapi-schema +=3D alternate-array.json
-qapi-schema +=3D alternate-base.json
-qapi-schema +=3D alternate-clash.json
-qapi-schema +=3D alternate-conflict-dict.json
-qapi-schema +=3D alternate-conflict-enum-bool.json
-qapi-schema +=3D alternate-conflict-enum-int.json
-qapi-schema +=3D alternate-conflict-string.json
-qapi-schema +=3D alternate-conflict-bool-string.json
-qapi-schema +=3D alternate-conflict-num-string.json
-qapi-schema +=3D alternate-empty.json
-qapi-schema +=3D alternate-nested.json
-qapi-schema +=3D alternate-unknown.json
-qapi-schema +=3D args-alternate.json
-qapi-schema +=3D args-any.json
-qapi-schema +=3D args-array-empty.json
-qapi-schema +=3D args-array-unknown.json
-qapi-schema +=3D args-bad-boxed.json
-qapi-schema +=3D args-boxed-anon.json
-qapi-schema +=3D args-boxed-empty.json
-qapi-schema +=3D args-boxed-string.json
-qapi-schema +=3D args-int.json
-qapi-schema +=3D args-invalid.json
-qapi-schema +=3D args-member-array-bad.json
-qapi-schema +=3D args-member-case.json
-qapi-schema +=3D args-member-unknown.json
-qapi-schema +=3D args-name-clash.json
-qapi-schema +=3D args-union.json
-qapi-schema +=3D args-unknown.json
-qapi-schema +=3D bad-base.json
-qapi-schema +=3D bad-data.json
-qapi-schema +=3D bad-ident.json
-qapi-schema +=3D bad-type-bool.json
-qapi-schema +=3D bad-type-dict.json
-qapi-schema +=3D bad-type-int.json
-qapi-schema +=3D base-cycle-direct.json
-qapi-schema +=3D base-cycle-indirect.json
-qapi-schema +=3D command-int.json
-qapi-schema +=3D comments.json
-qapi-schema +=3D doc-bad-alternate-member.json
-qapi-schema +=3D doc-bad-command-arg.json
-qapi-schema +=3D doc-bad-section.json
-qapi-schema +=3D doc-bad-symbol.json
-qapi-schema +=3D doc-bad-union-member.json
-qapi-schema +=3D doc-before-include.json
-qapi-schema +=3D doc-before-pragma.json
-qapi-schema +=3D doc-duplicated-arg.json
-qapi-schema +=3D doc-duplicated-return.json
-qapi-schema +=3D doc-duplicated-since.json
-qapi-schema +=3D doc-empty-arg.json
-qapi-schema +=3D doc-empty-section.json
-qapi-schema +=3D doc-empty-symbol.json
-qapi-schema +=3D doc-good.json
-qapi-schema +=3D doc-interleaved-section.json
-qapi-schema +=3D doc-invalid-end.json
-qapi-schema +=3D doc-invalid-end2.json
-qapi-schema +=3D doc-invalid-return.json
-qapi-schema +=3D doc-invalid-section.json
-qapi-schema +=3D doc-invalid-start.json
-qapi-schema +=3D doc-missing-colon.json
-qapi-schema +=3D doc-missing-expr.json
-qapi-schema +=3D doc-missing-space.json
-qapi-schema +=3D doc-missing.json
-qapi-schema +=3D doc-no-symbol.json
-qapi-schema +=3D double-data.json
-qapi-schema +=3D double-type.json
-qapi-schema +=3D duplicate-key.json
-qapi-schema +=3D empty.json
-qapi-schema +=3D enum-bad-name.json
-qapi-schema +=3D enum-bad-prefix.json
-qapi-schema +=3D enum-clash-member.json
-qapi-schema +=3D enum-dict-member.json
-qapi-schema +=3D enum-int-member.json
-qapi-schema +=3D enum-member-case.json
-qapi-schema +=3D enum-missing-data.json
-qapi-schema +=3D enum-wrong-data.json
-qapi-schema +=3D escape-outside-string.json
-qapi-schema +=3D escape-too-big.json
-qapi-schema +=3D escape-too-short.json
-qapi-schema +=3D event-boxed-empty.json
-qapi-schema +=3D event-case.json
-qapi-schema +=3D event-nest-struct.json
-qapi-schema +=3D flat-union-array-branch.json
-qapi-schema +=3D flat-union-bad-base.json
-qapi-schema +=3D flat-union-bad-discriminator.json
-qapi-schema +=3D flat-union-base-any.json
-qapi-schema +=3D flat-union-base-union.json
-qapi-schema +=3D flat-union-clash-member.json
-qapi-schema +=3D flat-union-empty.json
-qapi-schema +=3D flat-union-incomplete-branch.json
-qapi-schema +=3D flat-union-inline.json
-qapi-schema +=3D flat-union-int-branch.json
-qapi-schema +=3D flat-union-invalid-branch-key.json
-qapi-schema +=3D flat-union-invalid-discriminator.json
-qapi-schema +=3D flat-union-no-base.json
-qapi-schema +=3D flat-union-optional-discriminator.json
-qapi-schema +=3D flat-union-string-discriminator.json
-qapi-schema +=3D funny-char.json
-qapi-schema +=3D ident-with-escape.json
-qapi-schema +=3D include-before-err.json
-qapi-schema +=3D include-cycle.json
-qapi-schema +=3D include-extra-junk.json
-qapi-schema +=3D include-format-err.json
-qapi-schema +=3D include-nested-err.json
-qapi-schema +=3D include-no-file.json
-qapi-schema +=3D include-non-file.json
-qapi-schema +=3D include-relpath.json
-qapi-schema +=3D include-repetition.json
-qapi-schema +=3D include-self-cycle.json
-qapi-schema +=3D include-simple.json
-qapi-schema +=3D indented-expr.json
-qapi-schema +=3D leading-comma-list.json
-qapi-schema +=3D leading-comma-object.json
-qapi-schema +=3D missing-colon.json
-qapi-schema +=3D missing-comma-list.json
-qapi-schema +=3D missing-comma-object.json
-qapi-schema +=3D missing-type.json
-qapi-schema +=3D nested-struct-data.json
-qapi-schema +=3D non-objects.json
-qapi-schema +=3D oob-test.json
-qapi-schema +=3D pragma-doc-required-crap.json
-qapi-schema +=3D pragma-extra-junk.json
-qapi-schema +=3D pragma-name-case-whitelist-crap.json
-qapi-schema +=3D pragma-non-dict.json
-qapi-schema +=3D pragma-returns-whitelist-crap.json
-qapi-schema +=3D qapi-schema-test.json
-qapi-schema +=3D quoted-structural-chars.json
-qapi-schema +=3D redefined-builtin.json
-qapi-schema +=3D redefined-command.json
-qapi-schema +=3D redefined-event.json
-qapi-schema +=3D redefined-type.json
-qapi-schema +=3D reserved-command-q.json
-qapi-schema +=3D reserved-enum-q.json
-qapi-schema +=3D reserved-member-has.json
-qapi-schema +=3D reserved-member-q.json
-qapi-schema +=3D reserved-member-u.json
-qapi-schema +=3D reserved-member-underscore.json
-qapi-schema +=3D reserved-type-kind.json
-qapi-schema +=3D reserved-type-list.json
-qapi-schema +=3D returns-alternate.json
-qapi-schema +=3D returns-array-bad.json
-qapi-schema +=3D returns-dict.json
-qapi-schema +=3D returns-unknown.json
-qapi-schema +=3D returns-whitelist.json
-qapi-schema +=3D struct-base-clash-deep.json
-qapi-schema +=3D struct-base-clash.json
-qapi-schema +=3D struct-data-invalid.json
-qapi-schema +=3D struct-member-invalid.json
-qapi-schema +=3D trailing-comma-list.json
-qapi-schema +=3D trailing-comma-object.json
-qapi-schema +=3D type-bypass-bad-gen.json
-qapi-schema +=3D unclosed-list.json
-qapi-schema +=3D unclosed-object.json
-qapi-schema +=3D unclosed-string.json
-qapi-schema +=3D unicode-str.json
-qapi-schema +=3D union-base-empty.json
-qapi-schema +=3D union-base-no-discriminator.json
-qapi-schema +=3D union-branch-case.json
-qapi-schema +=3D union-clash-branches.json
-qapi-schema +=3D union-empty.json
-qapi-schema +=3D union-invalid-base.json
-qapi-schema +=3D union-optional-branch.json
-qapi-schema +=3D union-unknown.json
-qapi-schema +=3D unknown-escape.json
-qapi-schema +=3D unknown-expr-key.json
+qapi-schema +=3D alternate-any.qapi
+qapi-schema +=3D alternate-array.qapi
+qapi-schema +=3D alternate-base.qapi
+qapi-schema +=3D alternate-clash.qapi
+qapi-schema +=3D alternate-conflict-dict.qapi
+qapi-schema +=3D alternate-conflict-enum-bool.qapi
+qapi-schema +=3D alternate-conflict-enum-int.qapi
+qapi-schema +=3D alternate-conflict-string.qapi
+qapi-schema +=3D alternate-conflict-bool-string.qapi
+qapi-schema +=3D alternate-conflict-num-string.qapi
+qapi-schema +=3D alternate-empty.qapi
+qapi-schema +=3D alternate-nested.qapi
+qapi-schema +=3D alternate-unknown.qapi
+qapi-schema +=3D args-alternate.qapi
+qapi-schema +=3D args-any.qapi
+qapi-schema +=3D args-array-empty.qapi
+qapi-schema +=3D args-array-unknown.qapi
+qapi-schema +=3D args-bad-boxed.qapi
+qapi-schema +=3D args-boxed-anon.qapi
+qapi-schema +=3D args-boxed-empty.qapi
+qapi-schema +=3D args-boxed-string.qapi
+qapi-schema +=3D args-int.qapi
+qapi-schema +=3D args-invalid.qapi
+qapi-schema +=3D args-member-array-bad.qapi
+qapi-schema +=3D args-member-case.qapi
+qapi-schema +=3D args-member-unknown.qapi
+qapi-schema +=3D args-name-clash.qapi
+qapi-schema +=3D args-union.qapi
+qapi-schema +=3D args-unknown.qapi
+qapi-schema +=3D bad-base.qapi
+qapi-schema +=3D bad-data.qapi
+qapi-schema +=3D bad-ident.qapi
+qapi-schema +=3D bad-type-bool.qapi
+qapi-schema +=3D bad-type-dict.qapi
+qapi-schema +=3D bad-type-int.qapi
+qapi-schema +=3D base-cycle-direct.qapi
+qapi-schema +=3D base-cycle-indirect.qapi
+qapi-schema +=3D command-int.qapi
+qapi-schema +=3D comments.qapi
+qapi-schema +=3D doc-bad-alternate-member.qapi
+qapi-schema +=3D doc-bad-command-arg.qapi
+qapi-schema +=3D doc-bad-section.qapi
+qapi-schema +=3D doc-bad-symbol.qapi
+qapi-schema +=3D doc-bad-union-member.qapi
+qapi-schema +=3D doc-before-include.qapi
+qapi-schema +=3D doc-before-pragma.qapi
+qapi-schema +=3D doc-duplicated-arg.qapi
+qapi-schema +=3D doc-duplicated-return.qapi
+qapi-schema +=3D doc-duplicated-since.qapi
+qapi-schema +=3D doc-empty-arg.qapi
+qapi-schema +=3D doc-empty-section.qapi
+qapi-schema +=3D doc-empty-symbol.qapi
+qapi-schema +=3D doc-good.qapi
+qapi-schema +=3D doc-interleaved-section.qapi
+qapi-schema +=3D doc-invalid-end.qapi
+qapi-schema +=3D doc-invalid-end2.qapi
+qapi-schema +=3D doc-invalid-return.qapi
+qapi-schema +=3D doc-invalid-section.qapi
+qapi-schema +=3D doc-invalid-start.qapi
+qapi-schema +=3D doc-missing-colon.qapi
+qapi-schema +=3D doc-missing-expr.qapi
+qapi-schema +=3D doc-missing-space.qapi
+qapi-schema +=3D doc-missing.qapi
+qapi-schema +=3D doc-no-symbol.qapi
+qapi-schema +=3D double-data.qapi
+qapi-schema +=3D double-type.qapi
+qapi-schema +=3D duplicate-key.qapi
+qapi-schema +=3D empty.qapi
+qapi-schema +=3D enum-bad-name.qapi
+qapi-schema +=3D enum-bad-prefix.qapi
+qapi-schema +=3D enum-clash-member.qapi
+qapi-schema +=3D enum-dict-member.qapi
+qapi-schema +=3D enum-int-member.qapi
+qapi-schema +=3D enum-member-case.qapi
+qapi-schema +=3D enum-missing-data.qapi
+qapi-schema +=3D enum-wrong-data.qapi
+qapi-schema +=3D escape-outside-string.qapi
+qapi-schema +=3D escape-too-big.qapi
+qapi-schema +=3D escape-too-short.qapi
+qapi-schema +=3D event-boxed-empty.qapi
+qapi-schema +=3D event-case.qapi
+qapi-schema +=3D event-nest-struct.qapi
+qapi-schema +=3D flat-union-array-branch.qapi
+qapi-schema +=3D flat-union-bad-base.qapi
+qapi-schema +=3D flat-union-bad-discriminator.qapi
+qapi-schema +=3D flat-union-base-any.qapi
+qapi-schema +=3D flat-union-base-union.qapi
+qapi-schema +=3D flat-union-clash-member.qapi
+qapi-schema +=3D flat-union-empty.qapi
+qapi-schema +=3D flat-union-incomplete-branch.qapi
+qapi-schema +=3D flat-union-inline.qapi
+qapi-schema +=3D flat-union-int-branch.qapi
+qapi-schema +=3D flat-union-invalid-branch-key.qapi
+qapi-schema +=3D flat-union-invalid-discriminator.qapi
+qapi-schema +=3D flat-union-no-base.qapi
+qapi-schema +=3D flat-union-optional-discriminator.qapi
+qapi-schema +=3D flat-union-string-discriminator.qapi
+qapi-schema +=3D funny-char.qapi
+qapi-schema +=3D ident-with-escape.qapi
+qapi-schema +=3D include-before-err.qapi
+qapi-schema +=3D include-cycle.qapi
+qapi-schema +=3D include-extra-junk.qapi
+qapi-schema +=3D include-format-err.qapi
+qapi-schema +=3D include-nested-err.qapi
+qapi-schema +=3D include-no-file.qapi
+qapi-schema +=3D include-non-file.qapi
+qapi-schema +=3D include-relpath.qapi
+qapi-schema +=3D include-repetition.qapi
+qapi-schema +=3D include-self-cycle.qapi
+qapi-schema +=3D include-simple.qapi
+qapi-schema +=3D indented-expr.qapi
+qapi-schema +=3D leading-comma-list.qapi
+qapi-schema +=3D leading-comma-object.qapi
+qapi-schema +=3D missing-colon.qapi
+qapi-schema +=3D missing-comma-list.qapi
+qapi-schema +=3D missing-comma-object.qapi
+qapi-schema +=3D missing-type.qapi
+qapi-schema +=3D nested-struct-data.qapi
+qapi-schema +=3D non-objects.qapi
+qapi-schema +=3D oob-test.qapi
+qapi-schema +=3D pragma-doc-required-crap.qapi
+qapi-schema +=3D pragma-extra-junk.qapi
+qapi-schema +=3D pragma-name-case-whitelist-crap.qapi
+qapi-schema +=3D pragma-non-dict.qapi
+qapi-schema +=3D pragma-returns-whitelist-crap.qapi
+qapi-schema +=3D qapi-schema-test.qapi
+qapi-schema +=3D quoted-structural-chars.qapi
+qapi-schema +=3D redefined-builtin.qapi
+qapi-schema +=3D redefined-command.qapi
+qapi-schema +=3D redefined-event.qapi
+qapi-schema +=3D redefined-type.qapi
+qapi-schema +=3D reserved-command-q.qapi
+qapi-schema +=3D reserved-enum-q.qapi
+qapi-schema +=3D reserved-member-has.qapi
+qapi-schema +=3D reserved-member-q.qapi
+qapi-schema +=3D reserved-member-u.qapi
+qapi-schema +=3D reserved-member-underscore.qapi
+qapi-schema +=3D reserved-type-kind.qapi
+qapi-schema +=3D reserved-type-list.qapi
+qapi-schema +=3D returns-alternate.qapi
+qapi-schema +=3D returns-array-bad.qapi
+qapi-schema +=3D returns-dict.qapi
+qapi-schema +=3D returns-unknown.qapi
+qapi-schema +=3D returns-whitelist.qapi
+qapi-schema +=3D struct-base-clash-deep.qapi
+qapi-schema +=3D struct-base-clash.qapi
+qapi-schema +=3D struct-data-invalid.qapi
+qapi-schema +=3D struct-member-invalid.qapi
+qapi-schema +=3D trailing-comma-list.qapi
+qapi-schema +=3D trailing-comma-object.qapi
+qapi-schema +=3D type-bypass-bad-gen.qapi
+qapi-schema +=3D unclosed-list.qapi
+qapi-schema +=3D unclosed-object.qapi
+qapi-schema +=3D unclosed-string.qapi
+qapi-schema +=3D unicode-str.qapi
+qapi-schema +=3D union-base-empty.qapi
+qapi-schema +=3D union-base-no-discriminator.qapi
+qapi-schema +=3D union-branch-case.qapi
+qapi-schema +=3D union-clash-branches.qapi
+qapi-schema +=3D union-empty.qapi
+qapi-schema +=3D union-invalid-base.qapi
+qapi-schema +=3D union-optional-branch.qapi
+qapi-schema +=3D union-unknown.qapi
+qapi-schema +=3D unknown-escape.qapi
+qapi-schema +=3D unknown-expr-key.qapi


 check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schema))
@@ -669,13 +669,13 @@ tests/test-qapi-commands.h tests/test-qapi-commands=
.c \
 tests/test-qapi-events.c tests/test-qapi-events.h \
 tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
-tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema=
-test.json $(qapi-py)
+tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema=
-test.qapi $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=3D%)")
 	@>$@

-tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(qapi-py)
+tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.qapi $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests/qapi-schema -p "doc-good-" $<, \
 		"GEN","$@")
@@ -926,7 +926,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests=
-quick.sh qemu-img$(EXESUF)
 	$<

 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
-$(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
+$(patsubst %, check-%, $(check-qapi-schema-y)): check-%.qapi: $(SRC_PATH=
)/%.qapi
 	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
 		$(PYTHON_UTF8) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
 		$^ >$*.test.out 2>$*.test.err; \
diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index aaa01547310..bf762f9afe8 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one' can=
not use type 'any'
+tests/qapi-schema/alternate-any.qapi:2: Alternate 'Alt' member 'one' can=
not use type 'any'
diff --git a/tests/qapi-schema/alternate-any.json b/tests/qapi-schema/alt=
ernate-any.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-any.json
rename to tests/qapi-schema/alternate-any.qapi
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index 7b930c64abf..0e4a14e59d0 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'Alt=
' cannot be an array
+tests/qapi-schema/alternate-array.qapi:5: Member 'two' of alternate 'Alt=
' cannot be an array
diff --git a/tests/qapi-schema/alternate-array.json b/tests/qapi-schema/a=
lternate-array.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-array.json
rename to tests/qapi-schema/alternate-array.qapi
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 30d8a343734..9560f452eb3 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
+tests/qapi-schema/alternate-base.qapi:4: Unknown key 'base' in alternate=
 'Alt'
diff --git a/tests/qapi-schema/alternate-base.json b/tests/qapi-schema/al=
ternate-base.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-base.json
rename to tests/qapi-schema/alternate-base.qapi
diff --git a/tests/qapi-schema/alternate-clash.err b/tests/qapi-schema/al=
ternate-clash.err
index 604d8495eb0..d5eb85a256c 100644
--- a/tests/qapi-schema/alternate-clash.err
+++ b/tests/qapi-schema/alternate-clash.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) collide=
s with 'a-b' (branch of Alt1)
+tests/qapi-schema/alternate-clash.qapi:7: 'a_b' (branch of Alt1) collide=
s with 'a-b' (branch of Alt1)
diff --git a/tests/qapi-schema/alternate-clash.json b/tests/qapi-schema/a=
lternate-clash.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-clash.json
rename to tests/qapi-schema/alternate-clash.qapi
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.err b/tests=
/qapi-schema/alternate-conflict-bool-string.err
index e52fee76201..800267a2124 100644
--- a/tests/qapi-schema/alternate-conflict-bool-string.err
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-bool-string.json:2: Alternate 'Alt'=
 member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-bool-string.qapi:2: Alternate 'Alt'=
 member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.json b/test=
s/qapi-schema/alternate-conflict-bool-string.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-conflict-bool-string.json
rename to tests/qapi-schema/alternate-conflict-bool-string.qapi
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index 0f411f4faf5..2aeff136883 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-dict.qapi:6: Alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.json b/tests/qapi-=
schema/alternate-conflict-dict.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-conflict-dict.json
rename to tests/qapi-schema/alternate-conflict-dict.qapi
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.err b/tests/q=
api-schema/alternate-conflict-enum-bool.err
index 0dfc00242d8..cf166d6a3d4 100644
--- a/tests/qapi-schema/alternate-conflict-enum-bool.err
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-enum-bool.json:4: Alternate 'Alt' m=
ember 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-enum-bool.qapi:4: Alternate 'Alt' m=
ember 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.json b/tests/=
qapi-schema/alternate-conflict-enum-bool.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-conflict-enum-bool.json
rename to tests/qapi-schema/alternate-conflict-enum-bool.qapi
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.err b/tests/qa=
pi-schema/alternate-conflict-enum-int.err
index 2cc8e7b9aa4..04298eae905 100644
--- a/tests/qapi-schema/alternate-conflict-enum-int.err
+++ b/tests/qapi-schema/alternate-conflict-enum-int.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-enum-int.json:4: Alternate 'Alt' me=
mber 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-enum-int.qapi:4: Alternate 'Alt' me=
mber 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.json b/tests/q=
api-schema/alternate-conflict-enum-int.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-conflict-enum-int.json
rename to tests/qapi-schema/alternate-conflict-enum-int.qapi
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/=
qapi-schema/alternate-conflict-num-string.err
index 5ba3827dd12..42a6dbc449f 100644
--- a/tests/qapi-schema/alternate-conflict-num-string.err
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-num-string.json:2: Alternate 'Alt' =
member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-num-string.qapi:2: Alternate 'Alt' =
member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.json b/tests=
/qapi-schema/alternate-conflict-num-string.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-conflict-num-string.json
rename to tests/qapi-schema/alternate-conflict-num-string.qapi
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index fe2f188295b..ee70cad527b 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-string.json:2: Alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-string.qapi:2: Alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.json b/tests/qap=
i-schema/alternate-conflict-string.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-conflict-string.json
rename to tests/qapi-schema/alternate-conflict-string.qapi
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index bb06c5bfec0..4253cac8af5 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' should have at=
 least two branches in 'data'
+tests/qapi-schema/alternate-empty.qapi:2: Alternate 'Alt' should have at=
 least two branches in 'data'
diff --git a/tests/qapi-schema/alternate-empty.json b/tests/qapi-schema/a=
lternate-empty.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-empty.json
rename to tests/qapi-schema/alternate-empty.qapi
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index 4d1187e60ec..ae3aa1a73f0 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
+tests/qapi-schema/alternate-nested.qapi:4: Member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
diff --git a/tests/qapi-schema/alternate-nested.json b/tests/qapi-schema/=
alternate-nested.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-nested.json
rename to tests/qapi-schema/alternate-nested.qapi
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index dea45dc7302..706658d4959 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
+tests/qapi-schema/alternate-unknown.qapi:2: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/alternate-unknown.json b/tests/qapi-schema=
/alternate-unknown.qapi
similarity index 100%
rename from tests/qapi-schema/alternate-unknown.json
rename to tests/qapi-schema/alternate-unknown.qapi
diff --git a/tests/qapi-schema/args-alternate.err b/tests/qapi-schema/arg=
s-alternate.err
index 3086eae56b0..637d9884867 100644
--- a/tests/qapi-schema/args-alternate.err
+++ b/tests/qapi-schema/args-alternate.err
@@ -1 +1 @@
-tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' canno=
t use alternate type 'Alt'
+tests/qapi-schema/args-alternate.qapi:3: 'data' for command 'oops' canno=
t use alternate type 'Alt'
diff --git a/tests/qapi-schema/args-alternate.json b/tests/qapi-schema/ar=
gs-alternate.qapi
similarity index 100%
rename from tests/qapi-schema/args-alternate.json
rename to tests/qapi-schema/args-alternate.qapi
diff --git a/tests/qapi-schema/args-any.err b/tests/qapi-schema/args-any.=
err
index bf9b5e0730b..2853bdb41ea 100644
--- a/tests/qapi-schema/args-any.err
+++ b/tests/qapi-schema/args-any.err
@@ -1 +1 @@
-tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot use =
built-in type 'any'
+tests/qapi-schema/args-any.qapi:2: 'data' for command 'oops' cannot use =
built-in type 'any'
diff --git a/tests/qapi-schema/args-any.json b/tests/qapi-schema/args-any=
.qapi
similarity index 100%
rename from tests/qapi-schema/args-any.json
rename to tests/qapi-schema/args-any.qapi
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index cb7ed33b3fb..530d661b649 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1 +1 @@
-tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
+tests/qapi-schema/args-array-empty.qapi:2: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-array-empty.json b/tests/qapi-schema/=
args-array-empty.qapi
similarity index 100%
rename from tests/qapi-schema/args-array-empty.json
rename to tests/qapi-schema/args-array-empty.qapi
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index cd7a0f98d79..6273c088bb3 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-array-unknown.qapi:2: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-array-unknown.json b/tests/qapi-schem=
a/args-array-unknown.qapi
similarity index 100%
rename from tests/qapi-schema/args-array-unknown.json
rename to tests/qapi-schema/args-array-unknown.qapi
diff --git a/tests/qapi-schema/args-bad-boxed.err b/tests/qapi-schema/arg=
s-bad-boxed.err
index ad0d417321c..b059bcc3076 100644
--- a/tests/qapi-schema/args-bad-boxed.err
+++ b/tests/qapi-schema/args-bad-boxed.err
@@ -1 +1 @@
-tests/qapi-schema/args-bad-boxed.json:2: 'boxed' of command 'foo' should=
 only use true value
+tests/qapi-schema/args-bad-boxed.qapi:2: 'boxed' of command 'foo' should=
 only use true value
diff --git a/tests/qapi-schema/args-bad-boxed.json b/tests/qapi-schema/ar=
gs-bad-boxed.qapi
similarity index 100%
rename from tests/qapi-schema/args-bad-boxed.json
rename to tests/qapi-schema/args-bad-boxed.qapi
diff --git a/tests/qapi-schema/args-boxed-anon.err b/tests/qapi-schema/ar=
gs-boxed-anon.err
index f24f3452185..fc5f2828c44 100644
--- a/tests/qapi-schema/args-boxed-anon.err
+++ b/tests/qapi-schema/args-boxed-anon.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' shoul=
d be a type name
+tests/qapi-schema/args-boxed-anon.qapi:2: 'data' for command 'foo' shoul=
d be a type name
diff --git a/tests/qapi-schema/args-boxed-anon.json b/tests/qapi-schema/a=
rgs-boxed-anon.qapi
similarity index 100%
rename from tests/qapi-schema/args-boxed-anon.json
rename to tests/qapi-schema/args-boxed-anon.qapi
diff --git a/tests/qapi-schema/args-boxed-empty.err b/tests/qapi-schema/a=
rgs-boxed-empty.err
index 039603e85ca..c144d317b7f 100644
--- a/tests/qapi-schema/args-boxed-empty.err
+++ b/tests/qapi-schema/args-boxed-empty.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-empty.json:3: Cannot use 'boxed' with empty=
 type
+tests/qapi-schema/args-boxed-empty.qapi:3: Cannot use 'boxed' with empty=
 type
diff --git a/tests/qapi-schema/args-boxed-empty.json b/tests/qapi-schema/=
args-boxed-empty.qapi
similarity index 100%
rename from tests/qapi-schema/args-boxed-empty.json
rename to tests/qapi-schema/args-boxed-empty.qapi
diff --git a/tests/qapi-schema/args-boxed-string.err b/tests/qapi-schema/=
args-boxed-string.err
index d326b48aefd..48d612261c1 100644
--- a/tests/qapi-schema/args-boxed-string.err
+++ b/tests/qapi-schema/args-boxed-string.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo' can=
not use built-in type 'str'
+tests/qapi-schema/args-boxed-string.qapi:2: 'data' for command 'foo' can=
not use built-in type 'str'
diff --git a/tests/qapi-schema/args-boxed-string.json b/tests/qapi-schema=
/args-boxed-string.qapi
similarity index 100%
rename from tests/qapi-schema/args-boxed-string.json
rename to tests/qapi-schema/args-boxed-string.qapi
diff --git a/tests/qapi-schema/args-int.err b/tests/qapi-schema/args-int.=
err
index dc1d2504ff8..35b50e18825 100644
--- a/tests/qapi-schema/args-int.err
+++ b/tests/qapi-schema/args-int.err
@@ -1 +1 @@
-tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot use =
built-in type 'int'
+tests/qapi-schema/args-int.qapi:2: 'data' for command 'oops' cannot use =
built-in type 'int'
diff --git a/tests/qapi-schema/args-int.json b/tests/qapi-schema/args-int=
.qapi
similarity index 100%
rename from tests/qapi-schema/args-int.json
rename to tests/qapi-schema/args-int.qapi
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index fe1e94975b9..5884976eeed 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e a dictionary or type name
+tests/qapi-schema/args-invalid.qapi:1: 'data' for command 'foo' should b=
e a dictionary or type name
diff --git a/tests/qapi-schema/args-invalid.json b/tests/qapi-schema/args=
-invalid.qapi
similarity index 100%
rename from tests/qapi-schema/args-invalid.json
rename to tests/qapi-schema/args-invalid.qapi
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index 881b4d954f2..19fb4f4bfb3 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
+tests/qapi-schema/args-member-array-bad.qapi:2: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-member-array-bad.json b/tests/qapi-sc=
hema/args-member-array-bad.qapi
similarity index 100%
rename from tests/qapi-schema/args-member-array-bad.json
rename to tests/qapi-schema/args-member-array-bad.qapi
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index 19c44266015..62294827266 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-case.json:2: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
+tests/qapi-schema/args-member-case.qapi:2: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
diff --git a/tests/qapi-schema/args-member-case.json b/tests/qapi-schema/=
args-member-case.qapi
similarity index 100%
rename from tests/qapi-schema/args-member-case.json
rename to tests/qapi-schema/args-member-case.qapi
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index f6f82828ce5..c9e58b2d074 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-member-unknown.qapi:2: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-member-unknown.json b/tests/qapi-sche=
ma/args-member-unknown.qapi
similarity index 100%
rename from tests/qapi-schema/args-member-unknown.json
rename to tests/qapi-schema/args-member-unknown.qapi
diff --git a/tests/qapi-schema/args-name-clash.err b/tests/qapi-schema/ar=
gs-name-clash.err
index d953e8d2416..5e9dc79a3dd 100644
--- a/tests/qapi-schema/args-name-clash.err
+++ b/tests/qapi-schema/args-name-clash.err
@@ -1 +1 @@
-tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
+tests/qapi-schema/args-name-clash.qapi:4: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
diff --git a/tests/qapi-schema/args-name-clash.json b/tests/qapi-schema/a=
rgs-name-clash.qapi
similarity index 100%
rename from tests/qapi-schema/args-name-clash.json
rename to tests/qapi-schema/args-name-clash.qapi
diff --git a/tests/qapi-schema/args-union.err b/tests/qapi-schema/args-un=
ion.err
index f8ad223ddee..8b84f4034e8 100644
--- a/tests/qapi-schema/args-union.err
+++ b/tests/qapi-schema/args-union.err
@@ -1 +1 @@
-tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot us=
e union type 'Uni'
+tests/qapi-schema/args-union.qapi:3: 'data' for command 'oops' cannot us=
e union type 'Uni'
diff --git a/tests/qapi-schema/args-union.json b/tests/qapi-schema/args-u=
nion.qapi
similarity index 100%
rename from tests/qapi-schema/args-union.json
rename to tests/qapi-schema/args-union.qapi
diff --git a/tests/qapi-schema/args-unknown.err b/tests/qapi-schema/args-=
unknown.err
index 4d91ec869f9..86b4d123566 100644
--- a/tests/qapi-schema/args-unknown.err
+++ b/tests/qapi-schema/args-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses un=
known type 'NoSuchType'
+tests/qapi-schema/args-unknown.qapi:2: 'data' for command 'oops' uses un=
known type 'NoSuchType'
diff --git a/tests/qapi-schema/args-unknown.json b/tests/qapi-schema/args=
-unknown.qapi
similarity index 100%
rename from tests/qapi-schema/args-unknown.json
rename to tests/qapi-schema/args-unknown.qapi
diff --git a/tests/qapi-schema/bad-base.err b/tests/qapi-schema/bad-base.=
err
index 154274bdd3f..2329ecc605e 100644
--- a/tests/qapi-schema/bad-base.err
+++ b/tests/qapi-schema/bad-base.err
@@ -1 +1 @@
-tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot use=
 union type 'Union'
+tests/qapi-schema/bad-base.qapi:3: 'base' for struct 'MyType' cannot use=
 union type 'Union'
diff --git a/tests/qapi-schema/bad-base.json b/tests/qapi-schema/bad-base=
.qapi
similarity index 100%
rename from tests/qapi-schema/bad-base.json
rename to tests/qapi-schema/bad-base.qapi
diff --git a/tests/qapi-schema/bad-data.err b/tests/qapi-schema/bad-data.=
err
index 8523ac4f46d..7f6c19eaf0d 100644
--- a/tests/qapi-schema/bad-data.err
+++ b/tests/qapi-schema/bad-data.err
@@ -1 +1 @@
-tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be a=
n array
+tests/qapi-schema/bad-data.qapi:2: 'data' for command 'oops' cannot be a=
n array
diff --git a/tests/qapi-schema/bad-data.json b/tests/qapi-schema/bad-data=
.qapi
similarity index 100%
rename from tests/qapi-schema/bad-data.json
rename to tests/qapi-schema/bad-data.qapi
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index c4190602b5c..0733e38d4cd 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1 +1 @@
-tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional nam=
e '*oops'
+tests/qapi-schema/bad-ident.qapi:2: 'struct' does not allow optional nam=
e '*oops'
diff --git a/tests/qapi-schema/bad-ident.json b/tests/qapi-schema/bad-ide=
nt.qapi
similarity index 100%
rename from tests/qapi-schema/bad-ident.json
rename to tests/qapi-schema/bad-ident.qapi
diff --git a/tests/qapi-schema/bad-type-bool.err b/tests/qapi-schema/bad-=
type-bool.err
index 62fd70baafd..824d0b737e7 100644
--- a/tests/qapi-schema/bad-type-bool.err
+++ b/tests/qapi-schema/bad-type-bool.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-bool.json:2: 'struct' key must have a string =
value
+tests/qapi-schema/bad-type-bool.qapi:2: 'struct' key must have a string =
value
diff --git a/tests/qapi-schema/bad-type-bool.json b/tests/qapi-schema/bad=
-type-bool.qapi
similarity index 100%
rename from tests/qapi-schema/bad-type-bool.json
rename to tests/qapi-schema/bad-type-bool.qapi
diff --git a/tests/qapi-schema/bad-type-dict.err b/tests/qapi-schema/bad-=
type-dict.err
index 0b2a2aeac42..fc5302bd9af 100644
--- a/tests/qapi-schema/bad-type-dict.err
+++ b/tests/qapi-schema/bad-type-dict.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-dict.json:2: 'command' key must have a string=
 value
+tests/qapi-schema/bad-type-dict.qapi:2: 'command' key must have a string=
 value
diff --git a/tests/qapi-schema/bad-type-dict.json b/tests/qapi-schema/bad=
-type-dict.qapi
similarity index 100%
rename from tests/qapi-schema/bad-type-dict.json
rename to tests/qapi-schema/bad-type-dict.qapi
diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
index da898954046..a6c074644bb 100644
--- a/tests/qapi-schema/bad-type-int.err
+++ b/tests/qapi-schema/bad-type-int.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-int.json:3:13: Stray "1"
+tests/qapi-schema/bad-type-int.qapi:3:13: Stray "1"
diff --git a/tests/qapi-schema/bad-type-int.json b/tests/qapi-schema/bad-=
type-int.qapi
similarity index 100%
rename from tests/qapi-schema/bad-type-int.json
rename to tests/qapi-schema/bad-type-int.qapi
diff --git a/tests/qapi-schema/base-cycle-direct.err b/tests/qapi-schema/=
base-cycle-direct.err
index 9c68f6543d3..7b83d041ea4 100644
--- a/tests/qapi-schema/base-cycle-direct.err
+++ b/tests/qapi-schema/base-cycle-direct.err
@@ -1 +1 @@
-tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itself
+tests/qapi-schema/base-cycle-direct.qapi:2: Object Loopy contains itself
diff --git a/tests/qapi-schema/base-cycle-direct.json b/tests/qapi-schema=
/base-cycle-direct.qapi
similarity index 100%
rename from tests/qapi-schema/base-cycle-direct.json
rename to tests/qapi-schema/base-cycle-direct.qapi
diff --git a/tests/qapi-schema/base-cycle-indirect.err b/tests/qapi-schem=
a/base-cycle-indirect.err
index fc92fe47f82..585c95aea24 100644
--- a/tests/qapi-schema/base-cycle-indirect.err
+++ b/tests/qapi-schema/base-cycle-indirect.err
@@ -1 +1 @@
-tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains itse=
lf
+tests/qapi-schema/base-cycle-indirect.qapi:2: Object Base1 contains itse=
lf
diff --git a/tests/qapi-schema/base-cycle-indirect.json b/tests/qapi-sche=
ma/base-cycle-indirect.qapi
similarity index 100%
rename from tests/qapi-schema/base-cycle-indirect.json
rename to tests/qapi-schema/base-cycle-indirect.qapi
diff --git a/tests/qapi-schema/command-int.err b/tests/qapi-schema/comman=
d-int.err
index 0f9300679b3..10c53335fa9 100644
--- a/tests/qapi-schema/command-int.err
+++ b/tests/qapi-schema/command-int.err
@@ -1 +1 @@
-tests/qapi-schema/command-int.json:2: built-in 'int' is already defined
+tests/qapi-schema/command-int.qapi:2: built-in 'int' is already defined
diff --git a/tests/qapi-schema/command-int.json b/tests/qapi-schema/comma=
nd-int.qapi
similarity index 100%
rename from tests/qapi-schema/command-int.json
rename to tests/qapi-schema/command-int.qapi
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 8d2f1ce8a2e..6c0d162bc0a 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,5 +1,5 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module comments.json
+module comments.qapi
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/comments.json b/tests/qapi-schema/comments=
.qapi
similarity index 100%
rename from tests/qapi-schema/comments.json
rename to tests/qapi-schema/comments.qapi
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-=
schema/doc-bad-alternate-member.err
index 387f7824daa..318d1df8748 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.err
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-alternate-member.json:3: The following documen=
ted members are not in the declaration: aa, bb
+tests/qapi-schema/doc-bad-alternate-member.qapi:3: The following documen=
ted members are not in the declaration: aa, bb
diff --git a/tests/qapi-schema/doc-bad-alternate-member.json b/tests/qapi=
-schema/doc-bad-alternate-member.qapi
similarity index 100%
rename from tests/qapi-schema/doc-bad-alternate-member.json
rename to tests/qapi-schema/doc-bad-alternate-member.qapi
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schem=
a/doc-bad-command-arg.err
index 8075b146ae3..bd236a1f819 100644
--- a/tests/qapi-schema/doc-bad-command-arg.err
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-command-arg.json:3: The following documented m=
embers are not in the declaration: b
+tests/qapi-schema/doc-bad-command-arg.qapi:3: The following documented m=
embers are not in the declaration: b
diff --git a/tests/qapi-schema/doc-bad-command-arg.json b/tests/qapi-sche=
ma/doc-bad-command-arg.qapi
similarity index 100%
rename from tests/qapi-schema/doc-bad-command-arg.json
rename to tests/qapi-schema/doc-bad-command-arg.qapi
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index cd287215689..3a8b8d3fe0b 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,7 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module doc-bad-section.json
+module doc-bad-section.qapi
 enum Enum ['one', 'two']
 doc symbol=3DEnum
     body=3D
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/d=
oc-bad-section.qapi
similarity index 100%
rename from tests/qapi-schema/doc-bad-section.json
rename to tests/qapi-schema/doc-bad-section.qapi
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc=
-bad-symbol.err
index 8472030c791..5fe61db4e79 100644
--- a/tests/qapi-schema/doc-bad-symbol.err
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-symbol.json:6: Definition of 'foo' follows doc=
umentation for 'food'
+tests/qapi-schema/doc-bad-symbol.qapi:6: Definition of 'foo' follows doc=
umentation for 'food'
diff --git a/tests/qapi-schema/doc-bad-symbol.json b/tests/qapi-schema/do=
c-bad-symbol.qapi
similarity index 100%
rename from tests/qapi-schema/doc-bad-symbol.json
rename to tests/qapi-schema/doc-bad-symbol.qapi
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-sche=
ma/doc-bad-union-member.err
index 4b016df7ff7..0bb90004cc9 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-union-member.json:3: The following documented =
members are not in the declaration: a, b
+tests/qapi-schema/doc-bad-union-member.qapi:3: The following documented =
members are not in the declaration: a, b
diff --git a/tests/qapi-schema/doc-bad-union-member.json b/tests/qapi-sch=
ema/doc-bad-union-member.qapi
similarity index 100%
rename from tests/qapi-schema/doc-bad-union-member.json
rename to tests/qapi-schema/doc-bad-union-member.qapi
diff --git a/tests/qapi-schema/doc-before-include.err b/tests/qapi-schema=
/doc-before-include.err
index a649d38a630..a7b903fc1e9 100644
--- a/tests/qapi-schema/doc-before-include.err
+++ b/tests/qapi-schema/doc-before-include.err
@@ -1 +1 @@
-tests/qapi-schema/doc-before-include.json:3: Documentation for 'foo' is =
not followed by the definition
+tests/qapi-schema/doc-before-include.qapi:3: Documentation for 'foo' is =
not followed by the definition
diff --git a/tests/qapi-schema/doc-before-include.json b/tests/qapi-schem=
a/doc-before-include.qapi
similarity index 81%
rename from tests/qapi-schema/doc-before-include.json
rename to tests/qapi-schema/doc-before-include.qapi
index 0caa0ae0791..7fae0a67550 100644
--- a/tests/qapi-schema/doc-before-include.json
+++ b/tests/qapi-schema/doc-before-include.qapi
@@ -3,5 +3,5 @@
 ##
 # @foo:
 ##
-{ 'include': 'empty.json' }
+{ 'include': 'empty.qapi' }
 { 'struct': 'foo', 'data': {} }
diff --git a/tests/qapi-schema/doc-before-pragma.err b/tests/qapi-schema/=
doc-before-pragma.err
index c0fb0660d14..2dbc7e00de8 100644
--- a/tests/qapi-schema/doc-before-pragma.err
+++ b/tests/qapi-schema/doc-before-pragma.err
@@ -1 +1 @@
-tests/qapi-schema/doc-before-pragma.json:3: Documentation for 'foo' is n=
ot followed by the definition
+tests/qapi-schema/doc-before-pragma.qapi:3: Documentation for 'foo' is n=
ot followed by the definition
diff --git a/tests/qapi-schema/doc-before-pragma.json b/tests/qapi-schema=
/doc-before-pragma.qapi
similarity index 100%
rename from tests/qapi-schema/doc-before-pragma.json
rename to tests/qapi-schema/doc-before-pragma.qapi
diff --git a/tests/qapi-schema/doc-duplicated-arg.err b/tests/qapi-schema=
/doc-duplicated-arg.err
index 1c3f8e0a542..4929ac53cf3 100644
--- a/tests/qapi-schema/doc-duplicated-arg.err
+++ b/tests/qapi-schema/doc-duplicated-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-arg.json:6:1: 'a' parameter name duplic=
ated
+tests/qapi-schema/doc-duplicated-arg.qapi:6:1: 'a' parameter name duplic=
ated
diff --git a/tests/qapi-schema/doc-duplicated-arg.json b/tests/qapi-schem=
a/doc-duplicated-arg.qapi
similarity index 100%
rename from tests/qapi-schema/doc-duplicated-arg.json
rename to tests/qapi-schema/doc-duplicated-arg.qapi
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-sch=
ema/doc-duplicated-return.err
index e48039f8e53..92f7b655d4c 100644
--- a/tests/qapi-schema/doc-duplicated-return.err
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-return.json:7:1: Duplicated 'Returns' s=
ection
+tests/qapi-schema/doc-duplicated-return.qapi:7:1: Duplicated 'Returns' s=
ection
diff --git a/tests/qapi-schema/doc-duplicated-return.json b/tests/qapi-sc=
hema/doc-duplicated-return.qapi
similarity index 100%
rename from tests/qapi-schema/doc-duplicated-return.json
rename to tests/qapi-schema/doc-duplicated-return.qapi
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-sche=
ma/doc-duplicated-since.err
index 3fb890744a4..2bb0097fb09 100644
--- a/tests/qapi-schema/doc-duplicated-since.err
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-since.json:7:1: Duplicated 'Since' sect=
ion
+tests/qapi-schema/doc-duplicated-since.qapi:7:1: Duplicated 'Since' sect=
ion
diff --git a/tests/qapi-schema/doc-duplicated-since.json b/tests/qapi-sch=
ema/doc-duplicated-since.qapi
similarity index 100%
rename from tests/qapi-schema/doc-duplicated-since.json
rename to tests/qapi-schema/doc-duplicated-since.qapi
diff --git a/tests/qapi-schema/doc-empty-arg.err b/tests/qapi-schema/doc-=
empty-arg.err
index 2895518fa7f..873eddca052 100644
--- a/tests/qapi-schema/doc-empty-arg.err
+++ b/tests/qapi-schema/doc-empty-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-arg.json:5:1: Invalid parameter name
+tests/qapi-schema/doc-empty-arg.qapi:5:1: Invalid parameter name
diff --git a/tests/qapi-schema/doc-empty-arg.json b/tests/qapi-schema/doc=
-empty-arg.qapi
similarity index 100%
rename from tests/qapi-schema/doc-empty-arg.json
rename to tests/qapi-schema/doc-empty-arg.qapi
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/=
doc-empty-section.err
index b61e4a78860..ed54e31ba5e 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-section.json:7:1: Empty doc section 'Note'
+tests/qapi-schema/doc-empty-section.qapi:7:1: Empty doc section 'Note'
diff --git a/tests/qapi-schema/doc-empty-section.json b/tests/qapi-schema=
/doc-empty-section.qapi
similarity index 100%
rename from tests/qapi-schema/doc-empty-section.json
rename to tests/qapi-schema/doc-empty-section.qapi
diff --git a/tests/qapi-schema/doc-empty-symbol.err b/tests/qapi-schema/d=
oc-empty-symbol.err
index 1936ad094f8..ca349b1ec47 100644
--- a/tests/qapi-schema/doc-empty-symbol.err
+++ b/tests/qapi-schema/doc-empty-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-symbol.json:4:1: Invalid name
+tests/qapi-schema/doc-empty-symbol.qapi:4:1: Invalid name
diff --git a/tests/qapi-schema/doc-empty-symbol.json b/tests/qapi-schema/=
doc-empty-symbol.qapi
similarity index 100%
rename from tests/qapi-schema/doc-empty-symbol.json
rename to tests/qapi-schema/doc-empty-symbol.qapi
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 63058b1590a..e5aede089b1 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,7 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module doc-good.json
+module doc-good.qapi
 enum Enum ['one', 'two']
 object Base
     member base1: Enum optional=3DFalse
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.qapi
similarity index 100%
rename from tests/qapi-schema/doc-good.json
rename to tests/qapi-schema/doc-good.qapi
diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi-s=
chema/doc-interleaved-section.err
index d373eabc556..f5e347f391b 100644
--- a/tests/qapi-schema/doc-interleaved-section.err
+++ b/tests/qapi-schema/doc-interleaved-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-interleaved-section.json:15:1: '@foobar:' can't fo=
llow 'Note' section
+tests/qapi-schema/doc-interleaved-section.qapi:15:1: '@foobar:' can't fo=
llow 'Note' section
diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-=
schema/doc-interleaved-section.qapi
similarity index 100%
rename from tests/qapi-schema/doc-interleaved-section.json
rename to tests/qapi-schema/doc-interleaved-section.qapi
diff --git a/tests/qapi-schema/doc-invalid-end.err b/tests/qapi-schema/do=
c-invalid-end.err
index 2bda28cb548..2152663541e 100644
--- a/tests/qapi-schema/doc-invalid-end.err
+++ b/tests/qapi-schema/doc-invalid-end.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-end.json:5:2: Documentation comment must e=
nd with '##'
+tests/qapi-schema/doc-invalid-end.qapi:5:2: Documentation comment must e=
nd with '##'
diff --git a/tests/qapi-schema/doc-invalid-end.json b/tests/qapi-schema/d=
oc-invalid-end.qapi
similarity index 100%
rename from tests/qapi-schema/doc-invalid-end.json
rename to tests/qapi-schema/doc-invalid-end.qapi
diff --git a/tests/qapi-schema/doc-invalid-end2.err b/tests/qapi-schema/d=
oc-invalid-end2.err
index 6fad9c789e7..077931d8500 100644
--- a/tests/qapi-schema/doc-invalid-end2.err
+++ b/tests/qapi-schema/doc-invalid-end2.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-end2.json:5:1: Junk after '##' at end of d=
ocumentation comment
+tests/qapi-schema/doc-invalid-end2.qapi:5:1: Junk after '##' at end of d=
ocumentation comment
diff --git a/tests/qapi-schema/doc-invalid-end2.json b/tests/qapi-schema/=
doc-invalid-end2.qapi
similarity index 100%
rename from tests/qapi-schema/doc-invalid-end2.json
rename to tests/qapi-schema/doc-invalid-end2.qapi
diff --git a/tests/qapi-schema/doc-invalid-return.err b/tests/qapi-schema=
/doc-invalid-return.err
index 5aaba33bb42..32eb8db5e53 100644
--- a/tests/qapi-schema/doc-invalid-return.err
+++ b/tests/qapi-schema/doc-invalid-return.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-return.json:3: 'Returns:' is only valid fo=
r commands
+tests/qapi-schema/doc-invalid-return.qapi:3: 'Returns:' is only valid fo=
r commands
diff --git a/tests/qapi-schema/doc-invalid-return.json b/tests/qapi-schem=
a/doc-invalid-return.qapi
similarity index 100%
rename from tests/qapi-schema/doc-invalid-return.json
rename to tests/qapi-schema/doc-invalid-return.qapi
diff --git a/tests/qapi-schema/doc-invalid-section.err b/tests/qapi-schem=
a/doc-invalid-section.err
index bda93b44fde..810957cfc16 100644
--- a/tests/qapi-schema/doc-invalid-section.err
+++ b/tests/qapi-schema/doc-invalid-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-section.json:5:1: '@note:' not allowed in =
free-form documentation
+tests/qapi-schema/doc-invalid-section.qapi:5:1: '@note:' not allowed in =
free-form documentation
diff --git a/tests/qapi-schema/doc-invalid-section.json b/tests/qapi-sche=
ma/doc-invalid-section.qapi
similarity index 100%
rename from tests/qapi-schema/doc-invalid-section.json
rename to tests/qapi-schema/doc-invalid-section.qapi
diff --git a/tests/qapi-schema/doc-invalid-start.err b/tests/qapi-schema/=
doc-invalid-start.err
index 149af2bfacd..08dce5feafe 100644
--- a/tests/qapi-schema/doc-invalid-start.err
+++ b/tests/qapi-schema/doc-invalid-start.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-start.json:3:1: Junk after '##' at start o=
f documentation comment
+tests/qapi-schema/doc-invalid-start.qapi:3:1: Junk after '##' at start o=
f documentation comment
diff --git a/tests/qapi-schema/doc-invalid-start.json b/tests/qapi-schema=
/doc-invalid-start.qapi
similarity index 100%
rename from tests/qapi-schema/doc-invalid-start.json
rename to tests/qapi-schema/doc-invalid-start.qapi
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/=
doc-missing-colon.err
index 817398b8e42..0052605c972 100644
--- a/tests/qapi-schema/doc-missing-colon.err
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-colon.json:4:1: Line should end with :
+tests/qapi-schema/doc-missing-colon.qapi:4:1: Line should end with :
diff --git a/tests/qapi-schema/doc-missing-colon.json b/tests/qapi-schema=
/doc-missing-colon.qapi
similarity index 100%
rename from tests/qapi-schema/doc-missing-colon.json
rename to tests/qapi-schema/doc-missing-colon.qapi
diff --git a/tests/qapi-schema/doc-missing-expr.err b/tests/qapi-schema/d=
oc-missing-expr.err
index c909e26eca5..d2af40b1c68 100644
--- a/tests/qapi-schema/doc-missing-expr.err
+++ b/tests/qapi-schema/doc-missing-expr.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-expr.json:3: Documentation for 'bar' is no=
t followed by the definition
+tests/qapi-schema/doc-missing-expr.qapi:3: Documentation for 'bar' is no=
t followed by the definition
diff --git a/tests/qapi-schema/doc-missing-expr.json b/tests/qapi-schema/=
doc-missing-expr.qapi
similarity index 100%
rename from tests/qapi-schema/doc-missing-expr.json
rename to tests/qapi-schema/doc-missing-expr.qapi
diff --git a/tests/qapi-schema/doc-missing-space.err b/tests/qapi-schema/=
doc-missing-space.err
index d6b46ffd778..756122f26b1 100644
--- a/tests/qapi-schema/doc-missing-space.err
+++ b/tests/qapi-schema/doc-missing-space.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-space.json:5:1: Missing space after #
+tests/qapi-schema/doc-missing-space.qapi:5:1: Missing space after #
diff --git a/tests/qapi-schema/doc-missing-space.json b/tests/qapi-schema=
/doc-missing-space.qapi
similarity index 100%
rename from tests/qapi-schema/doc-missing-space.json
rename to tests/qapi-schema/doc-missing-space.qapi
diff --git a/tests/qapi-schema/doc-missing.err b/tests/qapi-schema/doc-mi=
ssing.err
index 7f2f326b30a..2b44937a201 100644
--- a/tests/qapi-schema/doc-missing.err
+++ b/tests/qapi-schema/doc-missing.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing.json:5: Expression missing documentation c=
omment
+tests/qapi-schema/doc-missing.qapi:5: Expression missing documentation c=
omment
diff --git a/tests/qapi-schema/doc-missing.json b/tests/qapi-schema/doc-m=
issing.qapi
similarity index 100%
rename from tests/qapi-schema/doc-missing.json
rename to tests/qapi-schema/doc-missing.qapi
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-=
no-symbol.err
index 75f032a9421..212c1241d7d 100644
--- a/tests/qapi-schema/doc-no-symbol.err
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-no-symbol.json:3: Expression documentation require=
d
+tests/qapi-schema/doc-no-symbol.qapi:3: Expression documentation require=
d
diff --git a/tests/qapi-schema/doc-no-symbol.json b/tests/qapi-schema/doc=
-no-symbol.qapi
similarity index 100%
rename from tests/qapi-schema/doc-no-symbol.json
rename to tests/qapi-schema/doc-no-symbol.qapi
diff --git a/tests/qapi-schema/double-data.err b/tests/qapi-schema/double=
-data.err
index cc765c4ff23..afa6b9ec681 100644
--- a/tests/qapi-schema/double-data.err
+++ b/tests/qapi-schema/double-data.err
@@ -1 +1 @@
-tests/qapi-schema/double-data.json:2:41: Duplicate key "data"
+tests/qapi-schema/double-data.qapi:2:41: Duplicate key "data"
diff --git a/tests/qapi-schema/double-data.json b/tests/qapi-schema/doubl=
e-data.qapi
similarity index 100%
rename from tests/qapi-schema/double-data.json
rename to tests/qapi-schema/double-data.qapi
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index f9613c6d6b5..95df26ced22 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1 +1 @@
-tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.qapi:2: Unknown key 'command' in struct 'b=
ar'
diff --git a/tests/qapi-schema/double-type.json b/tests/qapi-schema/doubl=
e-type.qapi
similarity index 100%
rename from tests/qapi-schema/double-type.json
rename to tests/qapi-schema/double-type.qapi
diff --git a/tests/qapi-schema/duplicate-key.err b/tests/qapi-schema/dupl=
icate-key.err
index 6d02f835388..2bf72416f56 100644
--- a/tests/qapi-schema/duplicate-key.err
+++ b/tests/qapi-schema/duplicate-key.err
@@ -1 +1 @@
-tests/qapi-schema/duplicate-key.json:3:10: Duplicate key "key"
+tests/qapi-schema/duplicate-key.qapi:3:10: Duplicate key "key"
diff --git a/tests/qapi-schema/duplicate-key.json b/tests/qapi-schema/dup=
licate-key.qapi
similarity index 100%
rename from tests/qapi-schema/duplicate-key.json
rename to tests/qapi-schema/duplicate-key.qapi
diff --git a/tests/qapi-schema/empty.json b/tests/qapi-schema/empty.qapi
similarity index 100%
rename from tests/qapi-schema/empty.json
rename to tests/qapi-schema/empty.qapi
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index 9c3c1002b78..485965dfb99 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1 +1 @@
-tests/qapi-schema/enum-bad-name.json:2: Member of enum 'MyEnum' uses inv=
alid name 'not^possible'
+tests/qapi-schema/enum-bad-name.qapi:2: Member of enum 'MyEnum' uses inv=
alid name 'not^possible'
diff --git a/tests/qapi-schema/enum-bad-name.json b/tests/qapi-schema/enu=
m-bad-name.qapi
similarity index 100%
rename from tests/qapi-schema/enum-bad-name.json
rename to tests/qapi-schema/enum-bad-name.qapi
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 399f5f7af5c..10ef1ca6192 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1 +1 @@
-tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a strin=
g for 'prefix'
+tests/qapi-schema/enum-bad-prefix.qapi:2: Enum 'MyEnum' requires a strin=
g for 'prefix'
diff --git a/tests/qapi-schema/enum-bad-prefix.json b/tests/qapi-schema/e=
num-bad-prefix.qapi
similarity index 100%
rename from tests/qapi-schema/enum-bad-prefix.json
rename to tests/qapi-schema/enum-bad-prefix.qapi
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 5403c785079..3a1b6d95e23 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-clash-member.json:2: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
+tests/qapi-schema/enum-clash-member.qapi:2: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
diff --git a/tests/qapi-schema/enum-clash-member.json b/tests/qapi-schema=
/enum-clash-member.qapi
similarity index 100%
rename from tests/qapi-schema/enum-clash-member.json
rename to tests/qapi-schema/enum-clash-member.qapi
diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/e=
num-dict-member.err
index 8ca146ea592..e758d0f4de1 100644
--- a/tests/qapi-schema/enum-dict-member.err
+++ b/tests/qapi-schema/enum-dict-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requi=
res a string name
+tests/qapi-schema/enum-dict-member.qapi:2: Member of enum 'MyEnum' requi=
res a string name
diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema/=
enum-dict-member.qapi
similarity index 100%
rename from tests/qapi-schema/enum-dict-member.json
rename to tests/qapi-schema/enum-dict-member.qapi
diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/en=
um-int-member.err
index 071c5213d8e..25d0034786f 100644
--- a/tests/qapi-schema/enum-int-member.err
+++ b/tests/qapi-schema/enum-int-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-int-member.json:3:31: Stray "1"
+tests/qapi-schema/enum-int-member.qapi:3:31: Stray "1"
diff --git a/tests/qapi-schema/enum-int-member.json b/tests/qapi-schema/e=
num-int-member.qapi
similarity index 100%
rename from tests/qapi-schema/enum-int-member.json
rename to tests/qapi-schema/enum-int-member.qapi
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index 3c67a3a067e..73bb81caf72 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/enum-member-case.json:4: 'Value' (member of NoWayThisW=
illGetWhitelisted) should not use uppercase
+tests/qapi-schema/enum-member-case.qapi:4: 'Value' (member of NoWayThisW=
illGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/enum-member-case.json b/tests/qapi-schema/=
enum-member-case.qapi
similarity index 100%
rename from tests/qapi-schema/enum-member-case.json
rename to tests/qapi-schema/enum-member-case.qapi
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index ba4873ae69a..ed90e42f0c8 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.qapi:2: Key 'data' is missing from e=
num 'MyEnum'
diff --git a/tests/qapi-schema/enum-missing-data.json b/tests/qapi-schema=
/enum-missing-data.qapi
similarity index 100%
rename from tests/qapi-schema/enum-missing-data.json
rename to tests/qapi-schema/enum-missing-data.qapi
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index 11b43471cf3..8cb349fc51a 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an arra=
y for 'data'
+tests/qapi-schema/enum-wrong-data.qapi:2: Enum 'MyEnum' requires an arra=
y for 'data'
diff --git a/tests/qapi-schema/enum-wrong-data.json b/tests/qapi-schema/e=
num-wrong-data.qapi
similarity index 100%
rename from tests/qapi-schema/enum-wrong-data.json
rename to tests/qapi-schema/enum-wrong-data.qapi
diff --git a/tests/qapi-schema/escape-outside-string.err b/tests/qapi-sch=
ema/escape-outside-string.err
index b9b8837fd2e..3e3bcd76f6e 100644
--- a/tests/qapi-schema/escape-outside-string.err
+++ b/tests/qapi-schema/escape-outside-string.err
@@ -1 +1 @@
-tests/qapi-schema/escape-outside-string.json:3:27: Stray "\"
+tests/qapi-schema/escape-outside-string.qapi:3:27: Stray "\"
diff --git a/tests/qapi-schema/escape-outside-string.json b/tests/qapi-sc=
hema/escape-outside-string.qapi
similarity index 100%
rename from tests/qapi-schema/escape-outside-string.json
rename to tests/qapi-schema/escape-outside-string.qapi
diff --git a/tests/qapi-schema/escape-too-big.err b/tests/qapi-schema/esc=
ape-too-big.err
index d9aeb5dc38a..9ade8c10de1 100644
--- a/tests/qapi-schema/escape-too-big.err
+++ b/tests/qapi-schema/escape-too-big.err
@@ -1 +1 @@
-tests/qapi-schema/escape-too-big.json:3:14: For now, \u escape only supp=
orts non-zero values up to \u007f
+tests/qapi-schema/escape-too-big.qapi:3:14: For now, \u escape only supp=
orts non-zero values up to \u007f
diff --git a/tests/qapi-schema/escape-too-big.json b/tests/qapi-schema/es=
cape-too-big.qapi
similarity index 100%
rename from tests/qapi-schema/escape-too-big.json
rename to tests/qapi-schema/escape-too-big.qapi
diff --git a/tests/qapi-schema/escape-too-short.err b/tests/qapi-schema/e=
scape-too-short.err
index 934de598ee2..7c36fe81a54 100644
--- a/tests/qapi-schema/escape-too-short.err
+++ b/tests/qapi-schema/escape-too-short.err
@@ -1 +1 @@
-tests/qapi-schema/escape-too-short.json:3:14: \u escape needs 4 hex digi=
ts
+tests/qapi-schema/escape-too-short.qapi:3:14: \u escape needs 4 hex digi=
ts
diff --git a/tests/qapi-schema/escape-too-short.json b/tests/qapi-schema/=
escape-too-short.qapi
similarity index 100%
rename from tests/qapi-schema/escape-too-short.json
rename to tests/qapi-schema/escape-too-short.qapi
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index 68ec6f2d2bd..5ae28cd9319 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1 +1 @@
-tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'dat=
a'
+tests/qapi-schema/event-boxed-empty.qapi:2: Use of 'boxed' requires 'dat=
a'
diff --git a/tests/qapi-schema/event-boxed-empty.json b/tests/qapi-schema=
/event-boxed-empty.qapi
similarity index 100%
rename from tests/qapi-schema/event-boxed-empty.json
rename to tests/qapi-schema/event-boxed-empty.qapi
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 88c0964917a..6fbaefb98c3 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,6 +1,6 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module event-case.json
+module event-case.qapi
 event oops None
    boxed=3DFalse
diff --git a/tests/qapi-schema/event-case.json b/tests/qapi-schema/event-=
case.qapi
similarity index 100%
rename from tests/qapi-schema/event-case.json
rename to tests/qapi-schema/event-case.qapi
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 5a42701b8f2..7d94765c06f 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1 +1 @@
-tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
+tests/qapi-schema/event-nest-struct.qapi:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
diff --git a/tests/qapi-schema/event-nest-struct.json b/tests/qapi-schema=
/event-nest-struct.qapi
similarity index 100%
rename from tests/qapi-schema/event-nest-struct.json
rename to tests/qapi-schema/event-nest-struct.qapi
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index 8ea91eadb2d..cd767b524c3 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of uni=
on 'TestUnion' cannot be an array
+tests/qapi-schema/flat-union-array-branch.qapi:8: Member 'value1' of uni=
on 'TestUnion' cannot be an array
diff --git a/tests/qapi-schema/flat-union-array-branch.json b/tests/qapi-=
schema/flat-union-array-branch.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-array-branch.json
rename to tests/qapi-schema/flat-union-array-branch.qapi
diff --git a/tests/qapi-schema/flat-union-bad-base.err b/tests/qapi-schem=
a/flat-union-bad-base.err
index bee24a217ae..e09b8b3cdf0 100644
--- a/tests/qapi-schema/flat-union-bad-base.err
+++ b/tests/qapi-schema/flat-union-bad-base.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of TestTy=
peA) collides with 'string' (base of TestUnion)
+tests/qapi-schema/flat-union-bad-base.qapi:8: 'string' (member of TestTy=
peA) collides with 'string' (base of TestUnion)
diff --git a/tests/qapi-schema/flat-union-bad-base.json b/tests/qapi-sche=
ma/flat-union-bad-base.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-bad-base.json
rename to tests/qapi-schema/flat-union-bad-base.qapi
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index c38cc8e4dfd..c2817008c5f 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator of=
 flat union 'TestUnion' requires a string name
+tests/qapi-schema/flat-union-bad-discriminator.qapi:11: Discriminator of=
 flat union 'TestUnion' requires a string name
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.json b/tests/=
qapi-schema/flat-union-bad-discriminator.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-bad-discriminator.json
rename to tests/qapi-schema/flat-union-bad-discriminator.qapi
diff --git a/tests/qapi-schema/flat-union-base-any.err b/tests/qapi-schem=
a/flat-union-base-any.err
index 646f1c9cd11..feed578a29b 100644
--- a/tests/qapi-schema/flat-union-base-any.err
+++ b/tests/qapi-schema/flat-union-base-any.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-base-any.json:8: 'base' for union 'TestUnio=
n' cannot use built-in type 'any'
+tests/qapi-schema/flat-union-base-any.qapi:8: 'base' for union 'TestUnio=
n' cannot use built-in type 'any'
diff --git a/tests/qapi-schema/flat-union-base-any.json b/tests/qapi-sche=
ma/flat-union-base-any.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-base-any.json
rename to tests/qapi-schema/flat-union-base-any.qapi
diff --git a/tests/qapi-schema/flat-union-base-union.err b/tests/qapi-sch=
ema/flat-union-base-union.err
index f138395e456..9fca152d2c8 100644
--- a/tests/qapi-schema/flat-union-base-union.err
+++ b/tests/qapi-schema/flat-union-base-union.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-base-union.json:14: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
+tests/qapi-schema/flat-union-base-union.qapi:14: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
diff --git a/tests/qapi-schema/flat-union-base-union.json b/tests/qapi-sc=
hema/flat-union-base-union.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-base-union.json
rename to tests/qapi-schema/flat-union-base-union.qapi
diff --git a/tests/qapi-schema/flat-union-clash-member.err b/tests/qapi-s=
chema/flat-union-clash-member.err
index 2adf69755ab..bd8dc62222e 100644
--- a/tests/qapi-schema/flat-union-clash-member.err
+++ b/tests/qapi-schema/flat-union-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
+tests/qapi-schema/flat-union-clash-member.qapi:11: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/flat-union-clash-member.json b/tests/qapi-=
schema/flat-union-clash-member.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-clash-member.json
rename to tests/qapi-schema/flat-union-clash-member.qapi
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index 15754f54eb9..b39f0761e94 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-empty.json:4: Union 'Union' cannot have emp=
ty 'data'
+tests/qapi-schema/flat-union-empty.qapi:4: Union 'Union' cannot have emp=
ty 'data'
diff --git a/tests/qapi-schema/flat-union-empty.json b/tests/qapi-schema/=
flat-union-empty.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-empty.json
rename to tests/qapi-schema/flat-union-empty.qapi
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err b/tests/q=
api-schema/flat-union-incomplete-branch.err
index e826bf07893..9fe7d2f43cd 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.err
+++ b/tests/qapi-schema/flat-union-incomplete-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion'=
 data missing 'value2' branch
+tests/qapi-schema/flat-union-incomplete-branch.qapi:6: Union 'TestUnion'=
 data missing 'value2' branch
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json b/tests/=
qapi-schema/flat-union-incomplete-branch.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-incomplete-branch.json
rename to tests/qapi-schema/flat-union-incomplete-branch.qapi
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 2333358d28b..d16e6cd87c5 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union 'Te=
stUnion' should be a type name
+tests/qapi-schema/flat-union-inline.qapi:7: Member 'value1' of union 'Te=
stUnion' should be a type name
diff --git a/tests/qapi-schema/flat-union-inline.json b/tests/qapi-schema=
/flat-union-inline.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-inline.json
rename to tests/qapi-schema/flat-union-inline.qapi
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index faf01573b79..8baf223a691 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
+tests/qapi-schema/flat-union-int-branch.qapi:8: Member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/flat-union-int-branch.json b/tests/qapi-sc=
hema/flat-union-int-branch.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-int-branch.json
rename to tests/qapi-schema/flat-union-int-branch.qapi
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index ccf72d2dfe2..3dfc7521810 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
+tests/qapi-schema/flat-union-invalid-branch-key.qapi:13: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.json b/tests=
/qapi-schema/flat-union-invalid-branch-key.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-invalid-branch-key.json
rename to tests/qapi-schema/flat-union-invalid-branch-key.qapi
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index 5f4055614ea..5490a3fa942 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-discriminator.json:13: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
+tests/qapi-schema/flat-union-invalid-discriminator.qapi:13: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json b/te=
sts/qapi-schema/flat-union-invalid-discriminator.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-invalid-discriminator.json
rename to tests/qapi-schema/flat-union-invalid-discriminator.qapi
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index 841c93b5544..b0de89317d8 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' must=
 have a base
+tests/qapi-schema/flat-union-no-base.qapi:9: Flat union 'TestUnion' must=
 have a base
diff --git a/tests/qapi-schema/flat-union-no-base.json b/tests/qapi-schem=
a/flat-union-no-base.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-no-base.json
rename to tests/qapi-schema/flat-union-no-base.qapi
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index aaabedb3bd6..d905598456b 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
+tests/qapi-schema/flat-union-optional-discriminator.qapi:6: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/t=
ests/qapi-schema/flat-union-optional-discriminator.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.json
rename to tests/qapi-schema/flat-union-optional-discriminator.qapi
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index 200016bd5c5..d8ce54a09f0 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminator=
 'kind' must be of enumeration type
+tests/qapi-schema/flat-union-string-discriminator.qapi:13: Discriminator=
 'kind' must be of enumeration type
diff --git a/tests/qapi-schema/flat-union-string-discriminator.json b/tes=
ts/qapi-schema/flat-union-string-discriminator.qapi
similarity index 100%
rename from tests/qapi-schema/flat-union-string-discriminator.json
rename to tests/qapi-schema/flat-union-string-discriminator.qapi
diff --git a/tests/qapi-schema/funny-char.err b/tests/qapi-schema/funny-c=
har.err
index bfc890cd9f2..990b44e1468 100644
--- a/tests/qapi-schema/funny-char.err
+++ b/tests/qapi-schema/funny-char.err
@@ -1 +1 @@
-tests/qapi-schema/funny-char.json:2:36: Stray ";"
+tests/qapi-schema/funny-char.qapi:2:36: Stray ";"
diff --git a/tests/qapi-schema/funny-char.json b/tests/qapi-schema/funny-=
char.qapi
similarity index 100%
rename from tests/qapi-schema/funny-char.json
rename to tests/qapi-schema/funny-char.qapi
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 82213aa51dd..3bb7c434340 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,7 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module ident-with-escape.json
+module ident-with-escape.qapi
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
 command fooA q_obj_fooA-arg -> None
diff --git a/tests/qapi-schema/ident-with-escape.json b/tests/qapi-schema=
/ident-with-escape.qapi
similarity index 100%
rename from tests/qapi-schema/ident-with-escape.json
rename to tests/qapi-schema/ident-with-escape.qapi
diff --git a/tests/qapi-schema/include-before-err.err b/tests/qapi-schema=
/include-before-err.err
index 55652751e10..d9f0cf5db10 100644
--- a/tests/qapi-schema/include-before-err.err
+++ b/tests/qapi-schema/include-before-err.err
@@ -1 +1 @@
-tests/qapi-schema/include-before-err.json:2:13: Expected ":"
+tests/qapi-schema/include-before-err.qapi:2:13: Expected ":"
diff --git a/tests/qapi-schema/include-before-err.json b/tests/qapi-schem=
a/include-before-err.json
deleted file mode 100644
index afb6cb63c47..00000000000
--- a/tests/qapi-schema/include-before-err.json
+++ /dev/null
@@ -1,2 +0,0 @@
-{ 'include': 'include-simple-sub.json' }
-{ 'command' 'missing-colon' }
diff --git a/tests/qapi-schema/include-before-err.qapi b/tests/qapi-schem=
a/include-before-err.qapi
new file mode 100644
index 00000000000..f1e5fa6d417
--- /dev/null
+++ b/tests/qapi-schema/include-before-err.qapi
@@ -0,0 +1,2 @@
+{ 'include': 'include-simple-sub.qapi' }
+{ 'command' 'missing-colon' }
diff --git a/tests/qapi-schema/include-cycle-b.json b/tests/qapi-schema/i=
nclude-cycle-b.json
deleted file mode 100644
index 4fa985dcd59..00000000000
--- a/tests/qapi-schema/include-cycle-b.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include-cycle-c.json' }
diff --git a/tests/qapi-schema/include-cycle-b.qapi b/tests/qapi-schema/i=
nclude-cycle-b.qapi
new file mode 100644
index 00000000000..ef8aa0d8bdb
--- /dev/null
+++ b/tests/qapi-schema/include-cycle-b.qapi
@@ -0,0 +1 @@
+{ 'include': 'include-cycle-c.qapi' }
diff --git a/tests/qapi-schema/include-cycle-c.json b/tests/qapi-schema/i=
nclude-cycle-c.json
deleted file mode 100644
index d12b5924a36..00000000000
--- a/tests/qapi-schema/include-cycle-c.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include-cycle.json' }
diff --git a/tests/qapi-schema/include-cycle-c.qapi b/tests/qapi-schema/i=
nclude-cycle-c.qapi
new file mode 100644
index 00000000000..dfa26a712ab
--- /dev/null
+++ b/tests/qapi-schema/include-cycle-c.qapi
@@ -0,0 +1 @@
+{ 'include': 'include-cycle.qapi' }
diff --git a/tests/qapi-schema/include-cycle.err b/tests/qapi-schema/incl=
ude-cycle.err
index bdcd07dce25..99a1ea20fc8 100644
--- a/tests/qapi-schema/include-cycle.err
+++ b/tests/qapi-schema/include-cycle.err
@@ -1,3 +1,3 @@
-In file included from tests/qapi-schema/include-cycle.json:1:
-In file included from tests/qapi-schema/include-cycle-b.json:1:
-tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cyc=
le.json
+In file included from tests/qapi-schema/include-cycle.qapi:1:
+In file included from tests/qapi-schema/include-cycle-b.qapi:1:
+tests/qapi-schema/include-cycle-c.qapi:1: Inclusion loop for include-cyc=
le.qapi
diff --git a/tests/qapi-schema/include-cycle.json b/tests/qapi-schema/inc=
lude-cycle.json
deleted file mode 100644
index 6fcf1ebaac8..00000000000
--- a/tests/qapi-schema/include-cycle.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include-cycle-b.json' }
diff --git a/tests/qapi-schema/include-cycle.qapi b/tests/qapi-schema/inc=
lude-cycle.qapi
new file mode 100644
index 00000000000..9feca30e6de
--- /dev/null
+++ b/tests/qapi-schema/include-cycle.qapi
@@ -0,0 +1 @@
+{ 'include': 'include-cycle-b.qapi' }
diff --git a/tests/qapi-schema/include-extra-junk.err b/tests/qapi-schema=
/include-extra-junk.err
index e6ef2a3720d..4a98d794483 100644
--- a/tests/qapi-schema/include-extra-junk.err
+++ b/tests/qapi-schema/include-extra-junk.err
@@ -1 +1 @@
-tests/qapi-schema/include-extra-junk.json:3: Invalid 'include' directive
+tests/qapi-schema/include-extra-junk.qapi:3: Invalid 'include' directive
diff --git a/tests/qapi-schema/include-extra-junk.json b/tests/qapi-schem=
a/include-extra-junk.json
deleted file mode 100644
index 25fe85078de..00000000000
--- a/tests/qapi-schema/include-extra-junk.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# 'include' must be the sole member
-
-{ 'include': 'comments.json', 'junk': true }
diff --git a/tests/qapi-schema/include-extra-junk.qapi b/tests/qapi-schem=
a/include-extra-junk.qapi
new file mode 100644
index 00000000000..609f9d5449f
--- /dev/null
+++ b/tests/qapi-schema/include-extra-junk.qapi
@@ -0,0 +1,3 @@
+# 'include' must be the sole member
+
+{ 'include': 'comments.qapi', 'junk': true }
diff --git a/tests/qapi-schema/include-format-err.err b/tests/qapi-schema=
/include-format-err.err
index 721ff4eccc0..1143089323b 100644
--- a/tests/qapi-schema/include-format-err.err
+++ b/tests/qapi-schema/include-format-err.err
@@ -1 +1 @@
-tests/qapi-schema/include-format-err.json:1: Invalid 'include' directive
+tests/qapi-schema/include-format-err.qapi:1: Invalid 'include' directive
diff --git a/tests/qapi-schema/include-format-err.json b/tests/qapi-schem=
a/include-format-err.json
deleted file mode 100644
index 44980f026f8..00000000000
--- a/tests/qapi-schema/include-format-err.json
+++ /dev/null
@@ -1,2 +0,0 @@
-{ 'include': 'include-simple-sub.json',
-  'foo': 'bar' }
diff --git a/tests/qapi-schema/include-format-err.qapi b/tests/qapi-schem=
a/include-format-err.qapi
new file mode 100644
index 00000000000..f17f16e6dc3
--- /dev/null
+++ b/tests/qapi-schema/include-format-err.qapi
@@ -0,0 +1,2 @@
+{ 'include': 'include-simple-sub.qapi',
+  'foo': 'bar' }
diff --git a/tests/qapi-schema/include-nested-err.err b/tests/qapi-schema=
/include-nested-err.err
index 1b7b22706be..9a13aa8a802 100644
--- a/tests/qapi-schema/include-nested-err.err
+++ b/tests/qapi-schema/include-nested-err.err
@@ -1,2 +1,2 @@
-In file included from tests/qapi-schema/include-nested-err.json:1:
-tests/qapi-schema/missing-colon.json:1:10: Expected ":"
+In file included from tests/qapi-schema/include-nested-err.qapi:1:
+tests/qapi-schema/missing-colon.qapi:1:10: Expected ":"
diff --git a/tests/qapi-schema/include-nested-err.json b/tests/qapi-schem=
a/include-nested-err.json
deleted file mode 100644
index 5631e56ea0d..00000000000
--- a/tests/qapi-schema/include-nested-err.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'missing-colon.json' }
diff --git a/tests/qapi-schema/include-nested-err.qapi b/tests/qapi-schem=
a/include-nested-err.qapi
new file mode 100644
index 00000000000..34b249824fb
--- /dev/null
+++ b/tests/qapi-schema/include-nested-err.qapi
@@ -0,0 +1 @@
+{ 'include': 'missing-colon.qapi' }
diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/in=
clude-no-file.err
index e42bcf4bc1a..770db16793c 100644
--- a/tests/qapi-schema/include-no-file.err
+++ b/tests/qapi-schema/include-no-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-no-file.json:1: No such file or directory: tes=
ts/qapi-schema/include-no-file-sub.json
+tests/qapi-schema/include-no-file.qapi:1: No such file or directory: tes=
ts/qapi-schema/include-no-file-sub.qapi
diff --git a/tests/qapi-schema/include-no-file.json b/tests/qapi-schema/i=
nclude-no-file.json
deleted file mode 100644
index 9249ebd50c2..00000000000
--- a/tests/qapi-schema/include-no-file.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include-no-file-sub.json' }
diff --git a/tests/qapi-schema/include-no-file.qapi b/tests/qapi-schema/i=
nclude-no-file.qapi
new file mode 100644
index 00000000000..2f0d0633eb5
--- /dev/null
+++ b/tests/qapi-schema/include-no-file.qapi
@@ -0,0 +1 @@
+{ 'include': 'include-no-file-sub.qapi' }
diff --git a/tests/qapi-schema/include-non-file.err b/tests/qapi-schema/i=
nclude-non-file.err
index faae1eacf1a..5f60d553727 100644
--- a/tests/qapi-schema/include-non-file.err
+++ b/tests/qapi-schema/include-non-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-non-file.json:1: Value of 'include' must be a =
string
+tests/qapi-schema/include-non-file.qapi:1: Value of 'include' must be a =
string
diff --git a/tests/qapi-schema/include-non-file.json b/tests/qapi-schema/=
include-non-file.qapi
similarity index 100%
rename from tests/qapi-schema/include-non-file.json
rename to tests/qapi-schema/include-non-file.qapi
diff --git a/tests/qapi-schema/include-relpath-sub.json b/tests/qapi-sche=
ma/include-relpath-sub.qapi
similarity index 100%
rename from tests/qapi-schema/include-relpath-sub.json
rename to tests/qapi-schema/include-relpath-sub.qapi
diff --git a/tests/qapi-schema/include-relpath.json b/tests/qapi-schema/i=
nclude-relpath.json
deleted file mode 100644
index 05018f39083..00000000000
--- a/tests/qapi-schema/include-relpath.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include/relpath.json' }
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index ebbabd7a186..67828f2cebd 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,9 +1,9 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module include-relpath.json
-include include/relpath.json
-module include/relpath.json
-include include-relpath-sub.json
-module include-relpath-sub.json
+module include-relpath.qapi
+include include/relpath.qapi
+module include/relpath.qapi
+include include-relpath-sub.qapi
+module include-relpath-sub.qapi
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/include-relpath.qapi b/tests/qapi-schema/i=
nclude-relpath.qapi
new file mode 100644
index 00000000000..f4e5205084f
--- /dev/null
+++ b/tests/qapi-schema/include-relpath.qapi
@@ -0,0 +1 @@
+{ 'include': 'include/relpath.qapi' }
diff --git a/tests/qapi-schema/include-repetition-sub.json b/tests/qapi-s=
chema/include-repetition-sub.json
deleted file mode 100644
index 6bfffdfd556..00000000000
--- a/tests/qapi-schema/include-repetition-sub.json
+++ /dev/null
@@ -1,2 +0,0 @@
-{ 'include': 'comments.json' }
-{ 'include': 'comments.json' }
diff --git a/tests/qapi-schema/include-repetition-sub.qapi b/tests/qapi-s=
chema/include-repetition-sub.qapi
new file mode 100644
index 00000000000..92bcc7fab47
--- /dev/null
+++ b/tests/qapi-schema/include-repetition-sub.qapi
@@ -0,0 +1,2 @@
+{ 'include': 'comments.qapi' }
+{ 'include': 'comments.qapi' }
diff --git a/tests/qapi-schema/include-repetition.json b/tests/qapi-schem=
a/include-repetition.json
deleted file mode 100644
index ec329dde586..00000000000
--- a/tests/qapi-schema/include-repetition.json
+++ /dev/null
@@ -1,3 +0,0 @@
-{ 'include': 'comments.json' }
-{ 'include': 'include-repetition-sub.json' }
-{ 'include': 'comments.json' }
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 7235e055bc1..6c4c8aec5d8 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,14 +1,14 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module include-repetition.json
-include comments.json
-module comments.json
+module include-repetition.qapi
+include comments.qapi
+module comments.qapi
 enum Status ['good', 'bad', 'ugly']
-module include-repetition.json
-include include-repetition-sub.json
-module include-repetition-sub.json
-include comments.json
-include comments.json
-module include-repetition.json
-include comments.json
+module include-repetition.qapi
+include include-repetition-sub.qapi
+module include-repetition-sub.qapi
+include comments.qapi
+include comments.qapi
+module include-repetition.qapi
+include comments.qapi
diff --git a/tests/qapi-schema/include-repetition.qapi b/tests/qapi-schem=
a/include-repetition.qapi
new file mode 100644
index 00000000000..7d0dd95c233
--- /dev/null
+++ b/tests/qapi-schema/include-repetition.qapi
@@ -0,0 +1,3 @@
+{ 'include': 'comments.qapi' }
+{ 'include': 'include-repetition-sub.qapi' }
+{ 'include': 'comments.qapi' }
diff --git a/tests/qapi-schema/include-self-cycle.err b/tests/qapi-schema=
/include-self-cycle.err
index 981742ae5f5..7c0f7711777 100644
--- a/tests/qapi-schema/include-self-cycle.err
+++ b/tests/qapi-schema/include-self-cycle.err
@@ -1 +1 @@
-tests/qapi-schema/include-self-cycle.json:1: Inclusion loop for include-=
self-cycle.json
+tests/qapi-schema/include-self-cycle.qapi:1: Inclusion loop for include-=
self-cycle.qapi
diff --git a/tests/qapi-schema/include-self-cycle.json b/tests/qapi-schem=
a/include-self-cycle.json
deleted file mode 100644
index 55fb1b596fa..00000000000
--- a/tests/qapi-schema/include-self-cycle.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include-self-cycle.json' }
diff --git a/tests/qapi-schema/include-self-cycle.qapi b/tests/qapi-schem=
a/include-self-cycle.qapi
new file mode 100644
index 00000000000..8517ba9e202
--- /dev/null
+++ b/tests/qapi-schema/include-self-cycle.qapi
@@ -0,0 +1 @@
+{ 'include': 'include-self-cycle.qapi' }
diff --git a/tests/qapi-schema/include-simple-sub.json b/tests/qapi-schem=
a/include-simple-sub.qapi
similarity index 100%
rename from tests/qapi-schema/include-simple-sub.json
rename to tests/qapi-schema/include-simple-sub.qapi
diff --git a/tests/qapi-schema/include-simple.json b/tests/qapi-schema/in=
clude-simple.json
deleted file mode 100644
index 1dd391a5925..00000000000
--- a/tests/qapi-schema/include-simple.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include-simple-sub.json' }
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 006f723eebc..3ec2d051c33 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,7 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module include-simple.json
-include include-simple-sub.json
-module include-simple-sub.json
+module include-simple.qapi
+include include-simple-sub.qapi
+module include-simple-sub.qapi
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/include-simple.qapi b/tests/qapi-schema/in=
clude-simple.qapi
new file mode 100644
index 00000000000..312aa7ed7f3
--- /dev/null
+++ b/tests/qapi-schema/include-simple.qapi
@@ -0,0 +1 @@
+{ 'include': 'include-simple-sub.qapi' }
diff --git a/tests/qapi-schema/include/relpath.json b/tests/qapi-schema/i=
nclude/relpath.json
deleted file mode 100644
index 45dee247048..00000000000
--- a/tests/qapi-schema/include/relpath.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': '../include-relpath-sub.json' }
diff --git a/tests/qapi-schema/include/relpath.qapi b/tests/qapi-schema/i=
nclude/relpath.qapi
new file mode 100644
index 00000000000..081be90ef70
--- /dev/null
+++ b/tests/qapi-schema/include/relpath.qapi
@@ -0,0 +1 @@
+{ 'include': '../include-relpath-sub.qapi' }
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index 862678f8f4c..8c59290610d 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,7 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module indented-expr.json
+module indented-expr.qapi
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 command zwei None -> None
diff --git a/tests/qapi-schema/indented-expr.json b/tests/qapi-schema/ind=
ented-expr.qapi
similarity index 100%
rename from tests/qapi-schema/indented-expr.json
rename to tests/qapi-schema/indented-expr.qapi
diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schema=
/leading-comma-list.err
index f5c870bb9c4..0c8eb27cb5d 100644
--- a/tests/qapi-schema/leading-comma-list.err
+++ b/tests/qapi-schema/leading-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]", =
string, boolean or "null"
+tests/qapi-schema/leading-comma-list.qapi:2:13: Expected "{", "[", "]", =
string, boolean or "null"
diff --git a/tests/qapi-schema/leading-comma-list.json b/tests/qapi-schem=
a/leading-comma-list.qapi
similarity index 100%
rename from tests/qapi-schema/leading-comma-list.json
rename to tests/qapi-schema/leading-comma-list.qapi
diff --git a/tests/qapi-schema/leading-comma-object.err b/tests/qapi-sche=
ma/leading-comma-object.err
index f767b95544e..ca86113ddd7 100644
--- a/tests/qapi-schema/leading-comma-object.err
+++ b/tests/qapi-schema/leading-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-object.json:1:3: Expected string or "}"
+tests/qapi-schema/leading-comma-object.qapi:1:3: Expected string or "}"
diff --git a/tests/qapi-schema/leading-comma-object.json b/tests/qapi-sch=
ema/leading-comma-object.qapi
similarity index 100%
rename from tests/qapi-schema/leading-comma-object.json
rename to tests/qapi-schema/leading-comma-object.qapi
diff --git a/tests/qapi-schema/missing-colon.err b/tests/qapi-schema/miss=
ing-colon.err
index d9d66b377af..0b72b631c4e 100644
--- a/tests/qapi-schema/missing-colon.err
+++ b/tests/qapi-schema/missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/missing-colon.json:1:10: Expected ":"
+tests/qapi-schema/missing-colon.qapi:1:10: Expected ":"
diff --git a/tests/qapi-schema/missing-colon.json b/tests/qapi-schema/mis=
sing-colon.qapi
similarity index 100%
rename from tests/qapi-schema/missing-colon.json
rename to tests/qapi-schema/missing-colon.qapi
diff --git a/tests/qapi-schema/missing-comma-list.err b/tests/qapi-schema=
/missing-comma-list.err
index e73d2770d63..786cd6a95a6 100644
--- a/tests/qapi-schema/missing-comma-list.err
+++ b/tests/qapi-schema/missing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-list.json:2:20: Expected "," or "]"
+tests/qapi-schema/missing-comma-list.qapi:2:20: Expected "," or "]"
diff --git a/tests/qapi-schema/missing-comma-list.json b/tests/qapi-schem=
a/missing-comma-list.qapi
similarity index 100%
rename from tests/qapi-schema/missing-comma-list.json
rename to tests/qapi-schema/missing-comma-list.qapi
diff --git a/tests/qapi-schema/missing-comma-object.err b/tests/qapi-sche=
ma/missing-comma-object.err
index 52b3a8a1ec8..60bf1d014eb 100644
--- a/tests/qapi-schema/missing-comma-object.err
+++ b/tests/qapi-schema/missing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-object.json:2:3: Expected "," or "}"
+tests/qapi-schema/missing-comma-object.qapi:2:3: Expected "," or "}"
diff --git a/tests/qapi-schema/missing-comma-object.json b/tests/qapi-sch=
ema/missing-comma-object.qapi
similarity index 100%
rename from tests/qapi-schema/missing-comma-object.json
rename to tests/qapi-schema/missing-comma-object.qapi
diff --git a/tests/qapi-schema/missing-type.err b/tests/qapi-schema/missi=
ng-type.err
index b3e7b14e420..b8cb5d116c4 100644
--- a/tests/qapi-schema/missing-type.err
+++ b/tests/qapi-schema/missing-type.err
@@ -1 +1 @@
-tests/qapi-schema/missing-type.json:2: Expression is missing metatype
+tests/qapi-schema/missing-type.qapi:2: Expression is missing metatype
diff --git a/tests/qapi-schema/missing-type.json b/tests/qapi-schema/miss=
ing-type.qapi
similarity index 100%
rename from tests/qapi-schema/missing-type.json
rename to tests/qapi-schema/missing-type.qapi
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index da767bade23..6783e25ecf1 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1 +1 @@
-tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
+tests/qapi-schema/nested-struct-data.qapi:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
diff --git a/tests/qapi-schema/nested-struct-data.json b/tests/qapi-schem=
a/nested-struct-data.qapi
similarity index 100%
rename from tests/qapi-schema/nested-struct-data.json
rename to tests/qapi-schema/nested-struct-data.qapi
diff --git a/tests/qapi-schema/non-objects.err b/tests/qapi-schema/non-ob=
jects.err
index 334f0c91aea..3749ddf5159 100644
--- a/tests/qapi-schema/non-objects.err
+++ b/tests/qapi-schema/non-objects.err
@@ -1 +1 @@
-tests/qapi-schema/non-objects.json:1:1: Expected "{"
+tests/qapi-schema/non-objects.qapi:1:1: Expected "{"
diff --git a/tests/qapi-schema/non-objects.json b/tests/qapi-schema/non-o=
bjects.qapi
similarity index 100%
rename from tests/qapi-schema/non-objects.json
rename to tests/qapi-schema/non-objects.qapi
diff --git a/tests/qapi-schema/oob-test.err b/tests/qapi-schema/oob-test.=
err
index 35b60f74800..04ecc0921fb 100644
--- a/tests/qapi-schema/oob-test.err
+++ b/tests/qapi-schema/oob-test.err
@@ -1 +1 @@
-tests/qapi-schema/oob-test.json:2: 'allow-oob' of command 'oob-command-1=
' should only use true value
+tests/qapi-schema/oob-test.qapi:2: 'allow-oob' of command 'oob-command-1=
' should only use true value
diff --git a/tests/qapi-schema/oob-test.json b/tests/qapi-schema/oob-test=
.qapi
similarity index 100%
rename from tests/qapi-schema/oob-test.json
rename to tests/qapi-schema/oob-test.qapi
diff --git a/tests/qapi-schema/pragma-doc-required-crap.err b/tests/qapi-=
schema/pragma-doc-required-crap.err
index 39cd56cd483..08ed951aaf8 100644
--- a/tests/qapi-schema/pragma-doc-required-crap.err
+++ b/tests/qapi-schema/pragma-doc-required-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-doc-required-crap.json:3: Pragma 'doc-required'=
 must be boolean
+tests/qapi-schema/pragma-doc-required-crap.qapi:3: Pragma 'doc-required'=
 must be boolean
diff --git a/tests/qapi-schema/pragma-doc-required-crap.json b/tests/qapi=
-schema/pragma-doc-required-crap.qapi
similarity index 100%
rename from tests/qapi-schema/pragma-doc-required-crap.json
rename to tests/qapi-schema/pragma-doc-required-crap.qapi
diff --git a/tests/qapi-schema/pragma-extra-junk.err b/tests/qapi-schema/=
pragma-extra-junk.err
index 4481688dbf0..20a8ddc06fa 100644
--- a/tests/qapi-schema/pragma-extra-junk.err
+++ b/tests/qapi-schema/pragma-extra-junk.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-extra-junk.json:3: Invalid 'pragma' directive
+tests/qapi-schema/pragma-extra-junk.qapi:3: Invalid 'pragma' directive
diff --git a/tests/qapi-schema/pragma-extra-junk.json b/tests/qapi-schema=
/pragma-extra-junk.qapi
similarity index 100%
rename from tests/qapi-schema/pragma-extra-junk.json
rename to tests/qapi-schema/pragma-extra-junk.qapi
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.err b/test=
s/qapi-schema/pragma-name-case-whitelist-crap.err
index f83b97e075a..6f377553683 100644
--- a/tests/qapi-schema/pragma-name-case-whitelist-crap.err
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-name-case-whitelist-crap.json:3: Pragma name-ca=
se-whitelist must be a list of strings
+tests/qapi-schema/pragma-name-case-whitelist-crap.qapi:3: Pragma name-ca=
se-whitelist must be a list of strings
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.json b/tes=
ts/qapi-schema/pragma-name-case-whitelist-crap.qapi
similarity index 100%
rename from tests/qapi-schema/pragma-name-case-whitelist-crap.json
rename to tests/qapi-schema/pragma-name-case-whitelist-crap.qapi
diff --git a/tests/qapi-schema/pragma-non-dict.err b/tests/qapi-schema/pr=
agma-non-dict.err
index 75bc335aea4..d8a31c2ecd1 100644
--- a/tests/qapi-schema/pragma-non-dict.err
+++ b/tests/qapi-schema/pragma-non-dict.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-non-dict.json:3: Value of 'pragma' must be a di=
ctionary
+tests/qapi-schema/pragma-non-dict.qapi:3: Value of 'pragma' must be a di=
ctionary
diff --git a/tests/qapi-schema/pragma-non-dict.json b/tests/qapi-schema/p=
ragma-non-dict.qapi
similarity index 100%
rename from tests/qapi-schema/pragma-non-dict.json
rename to tests/qapi-schema/pragma-non-dict.qapi
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.err b/tests/=
qapi-schema/pragma-returns-whitelist-crap.err
index 5d770216749..12926a6d949 100644
--- a/tests/qapi-schema/pragma-returns-whitelist-crap.err
+++ b/tests/qapi-schema/pragma-returns-whitelist-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-returns-whitelist-crap.json:3: Pragma returns-w=
hitelist must be a list of strings
+tests/qapi-schema/pragma-returns-whitelist-crap.qapi:3: Pragma returns-w=
hitelist must be a list of strings
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.json b/tests=
/qapi-schema/pragma-returns-whitelist-crap.qapi
similarity index 100%
rename from tests/qapi-schema/pragma-returns-whitelist-crap.json
rename to tests/qapi-schema/pragma-returns-whitelist-crap.qapi
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 467577d770b..672bcda08a6 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,7 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-module qapi-schema-test.json
+module qapi-schema-test.qapi
 object TestStruct
     member integer: int optional=3DFalse
     member boolean: bool optional=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.qapi
similarity index 100%
rename from tests/qapi-schema/qapi-schema-test.json
rename to tests/qapi-schema/qapi-schema-test.qapi
diff --git a/tests/qapi-schema/quoted-structural-chars.err b/tests/qapi-s=
chema/quoted-structural-chars.err
index 9b183841ddd..33c160b6eb9 100644
--- a/tests/qapi-schema/quoted-structural-chars.err
+++ b/tests/qapi-schema/quoted-structural-chars.err
@@ -1 +1 @@
-tests/qapi-schema/quoted-structural-chars.json:1:1: Expected "{"
+tests/qapi-schema/quoted-structural-chars.qapi:1:1: Expected "{"
diff --git a/tests/qapi-schema/quoted-structural-chars.json b/tests/qapi-=
schema/quoted-structural-chars.qapi
similarity index 100%
rename from tests/qapi-schema/quoted-structural-chars.json
rename to tests/qapi-schema/quoted-structural-chars.qapi
diff --git a/tests/qapi-schema/redefined-builtin.err b/tests/qapi-schema/=
redefined-builtin.err
index b2757225c4e..45d5eb0b6bf 100644
--- a/tests/qapi-schema/redefined-builtin.err
+++ b/tests/qapi-schema/redefined-builtin.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-builtin.json:2: built-in 'size' is already d=
efined
+tests/qapi-schema/redefined-builtin.qapi:2: built-in 'size' is already d=
efined
diff --git a/tests/qapi-schema/redefined-builtin.json b/tests/qapi-schema=
/redefined-builtin.qapi
similarity index 100%
rename from tests/qapi-schema/redefined-builtin.json
rename to tests/qapi-schema/redefined-builtin.qapi
diff --git a/tests/qapi-schema/redefined-command.err b/tests/qapi-schema/=
redefined-command.err
index 82ae256e639..e18fa60ee27 100644
--- a/tests/qapi-schema/redefined-command.err
+++ b/tests/qapi-schema/redefined-command.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-command.json:3: command 'foo' is already def=
ined
+tests/qapi-schema/redefined-command.qapi:3: command 'foo' is already def=
ined
diff --git a/tests/qapi-schema/redefined-command.json b/tests/qapi-schema=
/redefined-command.qapi
similarity index 100%
rename from tests/qapi-schema/redefined-command.json
rename to tests/qapi-schema/redefined-command.qapi
diff --git a/tests/qapi-schema/redefined-event.err b/tests/qapi-schema/re=
defined-event.err
index 35429cb4818..843cb650d91 100644
--- a/tests/qapi-schema/redefined-event.err
+++ b/tests/qapi-schema/redefined-event.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-event.json:3: event 'EVENT_A' is already def=
ined
+tests/qapi-schema/redefined-event.qapi:3: event 'EVENT_A' is already def=
ined
diff --git a/tests/qapi-schema/redefined-event.json b/tests/qapi-schema/r=
edefined-event.qapi
similarity index 100%
rename from tests/qapi-schema/redefined-event.json
rename to tests/qapi-schema/redefined-event.qapi
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 06ea78c4781..67d273c1221 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-type.json:3: struct 'foo' is already defined
+tests/qapi-schema/redefined-type.qapi:3: struct 'foo' is already defined
diff --git a/tests/qapi-schema/redefined-type.json b/tests/qapi-schema/re=
defined-type.qapi
similarity index 100%
rename from tests/qapi-schema/redefined-type.json
rename to tests/qapi-schema/redefined-type.qapi
diff --git a/tests/qapi-schema/reserved-command-q.err b/tests/qapi-schema=
/reserved-command-q.err
index f939e044eba..91dd7ed8f08 100644
--- a/tests/qapi-schema/reserved-command-q.err
+++ b/tests/qapi-schema/reserved-command-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-command-q.json:5: 'command' uses invalid name=
 'q-unix'
+tests/qapi-schema/reserved-command-q.qapi:5: 'command' uses invalid name=
 'q-unix'
diff --git a/tests/qapi-schema/reserved-command-q.json b/tests/qapi-schem=
a/reserved-command-q.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-command-q.json
rename to tests/qapi-schema/reserved-command-q.qapi
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index e1c3480ee22..034c9bd6cfe 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-enum-q.json:4: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
+tests/qapi-schema/reserved-enum-q.qapi:4: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
diff --git a/tests/qapi-schema/reserved-enum-q.json b/tests/qapi-schema/r=
eserved-enum-q.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-enum-q.json
rename to tests/qapi-schema/reserved-enum-q.qapi
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index e7557714461..33630aa5689 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-has.json:5: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
+tests/qapi-schema/reserved-member-has.qapi:5: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
diff --git a/tests/qapi-schema/reserved-member-has.json b/tests/qapi-sche=
ma/reserved-member-has.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-member-has.json
rename to tests/qapi-schema/reserved-member-has.qapi
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index f3d5dd78187..6ccd4f0c70f 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-q.json:4: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
+tests/qapi-schema/reserved-member-q.qapi:4: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
diff --git a/tests/qapi-schema/reserved-member-q.json b/tests/qapi-schema=
/reserved-member-q.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-member-q.json
rename to tests/qapi-schema/reserved-member-q.qapi
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index 87d42296cc1..2587d3a1548 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-u.json:7: Member of 'data' for struct =
'Oops' uses reserved name 'u'
+tests/qapi-schema/reserved-member-u.qapi:7: Member of 'data' for struct =
'Oops' uses reserved name 'u'
diff --git a/tests/qapi-schema/reserved-member-u.json b/tests/qapi-schema=
/reserved-member-u.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-member-u.json
rename to tests/qapi-schema/reserved-member-u.qapi
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index 65ff0da8ce9..6080f0d6baf 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-underscore.json:4: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
+tests/qapi-schema/reserved-member-underscore.qapi:4: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
diff --git a/tests/qapi-schema/reserved-member-underscore.json b/tests/qa=
pi-schema/reserved-member-underscore.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-member-underscore.json
rename to tests/qapi-schema/reserved-member-underscore.qapi
diff --git a/tests/qapi-schema/reserved-type-kind.err b/tests/qapi-schema=
/reserved-type-kind.err
index 0a38efaad8d..0d2b05f3100 100644
--- a/tests/qapi-schema/reserved-type-kind.err
+++ b/tests/qapi-schema/reserved-type-kind.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-type-kind.json:2: enum 'UnionKind' should not=
 end in 'Kind'
+tests/qapi-schema/reserved-type-kind.qapi:2: enum 'UnionKind' should not=
 end in 'Kind'
diff --git a/tests/qapi-schema/reserved-type-kind.json b/tests/qapi-schem=
a/reserved-type-kind.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-type-kind.json
rename to tests/qapi-schema/reserved-type-kind.qapi
diff --git a/tests/qapi-schema/reserved-type-list.err b/tests/qapi-schema=
/reserved-type-list.err
index 4510fa6d903..0ee5c659be6 100644
--- a/tests/qapi-schema/reserved-type-list.err
+++ b/tests/qapi-schema/reserved-type-list.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-type-list.json:5: struct 'FooList' should not=
 end in 'List'
+tests/qapi-schema/reserved-type-list.qapi:5: struct 'FooList' should not=
 end in 'List'
diff --git a/tests/qapi-schema/reserved-type-list.json b/tests/qapi-schem=
a/reserved-type-list.qapi
similarity index 100%
rename from tests/qapi-schema/reserved-type-list.json
rename to tests/qapi-schema/reserved-type-list.qapi
diff --git a/tests/qapi-schema/returns-alternate.err b/tests/qapi-schema/=
returns-alternate.err
index dfbb419cac2..a79c0805984 100644
--- a/tests/qapi-schema/returns-alternate.err
+++ b/tests/qapi-schema/returns-alternate.err
@@ -1 +1 @@
-tests/qapi-schema/returns-alternate.json:3: 'returns' for command 'oops'=
 cannot use alternate type 'Alt'
+tests/qapi-schema/returns-alternate.qapi:3: 'returns' for command 'oops'=
 cannot use alternate type 'Alt'
diff --git a/tests/qapi-schema/returns-alternate.json b/tests/qapi-schema=
/returns-alternate.qapi
similarity index 100%
rename from tests/qapi-schema/returns-alternate.json
rename to tests/qapi-schema/returns-alternate.qapi
diff --git a/tests/qapi-schema/returns-array-bad.err b/tests/qapi-schema/=
returns-array-bad.err
index 138095ccde1..54981ce3846 100644
--- a/tests/qapi-schema/returns-array-bad.err
+++ b/tests/qapi-schema/returns-array-bad.err
@@ -1 +1 @@
-tests/qapi-schema/returns-array-bad.json:2: 'returns' for command 'oops'=
: array type must contain single type name
+tests/qapi-schema/returns-array-bad.qapi:2: 'returns' for command 'oops'=
: array type must contain single type name
diff --git a/tests/qapi-schema/returns-array-bad.json b/tests/qapi-schema=
/returns-array-bad.qapi
similarity index 100%
rename from tests/qapi-schema/returns-array-bad.json
rename to tests/qapi-schema/returns-array-bad.qapi
diff --git a/tests/qapi-schema/returns-dict.err b/tests/qapi-schema/retur=
ns-dict.err
index eb2d0c46615..b153bdc74c2 100644
--- a/tests/qapi-schema/returns-dict.err
+++ b/tests/qapi-schema/returns-dict.err
@@ -1 +1 @@
-tests/qapi-schema/returns-dict.json:2: 'returns' for command 'oops' shou=
ld be a type name
+tests/qapi-schema/returns-dict.qapi:2: 'returns' for command 'oops' shou=
ld be a type name
diff --git a/tests/qapi-schema/returns-dict.json b/tests/qapi-schema/retu=
rns-dict.qapi
similarity index 100%
rename from tests/qapi-schema/returns-dict.json
rename to tests/qapi-schema/returns-dict.qapi
diff --git a/tests/qapi-schema/returns-unknown.err b/tests/qapi-schema/re=
turns-unknown.err
index 1f43e3ac9f6..26b9af8344c 100644
--- a/tests/qapi-schema/returns-unknown.err
+++ b/tests/qapi-schema/returns-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/returns-unknown.json:2: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
+tests/qapi-schema/returns-unknown.qapi:2: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/returns-unknown.json b/tests/qapi-schema/r=
eturns-unknown.qapi
similarity index 100%
rename from tests/qapi-schema/returns-unknown.json
rename to tests/qapi-schema/returns-unknown.qapi
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/=
returns-whitelist.err
index b2ba7a9deba..710fbb2f6f6 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1 +1 @@
-tests/qapi-schema/returns-whitelist.json:14: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
+tests/qapi-schema/returns-whitelist.qapi:14: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/returns-whitelist.json b/tests/qapi-schema=
/returns-whitelist.qapi
similarity index 100%
rename from tests/qapi-schema/returns-whitelist.json
rename to tests/qapi-schema/returns-whitelist.qapi
diff --git a/tests/qapi-schema/struct-base-clash-deep.err b/tests/qapi-sc=
hema/struct-base-clash-deep.err
index e2d7943f217..c6d7ef0a536 100644
--- a/tests/qapi-schema/struct-base-clash-deep.err
+++ b/tests/qapi-schema/struct-base-clash-deep.err
@@ -1 +1 @@
-tests/qapi-schema/struct-base-clash-deep.json:10: 'name' (member of Sub)=
 collides with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash-deep.qapi:10: 'name' (member of Sub)=
 collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash-deep.json b/tests/qapi-s=
chema/struct-base-clash-deep.qapi
similarity index 100%
rename from tests/qapi-schema/struct-base-clash-deep.json
rename to tests/qapi-schema/struct-base-clash-deep.qapi
diff --git a/tests/qapi-schema/struct-base-clash.err b/tests/qapi-schema/=
struct-base-clash.err
index c52f33d27bf..de89c0e0b93 100644
--- a/tests/qapi-schema/struct-base-clash.err
+++ b/tests/qapi-schema/struct-base-clash.err
@@ -1 +1 @@
-tests/qapi-schema/struct-base-clash.json:5: 'name' (member of Sub) colli=
des with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash.qapi:5: 'name' (member of Sub) colli=
des with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash.json b/tests/qapi-schema=
/struct-base-clash.qapi
similarity index 100%
rename from tests/qapi-schema/struct-base-clash.json
rename to tests/qapi-schema/struct-base-clash.qapi
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index 6644f4c2ad2..84fc1404fa7 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be a dictionary or type name
+tests/qapi-schema/struct-data-invalid.qapi:1: 'data' for struct 'foo' sh=
ould be a dictionary or type name
diff --git a/tests/qapi-schema/struct-data-invalid.json b/tests/qapi-sche=
ma/struct-data-invalid.qapi
similarity index 100%
rename from tests/qapi-schema/struct-data-invalid.json
rename to tests/qapi-schema/struct-data-invalid.qapi
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index 69a326d450e..c94c8c6d712 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-member-invalid.json:1: Member 'a' of 'data' for=
 struct 'foo' should be a type name
+tests/qapi-schema/struct-member-invalid.qapi:1: Member 'a' of 'data' for=
 struct 'foo' should be a type name
diff --git a/tests/qapi-schema/struct-member-invalid.json b/tests/qapi-sc=
hema/struct-member-invalid.qapi
similarity index 100%
rename from tests/qapi-schema/struct-member-invalid.json
rename to tests/qapi-schema/struct-member-invalid.qapi
diff --git a/tests/qapi-schema/trailing-comma-list.err b/tests/qapi-schem=
a/trailing-comma-list.err
index 212e14ae28e..c786b67d2ff 100644
--- a/tests/qapi-schema/trailing-comma-list.err
+++ b/tests/qapi-schema/trailing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-list.json:2:36: Expected "{", "[", stri=
ng, boolean or "null"
+tests/qapi-schema/trailing-comma-list.qapi:2:36: Expected "{", "[", stri=
ng, boolean or "null"
diff --git a/tests/qapi-schema/trailing-comma-list.json b/tests/qapi-sche=
ma/trailing-comma-list.qapi
similarity index 100%
rename from tests/qapi-schema/trailing-comma-list.json
rename to tests/qapi-schema/trailing-comma-list.qapi
diff --git a/tests/qapi-schema/trailing-comma-object.err b/tests/qapi-sch=
ema/trailing-comma-object.err
index 30bce5e1945..aff13d63986 100644
--- a/tests/qapi-schema/trailing-comma-object.err
+++ b/tests/qapi-schema/trailing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-object.json:2:38: Expected string
+tests/qapi-schema/trailing-comma-object.qapi:2:38: Expected string
diff --git a/tests/qapi-schema/trailing-comma-object.json b/tests/qapi-sc=
hema/trailing-comma-object.qapi
similarity index 100%
rename from tests/qapi-schema/trailing-comma-object.json
rename to tests/qapi-schema/trailing-comma-object.qapi
diff --git a/tests/qapi-schema/type-bypass-bad-gen.err b/tests/qapi-schem=
a/type-bypass-bad-gen.err
index a83c3c655de..e617f425b94 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.err
+++ b/tests/qapi-schema/type-bypass-bad-gen.err
@@ -1 +1 @@
-tests/qapi-schema/type-bypass-bad-gen.json:2: 'gen' of command 'foo' sho=
uld only use false value
+tests/qapi-schema/type-bypass-bad-gen.qapi:2: 'gen' of command 'foo' sho=
uld only use false value
diff --git a/tests/qapi-schema/type-bypass-bad-gen.json b/tests/qapi-sche=
ma/type-bypass-bad-gen.qapi
similarity index 100%
rename from tests/qapi-schema/type-bypass-bad-gen.json
rename to tests/qapi-schema/type-bypass-bad-gen.qapi
diff --git a/tests/qapi-schema/unclosed-list.err b/tests/qapi-schema/uncl=
osed-list.err
index fb41a86abd0..3e9bd74f833 100644
--- a/tests/qapi-schema/unclosed-list.err
+++ b/tests/qapi-schema/unclosed-list.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-list.json:1:20: Expected "," or "]"
+tests/qapi-schema/unclosed-list.qapi:1:20: Expected "," or "]"
diff --git a/tests/qapi-schema/unclosed-list.json b/tests/qapi-schema/unc=
losed-list.qapi
similarity index 100%
rename from tests/qapi-schema/unclosed-list.json
rename to tests/qapi-schema/unclosed-list.qapi
diff --git a/tests/qapi-schema/unclosed-object.err b/tests/qapi-schema/un=
closed-object.err
index db3deedd63d..42b5ba1abb6 100644
--- a/tests/qapi-schema/unclosed-object.err
+++ b/tests/qapi-schema/unclosed-object.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-object.json:1:21: Expected "," or "}"
+tests/qapi-schema/unclosed-object.qapi:1:21: Expected "," or "}"
diff --git a/tests/qapi-schema/unclosed-object.json b/tests/qapi-schema/u=
nclosed-object.qapi
similarity index 100%
rename from tests/qapi-schema/unclosed-object.json
rename to tests/qapi-schema/unclosed-object.qapi
diff --git a/tests/qapi-schema/unclosed-string.err b/tests/qapi-schema/un=
closed-string.err
index 12b187074e7..fbe5385d6e2 100644
--- a/tests/qapi-schema/unclosed-string.err
+++ b/tests/qapi-schema/unclosed-string.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-string.json:1:11: Missing terminating "'"
+tests/qapi-schema/unclosed-string.qapi:1:11: Missing terminating "'"
diff --git a/tests/qapi-schema/unclosed-string.json b/tests/qapi-schema/u=
nclosed-string.qapi
similarity index 100%
rename from tests/qapi-schema/unclosed-string.json
rename to tests/qapi-schema/unclosed-string.qapi
diff --git a/tests/qapi-schema/unicode-str.err b/tests/qapi-schema/unicod=
e-str.err
index f621cd6448b..9301f12bd0d 100644
--- a/tests/qapi-schema/unicode-str.err
+++ b/tests/qapi-schema/unicode-str.err
@@ -1 +1 @@
-tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9=
'
+tests/qapi-schema/unicode-str.qapi:2: 'command' uses invalid name '=C3=A9=
'
diff --git a/tests/qapi-schema/unicode-str.json b/tests/qapi-schema/unico=
de-str.qapi
similarity index 100%
rename from tests/qapi-schema/unicode-str.json
rename to tests/qapi-schema/unicode-str.qapi
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
index 7695806d81a..47dd3d6ac3b 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1 +1 @@
-tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a=
 member of base struct 'Empty'
+tests/qapi-schema/union-base-empty.qapi:5: Discriminator 'type' is not a=
 member of base struct 'Empty'
diff --git a/tests/qapi-schema/union-base-empty.json b/tests/qapi-schema/=
union-base-empty.qapi
similarity index 100%
rename from tests/qapi-schema/union-base-empty.json
rename to tests/qapi-schema/union-base-empty.qapi
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index 8b7a24260ff..e632a4d2649 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/union-base-no-discriminator.json:11: Simple union 'Tes=
tUnion' must not have a base
+tests/qapi-schema/union-base-no-discriminator.qapi:11: Simple union 'Tes=
tUnion' must not have a base
diff --git a/tests/qapi-schema/union-base-no-discriminator.json b/tests/q=
api-schema/union-base-no-discriminator.qapi
similarity index 100%
rename from tests/qapi-schema/union-base-no-discriminator.json
rename to tests/qapi-schema/union-base-no-discriminator.qapi
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index 11521901d88..8383a3394fa 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1 +1 @@
-tests/qapi-schema/union-branch-case.json:2: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
+tests/qapi-schema/union-branch-case.qapi:2: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/union-branch-case.json b/tests/qapi-schema=
/union-branch-case.qapi
similarity index 100%
rename from tests/qapi-schema/union-branch-case.json
rename to tests/qapi-schema/union-branch-case.qapi
diff --git a/tests/qapi-schema/union-clash-branches.err b/tests/qapi-sche=
ma/union-clash-branches.err
index e5b21135bb8..ee74c202af5 100644
--- a/tests/qapi-schema/union-clash-branches.err
+++ b/tests/qapi-schema/union-clash-branches.err
@@ -1 +1 @@
-tests/qapi-schema/union-clash-branches.json:4: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
+tests/qapi-schema/union-clash-branches.qapi:4: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
diff --git a/tests/qapi-schema/union-clash-branches.json b/tests/qapi-sch=
ema/union-clash-branches.qapi
similarity index 100%
rename from tests/qapi-schema/union-clash-branches.json
rename to tests/qapi-schema/union-clash-branches.qapi
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index 12c20221bdf..da45ccaf497 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1 +1 @@
-tests/qapi-schema/union-empty.json:2: Union 'Union' cannot have empty 'd=
ata'
+tests/qapi-schema/union-empty.qapi:2: Union 'Union' cannot have empty 'd=
ata'
diff --git a/tests/qapi-schema/union-empty.json b/tests/qapi-schema/union=
-empty.qapi
similarity index 100%
rename from tests/qapi-schema/union-empty.json
rename to tests/qapi-schema/union-empty.qapi
diff --git a/tests/qapi-schema/union-invalid-base.err b/tests/qapi-schema=
/union-invalid-base.err
index 03d7b97a93b..7176a08136e 100644
--- a/tests/qapi-schema/union-invalid-base.err
+++ b/tests/qapi-schema/union-invalid-base.err
@@ -1 +1 @@
-tests/qapi-schema/union-invalid-base.json:8: 'base' for union 'TestUnion=
' cannot use built-in type 'int'
+tests/qapi-schema/union-invalid-base.qapi:8: 'base' for union 'TestUnion=
' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/union-invalid-base.json b/tests/qapi-schem=
a/union-invalid-base.qapi
similarity index 100%
rename from tests/qapi-schema/union-invalid-base.json
rename to tests/qapi-schema/union-invalid-base.qapi
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 3ada1334dc6..1dcb5835cc2 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1 +1 @@
-tests/qapi-schema/union-optional-branch.json:2: Member of union 'Union' =
does not allow optional name '*a'
+tests/qapi-schema/union-optional-branch.qapi:2: Member of union 'Union' =
does not allow optional name '*a'
diff --git a/tests/qapi-schema/union-optional-branch.json b/tests/qapi-sc=
hema/union-optional-branch.qapi
similarity index 100%
rename from tests/qapi-schema/union-optional-branch.json
rename to tests/qapi-schema/union-optional-branch.qapi
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index 54fe456f9cd..dab37db8b8f 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/union-unknown.json:2: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
+tests/qapi-schema/union-unknown.qapi:2: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/union-unknown.json b/tests/qapi-schema/uni=
on-unknown.qapi
similarity index 100%
rename from tests/qapi-schema/union-unknown.json
rename to tests/qapi-schema/union-unknown.qapi
diff --git a/tests/qapi-schema/unknown-escape.err b/tests/qapi-schema/unk=
nown-escape.err
index 000e30ddf33..ad58d0eae97 100644
--- a/tests/qapi-schema/unknown-escape.err
+++ b/tests/qapi-schema/unknown-escape.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-escape.json:3:21: Unknown escape \x
+tests/qapi-schema/unknown-escape.qapi:3:21: Unknown escape \x
diff --git a/tests/qapi-schema/unknown-escape.json b/tests/qapi-schema/un=
known-escape.qapi
similarity index 100%
rename from tests/qapi-schema/unknown-escape.json
rename to tests/qapi-schema/unknown-escape.qapi
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index 12f5ed5b435..5b8dee56fa0 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.qapi:2: Unknown key 'bogus' in struct=
 'bar'
diff --git a/tests/qapi-schema/unknown-expr-key.json b/tests/qapi-schema/=
unknown-expr-key.qapi
similarity index 100%
rename from tests/qapi-schema/unknown-expr-key.json
rename to tests/qapi-schema/unknown-expr-key.qapi
--=20
2.14.3
