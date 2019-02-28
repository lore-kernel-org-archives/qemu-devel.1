Received: from eggs.gnu.org ([209.51.188.92]:58508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzNT1-0005VJ-5z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzNSz-0004lG-AZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:19:23 -0500
Date: Thu, 28 Feb 2019 16:19:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190228161914.740b2134@redhat.com>
In-Reply-To: <20190225012530.28225-3-richardw.yang@linux.intel.com>
References: <20190225012530.28225-1-richardw.yang@linux.intel.com>
	<20190225012530.28225-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] CODING_STYLE: indent example code
 as all others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org

On Mon, 25 Feb 2019 09:25:30 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> All the example code are indented with four spaces except this one.
>=20
> Fix this by adding four spaces here.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  CODING_STYLE | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 1bccf4f865..e6d21dcd67 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -137,10 +137,10 @@ block to a separate function altogether.
>  When comparing a variable for (in)equality with a constant, list the
>  constant on the right, as in:
> =20
> -if (a =3D=3D 1) {
> -    /* Reads like: "If a equals 1" */
> -    do_something();
> -}
> +    if (a =3D=3D 1) {
> +        /* Reads like: "If a equals 1" */
> +        do_something();
> +    }
> =20
>  Rationale: Yoda conditions (as in 'if (1 =3D=3D a)') are awkward to read.
>  Besides, good compilers already warn users when '=3D=3D' is mis-typed as=
 '=3D',
