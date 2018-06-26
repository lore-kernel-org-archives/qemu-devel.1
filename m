Received: from eggs.gnu.org ([2001:4830:134:3::10]:41931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXqfB-0008N1-PI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXqf8-0005HY-K4
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:17:53 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:52038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXqf8-0005Gv-Dr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:17:50 -0400
Received: from player786.ha.ovh.net (unknown [10.109.122.112])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id CD17313C173
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 18:17:48 +0200 (CEST)
Date: Tue, 26 Jun 2018 18:17:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180626181742.248b129f@bahia.lan>
In-Reply-To: <20180626142214.27801-1-clg@kaod.org>
References: <20180626142214.27801-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: fix pnv_core_realize()
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 26 Jun 2018 16:22:14 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> commit d35aefa9ae15 ("ppc/pnv: introduce a new intc_create() operation
> to the chip model") changed the object link in the pnv_core_realize()
> routine but a return was forgotten in case of error, which can lead to
> more problems afterwards (segv)
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a9f129fc2c5f..9750464bf4a1 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -150,6 +150,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      if (!chip) {
>          error_propagate(errp, local_err);
>          error_prepend(errp, "required link 'chip' not found: ");
> +        return;
>      }
> =20
>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
