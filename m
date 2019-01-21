Received: from eggs.gnu.org ([209.51.188.92]:58507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgDs-0001WY-J8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgDq-0007Pc-PA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:31:08 -0500
Date: Mon, 21 Jan 2019 18:20:47 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202045.GC17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-4-crosa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/18] Acceptance tests: improve docstring
 on pick_default_qemu_bin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, Jan 17, 2019 at 01:56:13PM -0500, Cleber Rosa wrote:
> Making it clear what is returned by this utility function.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index 1e54fd5932..d8d5b48dac 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -27,6 +27,10 @@ def pick_default_qemu_bin():
>      """
>      Picks the path of a QEMU binary, starting either in the current wo=
rking
>      directory or in the source tree root directory.
> +
> +    :returns: the path to the default QEMU binary or None if one could=
 not
> +              be found
> +    :rtype: str or None
>      """
>      arch =3D os.uname()[4]
>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
> --=20
> 2.20.1
>=20

--=20
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
