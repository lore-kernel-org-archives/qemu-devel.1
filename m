Received: from eggs.gnu.org ([209.51.188.92]:46841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hL7OT-0005SH-K4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hL7OS-0003zG-Q9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1hL7OS-0003yK-K8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:32 -0400
Message-ID: <bce204dbe4349dca7153d9b90904662f3038d183.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 29 Apr 2019 16:36:11 +0200
In-Reply-To: <20190429134757.13570-1-marcandre.lureau@redhat.com>
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, david@gibson.dropbear.id.au

On Mon, 2019-04-29 at 15:47 +0200, Marc-Andr=C3=A9 Lureau wrote:
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
>=20
> Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> use of the sandbox option group to produce a sensible error, it didn't
> do the same for another call to qemu_opts_parse_noisily():
>=20
> (gdb) bt
>     at util/qemu-option.c:829
>  #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffff=
ab5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
>      at util/qemu-option.c:829
>  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized o=
ut>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/q=
emu-option.c:890
>  #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:3589
>=20
> Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> Cc: david@gibson.dropbear.id.au
> Cc: otubo@redhat.com
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  vl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

This fixes the crash for me, so

  Tested-by: Andrea Bolognani <abologna@redhat.com>

--=20
Andrea Bolognani / Red Hat / Virtualization
