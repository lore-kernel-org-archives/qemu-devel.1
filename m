Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzaeJ-0004fa-8Q
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzaeF-0002h9-Vu
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:47:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzaeF-0002es-Mq
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:47:03 -0400
Date: Wed, 4 Oct 2017 00:46:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004034657.GH4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<a418ab36b8beecb9df9886b283c6bbedaf94bb68.1507059418.git.alistair.francis@xilinx.com>
	<20171003203956.GE4760@localhost.localdomain>
	<CAKmqyKN-ABwyryZvHpWHpS9Kuaqy2ZSvdDoXSku2eBskLc8EBA@mail.gmail.com>
	<a5ffa7ef-af03-7d63-5428-f78ad8a9339b@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a5ffa7ef-af03-7d63-5428-f78ad8a9339b@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 5/5] raspi: : Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Oct 03, 2017 at 07:18:44PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 10/03/2017 06:36 PM, Alistair Francis wrote:
> > On Tue, Oct 3, 2017 at 1:39 PM, Eduardo Habkost <ehabkost@redhat.com>=
 wrote:
> >> On Tue, Oct 03, 2017 at 01:05:18PM -0700, Alistair Francis wrote:
> >>> List all possible valid CPU options.
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >>> ---
> >>>
> >>>  hw/arm/raspi.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> >>> index 5941c9f751..555db0f258 100644
> >>> --- a/hw/arm/raspi.c
> >>> +++ b/hw/arm/raspi.c
> >>> @@ -158,6 +158,10 @@ static void raspi2_init(MachineState *machine)
> >>>      setup_boot(machine, 2, machine->ram_size - vcram_size);
> >>>  }
> >>>
> >>> +const char *raspi2_valid_cpus[] =3D { ARM_CPU_TYPE_NAME("cortex-a7=
"),
> >>> +                                    NULL
> >>> +                                  };
> >>> +
> >>>  static void raspi2_machine_init(MachineClass *mc)
> >>>  {
> >>>      mc->desc =3D "Raspberry Pi 2";
> >>> @@ -169,5 +173,7 @@ static void raspi2_machine_init(MachineClass *m=
c)
> >>>      mc->max_cpus =3D BCM2836_NCPUS;
> >>>      mc->default_ram_size =3D 1024 * 1024 * 1024;
> >>>      mc->ignore_memory_transaction_failures =3D true;
> >>> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> >>> +    mc->valid_cpu_types =3D raspi2_valid_cpus;
> >>
> >> I'm confused: bcm2836_init() is hardcoded to cortex-a15, not
> >> cortex-a7.
> >=20
> > Odd. I just looked up the Raspberry Pi 2 and it says a Cortex-A7:
> > https://www.raspberrypi.org/products/raspberry-pi-2-model-b/
>=20
> The BCM2836 SoC definitively is Cortex-A7.
>=20
> git history says the A7 was added after (dcf578ed8cec) the raspi2 board
> (bad5623690b1).

Shouldn't we update TYPE_BCM2836 to use cpu_type instead of
cortex-a15 before applying this patch, then?

>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> >=20
> > Thanks,
> > Alistair
> >=20
> >>
> >>>  };
> >>>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> >>> --
> >>> 2.11.0
> >>>
> >>
> >> --
> >> Eduardo

--=20
Eduardo
