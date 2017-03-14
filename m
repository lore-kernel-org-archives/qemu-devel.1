Received: from eggs.gnu.org ([2001:4830:134:3::10]:48776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni17-0002ri-68
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni16-0007RF-2E
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:41:17 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cni15-0007QT-Mo
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:41:15 -0400
Received: by mail-lf0-x242.google.com with SMTP id y193so13552056lfd.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-9-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:41:03 +0000
Message-ID: <CAJ+F1CLXbGE7nngODenZiRa+611fsT4JCE84mGPkm4sREifnkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 08/47] tests/qapi-schema: Cover
 empty union base
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

On Mon, Mar 13, 2017 at 10:19 AM Markus Armbruster <armbru@redhat.com>
wrote:

> The new test case shows off qapi.py choking on an empty union base.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/Makefile.include                  |  1 +
>  tests/qapi-schema/union-base-empty.err  | 10 ++++++++++
>  tests/qapi-schema/union-base-empty.exit |  1 +
>  tests/qapi-schema/union-base-empty.json |  9 +++++++++
>  tests/qapi-schema/union-base-empty.out  |  0
>  5 files changed, 21 insertions(+)
>  create mode 100644 tests/qapi-schema/union-base-empty.err
>  create mode 100644 tests/qapi-schema/union-base-empty.exit
>  create mode 100644 tests/qapi-schema/union-base-empty.json
>  create mode 100644 tests/qapi-schema/union-base-empty.out
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 736dd15..9f4e890 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -470,6 +470,7 @@ qapi-schema +=3D unclosed-list.json
>  qapi-schema +=3D unclosed-object.json
>  qapi-schema +=3D unclosed-string.json
>  qapi-schema +=3D unicode-str.json
> +qapi-schema +=3D union-base-empty.json
>  qapi-schema +=3D union-base-no-discriminator.json
>  qapi-schema +=3D union-branch-case.json
>  qapi-schema +=3D union-clash-branches.json
> diff --git a/tests/qapi-schema/union-base-empty.err
> b/tests/qapi-schema/union-base-empty.err
> new file mode 100644
> index 0000000..61e6ec6
> --- /dev/null
> +++ b/tests/qapi-schema/union-base-empty.err
> @@ -0,0 +1,10 @@
> +Traceback (most recent call last):
> +  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
> +    schema =3D QAPISchema(sys.argv[1])
> +  File "scripts/qapi.py", line 1483, in __init__
> +    self.exprs =3D check_exprs(parser.exprs)
> +  File "scripts/qapi.py", line 917, in check_exprs
> +    check_union(expr, info)
> +  File "scripts/qapi.py", line 734, in check_union
> +    assert base_members
> +AssertionError
> diff --git a/tests/qapi-schema/union-base-empty.exit
> b/tests/qapi-schema/union-base-empty.exit
> new file mode 100644
> index 0000000..d00491f
> --- /dev/null
> +++ b/tests/qapi-schema/union-base-empty.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/union-base-empty.json
> b/tests/qapi-schema/union-base-empty.json
> new file mode 100644
> index 0000000..d1843d3
> --- /dev/null
> +++ b/tests/qapi-schema/union-base-empty.json
> @@ -0,0 +1,9 @@
> +# Flat union with empty base and therefore without discriminator
> +
> +{ 'struct': 'Empty', 'data': { } }
> +
> +{ 'union': 'TestUnion',
> +  'base': 'Empty',
> +  'discriminator': 'type',
> +  'data': { 'value1': 'int',
> +            'value2': 'str' } }
> diff --git a/tests/qapi-schema/union-base-empty.out
> b/tests/qapi-schema/union-base-empty.out
> new file mode 100644
> index 0000000..e69de29
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
