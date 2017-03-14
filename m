Received: from eggs.gnu.org ([2001:4830:134:3::10]:45433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhp6-0005EV-NW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhos-0000tb-VM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:28:52 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:33121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnhor-0000tQ-VJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:28:38 -0400
Received: by mail-lf0-x22b.google.com with SMTP id a6so73304022lfa.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-4-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:28:24 +0000
Message-ID: <CAJ+F1CKpSENQk5ifJtk4s4YChPs2N9FO_OcOMioGeM63XaxknQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 03/47] qapi: Back out doc comments
 added just to please qapi.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Mon, Mar 13, 2017 at 10:36 AM Markus Armbruster <armbru@redhat.com>
wrote:

> This reverts commit 3313b61's changes to tests/qapi-schema/, except
> for tests/qapi-schema/doc-*.
>
>
Do we expect those files to change? If not, or not much, I think i't s
rather better to keep the docs to exercise the parser in various
situations. It doesn't reduce the merits of the doc pragma though for other
cases, which I wish I would have suggested (but I didn't like the  initial
series to grow more features)


> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/qapi-schema/alternate-any.err                |   2 +-
>  tests/qapi-schema/alternate-any.json               |   4 -
>  tests/qapi-schema/alternate-array.err              |   2 +-
>  tests/qapi-schema/alternate-array.json             |   7 -
>  tests/qapi-schema/alternate-base.err               |   2 +-
>  tests/qapi-schema/alternate-base.json              |   7 -
>  tests/qapi-schema/alternate-clash.err              |   2 +-
>  tests/qapi-schema/alternate-clash.json             |   4 -
>  tests/qapi-schema/alternate-conflict-dict.err      |   2 +-
>  tests/qapi-schema/alternate-conflict-dict.json     |  10 -
>  tests/qapi-schema/alternate-conflict-string.err    |   2 +-
>  tests/qapi-schema/alternate-conflict-string.json   |   7 -
>  tests/qapi-schema/alternate-empty.err              |   2 +-
>  tests/qapi-schema/alternate-empty.json             |   4 -
>  tests/qapi-schema/alternate-nested.err             |   2 +-
>  tests/qapi-schema/alternate-nested.json            |   7 -
>  tests/qapi-schema/alternate-unknown.err            |   2 +-
>  tests/qapi-schema/alternate-unknown.json           |   4 -
>  tests/qapi-schema/args-alternate.err               |   2 +-
>  tests/qapi-schema/args-alternate.json              |   8 -
>  tests/qapi-schema/args-any.err                     |   2 +-
>  tests/qapi-schema/args-any.json                    |   4 -
>  tests/qapi-schema/args-array-empty.err             |   2 +-
>  tests/qapi-schema/args-array-empty.json            |   4 -
>  tests/qapi-schema/args-array-unknown.err           |   2 +-
>  tests/qapi-schema/args-array-unknown.json          |   4 -
>  tests/qapi-schema/args-bad-boxed.err               |   2 +-
>  tests/qapi-schema/args-bad-boxed.json              |   4 -
>  tests/qapi-schema/args-boxed-anon.err              |   2 +-
>  tests/qapi-schema/args-boxed-anon.json             |   4 -
>  tests/qapi-schema/args-boxed-empty.err             |   2 +-
>  tests/qapi-schema/args-boxed-empty.json            |   8 -
>  tests/qapi-schema/args-boxed-string.err            |   2 +-
>  tests/qapi-schema/args-boxed-string.json           |   4 -
>  tests/qapi-schema/args-int.err                     |   2 +-
>  tests/qapi-schema/args-int.json                    |   4 -
>  tests/qapi-schema/args-invalid.err                 |   2 +-
>  tests/qapi-schema/args-invalid.json                |   3 -
>  tests/qapi-schema/args-member-array-bad.err        |   2 +-
>  tests/qapi-schema/args-member-array-bad.json       |   4 -
>  tests/qapi-schema/args-member-case.err             |   2 +-
>  tests/qapi-schema/args-member-case.json            |   4 -
>  tests/qapi-schema/args-member-unknown.err          |   2 +-
>  tests/qapi-schema/args-member-unknown.json         |   4 -
>  tests/qapi-schema/args-name-clash.err              |   2 +-
>  tests/qapi-schema/args-name-clash.json             |   4 -
>  tests/qapi-schema/args-union.err                   |   2 +-
>  tests/qapi-schema/args-union.json                  |   7 -
>  tests/qapi-schema/args-unknown.err                 |   2 +-
>  tests/qapi-schema/args-unknown.json                |   4 -
>  tests/qapi-schema/bad-base.err                     |   2 +-
>  tests/qapi-schema/bad-base.json                    |   7 -
>  tests/qapi-schema/bad-data.err                     |   2 +-
>  tests/qapi-schema/bad-data.json                    |   4 -
>  tests/qapi-schema/bad-ident.err                    |   2 +-
>  tests/qapi-schema/bad-ident.json                   |   4 -
>  tests/qapi-schema/bad-type-bool.err                |   2 +-
>  tests/qapi-schema/bad-type-bool.json               |   4 -
>  tests/qapi-schema/bad-type-dict.err                |   2 +-
>  tests/qapi-schema/bad-type-dict.json               |   4 -
>  tests/qapi-schema/base-cycle-direct.err            |   2 +-
>  tests/qapi-schema/base-cycle-direct.json           |   4 -
>  tests/qapi-schema/base-cycle-indirect.err          |   2 +-
>  tests/qapi-schema/base-cycle-indirect.json         |   7 -
>  tests/qapi-schema/command-int.err                  |   2 +-
>  tests/qapi-schema/command-int.json                 |   4 -
>  tests/qapi-schema/comments.json                    |   4 -
>  tests/qapi-schema/comments.out                     |   1 -
>  tests/qapi-schema/double-type.err                  |   2 +-
>  tests/qapi-schema/double-type.json                 |   4 -
>  tests/qapi-schema/enum-bad-name.err                |   2 +-
>  tests/qapi-schema/enum-bad-name.json               |   4 -
>  tests/qapi-schema/enum-bad-prefix.err              |   2 +-
>  tests/qapi-schema/enum-bad-prefix.json             |   4 -
>  tests/qapi-schema/enum-clash-member.err            |   2 +-
>  tests/qapi-schema/enum-clash-member.json           |   4 -
>  tests/qapi-schema/enum-dict-member.err             |   2 +-
>  tests/qapi-schema/enum-dict-member.json            |   4 -
>  tests/qapi-schema/enum-member-case.err             |   2 +-
>  tests/qapi-schema/enum-member-case.json            |   7 -
>  tests/qapi-schema/enum-missing-data.err            |   2 +-
>  tests/qapi-schema/enum-missing-data.json           |   4 -
>  tests/qapi-schema/enum-wrong-data.err              |   2 +-
>  tests/qapi-schema/enum-wrong-data.json             |   4 -
>  tests/qapi-schema/event-boxed-empty.err            |   2 +-
>  tests/qapi-schema/event-boxed-empty.json           |   4 -
>  tests/qapi-schema/event-case.json                  |   4 -
>  tests/qapi-schema/event-case.out                   |   1 -
>  tests/qapi-schema/event-nest-struct.err            |   2 +-
>  tests/qapi-schema/event-nest-struct.json           |   4 -
>  tests/qapi-schema/flat-union-array-branch.err      |   2 +-
>  tests/qapi-schema/flat-union-array-branch.json     |  12 --
>  tests/qapi-schema/flat-union-bad-base.err          |   2 +-
>  tests/qapi-schema/flat-union-bad-base.json         |  13 --
>  tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
>  .../qapi-schema/flat-union-bad-discriminator.json  |  16 --
>  tests/qapi-schema/flat-union-base-any.err          |   2 +-
>  tests/qapi-schema/flat-union-base-any.json         |  13 --
>  tests/qapi-schema/flat-union-base-union.err        |   2 +-
>  tests/qapi-schema/flat-union-base-union.json       |  16 --
>  tests/qapi-schema/flat-union-clash-member.err      |   2 +-
>  tests/qapi-schema/flat-union-clash-member.json     |  16 --
>  tests/qapi-schema/flat-union-empty.err             |   2 +-
>  tests/qapi-schema/flat-union-empty.json            |  10 -
>  tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
>  .../qapi-schema/flat-union-incomplete-branch.json  |  10 -
>  tests/qapi-schema/flat-union-inline.err            |   2 +-
>  tests/qapi-schema/flat-union-inline.json           |  10 -
>  tests/qapi-schema/flat-union-int-branch.err        |   2 +-
>  tests/qapi-schema/flat-union-int-branch.json       |  13 --
>  .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
>  .../qapi-schema/flat-union-invalid-branch-key.json |  15 --
>  .../flat-union-invalid-discriminator.err           |   2 +-
>  .../flat-union-invalid-discriminator.json          |  15 --
>  tests/qapi-schema/flat-union-no-base.err           |   2 +-
>  tests/qapi-schema/flat-union-no-base.json          |  13 --
>  .../flat-union-optional-discriminator.err          |   2 +-
>  .../flat-union-optional-discriminator.json         |  13 --
>  .../flat-union-string-discriminator.err            |   2 +-
>  .../flat-union-string-discriminator.json           |  15 --
>  tests/qapi-schema/ident-with-escape.json           |   4 -
>  tests/qapi-schema/ident-with-escape.out            |   1 -
>  tests/qapi-schema/include-relpath-sub.json         |   3 -
>  tests/qapi-schema/include-relpath.out              |   1 -
>  tests/qapi-schema/include-repetition.out           |   1 -
>  tests/qapi-schema/include-simple-sub.json          |   3 -
>  tests/qapi-schema/include-simple.out               |   1 -
>  tests/qapi-schema/indented-expr.json               |   6 -
>  tests/qapi-schema/indented-expr.out                |   2 -
>  tests/qapi-schema/missing-type.err                 |   2 +-
>  tests/qapi-schema/missing-type.json                |   4 -
>  tests/qapi-schema/nested-struct-data.err           |   2 +-
>  tests/qapi-schema/nested-struct-data.json          |   4 -
>  tests/qapi-schema/qapi-schema-test.json            | 213
> ---------------------
>  tests/qapi-schema/qapi-schema-test.out             | 130 -------------
>

At least here some docs should probably remain, or there won't be much
positive cases left.


>  tests/qapi-schema/redefined-builtin.err            |   2 +-
>  tests/qapi-schema/redefined-builtin.json           |   4 -
>  tests/qapi-schema/redefined-command.err            |   2 +-
>  tests/qapi-schema/redefined-command.json           |   7 -
>  tests/qapi-schema/redefined-event.err              |   2 +-
>  tests/qapi-schema/redefined-event.json             |   7 -
>  tests/qapi-schema/redefined-type.err               |   2 +-
>  tests/qapi-schema/redefined-type.json              |   7 -
>  tests/qapi-schema/reserved-command-q.err           |   2 +-
>  tests/qapi-schema/reserved-command-q.json          |   7 -
>  tests/qapi-schema/reserved-enum-q.err              |   2 +-
>  tests/qapi-schema/reserved-enum-q.json             |   4 -
>  tests/qapi-schema/reserved-member-has.err          |   2 +-
>  tests/qapi-schema/reserved-member-has.json         |   4 -
>  tests/qapi-schema/reserved-member-q.err            |   2 +-
>  tests/qapi-schema/reserved-member-q.json           |   4 -
>  tests/qapi-schema/reserved-member-u.err            |   2 +-
>  tests/qapi-schema/reserved-member-u.json           |   4 -
>  tests/qapi-schema/reserved-member-underscore.err   |   2 +-
>  tests/qapi-schema/reserved-member-underscore.json  |   4 -
>  tests/qapi-schema/reserved-type-kind.err           |   2 +-
>  tests/qapi-schema/reserved-type-kind.json          |   4 -
>  tests/qapi-schema/reserved-type-list.err           |   2 +-
>  tests/qapi-schema/reserved-type-list.json          |   4 -
>  tests/qapi-schema/returns-alternate.err            |   2 +-
>  tests/qapi-schema/returns-alternate.json           |   7 -
>  tests/qapi-schema/returns-array-bad.err            |   2 +-
>  tests/qapi-schema/returns-array-bad.json           |   4 -
>  tests/qapi-schema/returns-dict.err                 |   2 +-
>  tests/qapi-schema/returns-dict.json                |   4 -
>  tests/qapi-schema/returns-unknown.err              |   2 +-
>  tests/qapi-schema/returns-unknown.json             |   4 -
>  tests/qapi-schema/returns-whitelist.err            |   2 +-
>  tests/qapi-schema/returns-whitelist.json           |  16 --
>  tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
>  tests/qapi-schema/struct-base-clash-deep.json      |  10 -
>  tests/qapi-schema/struct-base-clash.err            |   2 +-
>  tests/qapi-schema/struct-base-clash.json           |   7 -
>  tests/qapi-schema/struct-data-invalid.err          |   2 +-
>  tests/qapi-schema/struct-data-invalid.json         |   3 -
>  tests/qapi-schema/struct-member-invalid.err        |   2 +-
>  tests/qapi-schema/struct-member-invalid.json       |   3 -
>  tests/qapi-schema/test-qapi.py                     |  14 --
>  tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
>  tests/qapi-schema/type-bypass-bad-gen.json         |   4 -
>  tests/qapi-schema/unicode-str.err                  |   2 +-
>  tests/qapi-schema/unicode-str.json                 |   4 -
>  tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
>  tests/qapi-schema/union-base-no-discriminator.json |  12 --
>  tests/qapi-schema/union-branch-case.err            |   2 +-
>  tests/qapi-schema/union-branch-case.json           |   4 -
>  tests/qapi-schema/union-clash-branches.err         |   2 +-
>  tests/qapi-schema/union-clash-branches.json        |   4 -
>  tests/qapi-schema/union-empty.err                  |   2 +-
>  tests/qapi-schema/union-empty.json                 |   4 -
>  tests/qapi-schema/union-invalid-base.err           |   2 +-
>  tests/qapi-schema/union-invalid-base.json          |  10 -
>  tests/qapi-schema/union-optional-branch.err        |   2 +-
>  tests/qapi-schema/union-optional-branch.json       |   4 -
>  tests/qapi-schema/union-unknown.err                |   2 +-
>  tests/qapi-schema/union-unknown.json               |   4 -
>  tests/qapi-schema/unknown-escape.err               |   2 +-
>  tests/qapi-schema/unknown-escape.json              |   4 -
>  tests/qapi-schema/unknown-expr-key.err             |   2 +-
>  tests/qapi-schema/unknown-expr-key.json            |   4 -
>  200 files changed, 92 insertions(+), 1074 deletions(-)
>
> diff --git a/tests/qapi-schema/alternate-any.err
> b/tests/qapi-schema/alternate-any.err
> index 395c8ab..aaa0154 100644
> --- a/tests/qapi-schema/alternate-any.err
> +++ b/tests/qapi-schema/alternate-any.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-any.json:6: Alternate 'Alt' member 'one'
> cannot use type 'any'
> +tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one'
> cannot use type 'any'
> diff --git a/tests/qapi-schema/alternate-any.json
> b/tests/qapi-schema/alternate-any.json
> index c958776..e47a73a 100644
> --- a/tests/qapi-schema/alternate-any.json
> +++ b/tests/qapi-schema/alternate-any.json
> @@ -1,8 +1,4 @@
>  # we do not allow the 'any' type as an alternate branch
> -
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt',
>    'data': { 'one': 'any',
>              'two': 'int' } }
> diff --git a/tests/qapi-schema/alternate-array.err
> b/tests/qapi-schema/alternate-array.err
> index 09628e9..7b930c6 100644
> --- a/tests/qapi-schema/alternate-array.err
> +++ b/tests/qapi-schema/alternate-array.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-array.json:12: Member 'two' of alternate
> 'Alt' cannot be an array
> +tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'Alt=
'
> cannot be an array
> diff --git a/tests/qapi-schema/alternate-array.json
> b/tests/qapi-schema/alternate-array.json
> index c2f98ad..f241aac 100644
> --- a/tests/qapi-schema/alternate-array.json
> +++ b/tests/qapi-schema/alternate-array.json
> @@ -1,14 +1,7 @@
>  # we do not allow array branches in alternates
> -
> -##
> -# @One:
> -##
>  # TODO: should we support this?
>  { 'struct': 'One',
>    'data': { 'name': 'str' } }
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt',
>    'data': { 'one': 'One',
>              'two': [ 'int' ] } }
> diff --git a/tests/qapi-schema/alternate-base.err
> b/tests/qapi-schema/alternate-base.err
> index 3b67914..30d8a34 100644
> --- a/tests/qapi-schema/alternate-base.err
> +++ b/tests/qapi-schema/alternate-base.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-base.json:11: Unknown key 'base' in alternat=
e
> 'Alt'
> +tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate
> 'Alt'
> diff --git a/tests/qapi-schema/alternate-base.json
> b/tests/qapi-schema/alternate-base.json
> index 9612b79..529430ec 100644
> --- a/tests/qapi-schema/alternate-base.json
> +++ b/tests/qapi-schema/alternate-base.json
> @@ -1,13 +1,6 @@
>  # we reject alternate with base type
> -
> -##
> -# @Base:
> -##
>  { 'struct': 'Base',
>    'data': { 'string': 'str' } }
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt',
>    'base': 'Base',
>    'data': { 'number': 'int' } }
> diff --git a/tests/qapi-schema/alternate-clash.err
> b/tests/qapi-schema/alternate-clash.err
> index f07c3e8..604d849 100644
> --- a/tests/qapi-schema/alternate-clash.err
> +++ b/tests/qapi-schema/alternate-clash.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-clash.json:11: 'a_b' (branch of Alt1)
> collides with 'a-b' (branch of Alt1)
> +tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) collide=
s
> with 'a-b' (branch of Alt1)
> diff --git a/tests/qapi-schema/alternate-clash.json
> b/tests/qapi-schema/alternate-clash.json
> index 97ca7c8..6d73bc5 100644
> --- a/tests/qapi-schema/alternate-clash.json
> +++ b/tests/qapi-schema/alternate-clash.json
> @@ -4,9 +4,5 @@
>  # TODO: In the future, if alternates are simplified to not generate
>  # the implicit Alt1Kind enum, we would still have a collision with the
>  # resulting C union trying to have two members named 'a_b'.
> -
> -##
> -# @Alt1:
> -##
>  { 'alternate': 'Alt1',
>    'data': { 'a-b': 'str', 'a_b': 'int' } }
> diff --git a/tests/qapi-schema/alternate-conflict-dict.err
> b/tests/qapi-schema/alternate-conflict-dict.err
> index 7cb023f..0f411f4 100644
> --- a/tests/qapi-schema/alternate-conflict-dict.err
> +++ b/tests/qapi-schema/alternate-conflict-dict.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-conflict-dict.json:16: Alternate 'Alt' membe=
r
> 'two' can't be distinguished from member 'one'
> +tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' member
> 'two' can't be distinguished from member 'one'
> diff --git a/tests/qapi-schema/alternate-conflict-dict.json
> b/tests/qapi-schema/alternate-conflict-dict.json
> index 9f9d97f..d566cca 100644
> --- a/tests/qapi-schema/alternate-conflict-dict.json
> +++ b/tests/qapi-schema/alternate-conflict-dict.json
> @@ -1,18 +1,8 @@
>  # we reject alternates with multiple object branches
> -
> -##
> -# @One:
> -##
>  { 'struct': 'One',
>    'data': { 'name': 'str' } }
> -##
> -# @Two:
> -##
>  { 'struct': 'Two',
>    'data': { 'value': 'int' } }
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt',
>    'data': { 'one': 'One',
>              'two': 'Two' } }
> diff --git a/tests/qapi-schema/alternate-conflict-string.err
> b/tests/qapi-schema/alternate-conflict-string.err
> index 6dbbacd..fc523b0 100644
> --- a/tests/qapi-schema/alternate-conflict-string.err
> +++ b/tests/qapi-schema/alternate-conflict-string.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-conflict-string.json:11: Alternate 'Alt'
> member 'two' can't be distinguished from member 'one'
> +tests/qapi-schema/alternate-conflict-string.json:4: Alternate 'Alt'
> member 'two' can't be distinguished from member 'one'
> diff --git a/tests/qapi-schema/alternate-conflict-string.json
> b/tests/qapi-schema/alternate-conflict-string.json
> index 12aafab..72f04a8 100644
> --- a/tests/qapi-schema/alternate-conflict-string.json
> +++ b/tests/qapi-schema/alternate-conflict-string.json
> @@ -1,13 +1,6 @@
>  # we reject alternates with multiple string-like branches
> -
> -##
> -# @Enum:
> -##
>  { 'enum': 'Enum',
>    'data': [ 'hello', 'world' ] }
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt',
>    'data': { 'one': 'str',
>              'two': 'Enum' } }
> diff --git a/tests/qapi-schema/alternate-empty.err
> b/tests/qapi-schema/alternate-empty.err
> index 8245ce3..bb06c5b 100644
> --- a/tests/qapi-schema/alternate-empty.err
> +++ b/tests/qapi-schema/alternate-empty.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-empty.json:6: Alternate 'Alt' should have at
> least two branches in 'data'
> +tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' should have at
> least two branches in 'data'
> diff --git a/tests/qapi-schema/alternate-empty.json
> b/tests/qapi-schema/alternate-empty.json
> index db54405..fff15ba 100644
> --- a/tests/qapi-schema/alternate-empty.json
> +++ b/tests/qapi-schema/alternate-empty.json
> @@ -1,6 +1,2 @@
>  # alternates must list at least two types to be useful
> -
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt', 'data': { 'i': 'int' } }
> diff --git a/tests/qapi-schema/alternate-nested.err
> b/tests/qapi-schema/alternate-nested.err
> index 1804ffb..4d1187e 100644
> --- a/tests/qapi-schema/alternate-nested.err
> +++ b/tests/qapi-schema/alternate-nested.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-nested.json:11: Member 'nested' of alternate
> 'Alt2' cannot use alternate type 'Alt1'
> +tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternate
> 'Alt2' cannot use alternate type 'Alt1'
> diff --git a/tests/qapi-schema/alternate-nested.json
> b/tests/qapi-schema/alternate-nested.json
> index 9f83ebe..8e22186 100644
> --- a/tests/qapi-schema/alternate-nested.json
> +++ b/tests/qapi-schema/alternate-nested.json
> @@ -1,12 +1,5 @@
>  # we reject a nested alternate branch
> -
> -##
> -# @Alt1:
> -##
>  { 'alternate': 'Alt1',
>    'data': { 'name': 'str', 'value': 'int' } }
> -##
> -# @Alt2:
> -##
>  { 'alternate': 'Alt2',
>    'data': { 'nested': 'Alt1', 'b': 'bool' } }
> diff --git a/tests/qapi-schema/alternate-unknown.err
> b/tests/qapi-schema/alternate-unknown.err
> index cf5b9b6..dea45dc 100644
> --- a/tests/qapi-schema/alternate-unknown.err
> +++ b/tests/qapi-schema/alternate-unknown.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-unknown.json:6: Member 'unknown' of alternat=
e
> 'Alt' uses unknown type 'MissingType'
> +tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of alternat=
e
> 'Alt' uses unknown type 'MissingType'
> diff --git a/tests/qapi-schema/alternate-unknown.json
> b/tests/qapi-schema/alternate-unknown.json
> index 941ba1f..08c80dc 100644
> --- a/tests/qapi-schema/alternate-unknown.json
> +++ b/tests/qapi-schema/alternate-unknown.json
> @@ -1,7 +1,3 @@
>  # we reject an alternate with unknown type in branch
> -
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt',
>    'data': { 'unknown': 'MissingType', 'i': 'int' } }
> diff --git a/tests/qapi-schema/args-alternate.err
> b/tests/qapi-schema/args-alternate.err
> index 2e6bf54..3086eae 100644
> --- a/tests/qapi-schema/args-alternate.err
> +++ b/tests/qapi-schema/args-alternate.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-alternate.json:11: 'data' for command 'oops'
> cannot use alternate type 'Alt'
> +tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' canno=
t
> use alternate type 'Alt'
> diff --git a/tests/qapi-schema/args-alternate.json
> b/tests/qapi-schema/args-alternate.json
> index 49d0211..69e94d4 100644
> --- a/tests/qapi-schema/args-alternate.json
> +++ b/tests/qapi-schema/args-alternate.json
> @@ -1,11 +1,3 @@
>  # we do not allow alternate arguments
> -
> -##
> -# @Alt:
> -##
>  { 'alternate': 'Alt', 'data': { 'case1': 'int', 'case2': 'str' } }
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': 'Alt' }
> diff --git a/tests/qapi-schema/args-any.err
> b/tests/qapi-schema/args-any.err
> index 955504b..bf9b5e0 100644
> --- a/tests/qapi-schema/args-any.err
> +++ b/tests/qapi-schema/args-any.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-any.json:6: 'data' for command 'oops' cannot use
> built-in type 'any'
> +tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot use
> built-in type 'any'
> diff --git a/tests/qapi-schema/args-any.json
> b/tests/qapi-schema/args-any.json
> index f494479..58fe5e4 100644
> --- a/tests/qapi-schema/args-any.json
> +++ b/tests/qapi-schema/args-any.json
> @@ -1,6 +1,2 @@
>  # we do not allow an 'any' argument
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': 'any' }
> diff --git a/tests/qapi-schema/args-array-empty.err
> b/tests/qapi-schema/args-array-empty.err
> index e85f791..cb7ed33 100644
> --- a/tests/qapi-schema/args-array-empty.err
> +++ b/tests/qapi-schema/args-array-empty.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-array-empty.json:6: Member 'empty' of 'data' for
> command 'oops': array type must contain single type name
> +tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' for
> command 'oops': array type must contain single type name
> diff --git a/tests/qapi-schema/args-array-empty.json
> b/tests/qapi-schema/args-array-empty.json
> index 78a0b88..652dcfb 100644
> --- a/tests/qapi-schema/args-array-empty.json
> +++ b/tests/qapi-schema/args-array-empty.json
> @@ -1,6 +1,2 @@
>  # we reject an array for data if it does not contain a known type
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': { 'empty': [ ] } }
> diff --git a/tests/qapi-schema/args-array-unknown.err
> b/tests/qapi-schema/args-array-unknown.err
> index 77788de..cd7a0f9 100644
> --- a/tests/qapi-schema/args-array-unknown.err
> +++ b/tests/qapi-schema/args-array-unknown.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-array-unknown.json:6: Member 'array' of 'data' fo=
r
> command 'oops' uses unknown type 'NoSuchType'
> +tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' fo=
r
> command 'oops' uses unknown type 'NoSuchType'
> diff --git a/tests/qapi-schema/args-array-unknown.json
> b/tests/qapi-schema/args-array-unknown.json
> index f680fc1..6f3e883 100644
> --- a/tests/qapi-schema/args-array-unknown.json
> +++ b/tests/qapi-schema/args-array-unknown.json
> @@ -1,6 +1,2 @@
>  # we reject an array for data if it does not contain a known type
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': { 'array': [ 'NoSuchType' ] } }
> diff --git a/tests/qapi-schema/args-bad-boxed.err
> b/tests/qapi-schema/args-bad-boxed.err
> index 87a9061..ad0d417 100644
> --- a/tests/qapi-schema/args-bad-boxed.err
> +++ b/tests/qapi-schema/args-bad-boxed.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-bad-boxed.json:6: 'boxed' of command 'foo' should
> only use true value
> +tests/qapi-schema/args-bad-boxed.json:2: 'boxed' of command 'foo' should
> only use true value
> diff --git a/tests/qapi-schema/args-bad-boxed.json
> b/tests/qapi-schema/args-bad-boxed.json
> index 4c0b28f..dea0cd0 100644
> --- a/tests/qapi-schema/args-bad-boxed.json
> +++ b/tests/qapi-schema/args-bad-boxed.json
> @@ -1,6 +1,2 @@
>  # 'boxed' should only appear with value true
> -
> -##
> -# @foo:
> -##
>  { 'command': 'foo', 'boxed': false }
> diff --git a/tests/qapi-schema/args-boxed-anon.err
> b/tests/qapi-schema/args-boxed-anon.err
> index 3cfac0b..f24f345 100644
> --- a/tests/qapi-schema/args-boxed-anon.err
> +++ b/tests/qapi-schema/args-boxed-anon.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-boxed-anon.json:6: 'data' for command 'foo' shoul=
d
> be a type name
> +tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' shoul=
d
> be a type name
> diff --git a/tests/qapi-schema/args-boxed-anon.json
> b/tests/qapi-schema/args-boxed-anon.json
> index 2358e6a..95f60da 100644
> --- a/tests/qapi-schema/args-boxed-anon.json
> +++ b/tests/qapi-schema/args-boxed-anon.json
> @@ -1,6 +1,2 @@
>  # 'boxed' can only be used with named types
> -
> -##
> -# @foo:
> -##
>  { 'command': 'foo', 'boxed': true, 'data': { 'string': 'str' } }
> diff --git a/tests/qapi-schema/args-boxed-empty.err
> b/tests/qapi-schema/args-boxed-empty.err
> index 963f495..039603e 100644
> --- a/tests/qapi-schema/args-boxed-empty.err
> +++ b/tests/qapi-schema/args-boxed-empty.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-boxed-empty.json:11: Cannot use 'boxed' with empt=
y
> type
> +tests/qapi-schema/args-boxed-empty.json:3: Cannot use 'boxed' with empty
> type
> diff --git a/tests/qapi-schema/args-boxed-empty.json
> b/tests/qapi-schema/args-boxed-empty.json
> index 8e8cc26..52717e0 100644
> --- a/tests/qapi-schema/args-boxed-empty.json
> +++ b/tests/qapi-schema/args-boxed-empty.json
> @@ -1,11 +1,3 @@
>  # 'boxed' requires a non-empty type
> -
> -##
> -# @Empty:
> -##
>  { 'struct': 'Empty', 'data': {} }
> -
> -##
> -# @foo:
> -##
>  { 'command': 'foo', 'boxed': true, 'data': 'Empty' }
> diff --git a/tests/qapi-schema/args-boxed-string.err
> b/tests/qapi-schema/args-boxed-string.err
> index 7623755..d326b48 100644
> --- a/tests/qapi-schema/args-boxed-string.err
> +++ b/tests/qapi-schema/args-boxed-string.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-boxed-string.json:6: 'data' for command 'foo'
> cannot use built-in type 'str'
> +tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo'
> cannot use built-in type 'str'
> diff --git a/tests/qapi-schema/args-boxed-string.json
> b/tests/qapi-schema/args-boxed-string.json
> index aecdf97..f91a150 100644
> --- a/tests/qapi-schema/args-boxed-string.json
> +++ b/tests/qapi-schema/args-boxed-string.json
> @@ -1,6 +1,2 @@
>  # 'boxed' requires a complex (not built-in) type
> -
> -##
> -# @foo:
> -##
>  { 'command': 'foo', 'boxed': true, 'data': 'str' }
> diff --git a/tests/qapi-schema/args-int.err
> b/tests/qapi-schema/args-int.err
> index 38b3202..dc1d250 100644
> --- a/tests/qapi-schema/args-int.err
> +++ b/tests/qapi-schema/args-int.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-int.json:6: 'data' for command 'oops' cannot use
> built-in type 'int'
> +tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot use
> built-in type 'int'
> diff --git a/tests/qapi-schema/args-int.json
> b/tests/qapi-schema/args-int.json
> index 7f4e1b7..a334d92 100644
> --- a/tests/qapi-schema/args-int.json
> +++ b/tests/qapi-schema/args-int.json
> @@ -1,6 +1,2 @@
>  # we reject commands where data is not an array or complex type
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': 'int' }
> diff --git a/tests/qapi-schema/args-invalid.err
> b/tests/qapi-schema/args-invalid.err
> index 5d3568d..fe1e949 100644
> --- a/tests/qapi-schema/args-invalid.err
> +++ b/tests/qapi-schema/args-invalid.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-invalid.json:4: 'data' for command 'foo' should b=
e
> a dictionary or type name
> +tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e
> a dictionary or type name
> diff --git a/tests/qapi-schema/args-invalid.json
> b/tests/qapi-schema/args-invalid.json
> index 1a7e63b..db09813 100644
> --- a/tests/qapi-schema/args-invalid.json
> +++ b/tests/qapi-schema/args-invalid.json
> @@ -1,5 +1,2 @@
> -##
> -# @foo:
> -##
>  { 'command': 'foo',
>    'data': false }
> diff --git a/tests/qapi-schema/args-member-array-bad.err
> b/tests/qapi-schema/args-member-array-bad.err
> index 825ffca..881b4d9 100644
> --- a/tests/qapi-schema/args-member-array-bad.err
> +++ b/tests/qapi-schema/args-member-array-bad.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-member-array-bad.json:6: Member 'member' of 'data=
'
> for command 'oops': array type must contain single type name
> +tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'data=
'
> for command 'oops': array type must contain single type name
> diff --git a/tests/qapi-schema/args-member-array-bad.json
> b/tests/qapi-schema/args-member-array-bad.json
> index e934f5c..b2ff144 100644
> --- a/tests/qapi-schema/args-member-array-bad.json
> +++ b/tests/qapi-schema/args-member-array-bad.json
> @@ -1,6 +1,2 @@
>  # we reject data if it does not contain a valid array type
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': { 'member': [ { 'nested': 'str' } ] } }
> diff --git a/tests/qapi-schema/args-member-case.err
> b/tests/qapi-schema/args-member-case.err
> index a3fb2bd..19c4426 100644
> --- a/tests/qapi-schema/args-member-case.err
> +++ b/tests/qapi-schema/args-member-case.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-member-case.json:6: 'Arg' (parameter of
> no-way-this-will-get-whitelisted) should not use uppercase
> +tests/qapi-schema/args-member-case.json:2: 'Arg' (parameter of
> no-way-this-will-get-whitelisted) should not use uppercase
> diff --git a/tests/qapi-schema/args-member-case.json
> b/tests/qapi-schema/args-member-case.json
> index 811e658..93439be 100644
> --- a/tests/qapi-schema/args-member-case.json
> +++ b/tests/qapi-schema/args-member-case.json
> @@ -1,6 +1,2 @@
>  # Member names should be 'lower-case' unless the struct/command is
> whitelisted
> -
> -##
> -# @no-way-this-will-get-whitelisted:
> -##
>  { 'command': 'no-way-this-will-get-whitelisted', 'data': { 'Arg': 'int' =
}
> }
> diff --git a/tests/qapi-schema/args-member-unknown.err
> b/tests/qapi-schema/args-member-unknown.err
> index 3db452b..f6f8282 100644
> --- a/tests/qapi-schema/args-member-unknown.err
> +++ b/tests/qapi-schema/args-member-unknown.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-member-unknown.json:6: Member 'member' of 'data'
> for command 'oops' uses unknown type 'NoSuchType'
> +tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data'
> for command 'oops' uses unknown type 'NoSuchType'
> diff --git a/tests/qapi-schema/args-member-unknown.json
> b/tests/qapi-schema/args-member-unknown.json
> index e2fef9c..342a41e 100644
> --- a/tests/qapi-schema/args-member-unknown.json
> +++ b/tests/qapi-schema/args-member-unknown.json
> @@ -1,6 +1,2 @@
>  # we reject data if it does not contain a known type
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': { 'member': 'NoSuchType' } }
> diff --git a/tests/qapi-schema/args-name-clash.err
> b/tests/qapi-schema/args-name-clash.err
> index 23988cb..d953e8d 100644
> --- a/tests/qapi-schema/args-name-clash.err
> +++ b/tests/qapi-schema/args-name-clash.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-name-clash.json:8: 'a_b' (parameter of oops)
> collides with 'a-b' (parameter of oops)
> +tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops)
> collides with 'a-b' (parameter of oops)
> diff --git a/tests/qapi-schema/args-name-clash.json
> b/tests/qapi-schema/args-name-clash.json
> index 991323b..61423cb 100644
> --- a/tests/qapi-schema/args-name-clash.json
> +++ b/tests/qapi-schema/args-name-clash.json
> @@ -1,8 +1,4 @@
>  # C member name collision
>  # Reject members that clash when mapped to C names (we would have two
> 'a_b'
>  # members).
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': { 'a-b': 'str', 'a_b': 'str' } }
> diff --git a/tests/qapi-schema/args-union.err
> b/tests/qapi-schema/args-union.err
> index ce0a34e..f8ad223 100644
> --- a/tests/qapi-schema/args-union.err
> +++ b/tests/qapi-schema/args-union.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-union.json:10: 'data' for command 'oops' cannot
> use union type 'Uni'
> +tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot us=
e
> union type 'Uni'
> diff --git a/tests/qapi-schema/args-union.json
> b/tests/qapi-schema/args-union.json
> index 57284b4..2fcaeaa 100644
> --- a/tests/qapi-schema/args-union.json
> +++ b/tests/qapi-schema/args-union.json
> @@ -1,10 +1,3 @@
>  # use of union arguments requires 'boxed':true
> -
> -##
> -# @Uni:
> -##
>  { 'union': 'Uni', 'data': { 'case1': 'int', 'case2': 'str' } }
> -##
> -# oops:
> -##
>  { 'command': 'oops', 'data': 'Uni' }
> diff --git a/tests/qapi-schema/args-unknown.err
> b/tests/qapi-schema/args-unknown.err
> index ba6c6cf..4d91ec8 100644
> --- a/tests/qapi-schema/args-unknown.err
> +++ b/tests/qapi-schema/args-unknown.err
> @@ -1 +1 @@
> -tests/qapi-schema/args-unknown.json:6: 'data' for command 'oops' uses
> unknown type 'NoSuchType'
> +tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses
> unknown type 'NoSuchType'
> diff --git a/tests/qapi-schema/args-unknown.json
> b/tests/qapi-schema/args-unknown.json
> index 12666dc..32aba43 100644
> --- a/tests/qapi-schema/args-unknown.json
> +++ b/tests/qapi-schema/args-unknown.json
> @@ -1,6 +1,2 @@
>  # we reject data if it does not contain a known type
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': 'NoSuchType' }
> diff --git a/tests/qapi-schema/bad-base.err
> b/tests/qapi-schema/bad-base.err
> index e668761..154274b 100644
> --- a/tests/qapi-schema/bad-base.err
> +++ b/tests/qapi-schema/bad-base.err
> @@ -1 +1 @@
> -tests/qapi-schema/bad-base.json:10: 'base' for struct 'MyType' cannot us=
e
> union type 'Union'
> +tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot use
> union type 'Union'
> diff --git a/tests/qapi-schema/bad-base.json
> b/tests/qapi-schema/bad-base.json
> index c3faa82..a634331 100644
> --- a/tests/qapi-schema/bad-base.json
> +++ b/tests/qapi-schema/bad-base.json
> @@ -1,10 +1,3 @@
>  # we reject a base that is not a struct
> -
> -##
> -# @Union:
> -##
>  { 'union': 'Union', 'data': { 'a': 'int', 'b': 'str' } }
> -##
> -# @MyType:
> -##
>  { 'struct': 'MyType', 'base': 'Union', 'data': { 'c': 'int' } }
> diff --git a/tests/qapi-schema/bad-data.err
> b/tests/qapi-schema/bad-data.err
> index c1b9e35..8523ac4 100644
> --- a/tests/qapi-schema/bad-data.err
> +++ b/tests/qapi-schema/bad-data.err
> @@ -1 +1 @@
> -tests/qapi-schema/bad-data.json:6: 'data' for command 'oops' cannot be a=
n
> array
> +tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be a=
n
> array
> diff --git a/tests/qapi-schema/bad-data.json
> b/tests/qapi-schema/bad-data.json
> index 51c444f..832eeb7 100644
> --- a/tests/qapi-schema/bad-data.json
> +++ b/tests/qapi-schema/bad-data.json
> @@ -1,6 +1,2 @@
>  # we ensure 'data' is a dictionary for all but enums
> -
> -##
> -# @oops:
> -##
>  { 'command': 'oops', 'data': [ ] }
> diff --git a/tests/qapi-schema/bad-ident.err
> b/tests/qapi-schema/bad-ident.err
> index b757aa2..c419060 100644
> --- a/tests/qapi-schema/bad-ident.err
> +++ b/tests/qapi-schema/bad-ident.err
> @@ -1 +1 @@
> -tests/qapi-schema/bad-ident.json:6: 'struct' does not allow optional nam=
e
> '*oops'
> +tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional nam=
e
> '*oops'
> diff --git a/tests/qapi-schema/bad-ident.json
> b/tests/qapi-schema/bad-ident.json
> index b43df7a..763627a 100644
> --- a/tests/qapi-schema/bad-ident.json
> +++ b/tests/qapi-schema/bad-ident.json
> @@ -1,6 +1,2 @@
>  # we reject creating a type name with bad name
> -
> -##
> -# @*oops:
> -##
>  { 'struct': '*oops', 'data': { 'i': 'int' } }
> diff --git a/tests/qapi-schema/bad-type-bool.err
> b/tests/qapi-schema/bad-type-bool.err
> index 72e026b..62fd70b 100644
> --- a/tests/qapi-schema/bad-type-bool.err
> +++ b/tests/qapi-schema/bad-type-bool.err
> @@ -1 +1 @@
> -tests/qapi-schema/bad-type-bool.json:6: 'struct' key must have a string
> value
> +tests/qapi-schema/bad-type-bool.json:2: 'struct' key must have a string
> value
> diff --git a/tests/qapi-schema/bad-type-bool.json
> b/tests/qapi-schema/bad-type-bool.json
> index 1f9eddf..bde17b5 100644
> --- a/tests/qapi-schema/bad-type-bool.json
> +++ b/tests/qapi-schema/bad-type-bool.json
> @@ -1,6 +1,2 @@
>  # we reject an expression with a metatype that is not a string
> -
> -##
> -# @true:
> -##
>  { 'struct': true, 'data': { } }
> diff --git a/tests/qapi-schema/bad-type-dict.err
> b/tests/qapi-schema/bad-type-dict.err
> index d0d1f60..0b2a2ae 100644
> --- a/tests/qapi-schema/bad-type-dict.err
> +++ b/tests/qapi-schema/bad-type-dict.err
> @@ -1 +1 @@
> -tests/qapi-schema/bad-type-dict.json:6: 'command' key must have a string
> value
> +tests/qapi-schema/bad-type-dict.json:2: 'command' key must have a string
> value
> diff --git a/tests/qapi-schema/bad-type-dict.json
> b/tests/qapi-schema/bad-type-dict.json
> index 5952caa..2a91b24 100644
> --- a/tests/qapi-schema/bad-type-dict.json
> +++ b/tests/qapi-schema/bad-type-dict.json
> @@ -1,6 +1,2 @@
>  # we reject an expression with a metatype that is not a string
> -
> -##
> -# @foo:
> -##
>  { 'command': { } }
> diff --git a/tests/qapi-schema/base-cycle-direct.err
> b/tests/qapi-schema/base-cycle-direct.err
> index dd7f5aa..9c68f65 100644
> --- a/tests/qapi-schema/base-cycle-direct.err
> +++ b/tests/qapi-schema/base-cycle-direct.err
> @@ -1 +1 @@
> -tests/qapi-schema/base-cycle-direct.json:6: Object Loopy contains itself
> +tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itself
> diff --git a/tests/qapi-schema/base-cycle-direct.json
> b/tests/qapi-schema/base-cycle-direct.json
> index 9780f7e..4fc66d0 100644
> --- a/tests/qapi-schema/base-cycle-direct.json
> +++ b/tests/qapi-schema/base-cycle-direct.json
> @@ -1,6 +1,2 @@
>  # we reject a loop in base classes
> -
> -##
> -# @Loopy:
> -##
>  { 'struct': 'Loopy', 'base': 'Loopy', 'data': {} }
> diff --git a/tests/qapi-schema/base-cycle-indirect.err
> b/tests/qapi-schema/base-cycle-indirect.err
> index f4198e4..fc92fe4 100644
> --- a/tests/qapi-schema/base-cycle-indirect.err
> +++ b/tests/qapi-schema/base-cycle-indirect.err
> @@ -1 +1 @@
> -tests/qapi-schema/base-cycle-indirect.json:6: Object Base1 contains itse=
lf
> +tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains itse=
lf
> diff --git a/tests/qapi-schema/base-cycle-indirect.json
> b/tests/qapi-schema/base-cycle-indirect.json
> index 99926c4..2866772 100644
> --- a/tests/qapi-schema/base-cycle-indirect.json
> +++ b/tests/qapi-schema/base-cycle-indirect.json
> @@ -1,10 +1,3 @@
>  # we reject a loop in base classes
> -
> -##
> -# @Base1:
> -##
>  { 'struct': 'Base1', 'base': 'Base2', 'data': {} }
> -##
> -# @Base2:
> -##
>  { 'struct': 'Base2', 'base': 'Base1', 'data': {} }
> diff --git a/tests/qapi-schema/command-int.err
> b/tests/qapi-schema/command-int.err
> index 3c834a9..0f93006 100644
> --- a/tests/qapi-schema/command-int.err
> +++ b/tests/qapi-schema/command-int.err
> @@ -1 +1 @@
> -tests/qapi-schema/command-int.json:6: built-in 'int' is already defined
> +tests/qapi-schema/command-int.json:2: built-in 'int' is already defined
> diff --git a/tests/qapi-schema/command-int.json
> b/tests/qapi-schema/command-int.json
> index 5b51bf1..9a62554 100644
> --- a/tests/qapi-schema/command-int.json
> +++ b/tests/qapi-schema/command-int.json
> @@ -1,6 +1,2 @@
>  # we reject collisions between commands and types
> -
> -##
> -# @int:
> -##
>  { 'command': 'int', 'data': { 'character': 'str' } }
> diff --git a/tests/qapi-schema/comments.json
> b/tests/qapi-schema/comments.json
> index d31ef0d..e643f3a 100644
> --- a/tests/qapi-schema/comments.json
> +++ b/tests/qapi-schema/comments.json
> @@ -1,8 +1,4 @@
>  # Unindented comment
> -
> -##
> -# @Status:
> -##
>  { 'enum': 'Status',             # Comment to the right of code
>    # Indented comment
>    'data': [ 'good', 'bad', 'ugly' ] }
> diff --git a/tests/qapi-schema/comments.out
> b/tests/qapi-schema/comments.out
> index a962fb2..5d7c13c 100644
> --- a/tests/qapi-schema/comments.out
> +++ b/tests/qapi-schema/comments.out
> @@ -2,4 +2,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict',
> 'qlist', 'qfloat', 'qbo
>      prefix QTYPE
>  enum Status ['good', 'bad', 'ugly']
>  object q_empty
> -doc symbol=3DStatus expr=3D('enum', 'Status')
> diff --git a/tests/qapi-schema/double-type.err
> b/tests/qapi-schema/double-type.err
> index 424df9b..f9613c6 100644
> --- a/tests/qapi-schema/double-type.err
> +++ b/tests/qapi-schema/double-type.err
> @@ -1 +1 @@
> -tests/qapi-schema/double-type.json:6: Unknown key 'command' in struct
> 'bar'
> +tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct
> 'bar'
> diff --git a/tests/qapi-schema/double-type.json
> b/tests/qapi-schema/double-type.json
> index ab59523..911fa7a 100644
> --- a/tests/qapi-schema/double-type.json
> +++ b/tests/qapi-schema/double-type.json
> @@ -1,6 +1,2 @@
>  # we reject an expression with ambiguous metatype
> -
> -##
> -# @foo:
> -##
>  { 'command': 'foo', 'struct': 'bar', 'data': { } }
> diff --git a/tests/qapi-schema/enum-bad-name.err
> b/tests/qapi-schema/enum-bad-name.err
> index 157d1b0..9c3c100 100644
> --- a/tests/qapi-schema/enum-bad-name.err
> +++ b/tests/qapi-schema/enum-bad-name.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-bad-name.json:6: Member of enum 'MyEnum' uses
> invalid name 'not^possible'
> +tests/qapi-schema/enum-bad-name.json:2: Member of enum 'MyEnum' uses
> invalid name 'not^possible'
> diff --git a/tests/qapi-schema/enum-bad-name.json
> b/tests/qapi-schema/enum-bad-name.json
> index 978cb88..8506562 100644
> --- a/tests/qapi-schema/enum-bad-name.json
> +++ b/tests/qapi-schema/enum-bad-name.json
> @@ -1,6 +1,2 @@
>  # we ensure all enum names can map to C
> -
> -##
> -# @MyEnum:
> -##
>  { 'enum': 'MyEnum', 'data': [ 'not^possible' ] }
> diff --git a/tests/qapi-schema/enum-bad-prefix.err
> b/tests/qapi-schema/enum-bad-prefix.err
> index 918915f..399f5f7 100644
> --- a/tests/qapi-schema/enum-bad-prefix.err
> +++ b/tests/qapi-schema/enum-bad-prefix.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-bad-prefix.json:6: Enum 'MyEnum' requires a strin=
g
> for 'prefix'
> +tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a strin=
g
> for 'prefix'
> diff --git a/tests/qapi-schema/enum-bad-prefix.json
> b/tests/qapi-schema/enum-bad-prefix.json
> index 25f17a7..996f628 100644
> --- a/tests/qapi-schema/enum-bad-prefix.json
> +++ b/tests/qapi-schema/enum-bad-prefix.json
> @@ -1,6 +1,2 @@
>  # The prefix must be a string type
> -
> -##
> -# @MyEnum:
> -##
>  { 'enum': 'MyEnum', 'data': [ 'one' ], 'prefix': [ 'fish' ] }
> diff --git a/tests/qapi-schema/enum-clash-member.err
> b/tests/qapi-schema/enum-clash-member.err
> index 25249b6..5403c78 100644
> --- a/tests/qapi-schema/enum-clash-member.err
> +++ b/tests/qapi-schema/enum-clash-member.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-clash-member.json:6: 'one_two' (member of MyEnum)
> collides with 'one-two' (member of MyEnum)
> +tests/qapi-schema/enum-clash-member.json:2: 'one_two' (member of MyEnum)
> collides with 'one-two' (member of MyEnum)
> diff --git a/tests/qapi-schema/enum-clash-member.json
> b/tests/qapi-schema/enum-clash-member.json
> index fd52751..b6928b8 100644
> --- a/tests/qapi-schema/enum-clash-member.json
> +++ b/tests/qapi-schema/enum-clash-member.json
> @@ -1,6 +1,2 @@
>  # we reject enums where members will clash when mapped to C enum
> -
> -##
> -# @MyEnum:
> -##
>  { 'enum': 'MyEnum', 'data': [ 'one-two', 'one_two' ] }
> diff --git a/tests/qapi-schema/enum-dict-member.err
> b/tests/qapi-schema/enum-dict-member.err
> index 9b7d2f1..8ca146e 100644
> --- a/tests/qapi-schema/enum-dict-member.err
> +++ b/tests/qapi-schema/enum-dict-member.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-dict-member.json:6: Member of enum 'MyEnum'
> requires a string name
> +tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum'
> requires a string name
> diff --git a/tests/qapi-schema/enum-dict-member.json
> b/tests/qapi-schema/enum-dict-member.json
> index 69d30f0..79672e0 100644
> --- a/tests/qapi-schema/enum-dict-member.json
> +++ b/tests/qapi-schema/enum-dict-member.json
> @@ -1,6 +1,2 @@
>  # we reject any enum member that is not a string
> -
> -##
> -# @MyEnum:
> -##
>  { 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
> diff --git a/tests/qapi-schema/enum-member-case.err
> b/tests/qapi-schema/enum-member-case.err
> index df96e22..b652e9a 100644
> --- a/tests/qapi-schema/enum-member-case.err
> +++ b/tests/qapi-schema/enum-member-case.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-member-case.json:10: 'Value' (member of
> NoWayThisWillGetWhitelisted) should not use uppercase
> +tests/qapi-schema/enum-member-case.json:3: 'Value' (member of
> NoWayThisWillGetWhitelisted) should not use uppercase
> diff --git a/tests/qapi-schema/enum-member-case.json
> b/tests/qapi-schema/enum-member-case.json
> index d2e4aba..2096b35 100644
> --- a/tests/qapi-schema/enum-member-case.json
> +++ b/tests/qapi-schema/enum-member-case.json
> @@ -1,10 +1,3 @@
>  # Member names should be 'lower-case' unless the enum is whitelisted
> -
> -##
> -# @UuidInfo:
> -##
>  { 'enum': 'UuidInfo', 'data': [ 'Value' ] } # UuidInfo is whitelisted
> -##
> -# @NoWayThisWillGetWhitelisted:
> -##
>  { 'enum': 'NoWayThisWillGetWhitelisted', 'data': [ 'Value' ] }
> diff --git a/tests/qapi-schema/enum-missing-data.err
> b/tests/qapi-schema/enum-missing-data.err
> index de4b9e8..ba4873a 100644
> --- a/tests/qapi-schema/enum-missing-data.err
> +++ b/tests/qapi-schema/enum-missing-data.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-missing-data.json:6: Key 'data' is missing from
> enum 'MyEnum'
> +tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from
> enum 'MyEnum'
> diff --git a/tests/qapi-schema/enum-missing-data.json
> b/tests/qapi-schema/enum-missing-data.json
> index d7601f9..558fd35 100644
> --- a/tests/qapi-schema/enum-missing-data.json
> +++ b/tests/qapi-schema/enum-missing-data.json
> @@ -1,6 +1,2 @@
>  # we require that all QAPI enums have a data array
> -
> -##
> -# @MyEnum:
> -##
>  { 'enum': 'MyEnum' }
> diff --git a/tests/qapi-schema/enum-wrong-data.err
> b/tests/qapi-schema/enum-wrong-data.err
> index c44e9b5..11b4347 100644
> --- a/tests/qapi-schema/enum-wrong-data.err
> +++ b/tests/qapi-schema/enum-wrong-data.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-wrong-data.json:6: Enum 'MyEnum' requires an arra=
y
> for 'data'
> +tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an arra=
y
> for 'data'
> diff --git a/tests/qapi-schema/enum-wrong-data.json
> b/tests/qapi-schema/enum-wrong-data.json
> index 4b9e978..7b3e255 100644
> --- a/tests/qapi-schema/enum-wrong-data.json
> +++ b/tests/qapi-schema/enum-wrong-data.json
> @@ -1,6 +1,2 @@
>  # we require that all qapi enums have an array for data
> -
> -##
> -# @MyEnum:
> -##
>  { 'enum': 'MyEnum', 'data': { 'value': 'str' } }
> diff --git a/tests/qapi-schema/event-boxed-empty.err
> b/tests/qapi-schema/event-boxed-empty.err
> index defe656..68ec6f2 100644
> --- a/tests/qapi-schema/event-boxed-empty.err
> +++ b/tests/qapi-schema/event-boxed-empty.err
> @@ -1 +1 @@
> -tests/qapi-schema/event-boxed-empty.json:6: Use of 'boxed' requires 'dat=
a'
> +tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'dat=
a'
> diff --git a/tests/qapi-schema/event-boxed-empty.json
> b/tests/qapi-schema/event-boxed-empty.json
> index 63b870b..cb145f1 100644
> --- a/tests/qapi-schema/event-boxed-empty.json
> +++ b/tests/qapi-schema/event-boxed-empty.json
> @@ -1,6 +1,2 @@
>  # 'boxed' requires a non-empty type
> -
> -##
> -# @FOO:
> -##
>  { 'event': 'FOO', 'boxed': true }
> diff --git a/tests/qapi-schema/event-case.json
> b/tests/qapi-schema/event-case.json
> index 6b05c5d..3a92d8b 100644
> --- a/tests/qapi-schema/event-case.json
> +++ b/tests/qapi-schema/event-case.json
> @@ -1,7 +1,3 @@
>  # TODO: might be nice to enforce naming conventions; but until then this
> works
>  # even though events should usually be ALL_CAPS
> -
> -##
> -# @oops:
> -##
>  { 'event': 'oops' }
> diff --git a/tests/qapi-schema/event-case.out
> b/tests/qapi-schema/event-case.out
> index 2865714..5a0f2bf 100644
> --- a/tests/qapi-schema/event-case.out
> +++ b/tests/qapi-schema/event-case.out
> @@ -3,4 +3,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict',
> 'qlist', 'qfloat', 'qbo
>  event oops None
>     boxed=3DFalse
>  object q_empty
> -doc symbol=3Doops expr=3D('event', 'oops')
> diff --git a/tests/qapi-schema/event-nest-struct.err
> b/tests/qapi-schema/event-nest-struct.err
> index 17a6c3c..5a42701 100644
> --- a/tests/qapi-schema/event-nest-struct.err
> +++ b/tests/qapi-schema/event-nest-struct.err
> @@ -1 +1 @@
> -tests/qapi-schema/event-nest-struct.json:5: Member 'a' of 'data' for
> event 'EVENT_A' should be a type name
> +tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for
> event 'EVENT_A' should be a type name
> diff --git a/tests/qapi-schema/event-nest-struct.json
> b/tests/qapi-schema/event-nest-struct.json
> index 328e0a6..ee6f3ec 100644
> --- a/tests/qapi-schema/event-nest-struct.json
> +++ b/tests/qapi-schema/event-nest-struct.json
> @@ -1,6 +1,2 @@
> -##
> -# @EVENT_A:
> -# event-nest-struct
> -##
>  { 'event': 'EVENT_A',
>    'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' } =
}
> diff --git a/tests/qapi-schema/flat-union-array-branch.err
> b/tests/qapi-schema/flat-union-array-branch.err
> index e456094..8ea91ea 100644
> --- a/tests/qapi-schema/flat-union-array-branch.err
> +++ b/tests/qapi-schema/flat-union-array-branch.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-array-branch.json:20: Member 'value1' of
> union 'TestUnion' cannot be an array
> +tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of
> union 'TestUnion' cannot be an array
> diff --git a/tests/qapi-schema/flat-union-array-branch.json
> b/tests/qapi-schema/flat-union-array-branch.json
> index 51dde10..0b98820 100644
> --- a/tests/qapi-schema/flat-union-array-branch.json
> +++ b/tests/qapi-schema/flat-union-array-branch.json
> @@ -1,22 +1,10 @@
> -##
> -# @TestEnum:
> -##
>  # we require flat union branches to be a struct
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @Base:
> -##
>  { 'struct': 'Base',
>    'data': { 'enum1': 'TestEnum' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'Base',
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-bad-base.err
> b/tests/qapi-schema/flat-union-bad-base.err
> index 072ffba..bee24a2 100644
> --- a/tests/qapi-schema/flat-union-bad-base.err
> +++ b/tests/qapi-schema/flat-union-bad-base.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-bad-base.json:21: 'string' (member of
> TestTypeA) collides with 'string' (base of TestUnion)
> +tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of
> TestTypeA) collides with 'string' (base of TestUnion)
> diff --git a/tests/qapi-schema/flat-union-bad-base.json
> b/tests/qapi-schema/flat-union-bad-base.json
> index 7713e7f..74dd421 100644
> --- a/tests/qapi-schema/flat-union-bad-base.json
> +++ b/tests/qapi-schema/flat-union-bad-base.json
> @@ -1,23 +1,10 @@
>  # we allow anonymous base, but enforce no duplicate keys
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': { 'enum1': 'TestEnum', 'string': 'str' },
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err
> b/tests/qapi-schema/flat-union-bad-discriminator.err
> index 1be4e7b..c38cc8e 100644
> --- a/tests/qapi-schema/flat-union-bad-discriminator.err
> +++ b/tests/qapi-schema/flat-union-bad-discriminator.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-bad-discriminator.json:27: Discriminator of
> flat union 'TestUnion' requires a string name
> +tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator of
> flat union 'TestUnion' requires a string name
> diff --git a/tests/qapi-schema/flat-union-bad-discriminator.json
> b/tests/qapi-schema/flat-union-bad-discriminator.json
> index ef92f9b..cd10b9d 100644
> --- a/tests/qapi-schema/flat-union-bad-discriminator.json
> +++ b/tests/qapi-schema/flat-union-bad-discriminator.json
> @@ -1,29 +1,13 @@
>  # we require the discriminator to be a string naming a base-type member
>  # this tests the old syntax for anonymous unions before we added
> alternates
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @TestBase:
> -##
>  { 'struct': 'TestBase',
>    'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'TestBase',
>    'discriminator': {},
> diff --git a/tests/qapi-schema/flat-union-base-any.err
> b/tests/qapi-schema/flat-union-base-any.err
> index c1ea2d7..646f1c9 100644
> --- a/tests/qapi-schema/flat-union-base-any.err
> +++ b/tests/qapi-schema/flat-union-base-any.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-base-any.json:21: 'base' for union
> 'TestUnion' cannot use built-in type 'any'
> +tests/qapi-schema/flat-union-base-any.json:8: 'base' for union
> 'TestUnion' cannot use built-in type 'any'
> diff --git a/tests/qapi-schema/flat-union-base-any.json
> b/tests/qapi-schema/flat-union-base-any.json
> index 3dfb02f..fe66b71 100644
> --- a/tests/qapi-schema/flat-union-base-any.json
> +++ b/tests/qapi-schema/flat-union-base-any.json
> @@ -1,23 +1,10 @@
>  # we require the base to be an existing struct
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'any',
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-base-union.err
> b/tests/qapi-schema/flat-union-base-union.err
> index ccc5e85..f138395 100644
> --- a/tests/qapi-schema/flat-union-base-union.err
> +++ b/tests/qapi-schema/flat-union-base-union.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-base-union.json:30: 'base' for union
> 'TestUnion' cannot use union type 'UnionBase'
> +tests/qapi-schema/flat-union-base-union.json:14: 'base' for union
> 'TestUnion' cannot use union type 'UnionBase'
> diff --git a/tests/qapi-schema/flat-union-base-union.json
> b/tests/qapi-schema/flat-union-base-union.json
> index c63c613..98b4eba 100644
> --- a/tests/qapi-schema/flat-union-base-union.json
> +++ b/tests/qapi-schema/flat-union-base-union.json
> @@ -2,31 +2,15 @@
>  # TODO: It would be possible to allow a union as a base, as long as all
>  # permutations of QMP names exposed by base do not clash with any QMP
>  # member names added by local variants.
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @UnionBase:
> -##
>  { 'union': 'UnionBase',
>    'data': { 'kind1': 'TestTypeA',
>              'kind2': 'TestTypeB' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'UnionBase',
>    'discriminator': 'type',
> diff --git a/tests/qapi-schema/flat-union-clash-member.err
> b/tests/qapi-schema/flat-union-clash-member.err
> index fe12a07..2adf697 100644
> --- a/tests/qapi-schema/flat-union-clash-member.err
> +++ b/tests/qapi-schema/flat-union-clash-member.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-clash-member.json:27: 'name' (member of
> Branch1) collides with 'name' (member of Base)
> +tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of
> Branch1) collides with 'name' (member of Base)
> diff --git a/tests/qapi-schema/flat-union-clash-member.json
> b/tests/qapi-schema/flat-union-clash-member.json
> index 9000b94..9efc771 100644
> --- a/tests/qapi-schema/flat-union-clash-member.json
> +++ b/tests/qapi-schema/flat-union-clash-member.json
> @@ -1,29 +1,13 @@
>  # We check for no duplicate keys between branch members and base
>  # base's member 'name' clashes with Branch1's
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @Base:
> -##
>  { 'struct': 'Base',
>    'data': { 'enum1': 'TestEnum', '*name': 'str' } }
> -##
> -# @Branch1:
> -##
>  { 'struct': 'Branch1',
>    'data': { 'name': 'str' } }
> -##
> -# @Branch2:
> -##
>  { 'struct': 'Branch2',
>    'data': { 'value': 'int' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'Base',
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-empty.err
> b/tests/qapi-schema/flat-union-empty.err
> index ead7bd4..15754f5 100644
> --- a/tests/qapi-schema/flat-union-empty.err
> +++ b/tests/qapi-schema/flat-union-empty.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-empty.json:14: Union 'Union' cannot have
> empty 'data'
> +tests/qapi-schema/flat-union-empty.json:4: Union 'Union' cannot have
> empty 'data'
> diff --git a/tests/qapi-schema/flat-union-empty.json
> b/tests/qapi-schema/flat-union-empty.json
> index afa8988..77f1d9a 100644
> --- a/tests/qapi-schema/flat-union-empty.json
> +++ b/tests/qapi-schema/flat-union-empty.json
> @@ -1,14 +1,4 @@
>  # flat unions cannot be empty
> -
> -##
> -# @Empty:
> -##
>  { 'enum': 'Empty', 'data': [ ] }
> -##
> -# @Base:
> -##
>  { 'struct': 'Base', 'data': { 'type': 'Empty' } }
> -##
> -# @Union:
> -##
>  { 'union': 'Union', 'base': 'Base', 'discriminator': 'type', 'data': { }=
 }
> diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err
> b/tests/qapi-schema/flat-union-incomplete-branch.err
> index c655bbf..e826bf0 100644
> --- a/tests/qapi-schema/flat-union-incomplete-branch.err
> +++ b/tests/qapi-schema/flat-union-incomplete-branch.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-incomplete-branch.json:16: Union 'TestUnion=
'
> data missing 'value2' branch
> +tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion'
> data missing 'value2' branch
> diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json
> b/tests/qapi-schema/flat-union-incomplete-branch.json
> index dea0377..25a411b 100644
> --- a/tests/qapi-schema/flat-union-incomplete-branch.json
> +++ b/tests/qapi-schema/flat-union-incomplete-branch.json
> @@ -1,18 +1,8 @@
>  # we require all branches of the union to be covered
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': { 'type': 'TestEnum' },
>    'discriminator': 'type',
> diff --git a/tests/qapi-schema/flat-union-inline.err
> b/tests/qapi-schema/flat-union-inline.err
> index c2c3f76..2333358 100644
> --- a/tests/qapi-schema/flat-union-inline.err
> +++ b/tests/qapi-schema/flat-union-inline.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-inline.json:17: Member 'value1' of union
> 'TestUnion' should be a type name
> +tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union
> 'TestUnion' should be a type name
> diff --git a/tests/qapi-schema/flat-union-inline.json
> b/tests/qapi-schema/flat-union-inline.json
> index 400f081..62c7cda 100644
> --- a/tests/qapi-schema/flat-union-inline.json
> +++ b/tests/qapi-schema/flat-union-inline.json
> @@ -1,19 +1,9 @@
>  # we require branches to be a struct name
>  # TODO: should we allow anonymous inline branch types?
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @Base:
> -##
>  { 'struct': 'Base',
>    'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'Base',
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-int-branch.err
> b/tests/qapi-schema/flat-union-int-branch.err
> index 299cbb2..faf0157 100644
> --- a/tests/qapi-schema/flat-union-int-branch.err
> +++ b/tests/qapi-schema/flat-union-int-branch.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-int-branch.json:21: Member 'value1' of unio=
n
> 'TestUnion' cannot use built-in type 'int'
> +tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of union
> 'TestUnion' cannot use built-in type 'int'
> diff --git a/tests/qapi-schema/flat-union-int-branch.json
> b/tests/qapi-schema/flat-union-int-branch.json
> index 9603e17..9370c34 100644
> --- a/tests/qapi-schema/flat-union-int-branch.json
> +++ b/tests/qapi-schema/flat-union-int-branch.json
> @@ -1,23 +1,10 @@
>  # we require flat union branches to be a struct
> -
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @Base:
> -##
>  { 'struct': 'Base',
>    'data': { 'enum1': 'TestEnum' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'Base',
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err
> b/tests/qapi-schema/flat-union-invalid-branch-key.err
> index 455f2dc..ccf72d2 100644
> --- a/tests/qapi-schema/flat-union-invalid-branch-key.err
> +++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-invalid-branch-key.json:28: Discriminator
> value 'value_wrong' is not found in enum 'TestEnum'
> +tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator
> value 'value_wrong' is not found in enum 'TestEnum'
> diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.json
> b/tests/qapi-schema/flat-union-invalid-branch-key.json
> index 00f2896..95ff774 100644
> --- a/tests/qapi-schema/flat-union-invalid-branch-key.json
> +++ b/tests/qapi-schema/flat-union-invalid-branch-key.json
> @@ -1,30 +1,15 @@
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
>
> -##
> -# @TestBase:
> -##
>  { 'struct': 'TestBase',
>    'data': { 'enum1': 'TestEnum' } }
>
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
>
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
>
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'TestBase',
>    'discriminator': 'enum1',
> diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err
> b/tests/qapi-schema/flat-union-invalid-discriminator.err
> index f0e427b..5f40556 100644
> --- a/tests/qapi-schema/flat-union-invalid-discriminator.err
> +++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-invalid-discriminator.json:28: Discriminato=
r
> 'enum_wrong' is not a member of base struct 'TestBase'
> +tests/qapi-schema/flat-union-invalid-discriminator.json:13: Discriminato=
r
> 'enum_wrong' is not a member of base struct 'TestBase'
> diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json
> b/tests/qapi-schema/flat-union-invalid-discriminator.json
> index c8700c7..48b94c3 100644
> --- a/tests/qapi-schema/flat-union-invalid-discriminator.json
> +++ b/tests/qapi-schema/flat-union-invalid-discriminator.json
> @@ -1,30 +1,15 @@
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
>
> -##
> -# @TestBase:
> -##
>  { 'struct': 'TestBase',
>    'data': { 'enum1': 'TestEnum' } }
>
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
>
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
>
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'TestBase',
>    'discriminator': 'enum_wrong',
> diff --git a/tests/qapi-schema/flat-union-no-base.err
> b/tests/qapi-schema/flat-union-no-base.err
> index a2d0a81..841c93b 100644
> --- a/tests/qapi-schema/flat-union-no-base.err
> +++ b/tests/qapi-schema/flat-union-no-base.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-no-base.json:22: Flat union 'TestUnion' mus=
t
> have a base
> +tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' must
> have a base
> diff --git a/tests/qapi-schema/flat-union-no-base.json
> b/tests/qapi-schema/flat-union-no-base.json
> index 641f68a..ffc4c6f 100644
> --- a/tests/qapi-schema/flat-union-no-base.json
> +++ b/tests/qapi-schema/flat-union-no-base.json
> @@ -1,24 +1,11 @@
>  # flat unions require a base
>  # TODO: simple unions should be able to use an enum discriminator
> -
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
> -##
> -# @Enum:
> -##
>  { 'enum': 'Enum',
>    'data': [ 'value1', 'value2' ] }
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'discriminator': 'Enum',
>    'data': { 'value1': 'TestTypeA',
> diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err
> b/tests/qapi-schema/flat-union-optional-discriminator.err
> index e15f856..aaabedb 100644
> --- a/tests/qapi-schema/flat-union-optional-discriminator.err
> +++ b/tests/qapi-schema/flat-union-optional-discriminator.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-optional-discriminator.json:19:
> Discriminator of flat union 'MyUnion' does not allow optional name '*swit=
ch'
> +tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminato=
r
> of flat union 'MyUnion' does not allow optional name '*switch'
> diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json
> b/tests/qapi-schema/flat-union-optional-discriminator.json
> index 9f19af5..08a8f7e 100644
> --- a/tests/qapi-schema/flat-union-optional-discriminator.json
> +++ b/tests/qapi-schema/flat-union-optional-discriminator.json
> @@ -1,21 +1,8 @@
>  # we require the discriminator to be non-optional
> -
> -##
> -# @Enum:
> -##
>  { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
> -##
> -# @Base:
> -##
>  { 'struct': 'Base',
>    'data': { '*switch': 'Enum' } }
> -##
> -# @Branch:
> -##
>  { 'struct': 'Branch', 'data': { 'name': 'str' } }
> -##
> -# @MyUnion:
> -##
>  { 'union': 'MyUnion',
>    'base': 'Base',
>    'discriminator': '*switch',
> diff --git a/tests/qapi-schema/flat-union-string-discriminator.err
> b/tests/qapi-schema/flat-union-string-discriminator.err
> index bc0c133..200016b 100644
> --- a/tests/qapi-schema/flat-union-string-discriminator.err
> +++ b/tests/qapi-schema/flat-union-string-discriminator.err
> @@ -1 +1 @@
> -tests/qapi-schema/flat-union-string-discriminator.json:28: Discriminator
> 'kind' must be of enumeration type
> +tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminator
> 'kind' must be of enumeration type
> diff --git a/tests/qapi-schema/flat-union-string-discriminator.json
> b/tests/qapi-schema/flat-union-string-discriminator.json
> index 47a17d2..8af6033 100644
> --- a/tests/qapi-schema/flat-union-string-discriminator.json
> +++ b/tests/qapi-schema/flat-union-string-discriminator.json
> @@ -1,30 +1,15 @@
> -##
> -# @TestEnum:
> -##
>  { 'enum': 'TestEnum',
>    'data': [ 'value1', 'value2' ] }
>
> -##
> -# @TestBase:
> -##
>  { 'struct': 'TestBase',
>    'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
>
> -##
> -# @TestTypeA:
> -##
>  { 'struct': 'TestTypeA',
>    'data': { 'string': 'str' } }
>
> -##
> -# @TestTypeB:
> -##
>  { 'struct': 'TestTypeB',
>    'data': { 'integer': 'int' } }
>
> -##
> -# @TestUnion:
> -##
>  { 'union': 'TestUnion',
>    'base': 'TestBase',
>    'discriminator': 'kind',
> diff --git a/tests/qapi-schema/ident-with-escape.json
> b/tests/qapi-schema/ident-with-escape.json
> index c03404b..5661750 100644
> --- a/tests/qapi-schema/ident-with-escape.json
> +++ b/tests/qapi-schema/ident-with-escape.json
> @@ -1,8 +1,4 @@
>  # we allow escape sequences in strings, if they map back to ASCII
>  # { 'command': 'fooA', 'data': { 'bar1': 'str' } }
> -
> -##
> -# @fooA:
> -##
>  { 'c\u006fmmand': '\u0066\u006f\u006FA',
>    'd\u0061ta': { '\u0062\u0061\u00721': '\u0073\u0074\u0072' } }
> diff --git a/tests/qapi-schema/ident-with-escape.out
> b/tests/qapi-schema/ident-with-escape.out
> index 69fc908..1d2722c 100644
> --- a/tests/qapi-schema/ident-with-escape.out
> +++ b/tests/qapi-schema/ident-with-escape.out
> @@ -5,4 +5,3 @@ command fooA q_obj_fooA-arg -> None
>  object q_empty
>  object q_obj_fooA-arg
>      member bar1: str optional=3DFalse
> -doc symbol=3DfooA expr=3D('command', 'fooA')
> diff --git a/tests/qapi-schema/include-relpath-sub.json
> b/tests/qapi-schema/include-relpath-sub.json
> index b4bd8a2..4bd4af4 100644
> --- a/tests/qapi-schema/include-relpath-sub.json
> +++ b/tests/qapi-schema/include-relpath-sub.json
> @@ -1,5 +1,2 @@
> -##
> -# @Status:
> -##
>  { 'enum': 'Status',
>    'data': [ 'good', 'bad', 'ugly' ] }
> diff --git a/tests/qapi-schema/include-relpath.out
> b/tests/qapi-schema/include-relpath.out
> index a962fb2..5d7c13c 100644
> --- a/tests/qapi-schema/include-relpath.out
> +++ b/tests/qapi-schema/include-relpath.out
> @@ -2,4 +2,3 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict',
> 'qlist', 'qfloat', 'qbo
>      prefix QTYPE
>  enum Status ['good', 'bad', 'ugly']
>  object q_empty
> -doc symbol=3DStatus expr=3D('enum', 'Status')
> diff --git a/tests/qapi-schema/inc

--=20
Marc-Andr=C3=A9 Lureau
