Received: from eggs.gnu.org ([2001:4830:134:3::10]:44001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eDXVw-00055M-7K
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 10:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eDXVt-0004xe-1y
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 10:16:08 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eDXVs-0004ws-ON
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 10:16:04 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 17D90CA5A1
	for <qemu-devel@nongnu.org>; Sat, 11 Nov 2017 16:16:03 +0100 (CET)
Date: Sat, 11 Nov 2017 16:15:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171111161554.11776904@bahia.lan>
In-Reply-To: <20171110152017.24324-2-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 01/11] spapr: add pseries 2.12
 machine type
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

On Fri, 10 Nov 2017 15:20:07 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d682f013d422..a2dcbee07214 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3687,6 +3687,20 @@ static const TypeInfo spapr_machine_info =3D {
>      type_init(spapr_machine_register_##suffix)
> =20
>  /*
> + * pseries-2.12
> + */
> +static void spapr_machine_2_12_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_2_12_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> +
> +/*
>   * pseries-2.11
>   */
>  static void spapr_machine_2_11_instance_options(MachineState *machine)
> @@ -3698,7 +3712,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      /* Defaults for the latest behaviour inherited from the base class */
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> +DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> =20
>  /*
>   * pseries-2.10
