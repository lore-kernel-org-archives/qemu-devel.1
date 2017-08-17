Received: from eggs.gnu.org ([2001:4830:134:3::10]:52761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diJL3-0007sm-OT
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diJKz-0006ZC-Ra
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diJKz-0006Yu-LG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:51:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-8-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 13:51:41 +0200
In-Reply-To: <20170727154126.11339-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:07 +0200")
Message-ID: <87lgmifm42.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/26] qapi: add 'if' condition on
 top-level schema elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add 'if' c-preprocessor condition on top-level schema elements:
> struct, enum, union, alternate, command, event.
>
> Variants objects types are created outside of #if blocks, since they
> may be shared by various types. Even if unused, this shouldn't be an
> issue, since those are internal types.
>
> Note that there is no checks in qapi scripts to verify that elements
> have compatible conditions (ex: if-struct used by a if-foo
> command). This may thus fail at C build time if they don't share the
> same subset of conditions.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                         | 153 +++++++++++++++++++++++++-=
------
>  scripts/qapi-commands.py                |   4 +-
>  scripts/qapi-event.py                   |   4 +-
>  scripts/qapi-introspect.py              |  46 ++++++----
>  scripts/qapi-types.py                   |  51 +++++++----
>  scripts/qapi-visit.py                   |  13 ++-
>  scripts/qapi2texi.py                    |  10 +--
>  tests/Makefile.include                  |   1 +
>  tests/qapi-schema/bad-if.err            |   1 +
>  tests/qapi-schema/bad-if.exit           |   1 +
>  tests/qapi-schema/bad-if.json           |   3 +
>  tests/qapi-schema/bad-if.out            |   0
>  tests/qapi-schema/qapi-schema-test.json |  20 +++++
>  tests/qapi-schema/qapi-schema-test.out  |  31 +++++++
>  tests/qapi-schema/test-qapi.py          |  21 +++--
>  15 files changed, 272 insertions(+), 87 deletions(-)
>  create mode 100644 tests/qapi-schema/bad-if.err
>  create mode 100644 tests/qapi-schema/bad-if.exit
>  create mode 100644 tests/qapi-schema/bad-if.json
>  create mode 100644 tests/qapi-schema/bad-if.out

Missing: docs/devel/qapi-code-gen.txt update.

[...]
