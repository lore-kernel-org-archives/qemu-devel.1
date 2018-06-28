Received: from eggs.gnu.org ([2001:4830:134:3::10]:59467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYaYA-000518-Vl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYaY6-0007Z7-E2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:17:42 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYaY6-0007WY-6p
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:17:38 -0400
Received: by mail-wr0-x244.google.com with SMTP id c5-v6so6276618wrs.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:17:38 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-3-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180622004435.10291-3-f4bug@amsat.org>
Date: Thu, 28 Jun 2018 18:17:35 +0100
Message-ID: <87d0wavnio.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/acceptance: Rename the x86-64
 specific BootLinuxConsole test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 98324f7591..f6a34d75a5 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -13,7 +13,7 @@ import logging
>  from avocado_qemu import Test
>
>
> -class BootLinuxConsole(Test):
> +class BootLinuxConsoleX86_64(Test):
>      """
>      Boots a x86_64 Linux kernel and checks that the console is operation=
al
>      and the kernel command line is properly passed from QEMU to the kern=
el

Not your bug but it also needs to be better at choosing a QEMU to run:

2018-06-28 16:10:24,736 download         L0066 INFO | Fetching https://mirr=
ors.kernel.org/fedora/releases/28/Everything/x86_64/os/images/pxeboot/vmlin=
uz -> /home/alex.bennee/avocado/data/cache/vmlinuz.gqWhs5
2018-06-28 16:10:40,841 qemu             L0268 DEBUG| Error launching VM
2018-06-28 16:10:40,841 qemu             L0270 DEBUG| Command: 'aarch64-sof=
tmmu/qemu-system-aarch64 -chardev socket,id=3Dmon,path=3D/var/tmp/tmpdXbtIA=
/qemu-16646-monitor.sock -mon chardev=3Dmon,mode=3Dcontrol -display none -v=
ga none -machine pc -chardev socket,id=3Dconsole,path=3D/var/tmp/tmpdXbtIA/=
qemu-16646-console.sock,server,nowait -device isa-serial,chardev=3Dconsole =
-kernel /home/alex.bennee/avocado/data/cache/vmlinuz -append console=3DttyS=
0'


--
Alex Benn=C3=A9e
