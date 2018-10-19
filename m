Received: from eggs.gnu.org ([2001:4830:134:3::10]:45646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDZJF-0005Qe-FX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDZJE-0000a2-KE
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDZJE-0000ZG-DD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:15:40 -0400
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-2-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8328ffc9-a3a0-a66c-7dc7-d19a632d9b2c@redhat.com>
Date: Fri, 19 Oct 2018 14:15:35 -0400
MIME-Version: 1.0
In-Reply-To: <20181013151545.3731-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] tests/acceptance: Rename the
 generic BootLinuxConsole test as test_x86_64_pc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>



On 10/13/18 11:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index ba3ac036da..3aa4dbe5f9 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -15,7 +15,7 @@ from avocado_qemu import Test
> =20
>  class BootLinuxConsole(Test):
>      """
> -    Boots a x86_64 Linux kernel and checks that the console is operati=
onal
> +    Boots a Linux kernel and checks that the console is operational
>      and the kernel command line is properly passed from QEMU to the ke=
rnel
> =20
>      :avocado: enable
> @@ -23,7 +23,7 @@ class BootLinuxConsole(Test):
> =20
>      timeout =3D 60
> =20
> -    def test(self):
> +    def test_x86_64_pc(self):
>          if self.arch !=3D 'x86_64':
>              self.cancel('Currently specific to the x86_64 target arch'=
)
>          kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28=
/'
>=20


This looks right, but given "self.arch" is still not on master, so I'm
holding on to giving the reviewed-by/tested-by.

Question: do you believe a maintainer and/or developer would want to
test specific machine types?
