Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCNgw-000604-75
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCNgv-0005o7-C6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:34:42 -0500
Date: Wed, 8 Nov 2017 10:34:24 +0000
From: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20171108103416.GA8971@e103592.cambridge.arm.com>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171107150558.22131-7-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 06/10] configure: support CPPFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On Tue, Nov 07, 2017 at 03:05:54PM +0000, Alex Benn=E9e wrote:
> Useful for accessing API's that are still brewing, e.g:
>=20
>   CROSS_PREFIX=3Daarch64-linux-gnu- \
>     CPPFLAGS=3D-I/home/alex/lsrc/qemu/risu.git/sve-headers/include \
>     ../configure
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  README    | 6 ++++++
>  configure | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/README b/README
> index 9946e6e..fbe408d 100644
> --- a/README
> +++ b/README
> @@ -26,6 +26,12 @@ Most useful is
>     need this if you're not building on the target system
>     (Example: CROSS_PREFIX=3Darm-linux-gnueabihf- )
> =20
> +Another useful flag is
> + CPPFLAGS=3D which specified pre-processor flags, usually -I statement=
s
> +   for specifying extra include paths. Use this is you need something

s/is/if/

> +   from new kernel headers not installed on your system.
> +   (Example: CPPFLAGS=3D-I/path/to/sve-kernel-headers/include)
> +

You should probably point out that the path should refer to headers
installed by running 'make headers_install' in the Linux source.  This
means we really test the uapi headers properly, and I don't get spurious
bug reports about bad headers ;)

[...]

Cheers
---Dave
