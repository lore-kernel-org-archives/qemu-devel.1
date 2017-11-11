Received: from eggs.gnu.org ([2001:4830:134:3::10]:39427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eDX7O-0000n2-1c
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 09:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eDX7K-0003ta-5f
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 09:50:46 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:53769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eDX7J-0003ri-VM
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 09:50:42 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E3E83CAE75
	for <qemu-devel@nongnu.org>; Sat, 11 Nov 2017 15:50:32 +0100 (CET)
Date: Sat, 11 Nov 2017 15:50:19 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171111155019.3771a379@bahia.lan>
In-Reply-To: <20171110152017.24324-3-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 02/11] ppc/xics: remove useless
 if condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 10 Nov 2017 15:20:08 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The previous code section uses a 'first < 0' test and returns. Therefore,
> there is no need to test the 'first' variable against '>=3D 0' afterwards.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/xics_spapr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index d98ea8b13068..e8c0a1b3e903 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -329,10 +329,8 @@ int spapr_ics_alloc_block(ICSState *ics, int num, bo=
ol lsi,
>          return -1;
>      }
> =20
> -    if (first >=3D 0) {
> -        for (i =3D first; i < first + num; ++i) {
> -            ics_set_irq_type(ics, i, lsi);
> -        }
> +    for (i =3D first; i < first + num; ++i) {
> +        ics_set_irq_type(ics, i, lsi);
>      }
>      first +=3D ics->offset;
> =20
