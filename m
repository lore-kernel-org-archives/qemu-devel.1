Received: from eggs.gnu.org ([209.51.188.92]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Uwu-0003eX-IM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Uqt-0004QM-W4
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:01:06 -0400
Date: Mon, 11 Mar 2019 20:00:48 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190312000048.klac35tbrousl32w@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-10-crosa@redhat.com>
	<540075f0-5217-db8e-e4b0-36849bb7738d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <540075f0-5217-db8e-e4b0-36849bb7738d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/20] Boot Linux Console Test: update
 the x86_64 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>

On Sat, Mar 02, 2019 at 10:42:13PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/21/19 1:57 AM, Cleber Rosa wrote:
> > To the stock Fedora 29 kernel, from the Fedora 28.  New tests will be
>=20
> [Update] to ... ?
>

Right... I used this line as a continuation of the commit title,
but probably shouldn't have done that.

> > added using the 29 kernel, so for consistency, let's also update it
> > here.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Caio Carrara <ccarrara@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>

Thanks!
- Cleber.

> > ---
> >  tests/acceptance/boot_linux_console.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptanc=
e/boot_linux_console.py
> > index 89df7f6e4f..35b31162d4 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -28,9 +28,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:x86_64
> >          :avocado: tags=3Dmachine:pc
> >          """
> > -        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/=
28/'
> > +        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/=
29/'
> >                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
> > -        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
> > +        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> > =20
> >          self.vm.set_machine('pc')
> >=20
