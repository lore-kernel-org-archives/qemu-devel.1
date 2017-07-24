Received: from eggs.gnu.org ([2001:4830:134:3::10]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZjeK-0000bk-Ui
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZjeH-0003YM-Oe
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:08:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZjeH-0003Xd-Ax
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:08:13 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-34-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06a5f041-2769-06ab-ef7b-0bbe63c9411a@redhat.com>
Date: Mon, 24 Jul 2017 22:08:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-34-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 33/35] configure: clang does
 not support -Wexpansion-to-defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 24/07/2017 20:27, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 6b52e19ee3..48295aa1e6 100755
> --- a/configure
> +++ b/configure
> @@ -1582,8 +1582,12 @@ gcc_flags=3D"-Wold-style-declaration -Wold-style=
-definition -Wtype-limits"
>  gcc_flags=3D"-Wformat-security -Wformat-y2k -Winit-self -Wignored-qual=
ifiers $gcc_flags"
>  gcc_flags=3D"-Wno-missing-include-dirs -Wempty-body -Wnested-externs $=
gcc_flags"
>  gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
> -gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_fl=
ags"
> +gcc_flags=3D"-Wno-initializer-overrides $gcc_flags"
>  gcc_flags=3D"-Wno-string-plus-int $gcc_flags"
> +# clang does not support -Wexpansion-to-defined
> +if ! echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
> +    gcc_flags=3D"-Wexpansion-to-defined $gcc_flags"
> +fi
>  # Note that we do not add -Werror to gcc_flags here, because that woul=
d
>  # enable it for all configure tests. If a configure test failed due
>  # to -Werror this would just silently disable some features,

Clang 3.9 does.

Paolo
