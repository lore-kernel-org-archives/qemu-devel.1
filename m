Received: from eggs.gnu.org ([209.51.188.92]:53959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzffc-0001A0-3r
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzffb-0000WC-Dq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:45:36 -0500
Date: Fri, 1 Mar 2019 11:45:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190301114520.13895434.cohuck@redhat.com>
In-Reply-To: <20190221005753.27955-12-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-12-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/20] Boot Linux Console Test: increase
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 20 Feb 2019 19:57:44 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> When running on very low powered environments, some tests may time out
> causing false negatives.  As a conservative change, and for
> considering that human time (investigating false negatives) is worth
> more than some extra machine cycles (and time), let's increase the
> overall timeout.
>=20
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index cc5dcd7373..fa721a7355 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -21,7 +21,7 @@ class BootLinuxConsole(Test):
>      :avocado: enable
>      """
> =20
> -    timeout =3D 60
> +    timeout =3D 90
> =20
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> =20

Not sure what a good value is, but it is easy to tweak later if needed.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
