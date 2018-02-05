Received: from eggs.gnu.org ([2001:4830:134:3::10]:56583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eia1U-00082U-Uo
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eia1P-0006M2-W9
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:13:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eia1P-0006LX-Od
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:12:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-6-marcandre.lureau@redhat.com>
Date: Mon, 05 Feb 2018 07:12:51 +0100
In-Reply-To: <20180111213250.16511-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 11 Jan 2018 22:32:04 +0100")
Message-ID: <87fu6gynfg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 05/51] qapi: add 'if' to top-level
 expressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Accept 'if' key in top-level elements, accepted as string or list of
> string type. The following patches will modify the test visitor to
> check the value is correctly saved, and generate #if/#endif code (as a
> single #if/endif line or a series for a list).
>
> Example of 'if' key:
> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>   'if': 'defined(TEST_IF_STRUCT)' }
>
> The generated code is for now *unconditional*. Later patches generate
> the conditionals.
>
> A following patch for qapi-code-gen.txt will provide more complete
> documentation for 'if' usage.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                          | 36 ++++++++++++++++++++++++++=
------
>  tests/test-qmp-commands.c                |  6 ++++++
>  tests/Makefile.include                   |  4 ++++
>  tests/qapi-schema/bad-if-empty-list.err  |  1 +
>  tests/qapi-schema/bad-if-empty-list.exit |  1 +
>  tests/qapi-schema/bad-if-empty-list.json |  3 +++
>  tests/qapi-schema/bad-if-empty-list.out  |  0
>  tests/qapi-schema/bad-if-empty.err       |  1 +
>  tests/qapi-schema/bad-if-empty.exit      |  1 +
>  tests/qapi-schema/bad-if-empty.json      |  3 +++
>  tests/qapi-schema/bad-if-empty.out       |  0
>  tests/qapi-schema/bad-if-list.err        |  1 +
>  tests/qapi-schema/bad-if-list.exit       |  1 +
>  tests/qapi-schema/bad-if-list.json       |  3 +++
>  tests/qapi-schema/bad-if-list.out        |  0
>  tests/qapi-schema/bad-if.err             |  1 +
>  tests/qapi-schema/bad-if.exit            |  1 +
>  tests/qapi-schema/bad-if.json            |  3 +++
>  tests/qapi-schema/bad-if.out             |  0
>  tests/qapi-schema/qapi-schema-test.json  | 20 ++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.out   | 22 +++++++++++++++++++
>  21 files changed, 102 insertions(+), 6 deletions(-)
>  create mode 100644 tests/qapi-schema/bad-if-empty-list.err
>  create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
>  create mode 100644 tests/qapi-schema/bad-if-empty-list.json
>  create mode 100644 tests/qapi-schema/bad-if-empty-list.out
>  create mode 100644 tests/qapi-schema/bad-if-empty.err
>  create mode 100644 tests/qapi-schema/bad-if-empty.exit
>  create mode 100644 tests/qapi-schema/bad-if-empty.json
>  create mode 100644 tests/qapi-schema/bad-if-empty.out
>  create mode 100644 tests/qapi-schema/bad-if-list.err
>  create mode 100644 tests/qapi-schema/bad-if-list.exit
>  create mode 100644 tests/qapi-schema/bad-if-list.json
>  create mode 100644 tests/qapi-schema/bad-if-list.out
>  create mode 100644 tests/qapi-schema/bad-if.err
>  create mode 100644 tests/qapi-schema/bad-if.exit
>  create mode 100644 tests/qapi-schema/bad-if.json
>  create mode 100644 tests/qapi-schema/bad-if.out
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 43a54bf40f..27df0fcf48 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -630,6 +630,27 @@ def add_name(name, info, meta, implicit=3DFalse):
>      all_names[name] =3D meta
>=20=20
>=20=20
> +def check_if(expr, info):
> +
> +    def check_if_str(ifcond, info):
> +        if not isinstance(ifcond, str):
> +            raise QAPISemError(
> +                info, "'if' condition must be a string or a list of stri=
ngs")
> +        if ifcond =3D=3D '':
> +            raise QAPISemError(info, "'if' condition '' makes no sense")
> +
> +    ifcond =3D expr.get('if')
> +    if ifcond is None:
> +        return
> +    elif isinstance(ifcond, list):

Suggest s/elif/if/

> +        if ifcond =3D=3D []:
> +            raise QAPISemError(info, "'if' condition [] is useless")
> +        for elt in ifcond:
> +            check_if_str(elt, info)
> +    else:
> +        check_if_str(ifcond, info)
> +
> +
>  def check_type(info, source, value, allow_array=3DFalse,
>                 allow_dict=3DFalse, allow_optional=3DFalse,
>                 allow_metas=3D[]):

R-by stands.
