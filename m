Received: from eggs.gnu.org ([2001:4830:134:3::10]:33881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8V8-0001oY-A6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Un-0000Gw-VY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Un-0000G2-Bu
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:56:52 +0100
Message-Id: <1489582656-31133-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.9 03/47] qapi: Back out doc comments
 added just to please qapi.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

This reverts commit 3313b61's changes to tests/qapi-schema/, except
for tests/qapi-schema/doc-*.

We could keep some of these doc comments to serve as positive test
cases.  However, they don't actually add to what we get from doc
comment use in actual schemas, as we we don't test output matches
expectations, and don't systematically cover doc comment features.
Proper positive test coverage would be nice.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
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
 tests/qapi-schema/enum-member-case.json            |   7 -
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
 tests/qapi-schema/flat-union-array-branch.json     |  12 --
 tests/qapi-schema/flat-union-bad-base.err          |   2 +-
 tests/qapi-schema/flat-union-bad-base.json         |  13 --
 tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
 .../qapi-schema/flat-union-bad-discriminator.json  |  16 --
 tests/qapi-schema/flat-union-base-any.err          |   2 +-
 tests/qapi-schema/flat-union-base-any.json         |  13 --
 tests/qapi-schema/flat-union-base-union.err        |   2 +-
 tests/qapi-schema/flat-union-base-union.json       |  16 --
 tests/qapi-schema/flat-union-clash-member.err      |   2 +-
 tests/qapi-schema/flat-union-clash-member.json     |  16 --
 tests/qapi-schema/flat-union-empty.err             |   2 +-
 tests/qapi-schema/flat-union-empty.json            |  10 -
 tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
 .../qapi-schema/flat-union-incomplete-branch.json  |  10 -
 tests/qapi-schema/flat-union-inline.err            |   2 +-
 tests/qapi-schema/flat-union-inline.json           |  10 -
 tests/qapi-schema/flat-union-int-branch.err        |   2 +-
 tests/qapi-schema/flat-union-int-branch.json       |  13 --
 .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
 .../qapi-schema/flat-union-invalid-branch-key.json |  15 --
 .../flat-union-invalid-discriminator.err           |   2 +-
 .../flat-union-invalid-discriminator.json          |  15 --
 tests/qapi-schema/flat-union-no-base.err           |   2 +-
 tests/qapi-schema/flat-union-no-base.json          |  13 --
 .../flat-union-optional-discriminator.err          |   2 +-
 .../flat-union-optional-discriminator.json         |  13 --
 .../flat-union-string-discriminator.err            |   2 +-
 .../flat-union-string-discriminator.json           |  15 --
 tests/qapi-schema/ident-with-escape.json           |   4 -
 tests/qapi-schema/ident-with-escape.out            |   1 -
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
 tests/qapi-schema/qapi-schema-test.json            | 213 ---------------=
------
 tests/qapi-schema/qapi-schema-test.out             | 130 -------------
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
 tests/qapi-schema/returns-whitelist.json           |  16 --
 tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
 tests/qapi-schema/struct-base-clash-deep.json      |  10 -
 tests/qapi-schema/struct-base-clash.err            |   2 +-
 tests/qapi-schema/struct-base-clash.json           |   7 -
 tests/qapi-schema/struct-data-invalid.err          |   2 +-
 tests/qapi-schema/struct-data-invalid.json         |   3 -
 tests/qapi-schema/struct-member-invalid.err        |   2 +-
 tests/qapi-schema/struct-member-invalid.json       |   3 -
 tests/qapi-schema/test-qapi.py                     |  14 --
 tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
 tests/qapi-schema/type-bypass-bad-gen.json         |   4 -
 tests/qapi-schema/unicode-str.err                  |   2 +-
 tests/qapi-schema/unicode-str.json                 |   4 -
 tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
 tests/qapi-schema/union-base-no-discriminator.json |  12 --
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
 200 files changed, 92 insertions(+), 1074 deletions(-)

diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index 395c8ab..aaa0154 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-any.json:6: Alternate 'Alt' member 'one' can=
not use type 'any'
+tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one' can=
not use type 'any'
diff --git a/tests/qapi-schema/alternate-any.json b/tests/qapi-schema/alt=
ernate-any.json
index c958776..e47a73a 100644
--- a/tests/qapi-schema/alternate-any.json
+++ b/tests/qapi-schema/alternate-any.json
@@ -1,8 +1,4 @@
 # we do not allow the 'any' type as an alternate branch
-
-##
-# @Alt:
-##
 { 'alternate': 'Alt',
   'data': { 'one': 'any',
             'two': 'int' } }
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index 09628e9..7b930c6 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-array.json:12: Member 'two' of alternate 'Al=
t' cannot be an array
+tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'Alt=
' cannot be an array
diff --git a/tests/qapi-schema/alternate-array.json b/tests/qapi-schema/a=
lternate-array.json
index c2f98ad..f241aac 100644
--- a/tests/qapi-schema/alternate-array.json
+++ b/tests/qapi-schema/alternate-array.json
@@ -1,14 +1,7 @@
 # we do not allow array branches in alternates
-
-##
-# @One:
-##
 # TODO: should we support this?
 { 'struct': 'One',
   'data': { 'name': 'str' } }
-##
-# @Alt:
-##
 { 'alternate': 'Alt',
   'data': { 'one': 'One',
             'two': [ 'int' ] } }
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 3b67914..30d8a34 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-base.json:11: Unknown key 'base' in alternat=
e 'Alt'
+tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
diff --git a/tests/qapi-schema/alternate-base.json b/tests/qapi-schema/al=
ternate-base.json
index 9612b79..529430ec 100644
--- a/tests/qapi-schema/alternate-base.json
+++ b/tests/qapi-schema/alternate-base.json
@@ -1,13 +1,6 @@
 # we reject alternate with base type
-
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'string': 'str' } }
-##
-# @Alt:
-##
 { 'alternate': 'Alt',
   'base': 'Base',
   'data': { 'number': 'int' } }
diff --git a/tests/qapi-schema/alternate-clash.err b/tests/qapi-schema/al=
ternate-clash.err
index f07c3e8..604d849 100644
--- a/tests/qapi-schema/alternate-clash.err
+++ b/tests/qapi-schema/alternate-clash.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-clash.json:11: 'a_b' (branch of Alt1) collid=
es with 'a-b' (branch of Alt1)
+tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) collide=
s with 'a-b' (branch of Alt1)
diff --git a/tests/qapi-schema/alternate-clash.json b/tests/qapi-schema/a=
lternate-clash.json
index 97ca7c8..6d73bc5 100644
--- a/tests/qapi-schema/alternate-clash.json
+++ b/tests/qapi-schema/alternate-clash.json
@@ -4,9 +4,5 @@
 # TODO: In the future, if alternates are simplified to not generate
 # the implicit Alt1Kind enum, we would still have a collision with the
 # resulting C union trying to have two members named 'a_b'.
-
-##
-# @Alt1:
-##
 { 'alternate': 'Alt1',
   'data': { 'a-b': 'str', 'a_b': 'int' } }
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index 7cb023f..0f411f4 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-dict.json:16: Alternate 'Alt' membe=
r 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.json b/tests/qapi-=
schema/alternate-conflict-dict.json
index 9f9d97f..d566cca 100644
--- a/tests/qapi-schema/alternate-conflict-dict.json
+++ b/tests/qapi-schema/alternate-conflict-dict.json
@@ -1,18 +1,8 @@
 # we reject alternates with multiple object branches
-
-##
-# @One:
-##
 { 'struct': 'One',
   'data': { 'name': 'str' } }
-##
-# @Two:
-##
 { 'struct': 'Two',
   'data': { 'value': 'int' } }
-##
-# @Alt:
-##
 { 'alternate': 'Alt',
   'data': { 'one': 'One',
             'two': 'Two' } }
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index 6dbbacd..fc523b0 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-string.json:11: Alternate 'Alt' mem=
ber 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-string.json:4: Alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.json b/tests/qap=
i-schema/alternate-conflict-string.json
index 12aafab..72f04a8 100644
--- a/tests/qapi-schema/alternate-conflict-string.json
+++ b/tests/qapi-schema/alternate-conflict-string.json
@@ -1,13 +1,6 @@
 # we reject alternates with multiple string-like branches
-
-##
-# @Enum:
-##
 { 'enum': 'Enum',
   'data': [ 'hello', 'world' ] }
-##
-# @Alt:
-##
 { 'alternate': 'Alt',
   'data': { 'one': 'str',
             'two': 'Enum' } }
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index 8245ce3..bb06c5b 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-empty.json:6: Alternate 'Alt' should have at=
 least two branches in 'data'
+tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' should have at=
 least two branches in 'data'
diff --git a/tests/qapi-schema/alternate-empty.json b/tests/qapi-schema/a=
lternate-empty.json
index db54405..fff15ba 100644
--- a/tests/qapi-schema/alternate-empty.json
+++ b/tests/qapi-schema/alternate-empty.json
@@ -1,6 +1,2 @@
 # alternates must list at least two types to be useful
-
-##
-# @Alt:
-##
 { 'alternate': 'Alt', 'data': { 'i': 'int' } }
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index 1804ffb..4d1187e 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-nested.json:11: Member 'nested' of alternate=
 'Alt2' cannot use alternate type 'Alt1'
+tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
diff --git a/tests/qapi-schema/alternate-nested.json b/tests/qapi-schema/=
alternate-nested.json
index 9f83ebe..8e22186 100644
--- a/tests/qapi-schema/alternate-nested.json
+++ b/tests/qapi-schema/alternate-nested.json
@@ -1,12 +1,5 @@
 # we reject a nested alternate branch
-
-##
-# @Alt1:
-##
 { 'alternate': 'Alt1',
   'data': { 'name': 'str', 'value': 'int' } }
-##
-# @Alt2:
-##
 { 'alternate': 'Alt2',
   'data': { 'nested': 'Alt1', 'b': 'bool' } }
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index cf5b9b6..dea45dc 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-unknown.json:6: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
+tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/alternate-unknown.json b/tests/qapi-schema=
/alternate-unknown.json
index 941ba1f..08c80dc 100644
--- a/tests/qapi-schema/alternate-unknown.json
+++ b/tests/qapi-schema/alternate-unknown.json
@@ -1,7 +1,3 @@
 # we reject an alternate with unknown type in branch
-
-##
-# @Alt:
-##
 { 'alternate': 'Alt',
   'data': { 'unknown': 'MissingType', 'i': 'int' } }
diff --git a/tests/qapi-schema/args-alternate.err b/tests/qapi-schema/arg=
s-alternate.err
index 2e6bf54..3086eae 100644
--- a/tests/qapi-schema/args-alternate.err
+++ b/tests/qapi-schema/args-alternate.err
@@ -1 +1 @@
-tests/qapi-schema/args-alternate.json:11: 'data' for command 'oops' cann=
ot use alternate type 'Alt'
+tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' canno=
t use alternate type 'Alt'
diff --git a/tests/qapi-schema/args-alternate.json b/tests/qapi-schema/ar=
gs-alternate.json
index 49d0211..69e94d4 100644
--- a/tests/qapi-schema/args-alternate.json
+++ b/tests/qapi-schema/args-alternate.json
@@ -1,11 +1,3 @@
 # we do not allow alternate arguments
-
-##
-# @Alt:
-##
 { 'alternate': 'Alt', 'data': { 'case1': 'int', 'case2': 'str' } }
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': 'Alt' }
diff --git a/tests/qapi-schema/args-any.err b/tests/qapi-schema/args-any.=
err
index 955504b..bf9b5e0 100644
--- a/tests/qapi-schema/args-any.err
+++ b/tests/qapi-schema/args-any.err
@@ -1 +1 @@
-tests/qapi-schema/args-any.json:6: 'data' for command 'oops' cannot use =
built-in type 'any'
+tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot use =
built-in type 'any'
diff --git a/tests/qapi-schema/args-any.json b/tests/qapi-schema/args-any=
.json
index f494479..58fe5e4 100644
--- a/tests/qapi-schema/args-any.json
+++ b/tests/qapi-schema/args-any.json
@@ -1,6 +1,2 @@
 # we do not allow an 'any' argument
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': 'any' }
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index e85f791..cb7ed33 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1 +1 @@
-tests/qapi-schema/args-array-empty.json:6: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
+tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-array-empty.json b/tests/qapi-schema/=
args-array-empty.json
index 78a0b88..652dcfb 100644
--- a/tests/qapi-schema/args-array-empty.json
+++ b/tests/qapi-schema/args-array-empty.json
@@ -1,6 +1,2 @@
 # we reject an array for data if it does not contain a known type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': { 'empty': [ ] } }
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index 77788de..cd7a0f9 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-array-unknown.json:6: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-array-unknown.json b/tests/qapi-schem=
a/args-array-unknown.json
index f680fc1..6f3e883 100644
--- a/tests/qapi-schema/args-array-unknown.json
+++ b/tests/qapi-schema/args-array-unknown.json
@@ -1,6 +1,2 @@
 # we reject an array for data if it does not contain a known type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': { 'array': [ 'NoSuchType' ] } }
diff --git a/tests/qapi-schema/args-bad-boxed.err b/tests/qapi-schema/arg=
s-bad-boxed.err
index 87a9061..ad0d417 100644
--- a/tests/qapi-schema/args-bad-boxed.err
+++ b/tests/qapi-schema/args-bad-boxed.err
@@ -1 +1 @@
-tests/qapi-schema/args-bad-boxed.json:6: 'boxed' of command 'foo' should=
 only use true value
+tests/qapi-schema/args-bad-boxed.json:2: 'boxed' of command 'foo' should=
 only use true value
diff --git a/tests/qapi-schema/args-bad-boxed.json b/tests/qapi-schema/ar=
gs-bad-boxed.json
index 4c0b28f..dea0cd0 100644
--- a/tests/qapi-schema/args-bad-boxed.json
+++ b/tests/qapi-schema/args-bad-boxed.json
@@ -1,6 +1,2 @@
 # 'boxed' should only appear with value true
-
-##
-# @foo:
-##
 { 'command': 'foo', 'boxed': false }
diff --git a/tests/qapi-schema/args-boxed-anon.err b/tests/qapi-schema/ar=
gs-boxed-anon.err
index 3cfac0b..f24f345 100644
--- a/tests/qapi-schema/args-boxed-anon.err
+++ b/tests/qapi-schema/args-boxed-anon.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-anon.json:6: 'data' for command 'foo' shoul=
d be a type name
+tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' shoul=
d be a type name
diff --git a/tests/qapi-schema/args-boxed-anon.json b/tests/qapi-schema/a=
rgs-boxed-anon.json
index 2358e6a..95f60da 100644
--- a/tests/qapi-schema/args-boxed-anon.json
+++ b/tests/qapi-schema/args-boxed-anon.json
@@ -1,6 +1,2 @@
 # 'boxed' can only be used with named types
-
-##
-# @foo:
-##
 { 'command': 'foo', 'boxed': true, 'data': { 'string': 'str' } }
diff --git a/tests/qapi-schema/args-boxed-empty.err b/tests/qapi-schema/a=
rgs-boxed-empty.err
index 963f495..039603e 100644
--- a/tests/qapi-schema/args-boxed-empty.err
+++ b/tests/qapi-schema/args-boxed-empty.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-empty.json:11: Cannot use 'boxed' with empt=
y type
+tests/qapi-schema/args-boxed-empty.json:3: Cannot use 'boxed' with empty=
 type
diff --git a/tests/qapi-schema/args-boxed-empty.json b/tests/qapi-schema/=
args-boxed-empty.json
index 8e8cc26..52717e0 100644
--- a/tests/qapi-schema/args-boxed-empty.json
+++ b/tests/qapi-schema/args-boxed-empty.json
@@ -1,11 +1,3 @@
 # 'boxed' requires a non-empty type
-
-##
-# @Empty:
-##
 { 'struct': 'Empty', 'data': {} }
-
-##
-# @foo:
-##
 { 'command': 'foo', 'boxed': true, 'data': 'Empty' }
diff --git a/tests/qapi-schema/args-boxed-string.err b/tests/qapi-schema/=
args-boxed-string.err
index 7623755..d326b48 100644
--- a/tests/qapi-schema/args-boxed-string.err
+++ b/tests/qapi-schema/args-boxed-string.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-string.json:6: 'data' for command 'foo' can=
not use built-in type 'str'
+tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo' can=
not use built-in type 'str'
diff --git a/tests/qapi-schema/args-boxed-string.json b/tests/qapi-schema=
/args-boxed-string.json
index aecdf97..f91a150 100644
--- a/tests/qapi-schema/args-boxed-string.json
+++ b/tests/qapi-schema/args-boxed-string.json
@@ -1,6 +1,2 @@
 # 'boxed' requires a complex (not built-in) type
-
-##
-# @foo:
-##
 { 'command': 'foo', 'boxed': true, 'data': 'str' }
diff --git a/tests/qapi-schema/args-int.err b/tests/qapi-schema/args-int.=
err
index 38b3202..dc1d250 100644
--- a/tests/qapi-schema/args-int.err
+++ b/tests/qapi-schema/args-int.err
@@ -1 +1 @@
-tests/qapi-schema/args-int.json:6: 'data' for command 'oops' cannot use =
built-in type 'int'
+tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot use =
built-in type 'int'
diff --git a/tests/qapi-schema/args-int.json b/tests/qapi-schema/args-int=
.json
index 7f4e1b7..a334d92 100644
--- a/tests/qapi-schema/args-int.json
+++ b/tests/qapi-schema/args-int.json
@@ -1,6 +1,2 @@
 # we reject commands where data is not an array or complex type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': 'int' }
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index 5d3568d..fe1e949 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/args-invalid.json:4: 'data' for command 'foo' should b=
e a dictionary or type name
+tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e a dictionary or type name
diff --git a/tests/qapi-schema/args-invalid.json b/tests/qapi-schema/args=
-invalid.json
index 1a7e63b..db09813 100644
--- a/tests/qapi-schema/args-invalid.json
+++ b/tests/qapi-schema/args-invalid.json
@@ -1,5 +1,2 @@
-##
-# @foo:
-##
 { 'command': 'foo',
   'data': false }
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index 825ffca..881b4d9 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-array-bad.json:6: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
+tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-member-array-bad.json b/tests/qapi-sc=
hema/args-member-array-bad.json
index e934f5c..b2ff144 100644
--- a/tests/qapi-schema/args-member-array-bad.json
+++ b/tests/qapi-schema/args-member-array-bad.json
@@ -1,6 +1,2 @@
 # we reject data if it does not contain a valid array type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': { 'member': [ { 'nested': 'str' } ] } }
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index a3fb2bd..19c4426 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-case.json:6: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
+tests/qapi-schema/args-member-case.json:2: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
diff --git a/tests/qapi-schema/args-member-case.json b/tests/qapi-schema/=
args-member-case.json
index 811e658..93439be 100644
--- a/tests/qapi-schema/args-member-case.json
+++ b/tests/qapi-schema/args-member-case.json
@@ -1,6 +1,2 @@
 # Member names should be 'lower-case' unless the struct/command is white=
listed
-
-##
-# @no-way-this-will-get-whitelisted:
-##
 { 'command': 'no-way-this-will-get-whitelisted', 'data': { 'Arg': 'int' =
} }
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index 3db452b..f6f8282 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-unknown.json:6: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-member-unknown.json b/tests/qapi-sche=
ma/args-member-unknown.json
index e2fef9c..342a41e 100644
--- a/tests/qapi-schema/args-member-unknown.json
+++ b/tests/qapi-schema/args-member-unknown.json
@@ -1,6 +1,2 @@
 # we reject data if it does not contain a known type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': { 'member': 'NoSuchType' } }
diff --git a/tests/qapi-schema/args-name-clash.err b/tests/qapi-schema/ar=
gs-name-clash.err
index 23988cb..d953e8d 100644
--- a/tests/qapi-schema/args-name-clash.err
+++ b/tests/qapi-schema/args-name-clash.err
@@ -1 +1 @@
-tests/qapi-schema/args-name-clash.json:8: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
+tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
diff --git a/tests/qapi-schema/args-name-clash.json b/tests/qapi-schema/a=
rgs-name-clash.json
index 991323b..61423cb 100644
--- a/tests/qapi-schema/args-name-clash.json
+++ b/tests/qapi-schema/args-name-clash.json
@@ -1,8 +1,4 @@
 # C member name collision
 # Reject members that clash when mapped to C names (we would have two 'a=
_b'
 # members).
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': { 'a-b': 'str', 'a_b': 'str' } }
diff --git a/tests/qapi-schema/args-union.err b/tests/qapi-schema/args-un=
ion.err
index ce0a34e..f8ad223 100644
--- a/tests/qapi-schema/args-union.err
+++ b/tests/qapi-schema/args-union.err
@@ -1 +1 @@
-tests/qapi-schema/args-union.json:10: 'data' for command 'oops' cannot u=
se union type 'Uni'
+tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot us=
e union type 'Uni'
diff --git a/tests/qapi-schema/args-union.json b/tests/qapi-schema/args-u=
nion.json
index 57284b4..2fcaeaa 100644
--- a/tests/qapi-schema/args-union.json
+++ b/tests/qapi-schema/args-union.json
@@ -1,10 +1,3 @@
 # use of union arguments requires 'boxed':true
-
-##
-# @Uni:
-##
 { 'union': 'Uni', 'data': { 'case1': 'int', 'case2': 'str' } }
-##
-# oops:
-##
 { 'command': 'oops', 'data': 'Uni' }
diff --git a/tests/qapi-schema/args-unknown.err b/tests/qapi-schema/args-=
unknown.err
index ba6c6cf..4d91ec8 100644
--- a/tests/qapi-schema/args-unknown.err
+++ b/tests/qapi-schema/args-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-unknown.json:6: 'data' for command 'oops' uses un=
known type 'NoSuchType'
+tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses un=
known type 'NoSuchType'
diff --git a/tests/qapi-schema/args-unknown.json b/tests/qapi-schema/args=
-unknown.json
index 12666dc..32aba43 100644
--- a/tests/qapi-schema/args-unknown.json
+++ b/tests/qapi-schema/args-unknown.json
@@ -1,6 +1,2 @@
 # we reject data if it does not contain a known type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': 'NoSuchType' }
diff --git a/tests/qapi-schema/bad-base.err b/tests/qapi-schema/bad-base.=
err
index e668761..154274b 100644
--- a/tests/qapi-schema/bad-base.err
+++ b/tests/qapi-schema/bad-base.err
@@ -1 +1 @@
-tests/qapi-schema/bad-base.json:10: 'base' for struct 'MyType' cannot us=
e union type 'Union'
+tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot use=
 union type 'Union'
diff --git a/tests/qapi-schema/bad-base.json b/tests/qapi-schema/bad-base=
.json
index c3faa82..a634331 100644
--- a/tests/qapi-schema/bad-base.json
+++ b/tests/qapi-schema/bad-base.json
@@ -1,10 +1,3 @@
 # we reject a base that is not a struct
-
-##
-# @Union:
-##
 { 'union': 'Union', 'data': { 'a': 'int', 'b': 'str' } }
-##
-# @MyType:
-##
 { 'struct': 'MyType', 'base': 'Union', 'data': { 'c': 'int' } }
diff --git a/tests/qapi-schema/bad-data.err b/tests/qapi-schema/bad-data.=
err
index c1b9e35..8523ac4 100644
--- a/tests/qapi-schema/bad-data.err
+++ b/tests/qapi-schema/bad-data.err
@@ -1 +1 @@
-tests/qapi-schema/bad-data.json:6: 'data' for command 'oops' cannot be a=
n array
+tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be a=
n array
diff --git a/tests/qapi-schema/bad-data.json b/tests/qapi-schema/bad-data=
.json
index 51c444f..832eeb7 100644
--- a/tests/qapi-schema/bad-data.json
+++ b/tests/qapi-schema/bad-data.json
@@ -1,6 +1,2 @@
 # we ensure 'data' is a dictionary for all but enums
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': [ ] }
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index b757aa2..c419060 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1 +1 @@
-tests/qapi-schema/bad-ident.json:6: 'struct' does not allow optional nam=
e '*oops'
+tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional nam=
e '*oops'
diff --git a/tests/qapi-schema/bad-ident.json b/tests/qapi-schema/bad-ide=
nt.json
index b43df7a..763627a 100644
--- a/tests/qapi-schema/bad-ident.json
+++ b/tests/qapi-schema/bad-ident.json
@@ -1,6 +1,2 @@
 # we reject creating a type name with bad name
-
-##
-# @*oops:
-##
 { 'struct': '*oops', 'data': { 'i': 'int' } }
diff --git a/tests/qapi-schema/bad-type-bool.err b/tests/qapi-schema/bad-=
type-bool.err
index 72e026b..62fd70b 100644
--- a/tests/qapi-schema/bad-type-bool.err
+++ b/tests/qapi-schema/bad-type-bool.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-bool.json:6: 'struct' key must have a string =
value
+tests/qapi-schema/bad-type-bool.json:2: 'struct' key must have a string =
value
diff --git a/tests/qapi-schema/bad-type-bool.json b/tests/qapi-schema/bad=
-type-bool.json
index 1f9eddf..bde17b5 100644
--- a/tests/qapi-schema/bad-type-bool.json
+++ b/tests/qapi-schema/bad-type-bool.json
@@ -1,6 +1,2 @@
 # we reject an expression with a metatype that is not a string
-
-##
-# @true:
-##
 { 'struct': true, 'data': { } }
diff --git a/tests/qapi-schema/bad-type-dict.err b/tests/qapi-schema/bad-=
type-dict.err
index d0d1f60..0b2a2ae 100644
--- a/tests/qapi-schema/bad-type-dict.err
+++ b/tests/qapi-schema/bad-type-dict.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-dict.json:6: 'command' key must have a string=
 value
+tests/qapi-schema/bad-type-dict.json:2: 'command' key must have a string=
 value
diff --git a/tests/qapi-schema/bad-type-dict.json b/tests/qapi-schema/bad=
-type-dict.json
index 5952caa..2a91b24 100644
--- a/tests/qapi-schema/bad-type-dict.json
+++ b/tests/qapi-schema/bad-type-dict.json
@@ -1,6 +1,2 @@
 # we reject an expression with a metatype that is not a string
-
-##
-# @foo:
-##
 { 'command': { } }
diff --git a/tests/qapi-schema/base-cycle-direct.err b/tests/qapi-schema/=
base-cycle-direct.err
index dd7f5aa..9c68f65 100644
--- a/tests/qapi-schema/base-cycle-direct.err
+++ b/tests/qapi-schema/base-cycle-direct.err
@@ -1 +1 @@
-tests/qapi-schema/base-cycle-direct.json:6: Object Loopy contains itself
+tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itself
diff --git a/tests/qapi-schema/base-cycle-direct.json b/tests/qapi-schema=
/base-cycle-direct.json
index 9780f7e..4fc66d0 100644
--- a/tests/qapi-schema/base-cycle-direct.json
+++ b/tests/qapi-schema/base-cycle-direct.json
@@ -1,6 +1,2 @@
 # we reject a loop in base classes
-
-##
-# @Loopy:
-##
 { 'struct': 'Loopy', 'base': 'Loopy', 'data': {} }
diff --git a/tests/qapi-schema/base-cycle-indirect.err b/tests/qapi-schem=
a/base-cycle-indirect.err
index f4198e4..fc92fe4 100644
--- a/tests/qapi-schema/base-cycle-indirect.err
+++ b/tests/qapi-schema/base-cycle-indirect.err
@@ -1 +1 @@
-tests/qapi-schema/base-cycle-indirect.json:6: Object Base1 contains itse=
lf
+tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains itse=
lf
diff --git a/tests/qapi-schema/base-cycle-indirect.json b/tests/qapi-sche=
ma/base-cycle-indirect.json
index 99926c4..2866772 100644
--- a/tests/qapi-schema/base-cycle-indirect.json
+++ b/tests/qapi-schema/base-cycle-indirect.json
@@ -1,10 +1,3 @@
 # we reject a loop in base classes
-
-##
-# @Base1:
-##
 { 'struct': 'Base1', 'base': 'Base2', 'data': {} }
-##
-# @Base2:
-##
 { 'struct': 'Base2', 'base': 'Base1', 'data': {} }
diff --git a/tests/qapi-schema/command-int.err b/tests/qapi-schema/comman=
d-int.err
index 3c834a9..0f93006 100644
--- a/tests/qapi-schema/command-int.err
+++ b/tests/qapi-schema/command-int.err
@@ -1 +1 @@
-tests/qapi-schema/command-int.json:6: built-in 'int' is already defined
+tests/qapi-schema/command-int.json:2: built-in 'int' is already defined
diff --git a/tests/qapi-schema/command-int.json b/tests/qapi-schema/comma=
nd-int.json
index 5b51bf1..9a62554 100644
--- a/tests/qapi-schema/command-int.json
+++ b/tests/qapi-schema/command-int.json
@@ -1,6 +1,2 @@
 # we reject collisions between commands and types
-
-##
-# @int:
-##
 { 'command': 'int', 'data': { 'character': 'str' } }
diff --git a/tests/qapi-schema/comments.json b/tests/qapi-schema/comments=
.json
index d31ef0d..e643f3a 100644
--- a/tests/qapi-schema/comments.json
+++ b/tests/qapi-schema/comments.json
@@ -1,8 +1,4 @@
 # Unindented comment
-
-##
-# @Status:
-##
 { 'enum': 'Status',             # Comment to the right of code
   # Indented comment
   'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index a962fb2..5d7c13c 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -2,4 +2,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
-doc symbol=3DStatus expr=3D('enum', 'Status')
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index 424df9b..f9613c6 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1 +1 @@
-tests/qapi-schema/double-type.json:6: Unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
diff --git a/tests/qapi-schema/double-type.json b/tests/qapi-schema/doubl=
e-type.json
index ab59523..911fa7a 100644
--- a/tests/qapi-schema/double-type.json
+++ b/tests/qapi-schema/double-type.json
@@ -1,6 +1,2 @@
 # we reject an expression with ambiguous metatype
-
-##
-# @foo:
-##
 { 'command': 'foo', 'struct': 'bar', 'data': { } }
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index 157d1b0..9c3c100 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1 +1 @@
-tests/qapi-schema/enum-bad-name.json:6: Member of enum 'MyEnum' uses inv=
alid name 'not^possible'
+tests/qapi-schema/enum-bad-name.json:2: Member of enum 'MyEnum' uses inv=
alid name 'not^possible'
diff --git a/tests/qapi-schema/enum-bad-name.json b/tests/qapi-schema/enu=
m-bad-name.json
index 978cb88..8506562 100644
--- a/tests/qapi-schema/enum-bad-name.json
+++ b/tests/qapi-schema/enum-bad-name.json
@@ -1,6 +1,2 @@
 # we ensure all enum names can map to C
-
-##
-# @MyEnum:
-##
 { 'enum': 'MyEnum', 'data': [ 'not^possible' ] }
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 918915f..399f5f7 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1 +1 @@
-tests/qapi-schema/enum-bad-prefix.json:6: Enum 'MyEnum' requires a strin=
g for 'prefix'
+tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a strin=
g for 'prefix'
diff --git a/tests/qapi-schema/enum-bad-prefix.json b/tests/qapi-schema/e=
num-bad-prefix.json
index 25f17a7..996f628 100644
--- a/tests/qapi-schema/enum-bad-prefix.json
+++ b/tests/qapi-schema/enum-bad-prefix.json
@@ -1,6 +1,2 @@
 # The prefix must be a string type
-
-##
-# @MyEnum:
-##
 { 'enum': 'MyEnum', 'data': [ 'one' ], 'prefix': [ 'fish' ] }
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 25249b6..5403c78 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-clash-member.json:6: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
+tests/qapi-schema/enum-clash-member.json:2: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
diff --git a/tests/qapi-schema/enum-clash-member.json b/tests/qapi-schema=
/enum-clash-member.json
index fd52751..b6928b8 100644
--- a/tests/qapi-schema/enum-clash-member.json
+++ b/tests/qapi-schema/enum-clash-member.json
@@ -1,6 +1,2 @@
 # we reject enums where members will clash when mapped to C enum
-
-##
-# @MyEnum:
-##
 { 'enum': 'MyEnum', 'data': [ 'one-two', 'one_two' ] }
diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/e=
num-dict-member.err
index 9b7d2f1..8ca146e 100644
--- a/tests/qapi-schema/enum-dict-member.err
+++ b/tests/qapi-schema/enum-dict-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-dict-member.json:6: Member of enum 'MyEnum' requi=
res a string name
+tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requi=
res a string name
diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema/=
enum-dict-member.json
index 69d30f0..79672e0 100644
--- a/tests/qapi-schema/enum-dict-member.json
+++ b/tests/qapi-schema/enum-dict-member.json
@@ -1,6 +1,2 @@
 # we reject any enum member that is not a string
-
-##
-# @MyEnum:
-##
 { 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index df96e22..b652e9a 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/enum-member-case.json:10: 'Value' (member of NoWayThis=
WillGetWhitelisted) should not use uppercase
+tests/qapi-schema/enum-member-case.json:3: 'Value' (member of NoWayThisW=
illGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/enum-member-case.json b/tests/qapi-schema/=
enum-member-case.json
index d2e4aba..2096b35 100644
--- a/tests/qapi-schema/enum-member-case.json
+++ b/tests/qapi-schema/enum-member-case.json
@@ -1,10 +1,3 @@
 # Member names should be 'lower-case' unless the enum is whitelisted
-
-##
-# @UuidInfo:
-##
 { 'enum': 'UuidInfo', 'data': [ 'Value' ] } # UuidInfo is whitelisted
-##
-# @NoWayThisWillGetWhitelisted:
-##
 { 'enum': 'NoWayThisWillGetWhitelisted', 'data': [ 'Value' ] }
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index de4b9e8..ba4873a 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:6: Key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
diff --git a/tests/qapi-schema/enum-missing-data.json b/tests/qapi-schema=
/enum-missing-data.json
index d7601f9..558fd35 100644
--- a/tests/qapi-schema/enum-missing-data.json
+++ b/tests/qapi-schema/enum-missing-data.json
@@ -1,6 +1,2 @@
 # we require that all QAPI enums have a data array
-
-##
-# @MyEnum:
-##
 { 'enum': 'MyEnum' }
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index c44e9b5..11b4347 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-wrong-data.json:6: Enum 'MyEnum' requires an arra=
y for 'data'
+tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an arra=
y for 'data'
diff --git a/tests/qapi-schema/enum-wrong-data.json b/tests/qapi-schema/e=
num-wrong-data.json
index 4b9e978..7b3e255 100644
--- a/tests/qapi-schema/enum-wrong-data.json
+++ b/tests/qapi-schema/enum-wrong-data.json
@@ -1,6 +1,2 @@
 # we require that all qapi enums have an array for data
-
-##
-# @MyEnum:
-##
 { 'enum': 'MyEnum', 'data': { 'value': 'str' } }
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index defe656..68ec6f2 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1 +1 @@
-tests/qapi-schema/event-boxed-empty.json:6: Use of 'boxed' requires 'dat=
a'
+tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'dat=
a'
diff --git a/tests/qapi-schema/event-boxed-empty.json b/tests/qapi-schema=
/event-boxed-empty.json
index 63b870b..cb145f1 100644
--- a/tests/qapi-schema/event-boxed-empty.json
+++ b/tests/qapi-schema/event-boxed-empty.json
@@ -1,6 +1,2 @@
 # 'boxed' requires a non-empty type
-
-##
-# @FOO:
-##
 { 'event': 'FOO', 'boxed': true }
diff --git a/tests/qapi-schema/event-case.json b/tests/qapi-schema/event-=
case.json
index 6b05c5d..3a92d8b 100644
--- a/tests/qapi-schema/event-case.json
+++ b/tests/qapi-schema/event-case.json
@@ -1,7 +1,3 @@
 # TODO: might be nice to enforce naming conventions; but until then this=
 works
 # even though events should usually be ALL_CAPS
-
-##
-# @oops:
-##
 { 'event': 'oops' }
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 2865714..5a0f2bf 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -3,4 +3,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
 event oops None
    boxed=3DFalse
 object q_empty
-doc symbol=3Doops expr=3D('event', 'oops')
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 17a6c3c..5a42701 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1 +1 @@
-tests/qapi-schema/event-nest-struct.json:5: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
+tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
diff --git a/tests/qapi-schema/event-nest-struct.json b/tests/qapi-schema=
/event-nest-struct.json
index 328e0a6..ee6f3ec 100644
--- a/tests/qapi-schema/event-nest-struct.json
+++ b/tests/qapi-schema/event-nest-struct.json
@@ -1,6 +1,2 @@
-##
-# @EVENT_A:
-# event-nest-struct
-##
 { 'event': 'EVENT_A',
   'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' } =
}
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index e456094..8ea91ea 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-array-branch.json:20: Member 'value1' of un=
ion 'TestUnion' cannot be an array
+tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of uni=
on 'TestUnion' cannot be an array
diff --git a/tests/qapi-schema/flat-union-array-branch.json b/tests/qapi-=
schema/flat-union-array-branch.json
index 51dde10..0b98820 100644
--- a/tests/qapi-schema/flat-union-array-branch.json
+++ b/tests/qapi-schema/flat-union-array-branch.json
@@ -1,22 +1,10 @@
-##
-# @TestEnum:
-##
 # we require flat union branches to be a struct
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-bad-base.err b/tests/qapi-schem=
a/flat-union-bad-base.err
index 072ffba..bee24a2 100644
--- a/tests/qapi-schema/flat-union-bad-base.err
+++ b/tests/qapi-schema/flat-union-bad-base.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-bad-base.json:21: 'string' (member of TestT=
ypeA) collides with 'string' (base of TestUnion)
+tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of TestTy=
peA) collides with 'string' (base of TestUnion)
diff --git a/tests/qapi-schema/flat-union-bad-base.json b/tests/qapi-sche=
ma/flat-union-bad-base.json
index 7713e7f..74dd421 100644
--- a/tests/qapi-schema/flat-union-bad-base.json
+++ b/tests/qapi-schema/flat-union-bad-base.json
@@ -1,23 +1,10 @@
 # we allow anonymous base, but enforce no duplicate keys
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': { 'enum1': 'TestEnum', 'string': 'str' },
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index 1be4e7b..c38cc8e 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-bad-discriminator.json:27: Discriminator of=
 flat union 'TestUnion' requires a string name
+tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator of=
 flat union 'TestUnion' requires a string name
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.json b/tests/=
qapi-schema/flat-union-bad-discriminator.json
index ef92f9b..cd10b9d 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.json
+++ b/tests/qapi-schema/flat-union-bad-discriminator.json
@@ -1,29 +1,13 @@
 # we require the discriminator to be a string naming a base-type member
 # this tests the old syntax for anonymous unions before we added alterna=
tes
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @TestBase:
-##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': {},
diff --git a/tests/qapi-schema/flat-union-base-any.err b/tests/qapi-schem=
a/flat-union-base-any.err
index c1ea2d7..646f1c9 100644
--- a/tests/qapi-schema/flat-union-base-any.err
+++ b/tests/qapi-schema/flat-union-base-any.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-base-any.json:21: 'base' for union 'TestUni=
on' cannot use built-in type 'any'
+tests/qapi-schema/flat-union-base-any.json:8: 'base' for union 'TestUnio=
n' cannot use built-in type 'any'
diff --git a/tests/qapi-schema/flat-union-base-any.json b/tests/qapi-sche=
ma/flat-union-base-any.json
index 3dfb02f..fe66b71 100644
--- a/tests/qapi-schema/flat-union-base-any.json
+++ b/tests/qapi-schema/flat-union-base-any.json
@@ -1,23 +1,10 @@
 # we require the base to be an existing struct
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'any',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-base-union.err b/tests/qapi-sch=
ema/flat-union-base-union.err
index ccc5e85..f138395 100644
--- a/tests/qapi-schema/flat-union-base-union.err
+++ b/tests/qapi-schema/flat-union-base-union.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-base-union.json:30: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
+tests/qapi-schema/flat-union-base-union.json:14: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
diff --git a/tests/qapi-schema/flat-union-base-union.json b/tests/qapi-sc=
hema/flat-union-base-union.json
index c63c613..98b4eba 100644
--- a/tests/qapi-schema/flat-union-base-union.json
+++ b/tests/qapi-schema/flat-union-base-union.json
@@ -2,31 +2,15 @@
 # TODO: It would be possible to allow a union as a base, as long as all
 # permutations of QMP names exposed by base do not clash with any QMP
 # member names added by local variants.
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @UnionBase:
-##
 { 'union': 'UnionBase',
   'data': { 'kind1': 'TestTypeA',
             'kind2': 'TestTypeB' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'UnionBase',
   'discriminator': 'type',
diff --git a/tests/qapi-schema/flat-union-clash-member.err b/tests/qapi-s=
chema/flat-union-clash-member.err
index fe12a07..2adf697 100644
--- a/tests/qapi-schema/flat-union-clash-member.err
+++ b/tests/qapi-schema/flat-union-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-clash-member.json:27: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
+tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/flat-union-clash-member.json b/tests/qapi-=
schema/flat-union-clash-member.json
index 9000b94..9efc771 100644
--- a/tests/qapi-schema/flat-union-clash-member.json
+++ b/tests/qapi-schema/flat-union-clash-member.json
@@ -1,29 +1,13 @@
 # We check for no duplicate keys between branch members and base
 # base's member 'name' clashes with Branch1's
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum', '*name': 'str' } }
-##
-# @Branch1:
-##
 { 'struct': 'Branch1',
   'data': { 'name': 'str' } }
-##
-# @Branch2:
-##
 { 'struct': 'Branch2',
   'data': { 'value': 'int' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index ead7bd4..15754f5 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-empty.json:14: Union 'Union' cannot have em=
pty 'data'
+tests/qapi-schema/flat-union-empty.json:4: Union 'Union' cannot have emp=
ty 'data'
diff --git a/tests/qapi-schema/flat-union-empty.json b/tests/qapi-schema/=
flat-union-empty.json
index afa8988..77f1d9a 100644
--- a/tests/qapi-schema/flat-union-empty.json
+++ b/tests/qapi-schema/flat-union-empty.json
@@ -1,14 +1,4 @@
 # flat unions cannot be empty
-
-##
-# @Empty:
-##
 { 'enum': 'Empty', 'data': [ ] }
-##
-# @Base:
-##
 { 'struct': 'Base', 'data': { 'type': 'Empty' } }
-##
-# @Union:
-##
 { 'union': 'Union', 'base': 'Base', 'discriminator': 'type', 'data': { }=
 }
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err b/tests/q=
api-schema/flat-union-incomplete-branch.err
index c655bbf..e826bf0 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.err
+++ b/tests/qapi-schema/flat-union-incomplete-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-incomplete-branch.json:16: Union 'TestUnion=
' data missing 'value2' branch
+tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion'=
 data missing 'value2' branch
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json b/tests/=
qapi-schema/flat-union-incomplete-branch.json
index dea0377..25a411b 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.json
+++ b/tests/qapi-schema/flat-union-incomplete-branch.json
@@ -1,18 +1,8 @@
 # we require all branches of the union to be covered
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': { 'type': 'TestEnum' },
   'discriminator': 'type',
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index c2c3f76..2333358 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-inline.json:17: Member 'value1' of union 'T=
estUnion' should be a type name
+tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union 'Te=
stUnion' should be a type name
diff --git a/tests/qapi-schema/flat-union-inline.json b/tests/qapi-schema=
/flat-union-inline.json
index 400f081..62c7cda 100644
--- a/tests/qapi-schema/flat-union-inline.json
+++ b/tests/qapi-schema/flat-union-inline.json
@@ -1,19 +1,9 @@
 # we require branches to be a struct name
 # TODO: should we allow anonymous inline branch types?
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index 299cbb2..faf0157 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-int-branch.json:21: Member 'value1' of unio=
n 'TestUnion' cannot use built-in type 'int'
+tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/flat-union-int-branch.json b/tests/qapi-sc=
hema/flat-union-int-branch.json
index 9603e17..9370c34 100644
--- a/tests/qapi-schema/flat-union-int-branch.json
+++ b/tests/qapi-schema/flat-union-int-branch.json
@@ -1,23 +1,10 @@
 # we require flat union branches to be a struct
-
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index 455f2dc..ccf72d2 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-branch-key.json:28: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
+tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.json b/tests=
/qapi-schema/flat-union-invalid-branch-key.json
index 00f2896..95ff774 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.json
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.json
@@ -1,30 +1,15 @@
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
-##
-# @TestBase:
-##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum' } }
=20
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index f0e427b..5f40556 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-discriminator.json:28: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
+tests/qapi-schema/flat-union-invalid-discriminator.json:13: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json b/te=
sts/qapi-schema/flat-union-invalid-discriminator.json
index c8700c7..48b94c3 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.json
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.json
@@ -1,30 +1,15 @@
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
-##
-# @TestBase:
-##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum' } }
=20
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': 'enum_wrong',
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index a2d0a81..841c93b 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-no-base.json:22: Flat union 'TestUnion' mus=
t have a base
+tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' must=
 have a base
diff --git a/tests/qapi-schema/flat-union-no-base.json b/tests/qapi-schem=
a/flat-union-no-base.json
index 641f68a..ffc4c6f 100644
--- a/tests/qapi-schema/flat-union-no-base.json
+++ b/tests/qapi-schema/flat-union-no-base.json
@@ -1,24 +1,11 @@
 # flat unions require a base
 # TODO: simple unions should be able to use an enum discriminator
-
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
-##
-# @Enum:
-##
 { 'enum': 'Enum',
   'data': [ 'value1', 'value2' ] }
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'discriminator': 'Enum',
   'data': { 'value1': 'TestTypeA',
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index e15f856..aaabedb 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:19: Discriminat=
or of flat union 'MyUnion' does not allow optional name '*switch'
+tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/t=
ests/qapi-schema/flat-union-optional-discriminator.json
index 9f19af5..08a8f7e 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.json
+++ b/tests/qapi-schema/flat-union-optional-discriminator.json
@@ -1,21 +1,8 @@
 # we require the discriminator to be non-optional
-
-##
-# @Enum:
-##
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
-##
-# @Branch:
-##
 { 'struct': 'Branch', 'data': { 'name': 'str' } }
-##
-# @MyUnion:
-##
 { 'union': 'MyUnion',
   'base': 'Base',
   'discriminator': '*switch',
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index bc0c133..200016b 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-string-discriminator.json:28: Discriminator=
 'kind' must be of enumeration type
+tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminator=
 'kind' must be of enumeration type
diff --git a/tests/qapi-schema/flat-union-string-discriminator.json b/tes=
ts/qapi-schema/flat-union-string-discriminator.json
index 47a17d2..8af6033 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.json
+++ b/tests/qapi-schema/flat-union-string-discriminator.json
@@ -1,30 +1,15 @@
-##
-# @TestEnum:
-##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
-##
-# @TestBase:
-##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
=20
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': 'kind',
diff --git a/tests/qapi-schema/ident-with-escape.json b/tests/qapi-schema=
/ident-with-escape.json
index c03404b..5661750 100644
--- a/tests/qapi-schema/ident-with-escape.json
+++ b/tests/qapi-schema/ident-with-escape.json
@@ -1,8 +1,4 @@
 # we allow escape sequences in strings, if they map back to ASCII
 # { 'command': 'fooA', 'data': { 'bar1': 'str' } }
-
-##
-# @fooA:
-##
 { 'c\u006fmmand': '\u0066\u006f\u006FA',
   'd\u0061ta': { '\u0062\u0061\u00721': '\u0073\u0074\u0072' } }
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 69fc908..1d2722c 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,4 +5,3 @@ command fooA q_obj_fooA-arg -> None
 object q_empty
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
-doc symbol=3DfooA expr=3D('command', 'fooA')
diff --git a/tests/qapi-schema/include-relpath-sub.json b/tests/qapi-sche=
ma/include-relpath-sub.json
index b4bd8a2..4bd4af4 100644
--- a/tests/qapi-schema/include-relpath-sub.json
+++ b/tests/qapi-schema/include-relpath-sub.json
@@ -1,5 +1,2 @@
-##
-# @Status:
-##
 { 'enum': 'Status',
   'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index a962fb2..5d7c13c 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -2,4 +2,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
-doc symbol=3DStatus expr=3D('enum', 'Status')
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index a962fb2..5d7c13c 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -2,4 +2,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
-doc symbol=3DStatus expr=3D('enum', 'Status')
diff --git a/tests/qapi-schema/include-simple-sub.json b/tests/qapi-schem=
a/include-simple-sub.json
index b4bd8a2..4bd4af4 100644
--- a/tests/qapi-schema/include-simple-sub.json
+++ b/tests/qapi-schema/include-simple-sub.json
@@ -1,5 +1,2 @@
-##
-# @Status:
-##
 { 'enum': 'Status',
   'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index a962fb2..5d7c13c 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -2,4 +2,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
-doc symbol=3DStatus expr=3D('enum', 'Status')
diff --git a/tests/qapi-schema/indented-expr.json b/tests/qapi-schema/ind=
ented-expr.json
index d759be1..7115d31 100644
--- a/tests/qapi-schema/indented-expr.json
+++ b/tests/qapi-schema/indented-expr.json
@@ -1,8 +1,2 @@
-##
-# @eins:
-##
 { 'command' : 'eins' }
-##
-# @zwei:
-##
  { 'command' : 'zwei' }
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index 285d052..e8171c9 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -5,5 +5,3 @@ command eins None -> None
 object q_empty
 command zwei None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
-doc symbol=3Deins expr=3D('command', 'eins')
-doc symbol=3Dzwei expr=3D('command', 'zwei')
diff --git a/tests/qapi-schema/missing-type.err b/tests/qapi-schema/missi=
ng-type.err
index 74c4ef7..b3e7b14 100644
--- a/tests/qapi-schema/missing-type.err
+++ b/tests/qapi-schema/missing-type.err
@@ -1 +1 @@
-tests/qapi-schema/missing-type.json:6: Expression is missing metatype
+tests/qapi-schema/missing-type.json:2: Expression is missing metatype
diff --git a/tests/qapi-schema/missing-type.json b/tests/qapi-schema/miss=
ing-type.json
index c2fc62d..ff5349d 100644
--- a/tests/qapi-schema/missing-type.json
+++ b/tests/qapi-schema/missing-type.json
@@ -1,6 +1,2 @@
 # we reject an expression with missing metatype
-
-##
-# @foo:
-##
 { 'data': { } }
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index 379bd1d..da767ba 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1 +1 @@
-tests/qapi-schema/nested-struct-data.json:6: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
+tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
diff --git a/tests/qapi-schema/nested-struct-data.json b/tests/qapi-schem=
a/nested-struct-data.json
index 6106e15..efbe773 100644
--- a/tests/qapi-schema/nested-struct-data.json
+++ b/tests/qapi-schema/nested-struct-data.json
@@ -1,7 +1,3 @@
 # inline subtypes collide with our desired future use of defaults
-
-##
-# @foo:
-##
 { 'command': 'foo',
   'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' } =
}
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index f4d8cc4..1719463 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -3,153 +3,67 @@
 # This file is a stress test of supported qapi constructs that must
 # parse and compile correctly.
=20
-##
-# =3D Section
-# =3D=3D subsection
-#
-# Some text foo with *strong* and _emphasis_
-# 1. with a list
-# 2. like that @foo
-#
-# And some code:
-# | $ echo foo
-# | -> do this
-# | <- get that
-#
-# Note: is not a meta
-##
-
-##
-# @TestStruct:
-#
-# body with @var
-#
-# @integer: foo
-#           blah
-#
-#           bao
-#
-# @boolean: bar
-# @string: baz
-#
-# Example:
-#
-# -> { "execute": ... }
-# <- { "return": ... }
-#
-# Since: 2.3
-# Note: a note
-#
-##
 { 'struct': 'TestStruct',
   'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
=20
-##
-# @NestedEnumsOne:
 # for testing enums
-##
 { 'struct': 'NestedEnumsOne',
   'data': { 'enum1': 'EnumOne',   # Intentional forward reference
             '*enum2': 'EnumOne', 'enum3': 'EnumOne', '*enum4': 'EnumOne'=
 } }
=20
-##
-# @MyEnum:
 # An empty enum, although unusual, is currently acceptable
-##
 { 'enum': 'MyEnum', 'data': [ ] }
=20
-##
-# @Empty1:
 # Likewise for an empty struct, including an empty base
-##
 { 'struct': 'Empty1', 'data': { } }
-##
-# @Empty2:
-##
 { 'struct': 'Empty2', 'base': 'Empty1', 'data': { } }
=20
-##
-# @user_def_cmd0:
-##
 { 'command': 'user_def_cmd0', 'data': 'Empty2', 'returns': 'Empty2' }
=20
-##
-# @QEnumTwo:
 # for testing override of default naming heuristic
-##
 { 'enum': 'QEnumTwo',
   'prefix': 'QENUM_TWO',
   'data': [ 'value1', 'value2' ] }
=20
-##
-# @UserDefOne:
 # for testing nested structs
-##
 { 'struct': 'UserDefOne',
   'base': 'UserDefZero',        # intentional forward reference
   'data': { 'string': 'str',
             '*enum1': 'EnumOne' } }   # intentional forward reference
=20
-##
-# @EnumOne:
-##
 { 'enum': 'EnumOne',
   'data': [ 'value1', 'value2', 'value3' ] }
=20
-##
-# @UserDefZero:
-##
 { 'struct': 'UserDefZero',
   'data': { 'integer': 'int' } }
=20
-##
-# @UserDefTwoDictDict:
-##
 { 'struct': 'UserDefTwoDictDict',
   'data': { 'userdef': 'UserDefOne', 'string': 'str' } }
=20
-##
-# @UserDefTwoDict:
-##
 { 'struct': 'UserDefTwoDict',
   'data': { 'string1': 'str',
             'dict2': 'UserDefTwoDictDict',
             '*dict3': 'UserDefTwoDictDict' } }
=20
-##
-# @UserDefTwo:
-##
 { 'struct': 'UserDefTwo',
   'data': { 'string0': 'str',
             'dict1': 'UserDefTwoDict' } }
=20
-##
-# @ForceArrays:
 # dummy struct to force generation of array types not otherwise mentione=
d
-##
 { 'struct': 'ForceArrays',
   'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
             'unused3':['TestStruct'] } }
=20
-##
-# @UserDefA:
 # for testing unions
 # Among other things, test that a name collision between branches does
 # not cause any problems (since only one branch can be in use at a time)=
,
 # by intentionally using two branches that both have a C member 'a_b'
-##
 { 'struct': 'UserDefA',
   'data': { 'boolean': 'bool', '*a_b': 'int' } }
=20
-##
-# @UserDefB:
-##
 { 'struct': 'UserDefB',
   'data': { 'intb': 'int', '*a-b': 'bool' } }
=20
-##
-# @UserDefFlatUnion:
-##
 { 'union': 'UserDefFlatUnion',
   'base': 'UserDefUnionBase',   # intentional forward reference
   'discriminator': 'enum1',
@@ -157,71 +71,35 @@
             'value2' : 'UserDefB',
             'value3' : 'UserDefB' } }
=20
-##
-# @UserDefUnionBase:
-##
 { 'struct': 'UserDefUnionBase',
   'base': 'UserDefZero',
   'data': { 'string': 'str', 'enum1': 'EnumOne' } }
=20
-##
-# @UserDefFlatUnion2:
 # this variant of UserDefFlatUnion defaults to a union that uses members=
 with
 # allocated types to test corner cases in the cleanup/dealloc visitor
-##
 { 'union': 'UserDefFlatUnion2',
   'base': { '*integer': 'int', 'string': 'str', 'enum1': 'QEnumTwo' },
   'discriminator': 'enum1',
   'data': { 'value1' : 'UserDefC', # intentional forward reference
             'value2' : 'UserDefB' } }
=20
-##
-# @WrapAlternate:
-##
 { 'struct': 'WrapAlternate',
   'data': { 'alt': 'UserDefAlternate' } }
-##
-# @UserDefAlternate:
-##
 { 'alternate': 'UserDefAlternate',
   'data': { 'udfu': 'UserDefFlatUnion', 's': 'str', 'i': 'int' } }
=20
-##
-# @UserDefC:
-##
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
=20
 # for testing use of 'number' within alternates
-##
-# @AltStrBool:
-##
 { 'alternate': 'AltStrBool', 'data': { 's': 'str', 'b': 'bool' } }
-##
-# @AltStrNum:
-##
 { 'alternate': 'AltStrNum', 'data': { 's': 'str', 'n': 'number' } }
-##
-# @AltNumStr:
-##
 { 'alternate': 'AltNumStr', 'data': { 'n': 'number', 's': 'str' } }
-##
-# @AltStrInt:
-##
 { 'alternate': 'AltStrInt', 'data': { 's': 'str', 'i': 'int' } }
-##
-# @AltIntNum:
-##
 { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
-##
-# @AltNumInt:
-##
 { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
=20
-##
-# @UserDefNativeListUnion:
 # for testing native lists
-##
 { 'union': 'UserDefNativeListUnion',
   'data': { 'integer': ['int'],
             's8': ['int8'],
@@ -239,61 +117,19 @@
             'any': ['any'] } }
=20
 # testing commands
-##
-# @user_def_cmd:
-##
 { 'command': 'user_def_cmd', 'data': {} }
-##
-# @user_def_cmd1:
-##
 { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
-##
-# @user_def_cmd2:
-##
 { 'command': 'user_def_cmd2',
   'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
   'returns': 'UserDefTwo' }
=20
-##
-# Another comment
-##
-
-##
-# @guest-get-time:
-#
-# @guest-get-time body
-#
-# @a: an integer
-# @b: #optional integer
-#
-# Returns: returns something
-#
-# Example:
-#
-# -> { "execute": "guest-get-time", ... }
-# <- { "return": "42" }
-#
-##
-
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
   'returns': 'int' }
-##
-# @guest-sync:
-##
 { 'command': 'guest-sync', 'data': { 'arg': 'any' }, 'returns': 'any' }
-##
-# @boxed-struct:
-##
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
-##
-# @boxed-union:
-##
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': t=
rue }
=20
-##
-# @UserDefOptions:
-#
 # For testing integer range flattening in opts-visitor. The following sc=
hema
 # corresponds to the option format:
 #
@@ -301,7 +137,6 @@
 #
 # For simplicity, this example doesn't use [type=3D]discriminator nor op=
targs
 # specific to discriminator values.
-##
 { 'struct': 'UserDefOptions',
   'data': {
     '*i64' : [ 'int'    ],
@@ -311,83 +146,35 @@
     '*u64x':   'uint64'  } }
=20
 # testing event
-##
-# @EventStructOne:
-##
 { 'struct': 'EventStructOne',
   'data': { 'struct1': 'UserDefOne', 'string': 'str', '*enum2': 'EnumOne=
' } }
=20
-##
-# @EVENT_A:
-##
 { 'event': 'EVENT_A' }
-##
-# @EVENT_B:
-##
 { 'event': 'EVENT_B',
   'data': { } }
-##
-# @EVENT_C:
-##
 { 'event': 'EVENT_C',
   'data': { '*a': 'int', '*b': 'UserDefOne', 'c': 'str' } }
-##
-# @EVENT_D:
-##
 { 'event': 'EVENT_D',
   'data': { 'a' : 'EventStructOne', 'b' : 'str', '*c': 'str', '*enum3': =
'EnumOne' } }
-##
-# @EVENT_E:
-##
 { 'event': 'EVENT_E', 'boxed': true, 'data': 'UserDefZero' }
-##
-# @EVENT_F:
-##
 { 'event': 'EVENT_F', 'boxed': true, 'data': 'UserDefAlternate' }
=20
 # test that we correctly compile downstream extensions, as well as munge
 # ticklish names
-##
-# @__org.qemu_x-Enum:
-##
 { 'enum': '__org.qemu_x-Enum', 'data': [ '__org.qemu_x-value' ] }
-##
-# @__org.qemu_x-Base:
-##
 { 'struct': '__org.qemu_x-Base',
   'data': { '__org.qemu_x-member1': '__org.qemu_x-Enum' } }
-##
-# @__org.qemu_x-Struct:
-##
 { 'struct': '__org.qemu_x-Struct', 'base': '__org.qemu_x-Base',
   'data': { '__org.qemu_x-member2': 'str', '*wchar-t': 'int' } }
-##
-# @__org.qemu_x-Union1:
-##
 { 'union': '__org.qemu_x-Union1', 'data': { '__org.qemu_x-branch': 'str'=
 } }
-##
-# @__org.qemu_x-Struct2:
-##
 { 'struct': '__org.qemu_x-Struct2',
   'data': { 'array': ['__org.qemu_x-Union1'] } }
-##
-# @__org.qemu_x-Union2:
-##
 { 'union': '__org.qemu_x-Union2', 'base': '__org.qemu_x-Base',
   'discriminator': '__org.qemu_x-member1',
   'data': { '__org.qemu_x-value': '__org.qemu_x-Struct2' } }
-##
-# @__org.qemu_x-Alt:
-##
 { 'alternate': '__org.qemu_x-Alt',
   'data': { '__org.qemu_x-branch': 'str', 'b': '__org.qemu_x-Base' } }
-##
-# @__ORG.QEMU_X-EVENT:
-##
 { 'event': '__ORG.QEMU_X-EVENT', 'data': '__org.qemu_x-Struct' }
-##
-# @__org.qemu_x-command:
-##
 { 'command': '__org.qemu_x-command',
   'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
             'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index bc8d496..9d99c4e 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -232,133 +232,3 @@ command user_def_cmd1 q_obj_user_def_cmd1-arg -> No=
ne
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
    gen=3DTrue success_response=3DTrue boxed=3DFalse
-doc freeform
-    body=3D
-=3D Section
-=3D=3D subsection
-
-Some text foo with *strong* and _emphasis_
-1. with a list
-2. like that @foo
-
-And some code:
-| $ echo foo
-| -> do this
-| <- get that
-
-Note: is not a meta
-doc symbol=3DTestStruct expr=3D('struct', 'TestStruct')
-    arg=3Dinteger
-foo
-blah
-
-bao
-    arg=3Dboolean
-bar
-    arg=3Dstring
-baz
-    section=3DExample
--> { "execute": ... }
-<- { "return": ... }
-    section=3DSince
-2.3
-    section=3DNote
-a note
-    body=3D
-body with @var
-doc symbol=3DNestedEnumsOne expr=3D('struct', 'NestedEnumsOne')
-    body=3D
-for testing enums
-doc symbol=3DMyEnum expr=3D('enum', 'MyEnum')
-    body=3D
-An empty enum, although unusual, is currently acceptable
-doc symbol=3DEmpty1 expr=3D('struct', 'Empty1')
-    body=3D
-Likewise for an empty struct, including an empty base
-doc symbol=3DEmpty2 expr=3D('struct', 'Empty2')
-doc symbol=3Duser_def_cmd0 expr=3D('command', 'user_def_cmd0')
-doc symbol=3DQEnumTwo expr=3D('enum', 'QEnumTwo')
-    body=3D
-for testing override of default naming heuristic
-doc symbol=3DUserDefOne expr=3D('struct', 'UserDefOne')
-    body=3D
-for testing nested structs
-doc symbol=3DEnumOne expr=3D('enum', 'EnumOne')
-doc symbol=3DUserDefZero expr=3D('struct', 'UserDefZero')
-doc symbol=3DUserDefTwoDictDict expr=3D('struct', 'UserDefTwoDictDict')
-doc symbol=3DUserDefTwoDict expr=3D('struct', 'UserDefTwoDict')
-doc symbol=3DUserDefTwo expr=3D('struct', 'UserDefTwo')
-doc symbol=3DForceArrays expr=3D('struct', 'ForceArrays')
-    body=3D
-dummy struct to force generation of array types not otherwise mentioned
-doc symbol=3DUserDefA expr=3D('struct', 'UserDefA')
-    body=3D
-for testing unions
-Among other things, test that a name collision between branches does
-not cause any problems (since only one branch can be in use at a time),
-by intentionally using two branches that both have a C member 'a_b'
-doc symbol=3DUserDefB expr=3D('struct', 'UserDefB')
-doc symbol=3DUserDefFlatUnion expr=3D('union', 'UserDefFlatUnion')
-doc symbol=3DUserDefUnionBase expr=3D('struct', 'UserDefUnionBase')
-doc symbol=3DUserDefFlatUnion2 expr=3D('union', 'UserDefFlatUnion2')
-    body=3D
-this variant of UserDefFlatUnion defaults to a union that uses members w=
ith
-allocated types to test corner cases in the cleanup/dealloc visitor
-doc symbol=3DWrapAlternate expr=3D('struct', 'WrapAlternate')
-doc symbol=3DUserDefAlternate expr=3D('alternate', 'UserDefAlternate')
-doc symbol=3DUserDefC expr=3D('struct', 'UserDefC')
-doc symbol=3DAltStrBool expr=3D('alternate', 'AltStrBool')
-doc symbol=3DAltStrNum expr=3D('alternate', 'AltStrNum')
-doc symbol=3DAltNumStr expr=3D('alternate', 'AltNumStr')
-doc symbol=3DAltStrInt expr=3D('alternate', 'AltStrInt')
-doc symbol=3DAltIntNum expr=3D('alternate', 'AltIntNum')
-doc symbol=3DAltNumInt expr=3D('alternate', 'AltNumInt')
-doc symbol=3DUserDefNativeListUnion expr=3D('union', 'UserDefNativeListU=
nion')
-    body=3D
-for testing native lists
-doc symbol=3Duser_def_cmd expr=3D('command', 'user_def_cmd')
-doc symbol=3Duser_def_cmd1 expr=3D('command', 'user_def_cmd1')
-doc symbol=3Duser_def_cmd2 expr=3D('command', 'user_def_cmd2')
-doc freeform
-    body=3D
-Another comment
-doc symbol=3Dguest-get-time expr=3D('command', 'guest-get-time')
-    arg=3Da
-an integer
-    arg=3Db
-#optional integer
-    section=3DReturns
-returns something
-    section=3DExample
--> { "execute": "guest-get-time", ... }
-<- { "return": "42" }
-    body=3D
-@guest-get-time body
-doc symbol=3Dguest-sync expr=3D('command', 'guest-sync')
-doc symbol=3Dboxed-struct expr=3D('command', 'boxed-struct')
-doc symbol=3Dboxed-union expr=3D('command', 'boxed-union')
-doc symbol=3DUserDefOptions expr=3D('struct', 'UserDefOptions')
-    body=3D
-For testing integer range flattening in opts-visitor. The following sche=
ma
-corresponds to the option format:
-
--userdef i64=3D3-6,i64=3D-5--1,u64=3D2,u16=3D1,u16=3D7-12
-
-For simplicity, this example doesn't use [type=3D]discriminator nor opta=
rgs
-specific to discriminator values.
-doc symbol=3DEventStructOne expr=3D('struct', 'EventStructOne')
-doc symbol=3DEVENT_A expr=3D('event', 'EVENT_A')
-doc symbol=3DEVENT_B expr=3D('event', 'EVENT_B')
-doc symbol=3DEVENT_C expr=3D('event', 'EVENT_C')
-doc symbol=3DEVENT_D expr=3D('event', 'EVENT_D')
-doc symbol=3DEVENT_E expr=3D('event', 'EVENT_E')
-doc symbol=3DEVENT_F expr=3D('event', 'EVENT_F')
-doc symbol=3D__org.qemu_x-Enum expr=3D('enum', '__org.qemu_x-Enum')
-doc symbol=3D__org.qemu_x-Base expr=3D('struct', '__org.qemu_x-Base')
-doc symbol=3D__org.qemu_x-Struct expr=3D('struct', '__org.qemu_x-Struct'=
)
-doc symbol=3D__org.qemu_x-Union1 expr=3D('union', '__org.qemu_x-Union1')
-doc symbol=3D__org.qemu_x-Struct2 expr=3D('struct', '__org.qemu_x-Struct=
2')
-doc symbol=3D__org.qemu_x-Union2 expr=3D('union', '__org.qemu_x-Union2')
-doc symbol=3D__org.qemu_x-Alt expr=3D('alternate', '__org.qemu_x-Alt')
-doc symbol=3D__ORG.QEMU_X-EVENT expr=3D('event', '__ORG.QEMU_X-EVENT')
-doc symbol=3D__org.qemu_x-command expr=3D('command', '__org.qemu_x-comma=
nd')
diff --git a/tests/qapi-schema/redefined-builtin.err b/tests/qapi-schema/=
redefined-builtin.err
index ee0a2ad..b275722 100644
--- a/tests/qapi-schema/redefined-builtin.err
+++ b/tests/qapi-schema/redefined-builtin.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-builtin.json:6: built-in 'size' is already d=
efined
+tests/qapi-schema/redefined-builtin.json:2: built-in 'size' is already d=
efined
diff --git a/tests/qapi-schema/redefined-builtin.json b/tests/qapi-schema=
/redefined-builtin.json
index 6d3a940..45b8a55 100644
--- a/tests/qapi-schema/redefined-builtin.json
+++ b/tests/qapi-schema/redefined-builtin.json
@@ -1,6 +1,2 @@
 # we reject types that duplicate builtin names
-
-##
-# @size:
-##
 { 'struct': 'size', 'data': { 'myint': 'size' } }
diff --git a/tests/qapi-schema/redefined-command.err b/tests/qapi-schema/=
redefined-command.err
index 1e297c4..82ae256 100644
--- a/tests/qapi-schema/redefined-command.err
+++ b/tests/qapi-schema/redefined-command.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-command.json:10: command 'foo' is already de=
fined
+tests/qapi-schema/redefined-command.json:3: command 'foo' is already def=
ined
diff --git a/tests/qapi-schema/redefined-command.json b/tests/qapi-schema=
/redefined-command.json
index 3a8cb90..247e401 100644
--- a/tests/qapi-schema/redefined-command.json
+++ b/tests/qapi-schema/redefined-command.json
@@ -1,10 +1,3 @@
 # we reject commands defined more than once
-
-##
-# @foo:
-##
 { 'command': 'foo', 'data': { 'one': 'str' } }
-##
-# @foo:
-##
 { 'command': 'foo', 'data': { '*two': 'str' } }
diff --git a/tests/qapi-schema/redefined-event.err b/tests/qapi-schema/re=
defined-event.err
index 912c785..35429cb 100644
--- a/tests/qapi-schema/redefined-event.err
+++ b/tests/qapi-schema/redefined-event.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-event.json:10: event 'EVENT_A' is already de=
fined
+tests/qapi-schema/redefined-event.json:3: event 'EVENT_A' is already def=
ined
diff --git a/tests/qapi-schema/redefined-event.json b/tests/qapi-schema/r=
edefined-event.json
index ec7aeea..7717e91 100644
--- a/tests/qapi-schema/redefined-event.json
+++ b/tests/qapi-schema/redefined-event.json
@@ -1,10 +1,3 @@
 # we reject duplicate events
-
-##
-# @EVENT_A:
-##
 { 'event': 'EVENT_A', 'data': { 'myint': 'int' } }
-##
-# @EVENT_A:
-##
 { 'event': 'EVENT_A', 'data': { 'myint': 'int' } }
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 28d87c0..06ea78c 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-type.json:10: struct 'foo' is already define=
d
+tests/qapi-schema/redefined-type.json:3: struct 'foo' is already defined
diff --git a/tests/qapi-schema/redefined-type.json b/tests/qapi-schema/re=
defined-type.json
index 7a8f3e1..a09e768 100644
--- a/tests/qapi-schema/redefined-type.json
+++ b/tests/qapi-schema/redefined-type.json
@@ -1,10 +1,3 @@
 # we reject types defined more than once
-
-##
-# @foo:
-##
 { 'struct': 'foo', 'data': { 'one': 'str' } }
-##
-# @foo:
-##
 { 'enum': 'foo', 'data': [ 'two' ] }
diff --git a/tests/qapi-schema/reserved-command-q.err b/tests/qapi-schema=
/reserved-command-q.err
index 5e17f31..f939e04 100644
--- a/tests/qapi-schema/reserved-command-q.err
+++ b/tests/qapi-schema/reserved-command-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-command-q.json:12: 'command' uses invalid nam=
e 'q-unix'
+tests/qapi-schema/reserved-command-q.json:5: 'command' uses invalid name=
 'q-unix'
diff --git a/tests/qapi-schema/reserved-command-q.json b/tests/qapi-schem=
a/reserved-command-q.json
index bba0860..99f8aae 100644
--- a/tests/qapi-schema/reserved-command-q.json
+++ b/tests/qapi-schema/reserved-command-q.json
@@ -1,12 +1,5 @@
 # C entity name collision
 # We reject names like 'q-unix', because they can collide with the mangl=
ed
 # name for 'unix' in generated C.
-
-##
-# @unix:
-##
 { 'command': 'unix' }
-##
-# @q-unix:
-##
 { 'command': 'q-unix' }
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index acb2df8..e1c3480 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-enum-q.json:8: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
+tests/qapi-schema/reserved-enum-q.json:4: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
diff --git a/tests/qapi-schema/reserved-enum-q.json b/tests/qapi-schema/r=
eserved-enum-q.json
index 6c7e717..3593a76 100644
--- a/tests/qapi-schema/reserved-enum-q.json
+++ b/tests/qapi-schema/reserved-enum-q.json
@@ -1,8 +1,4 @@
 # C entity name collision
 # We reject names like 'q-unix', because they can collide with the mangl=
ed
 # name for 'unix' in generated C.
-
-##
-# @Foo:
-##
 { 'enum': 'Foo', 'data': [ 'unix', 'q-Unix' ] }
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index 9ace796..e755771 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-has.json:9: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
+tests/qapi-schema/reserved-member-has.json:5: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
diff --git a/tests/qapi-schema/reserved-member-has.json b/tests/qapi-sche=
ma/reserved-member-has.json
index f0d8905..45b9109 100644
--- a/tests/qapi-schema/reserved-member-has.json
+++ b/tests/qapi-schema/reserved-member-has.json
@@ -2,8 +2,4 @@
 # We reject names like 'has-a', because they can collide with the flag
 # for an optional 'a' in generated C.
 # TODO we could munge the optional flag name to avoid the collision.
-
-##
-# @oops:
-##
 { 'command': 'oops', 'data': { '*a': 'str', 'has-a': 'str' } }
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index 1709a88..f3d5dd7 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-q.json:8: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
+tests/qapi-schema/reserved-member-q.json:4: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
diff --git a/tests/qapi-schema/reserved-member-q.json b/tests/qapi-schema=
/reserved-member-q.json
index f51e312..62fed8f 100644
--- a/tests/qapi-schema/reserved-member-q.json
+++ b/tests/qapi-schema/reserved-member-q.json
@@ -1,8 +1,4 @@
 # C member name collision
 # We reject names like 'q-unix', because they can collide with the mangl=
ed
 # name for 'unix' in generated C.
-
-##
-# @Foo:
-##
 { 'struct': 'Foo', 'data': { 'unix':'int', 'q-unix':'bool' } }
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index 6ec69a7..87d4229 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-u.json:11: Member of 'data' for struct=
 'Oops' uses reserved name 'u'
+tests/qapi-schema/reserved-member-u.json:7: Member of 'data' for struct =
'Oops' uses reserved name 'u'
diff --git a/tests/qapi-schema/reserved-member-u.json b/tests/qapi-schema=
/reserved-member-u.json
index 3a578e5..1eaf0f3 100644
--- a/tests/qapi-schema/reserved-member-u.json
+++ b/tests/qapi-schema/reserved-member-u.json
@@ -4,8 +4,4 @@
 # This is true even for non-unions, because it is possible to convert a
 # struct to flat union while remaining backwards compatible in QMP.
 # TODO - we could munge the member name to 'q_u' to avoid the collision
-
-##
-# @Oops:
-##
 { 'struct': 'Oops', 'data': { 'u': 'str' } }
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index c9aefee..65ff0da 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-underscore.json:8: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
+tests/qapi-schema/reserved-member-underscore.json:4: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
diff --git a/tests/qapi-schema/reserved-member-underscore.json b/tests/qa=
pi-schema/reserved-member-underscore.json
index cc34b54..4a3a017 100644
--- a/tests/qapi-schema/reserved-member-underscore.json
+++ b/tests/qapi-schema/reserved-member-underscore.json
@@ -1,8 +1,4 @@
 # C member name collision
 # We reject use of a single leading underscore in all names (names must
 # begin with a letter or a downstream extension double-underscore prefix=
).
-
-##
-# @Oops:
-##
 { 'struct': 'Oops', 'data': { '_oops': 'str' } }
diff --git a/tests/qapi-schema/reserved-type-kind.err b/tests/qapi-schema=
/reserved-type-kind.err
index 8698073..0a38efa 100644
--- a/tests/qapi-schema/reserved-type-kind.err
+++ b/tests/qapi-schema/reserved-type-kind.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-type-kind.json:6: enum 'UnionKind' should not=
 end in 'Kind'
+tests/qapi-schema/reserved-type-kind.json:2: enum 'UnionKind' should not=
 end in 'Kind'
diff --git a/tests/qapi-schema/reserved-type-kind.json b/tests/qapi-schem=
a/reserved-type-kind.json
index a094941..9ecaba1 100644
--- a/tests/qapi-schema/reserved-type-kind.json
+++ b/tests/qapi-schema/reserved-type-kind.json
@@ -1,6 +1,2 @@
 # we reject types that would conflict with implicit union enum
-
-##
-# @UnionKind:
-##
 { 'enum': 'UnionKind', 'data': [ 'oops' ] }
diff --git a/tests/qapi-schema/reserved-type-list.err b/tests/qapi-schema=
/reserved-type-list.err
index ec0531c..4510fa6 100644
--- a/tests/qapi-schema/reserved-type-list.err
+++ b/tests/qapi-schema/reserved-type-list.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-type-list.json:9: struct 'FooList' should not=
 end in 'List'
+tests/qapi-schema/reserved-type-list.json:5: struct 'FooList' should not=
 end in 'List'
diff --git a/tests/qapi-schema/reserved-type-list.json b/tests/qapi-schem=
a/reserved-type-list.json
index 6effb78..98d53bf 100644
--- a/tests/qapi-schema/reserved-type-list.json
+++ b/tests/qapi-schema/reserved-type-list.json
@@ -2,8 +2,4 @@
 # We reserve names ending in 'List' for use by array types.
 # TODO - we could choose array names to avoid collision with user types,
 # in order to let this compile
-
-##
-# @FooList:
-##
 { 'struct': 'FooList', 'data': { 's': 'str' } }
diff --git a/tests/qapi-schema/returns-alternate.err b/tests/qapi-schema/=
returns-alternate.err
index 2b81623..dfbb419 100644
--- a/tests/qapi-schema/returns-alternate.err
+++ b/tests/qapi-schema/returns-alternate.err
@@ -1 +1 @@
-tests/qapi-schema/returns-alternate.json:10: 'returns' for command 'oops=
' cannot use alternate type 'Alt'
+tests/qapi-schema/returns-alternate.json:3: 'returns' for command 'oops'=
 cannot use alternate type 'Alt'
diff --git a/tests/qapi-schema/returns-alternate.json b/tests/qapi-schema=
/returns-alternate.json
index 005bf2d..972390c 100644
--- a/tests/qapi-schema/returns-alternate.json
+++ b/tests/qapi-schema/returns-alternate.json
@@ -1,10 +1,3 @@
 # we reject returns if it is an alternate type
-
-##
-# @Alt:
-##
 { 'alternate': 'Alt', 'data': { 'a': 'int', 'b': 'str' } }
-##
-# @oops:
-##
 { 'command': 'oops', 'returns': 'Alt' }
diff --git a/tests/qapi-schema/returns-array-bad.err b/tests/qapi-schema/=
returns-array-bad.err
index b53bdb0..138095c 100644
--- a/tests/qapi-schema/returns-array-bad.err
+++ b/tests/qapi-schema/returns-array-bad.err
@@ -1 +1 @@
-tests/qapi-schema/returns-array-bad.json:6: 'returns' for command 'oops'=
: array type must contain single type name
+tests/qapi-schema/returns-array-bad.json:2: 'returns' for command 'oops'=
: array type must contain single type name
diff --git a/tests/qapi-schema/returns-array-bad.json b/tests/qapi-schema=
/returns-array-bad.json
index 30528fe..09b0b1f 100644
--- a/tests/qapi-schema/returns-array-bad.json
+++ b/tests/qapi-schema/returns-array-bad.json
@@ -1,6 +1,2 @@
 # we reject an array return that is not a single type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'returns': [ 'str', 'str' ] }
diff --git a/tests/qapi-schema/returns-dict.err b/tests/qapi-schema/retur=
ns-dict.err
index 1570a35..eb2d0c4 100644
--- a/tests/qapi-schema/returns-dict.err
+++ b/tests/qapi-schema/returns-dict.err
@@ -1 +1 @@
-tests/qapi-schema/returns-dict.json:6: 'returns' for command 'oops' shou=
ld be a type name
+tests/qapi-schema/returns-dict.json:2: 'returns' for command 'oops' shou=
ld be a type name
diff --git a/tests/qapi-schema/returns-dict.json b/tests/qapi-schema/retu=
rns-dict.json
index 6a3ed0f..1cfef3e 100644
--- a/tests/qapi-schema/returns-dict.json
+++ b/tests/qapi-schema/returns-dict.json
@@ -1,6 +1,2 @@
 # we reject inline struct return type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'returns': { 'a': 'str' } }
diff --git a/tests/qapi-schema/returns-unknown.err b/tests/qapi-schema/re=
turns-unknown.err
index d76bcfe..1f43e3a 100644
--- a/tests/qapi-schema/returns-unknown.err
+++ b/tests/qapi-schema/returns-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/returns-unknown.json:6: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
+tests/qapi-schema/returns-unknown.json:2: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/returns-unknown.json b/tests/qapi-schema/r=
eturns-unknown.json
index 3837f0e..25bd498 100644
--- a/tests/qapi-schema/returns-unknown.json
+++ b/tests/qapi-schema/returns-unknown.json
@@ -1,6 +1,2 @@
 # we reject returns if it does not contain a known type
-
-##
-# @oops:
-##
 { 'command': 'oops', 'returns': 'NoSuchType' }
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/=
returns-whitelist.err
index e77ea2d..f47c1ee 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1 +1 @@
-tests/qapi-schema/returns-whitelist.json:26: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
+tests/qapi-schema/returns-whitelist.json:10: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/returns-whitelist.json b/tests/qapi-schema=
/returns-whitelist.json
index 0bc952d..e8b3cea 100644
--- a/tests/qapi-schema/returns-whitelist.json
+++ b/tests/qapi-schema/returns-whitelist.json
@@ -1,27 +1,11 @@
 # we enforce that 'returns' be a dict or array of dict unless whiteliste=
d
-
-##
-# @human-monitor-command:
-##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str' }
-##
-# @TpmModel:
-##
 { 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
-##
-# @query-tpm-models:
-##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
-##
-# @guest-get-time:
-##
 { 'command': 'guest-get-time',
   'returns': 'int' }
=20
-##
-# @no-way-this-will-get-whitelisted:
-##
 { 'command': 'no-way-this-will-get-whitelisted',
   'returns': [ 'int' ] }
diff --git a/tests/qapi-schema/struct-base-clash-deep.err b/tests/qapi-sc=
hema/struct-base-clash-deep.err
index 1b7c0e9..e2d7943 100644
--- a/tests/qapi-schema/struct-base-clash-deep.err
+++ b/tests/qapi-schema/struct-base-clash-deep.err
@@ -1 +1 @@
-tests/qapi-schema/struct-base-clash-deep.json:20: 'name' (member of Sub)=
 collides with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash-deep.json:10: 'name' (member of Sub)=
 collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash-deep.json b/tests/qapi-s=
chema/struct-base-clash-deep.json
index 646d680..fa873ab 100644
--- a/tests/qapi-schema/struct-base-clash-deep.json
+++ b/tests/qapi-schema/struct-base-clash-deep.json
@@ -2,21 +2,11 @@
 # Here, 'name' would have to appear twice on the wire, locally and
 # indirectly for the grandparent base; the collision doesn't care that
 # one instance is optional.
-
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'name': 'str' } }
-##
-# @Mid:
-##
 { 'struct': 'Mid',
   'base': 'Base',
   'data': { 'value': 'int' } }
-##
-# @Sub:
-##
 { 'struct': 'Sub',
   'base': 'Mid',
   'data': { '*name': 'str' } }
diff --git a/tests/qapi-schema/struct-base-clash.err b/tests/qapi-schema/=
struct-base-clash.err
index 5fe6393..c52f33d 100644
--- a/tests/qapi-schema/struct-base-clash.err
+++ b/tests/qapi-schema/struct-base-clash.err
@@ -1 +1 @@
-tests/qapi-schema/struct-base-clash.json:12: 'name' (member of Sub) coll=
ides with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash.json:5: 'name' (member of Sub) colli=
des with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash.json b/tests/qapi-schema=
/struct-base-clash.json
index a853995..11aec80 100644
--- a/tests/qapi-schema/struct-base-clash.json
+++ b/tests/qapi-schema/struct-base-clash.json
@@ -1,14 +1,7 @@
 # Reject attempts to duplicate QMP members
 # Here, 'name' would have to appear twice on the wire, locally and for b=
ase.
-
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'name': 'str' } }
-##
-# @Sub:
-##
 { 'struct': 'Sub',
   'base': 'Base',
   'data': { 'name': 'str' } }
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index 2716335..6644f4c 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-data-invalid.json:4: 'data' for struct 'foo' sh=
ould be a dictionary or type name
+tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be a dictionary or type name
diff --git a/tests/qapi-schema/struct-data-invalid.json b/tests/qapi-sche=
ma/struct-data-invalid.json
index aa817bd..9adbc3b 100644
--- a/tests/qapi-schema/struct-data-invalid.json
+++ b/tests/qapi-schema/struct-data-invalid.json
@@ -1,5 +1,2 @@
-##
-# @foo:
-##
 { 'struct': 'foo',
   'data': false }
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index f2b105b..69a326d 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-member-invalid.json:4: Member 'a' of 'data' for=
 struct 'foo' should be a type name
+tests/qapi-schema/struct-member-invalid.json:1: Member 'a' of 'data' for=
 struct 'foo' should be a type name
diff --git a/tests/qapi-schema/struct-member-invalid.json b/tests/qapi-sc=
hema/struct-member-invalid.json
index 10c7426..8f172f7 100644
--- a/tests/qapi-schema/struct-member-invalid.json
+++ b/tests/qapi-schema/struct-member-invalid.json
@@ -1,5 +1,2 @@
-##
-# @foo:
-##
 { 'struct': 'foo',
   'data': { 'a': false } }
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index b4cde4f..ef74e2c 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -55,17 +55,3 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
=20
 schema =3D QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
-
-for doc in schema.docs:
-    if doc.symbol:
-        print 'doc symbol=3D%s expr=3D%s' % \
-            (doc.symbol, doc.expr.items()[0])
-    else:
-        print 'doc freeform'
-    for arg, section in doc.args.iteritems():
-        print '    arg=3D%s\n%s' % (arg, section)
-    for section in doc.sections:
-        print '    section=3D%s\n%s' % (section.name, section)
-    body =3D str(doc.body)
-    if body:
-        print '    body=3D\n%s' % body
diff --git a/tests/qapi-schema/type-bypass-bad-gen.err b/tests/qapi-schem=
a/type-bypass-bad-gen.err
index bd5431f..a83c3c6 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.err
+++ b/tests/qapi-schema/type-bypass-bad-gen.err
@@ -1 +1 @@
-tests/qapi-schema/type-bypass-bad-gen.json:6: 'gen' of command 'foo' sho=
uld only use false value
+tests/qapi-schema/type-bypass-bad-gen.json:2: 'gen' of command 'foo' sho=
uld only use false value
diff --git a/tests/qapi-schema/type-bypass-bad-gen.json b/tests/qapi-sche=
ma/type-bypass-bad-gen.json
index 7162c1a..e8dec34 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.json
+++ b/tests/qapi-schema/type-bypass-bad-gen.json
@@ -1,6 +1,2 @@
 # 'gen' should only appear with value false
-
-##
-# @foo:
-##
 { 'command': 'foo', 'gen': 'whatever' }
diff --git a/tests/qapi-schema/unicode-str.err b/tests/qapi-schema/unicod=
e-str.err
index 92ee277..f621cd6 100644
--- a/tests/qapi-schema/unicode-str.err
+++ b/tests/qapi-schema/unicode-str.err
@@ -1 +1 @@
-tests/qapi-schema/unicode-str.json:6: 'command' uses invalid name '=C3=A9=
'
+tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9=
'
diff --git a/tests/qapi-schema/unicode-str.json b/tests/qapi-schema/unico=
de-str.json
index 75a08b3..5253a1b 100644
--- a/tests/qapi-schema/unicode-str.json
+++ b/tests/qapi-schema/unicode-str.json
@@ -1,6 +1,2 @@
 # we don't support full Unicode strings, yet
-
-##
-# @e:
-##
 { 'command': '=C3=A9' }
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index ca6ee92..8b7a242 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/union-base-no-discriminator.json:23: Simple union 'Tes=
tUnion' must not have a base
+tests/qapi-schema/union-base-no-discriminator.json:11: Simple union 'Tes=
tUnion' must not have a base
diff --git a/tests/qapi-schema/union-base-no-discriminator.json b/tests/q=
api-schema/union-base-no-discriminator.json
index cc6bac1..1409cf5 100644
--- a/tests/qapi-schema/union-base-no-discriminator.json
+++ b/tests/qapi-schema/union-base-no-discriminator.json
@@ -1,25 +1,13 @@
-##
-# @TestTypeA:
-##
 # we reject simple unions with a base (or flat unions without discrimina=
tor)
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
-##
-# @Base:
-##
 { 'struct': 'Base',
   'data': { 'string': 'str' } }
=20
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'Base',
   'data': { 'value1': 'TestTypeA',
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index 9095bae..1152190 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1 +1 @@
-tests/qapi-schema/union-branch-case.json:6: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
+tests/qapi-schema/union-branch-case.json:2: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/union-branch-case.json b/tests/qapi-schema=
/union-branch-case.json
index 6de1315..e6565dc 100644
--- a/tests/qapi-schema/union-branch-case.json
+++ b/tests/qapi-schema/union-branch-case.json
@@ -1,6 +1,2 @@
 # Branch names should be 'lower-case' unless the union is whitelisted
-
-##
-# @NoWayThisWillGetWhitelisted:
-##
 { 'union': 'NoWayThisWillGetWhitelisted', 'data': { 'Branch': 'int' } }
diff --git a/tests/qapi-schema/union-clash-branches.err b/tests/qapi-sche=
ma/union-clash-branches.err
index 640caea..e5b2113 100644
--- a/tests/qapi-schema/union-clash-branches.err
+++ b/tests/qapi-schema/union-clash-branches.err
@@ -1 +1 @@
-tests/qapi-schema/union-clash-branches.json:8: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
+tests/qapi-schema/union-clash-branches.json:4: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
diff --git a/tests/qapi-schema/union-clash-branches.json b/tests/qapi-sch=
ema/union-clash-branches.json
index 6615665..3bece8c 100644
--- a/tests/qapi-schema/union-clash-branches.json
+++ b/tests/qapi-schema/union-clash-branches.json
@@ -1,9 +1,5 @@
 # Union branch name collision
 # Reject a union that would result in a collision in generated C names (=
this
 # would try to generate two members 'a_b').
-
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'data': { 'a-b': 'int', 'a_b': 'str' } }
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index 749bc76..12c2022 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1 +1 @@
-tests/qapi-schema/union-empty.json:6: Union 'Union' cannot have empty 'd=
ata'
+tests/qapi-schema/union-empty.json:2: Union 'Union' cannot have empty 'd=
ata'
diff --git a/tests/qapi-schema/union-empty.json b/tests/qapi-schema/union=
-empty.json
index c9b0a1e..1f0b13c 100644
--- a/tests/qapi-schema/union-empty.json
+++ b/tests/qapi-schema/union-empty.json
@@ -1,6 +1,2 @@
 # unions cannot be empty
-
-##
-# @Union:
-##
 { 'union': 'Union', 'data': { } }
diff --git a/tests/qapi-schema/union-invalid-base.err b/tests/qapi-schema=
/union-invalid-base.err
index 41e238f..03d7b97 100644
--- a/tests/qapi-schema/union-invalid-base.err
+++ b/tests/qapi-schema/union-invalid-base.err
@@ -1 +1 @@
-tests/qapi-schema/union-invalid-base.json:18: 'base' for union 'TestUnio=
n' cannot use built-in type 'int'
+tests/qapi-schema/union-invalid-base.json:8: 'base' for union 'TestUnion=
' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/union-invalid-base.json b/tests/qapi-schem=
a/union-invalid-base.json
index fd837cb..92be39d 100644
--- a/tests/qapi-schema/union-invalid-base.json
+++ b/tests/qapi-schema/union-invalid-base.json
@@ -1,20 +1,10 @@
 # a union base type must be a struct
-
-##
-# @TestTypeA:
-##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
-##
-# @TestTypeB:
-##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
-##
-# @TestUnion:
-##
 { 'union': 'TestUnion',
   'base': 'int',
   'discriminator': 'int',
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 60523c0..3ada133 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1 +1 @@
-tests/qapi-schema/union-optional-branch.json:6: Member of union 'Union' =
does not allow optional name '*a'
+tests/qapi-schema/union-optional-branch.json:2: Member of union 'Union' =
does not allow optional name '*a'
diff --git a/tests/qapi-schema/union-optional-branch.json b/tests/qapi-sc=
hema/union-optional-branch.json
index 7d2ee4c..591615f 100644
--- a/tests/qapi-schema/union-optional-branch.json
+++ b/tests/qapi-schema/union-optional-branch.json
@@ -1,6 +1,2 @@
 # union branches cannot be optional
-
-##
-# @Union:
-##
 { 'union': 'Union', 'data': { '*a': 'int', 'b': 'str' } }
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index 5568302..54fe456 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/union-unknown.json:6: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
+tests/qapi-schema/union-unknown.json:2: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/union-unknown.json b/tests/qapi-schema/uni=
on-unknown.json
index 5042b23..aa7e814 100644
--- a/tests/qapi-schema/union-unknown.json
+++ b/tests/qapi-schema/union-unknown.json
@@ -1,7 +1,3 @@
 # we reject a union with unknown type in branch
-
-##
-# @Union:
-##
 { 'union': 'Union',
   'data': { 'unknown': 'MissingType' } }
diff --git a/tests/qapi-schema/unknown-escape.err b/tests/qapi-schema/unk=
nown-escape.err
index 1a4ead6..000e30d 100644
--- a/tests/qapi-schema/unknown-escape.err
+++ b/tests/qapi-schema/unknown-escape.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-escape.json:7:21: Unknown escape \x
+tests/qapi-schema/unknown-escape.json:3:21: Unknown escape \x
diff --git a/tests/qapi-schema/unknown-escape.json b/tests/qapi-schema/un=
known-escape.json
index e3ae679..8e6891e 100644
--- a/tests/qapi-schema/unknown-escape.json
+++ b/tests/qapi-schema/unknown-escape.json
@@ -1,7 +1,3 @@
 # we only recognize JSON escape sequences, plus our \' extension (no \x)
-
-##
-# @foo:
-##
 # { 'command': 'foo', 'data': {} }
 { 'command': 'foo', 'dat\x61':{} }
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index b19a668..12f5ed5 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-expr-key.json:6: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
diff --git a/tests/qapi-schema/unknown-expr-key.json b/tests/qapi-schema/=
unknown-expr-key.json
index 1b764c7..3b2be00 100644
--- a/tests/qapi-schema/unknown-expr-key.json
+++ b/tests/qapi-schema/unknown-expr-key.json
@@ -1,6 +1,2 @@
 # we reject an expression with unknown top-level keys
-
-##
-# @bar:
-##
 { 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { } }
--=20
2.7.4
