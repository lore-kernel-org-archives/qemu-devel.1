Received: from eggs.gnu.org ([2001:4830:134:3::10]:60979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dECVv-0005kL-5x
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dECVt-0004IR-VO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:30:35 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:34753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dECVt-0004IL-Jz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:30:33 -0400
Received: by mail-lf0-x22c.google.com with SMTP id 99so3853726lfu.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 03:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-1-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 10:30:21 +0000
Message-ID: <CAJ+F1CKfHh8hZLnAn8TZaMAYTPUNReVma77D3O9mUzVN+ttAnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi: Handle some keyval fallout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Mon, May 22, 2017 at 8:45 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Markus Armbruster (4):
>   qobject-input-visitor: Reject non-finite numbers with keyval
>   qapi: Document visit_type_any() issues with keyval input
>   tests/qapi-schema: Avoid 'str' in alternate test cases
>   qapi: Reject alternates that can't work with keyval_parse()
>
>  include/qapi/visitor.h                             |  4 ++
>  qapi/qobject-input-visitor.c                       |  3 +-
>  scripts/qapi.py                                    | 19 ++++++-
>  tests/Makefile.include                             |  2 +
>  tests/qapi-schema/alternate-clash.json             |  2 +-
>  tests/qapi-schema/alternate-conflict-dict.json     |  2 +-
>  tests/qapi-schema/alternate-conflict-enum-bool.err |  1 +
>  .../qapi-schema/alternate-conflict-enum-bool.exit  |  1 +
>  .../qapi-schema/alternate-conflict-enum-bool.json  |  6 +++
>  tests/qapi-schema/alternate-conflict-enum-bool.out |  0
>  tests/qapi-schema/alternate-conflict-enum-int.err  |  1 +
>  tests/qapi-schema/alternate-conflict-enum-int.exit |  1 +
>  tests/qapi-schema/alternate-conflict-enum-int.json |  6 +++
>  tests/qapi-schema/alternate-conflict-enum-int.out  |  0
>  tests/qapi-schema/alternate-conflict-string.err    |  2 +-
>  tests/qapi-schema/alternate-conflict-string.json   |  6 +--
>  tests/qapi-schema/alternate-nested.json            |  2 +-
>  tests/qapi-schema/args-alternate.json              |  2 +-
>  tests/qapi-schema/doc-bad-alternate-member.json    |  2 +-
>  tests/qapi-schema/qapi-schema-test.json            | 13 +++--
>  tests/qapi-schema/qapi-schema-test.out             | 34 ++++++------
>  tests/qapi-schema/returns-alternate.json           |  2 +-
>  tests/test-clone-visitor.c                         | 23 ++++----
>  tests/test-keyval.c                                | 18 ++++---
>  tests/test-qobject-input-visitor.c                 | 62
> ++++++++++++----------
>  tests/test-qobject-output-visitor.c                |  4 +-
>  util/keyval.c                                      | 10 ++--
>  27 files changed, 140 insertions(+), 88 deletions(-)
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.err
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.exit
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.json
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.out
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.err
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.exit
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.json
>  create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.out
>
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
