Received: from eggs.gnu.org ([209.51.188.92]:58375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgDN-00019A-Bv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgDM-0006qO-3j
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:30:37 -0500
Date: Mon, 21 Jan 2019 18:30:23 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121203022.GK17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-13-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-13-crosa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/18] Boot Linux Console Test: add a test
 for mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Jan 17, 2019 at 01:56:22PM -0500, Cleber Rosa wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
> board and verify the serial is working.  Also, it relies on the serial
> device set by the machine itself.
>=20
> If mips is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips" tags.
>=20
> Alternatively, this test can be run using:
>=20
>     $ avocado run -t arch:mips tests/acceptance
>     $ avocado run -t machine:malta tests/acceptance
>     $ avocado run -t endian:big tests/acceptance
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  .travis.yml                            |  2 +-
>  scripts/qemu.py                        |  1 -
>  tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>=20
{...}
>=20

--=20
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
