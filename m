Received: from eggs.gnu.org ([2001:4830:134:3::10]:40309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fNcRM-00059u-IN
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fNcRH-0006Kz-Mi
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:05:20 -0400
Date: Tue, 29 May 2018 13:04:55 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180529110455.n2hjf5stvwq5lrsh@toto>
References: <20180503115620.10596-1-edgar.iglesias@gmail.com>
	<20180503115620.10596-3-edgar.iglesias@gmail.com>
	<c7409bf9-b336-8df2-bc2a-ace45077bcce@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7409bf9-b336-8df2-bc2a-ace45077bcce@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 2/2] xlnx-zynqmp: Swap
 Cortex-R5 for Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com, qemu-arm@nongnu.org

On Thu, May 10, 2018 at 03:09:46PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Edgar,
>=20
> On 05/03/2018 08:56 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >=20
> > The ZynqMP has Cortex-R5Fs with the optional FPU enabled.
>=20
> What about updating the xlnx-zcu102 machine description too?
>=20
>   mc->desc =3D "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs ..."

Yes, I've added the 'F' in v2 (I've kept the Rb and Tb lines).
Will send v2 in a moment.

Cheers,
Edgar


>=20
> >=20
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> I just noticed we can not get information for the R profile cores via
> the monitor:
>=20
> (qemu) info cpus
> * CPU #0: thread_id=3D19283
>   CPU #1: thread_id=3D19284
>   CPU #2: thread_id=3D19285
>   CPU #3: thread_id=3D19286
>=20
> same with "info registers -a"
>=20
> > ---
> >  hw/arm/xlnx-zynqmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> > index 505253e0d2..efeb53c732 100644
> > --- a/hw/arm/xlnx-zynqmp.c
> > +++ b/hw/arm/xlnx-zynqmp.c
> > @@ -116,7 +116,7 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
> >          char *name;
> > =20
> >          object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
> > -                          "cortex-r5-" TYPE_ARM_CPU);
> > +                          "cortex-r5f-" TYPE_ARM_CPU);
> >          object_property_add_child(OBJECT(s), "rpu-cpu[*]",
> >                                    OBJECT(&s->rpu_cpu[i]), &error_abort=
);
> > =20
> >=20
