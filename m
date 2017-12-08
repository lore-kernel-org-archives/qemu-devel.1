Received: from eggs.gnu.org ([2001:4830:134:3::10]:43744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMug-000426-LT
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMud-0006Mb-IH
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:58:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNMud-0006MJ-8j
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:58:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-23-marcandre.lureau@redhat.com>
Date: Fri, 08 Dec 2017 18:58:09 +0100
In-Reply-To: <20170911110623.24981-23-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:05:55 +0200")
Message-ID: <87tvx19k5q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 22/50] tests: add some enum members tests
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/Makefile.include                           | 3 +++
>  tests/qapi-schema/enum-dict-member-invalid.err   | 1 +
>  tests/qapi-schema/enum-dict-member-invalid.exit  | 1 +
>  tests/qapi-schema/enum-dict-member-invalid.json  | 2 ++
>  tests/qapi-schema/enum-dict-member-invalid.out   | 0
>  tests/qapi-schema/enum-dict-member-invalid2.err  | 1 +
>  tests/qapi-schema/enum-dict-member-invalid2.exit | 1 +
>  tests/qapi-schema/enum-dict-member-invalid2.json | 2 ++
>  tests/qapi-schema/enum-dict-member-invalid2.out  | 0
>  tests/qapi-schema/enum-if-invalid.err            | 1 +
>  tests/qapi-schema/enum-if-invalid.exit           | 1 +
>  tests/qapi-schema/enum-if-invalid.json           | 3 +++
>  tests/qapi-schema/enum-if-invalid.out            | 0
>  13 files changed, 16 insertions(+)
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid.err
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid.exit
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid.json
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid.out
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.err
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.exit
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.json
>  create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.out
>  create mode 100644 tests/qapi-schema/enum-if-invalid.err
>  create mode 100644 tests/qapi-schema/enum-if-invalid.exit
>  create mode 100644 tests/qapi-schema/enum-if-invalid.json
>  create mode 100644 tests/qapi-schema/enum-if-invalid.out
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a9f0ddbe01..0aa532f029 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -443,6 +443,9 @@ qapi-schema +=3D empty.json
>  qapi-schema +=3D enum-bad-name.json
>  qapi-schema +=3D enum-bad-prefix.json
>  qapi-schema +=3D enum-clash-member.json
> +qapi-schema +=3D enum-dict-member-invalid.json
> +qapi-schema +=3D enum-dict-member-invalid2.json
> +qapi-schema +=3D enum-if-invalid.json
>  qapi-schema +=3D enum-int-member.json
>  qapi-schema +=3D enum-member-case.json
>  qapi-schema +=3D enum-missing-data.json
> diff --git a/tests/qapi-schema/enum-dict-member-invalid.err b/tests/qapi-=
schema/enum-dict-member-invalid.err
> new file mode 100644
> index 0000000000..d12cca0df3
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-invalid.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/enum-dict-member-invalid.json:2: Dictionary member of =
enum 'MyEnum' must have a 'name' key
> diff --git a/tests/qapi-schema/enum-dict-member-invalid.exit b/tests/qapi=
-schema/enum-dict-member-invalid.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-invalid.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/enum-dict-member-invalid.json b/tests/qapi=
-schema/enum-dict-member-invalid.json
> new file mode 100644
> index 0000000000..9cf8406867
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-invalid.json
> @@ -0,0 +1,2 @@
> +# we reject any enum member that is not a string or a dict with 'name'
> +{ 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
> diff --git a/tests/qapi-schema/enum-dict-member-invalid.out b/tests/qapi-=
schema/enum-dict-member-invalid.out
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/enum-dict-member-invalid2.err b/tests/qapi=
-schema/enum-dict-member-invalid2.err
> new file mode 100644
> index 0000000000..f7dc1a2b33
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-invalid2.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/enum-dict-member-invalid2.json:2: Dictionnary has unkn=
own keys: bad-key (allowed: name, if)
> diff --git a/tests/qapi-schema/enum-dict-member-invalid2.exit b/tests/qap=
i-schema/enum-dict-member-invalid2.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-invalid2.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/enum-dict-member-invalid2.json b/tests/qap=
i-schema/enum-dict-member-invalid2.json
> new file mode 100644
> index 0000000000..6664c59201
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-invalid2.json
> @@ -0,0 +1,2 @@
> +# we reject any enum member that is not a string or a dict with 'name'
> +{ 'enum': 'MyEnum', 'data': [ { 'name': 'foo', 'bad-key': 'str' } ] }
> diff --git a/tests/qapi-schema/enum-dict-member-invalid2.out b/tests/qapi=
-schema/enum-dict-member-invalid2.out
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/en=
um-if-invalid.err
> new file mode 100644
> index 0000000000..54c3cf887b
> --- /dev/null
> +++ b/tests/qapi-schema/enum-if-invalid.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a strin=
g or a list of strings
> diff --git a/tests/qapi-schema/enum-if-invalid.exit b/tests/qapi-schema/e=
num-if-invalid.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/enum-if-invalid.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/enum-if-invalid.json b/tests/qapi-schema/e=
num-if-invalid.json
> new file mode 100644
> index 0000000000..60bd0ef1d7
> --- /dev/null
> +++ b/tests/qapi-schema/enum-if-invalid.json
> @@ -0,0 +1,3 @@
> +# check invalid 'if' type
> +{ 'enum': 'TestIfEnum', 'data':
> +  [ 'foo', { 'name' : 'bar', 'if': { 'val': 'foo' } } ] }
> diff --git a/tests/qapi-schema/enum-if-invalid.out b/tests/qapi-schema/en=
um-if-invalid.out
> new file mode 100644
> index 0000000000..e69de29bb2

These tests are related to the coverage gap I mentioned in my review of
PATCH 19.

I think it makes sense to add related new tests together, right when we
add whatever they test.
