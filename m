Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drWYI-0001f3-JR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drWYD-0004hY-LR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drWYD-0004gS-C5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:47:29 -0400
Date: Mon, 11 Sep 2017 17:47:27 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1827777248.5103399.1505166447511.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170911213328.9701-4-f4bug@amsat.org>
References: <20170911213328.9701-1-f4bug@amsat.org>
	<20170911213328.9701-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] tcg: move tcg-runtime to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, "Richard Henderson" <rth@twidd=
le.net>, "Peter Crosthwaite"
> <crosthwaite.peter@gmail.com>, "Thomas Huth" <thuth@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>, qemu-devel@nongnu.or=
g
> Sent: Monday, September 11, 2017 11:33:26 PM
> Subject: [PATCH v2 3/5] tcg: move tcg-runtime to accel/tcg/
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

To make this better, the "#ifndef CONFIG_SOFTMMU" part at the
end of this should be moved to user-exec.c.  Feel free to just
post a sixth patch for it.

Paolo

> ---
>  Makefile.target                  | 2 +-
>  {tcg =3D> accel/tcg}/tcg-runtime.h | 0
>  {tcg =3D> accel/tcg}/tcg-runtime.c | 0
>  accel/tcg/Makefile.objs          | 1 +
>  4 files changed, 2 insertions(+), 1 deletion(-)
>  rename {tcg =3D> accel/tcg}/tcg-runtime.h (100%)
>  rename {tcg =3D> accel/tcg}/tcg-runtime.c (100%)
>=20
> diff --git a/Makefile.target b/Makefile.target
> index 520305b025..6361f957fb 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -94,7 +94,7 @@ all: $(PROGS) stap
>  obj-y +=3D exec.o
>  obj-y +=3D accel/
>  obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
> -obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/tcg-runtime.o
> +obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D disas/tci.o
>  obj-y +=3D fpu/softfloat.o
> diff --git a/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> similarity index 100%
> rename from tcg/tcg-runtime.h
> rename to accel/tcg/tcg-runtime.h
> diff --git a/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> similarity index 100%
> rename from tcg/tcg-runtime.c
> rename to accel/tcg/tcg-runtime.c
> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
> index f2422d0fb3..228cd84fa4 100644
> --- a/accel/tcg/Makefile.objs
> +++ b/accel/tcg/Makefile.objs
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
>  obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
> +obj-y +=3D tcg-runtime.o
>  obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
>  obj-y +=3D translator.o
> =20
> --
> 2.14.1
>=20
>=20
