Received: from eggs.gnu.org ([2001:4830:134:3::10]:38975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eE8x2-0003OH-Jj
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eE8wz-0004jC-Eu
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eE8wz-0004io-98
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:14:33 -0500
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
Date: Mon, 13 Nov 2017 08:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171110152017.24324-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QEMU 3.0 ? (was: [PATCH for-2.12 v3 01/11] spapr: add
 pseries 2.12 machine type)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>

On 10.11.2017 16:20, C=C3=A9dric Le Goater wrote:
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
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
> +    /* Defaults for the latest behaviour inherited from the base class=
 */
> +}
> +
> +DEFINE_SPAPR_MACHINE(2_12, "2.12", true);

By the way, before everybody now introduces "2.12" machine types ... is
there already a consensus that the next version will be "2.12" ?

A couple of months ago, we discussed that we could maybe do a 3.0 after
2.11, e.g. here:

 https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html

I'd still like to see that happen... Peter, any thoughts on this?

 Thomas
