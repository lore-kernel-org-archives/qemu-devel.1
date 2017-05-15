Received: from eggs.gnu.org ([2001:4830:134:3::10]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAETZ-0001Ml-4e
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAETW-0006Pl-1l
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:47:45 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:43298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAETV-0006PS-S3
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:47:41 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6BF271DE9F
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:47:40 +0200 (CEST)
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484836649.20089.8174753739169885859.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27242b95-b09a-c83d-6245-ea910fef9878@kaod.org>
Date: Mon, 15 May 2017 13:47:30 +0200
MIME-Version: 1.0
In-Reply-To: <149484836649.20089.8174753739169885859.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] spapr: fix error path of required
 kernel-irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 05/15/2017 01:39 PM, Greg Kurz wrote:
> QEMU should exit if the user explicitely asked for kernel-irqchip suppo=
rt
> and "xics-kvm" initialization fails.
>=20
> The changelog of commit 34f2af3d3edf ("spapr: Clean up misuse of qdev_i=
nit()
> in xics-kvm creation") reads:
>=20
>     While there, improve the error message when we can't satisfy an
>     explicit user request for "xics-kvm", and exit(1) instead of abort(=
).
>     Simplify the abort when we can't create "xics".
>=20
> This patch adds the missing call to exit().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abfb99b71b7d..f477d7b8a210 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -133,6 +133,7 @@ static void xics_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
>              error_reportf_err(err,
>                                "kernel_irqchip requested but unavailabl=
e: ");
> +            exit(EXIT_FAILURE);
>          } else {
>              error_free(err);
>          }
>=20
