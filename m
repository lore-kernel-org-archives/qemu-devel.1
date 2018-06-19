Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVEtZ-0000vd-Vt
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVEtW-0005UA-SO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:33:57 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:40016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVEtW-0005Tl-Ku
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:33:54 -0400
Received: from player763.ha.ovh.net (unknown [10.109.105.21])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D0D8B1094F4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 13:33:52 +0200 (CEST)
Date: Tue, 19 Jun 2018 13:33:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180619133345.2fc58378@bahia.lan>
In-Reply-To: <20180619085631.2859-1-aik@ozlabs.ru>
References: <20180619085631.2859-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] xics-kvm: Fix compile
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 19 Jun 2018 18:56:31 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This fixes uninitialized variable warning:
>=20
> /home/aik/p/qemu/hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_sta=
te=E2=80=99:
> /home/aik/p/qemu/hw/intc/xics_kvm.c:281:20: warning: =E2=80=98ret=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
>              return ret;
>                     ^~~
>=20
> Discovered with gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0 from Ubuntu 18.04.
>=20
> Fixes: bf358b541b8 "xics_kvm: use KVM helpers"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

Already fixed and present in David's last pull req:

https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg00682.html

>  hw/intc/xics_kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 8bdf6af..48efbce 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -273,8 +273,8 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
>                  state |=3D KVM_XICS_QUEUED;
>          }
> =20
> -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                          i + ics->offset, &state, true, &local_err);
> +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURC=
ES,
> +                                i + ics->offset, &state, true, &local_er=
r);
>          if (local_err) {
>              error_report("Unable to restore KVM interrupt controller sta=
te"
>                      " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
