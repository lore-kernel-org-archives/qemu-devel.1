Received: from eggs.gnu.org ([209.51.188.92]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Uwq-0003gZ-M9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Uup-0005dd-22
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:05:07 -0400
Date: Mon, 11 Mar 2019 20:04:55 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190312000455.36rxgzw4tg32kunu@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-12-crosa@redhat.com>
	<e459358e-6d37-49b4-26a1-ace252c33248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e459358e-6d37-49b4-26a1-ace252c33248@redhat.com>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>

On Sat, Mar 02, 2019 at 10:43:52PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/21/19 1:57 AM, Cleber Rosa wrote:
> > When running on very low powered environments, some tests may time ou=
t
> > causing false negatives.  As a conservative change, and for
> > considering that human time (investigating false negatives) is worth
> > more than some extra machine cycles (and time), let's increase the
> > overall timeout.
>=20
> However this is annoying when a test is stuck and you work on battery..=
.
>

I agree, but at this point, the more we try to fix all use cases, the
furthest we get to something reasonable IMO.

Any ideas on how to do better here while still keeping things simple?

- Cleber.

> >=20
> > CC: Alex Benn=E9e <alex.bennee@linaro.org>
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/acceptance/boot_linux_console.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptanc=
e/boot_linux_console.py
> > index cc5dcd7373..fa721a7355 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -21,7 +21,7 @@ class BootLinuxConsole(Test):
> >      :avocado: enable
> >      """
> > =20
> > -    timeout =3D 60
> > +    timeout =3D 90
> > =20
> >      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> > =20
> >=20
