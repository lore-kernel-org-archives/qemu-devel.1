Received: from eggs.gnu.org ([2001:4830:134:3::10]:43529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emN1Q-0006aQ-17
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emN1L-0002Yr-Rs
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:08:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emN1L-0002YZ-Mx
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:08:31 -0500
Date: Thu, 15 Feb 2018 18:08:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180215180812.70dd05f4@redhat.com>
In-Reply-To: <CAFEAcA-AfiDp5Y1MiveFHCZgTKgLPb3Qzu=RdhzNaD0yE4XscA@mail.gmail.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<fa1d4990d897f61dd748ad7f10f6b88435e6cb46.1517532021.git.alistair.francis@xilinx.com>
	<CAFEAcA_T4S8kU5GtatL+1Uos2oqBuYH-=GqhEWm=y3q4TmF+-w@mail.gmail.com>
	<422117c4-4d0b-5db8-9c2a-4e85e2502694@amsat.org>
	<CAFEAcA-AfiDp5Y1MiveFHCZgTKgLPb3Qzu=RdhzNaD0yE4XscA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/6] raspi: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, 15 Feb 2018 13:17:50 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 15 February 2018 at 13:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> > Hi Peter,
> >
> > On 02/15/2018 08:29 AM, Peter Maydell wrote: =20
> >> On 2 February 2018 at 00:42, Alistair Francis
> >> <alistair.francis@xilinx.com> wrote: =20
> >>> List all possible valid CPU options.
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>> ---
> >>>
> >>> V5:
> >>>  - Use cpu_model names
> >>> V4:
> >>>  - Remove spaces
> >>> V3:
> >>>  - Add static property
> >>> V2:
> >>>  - Fix the indentation
> >>>
> >>>  hw/arm/raspi.c | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> >>> index cd5fa8c3dc..745a880726 100644
> >>> --- a/hw/arm/raspi.c
> >>> +++ b/hw/arm/raspi.c
> >>> @@ -158,6 +158,11 @@ static void raspi2_init(MachineState *machine)
> >>>      setup_boot(machine, 2, machine->ram_size - vcram_size);
> >>>  }
> >>>
> >>> +static const char *raspi2_valid_cpus[] =3D {
> >>> +    "cortex-a7",
> >>> +    NULL
> >>> +}; =20
> >>
> >> Is this definitely right? Looking at the code, the raspi2 board
> >> creates a TYPE_BCM2836, and that creates cortex-a15 CPUs... =20
> >
> > The BCM2836 use a cortex-a7 but this cpu was not available at the time
> > of this commit (bad5623690b) and was added later in dcf578ed8ce "The A7
> > is very similar to the A15."
> >
> > I can prepare a patch for it to apply before this series. =20
>=20
> I noticed after I'd written that comment that patch 3 in this
> series does exactly the change to cortex-a7...
anyways this series, needs not to depend MachineState::cpu_model,
removal of which is queued in Eduardo's tree.

It seems we can't find consensus on how to deal with cpu_model names
in boards code [1/6].

>=20
> thanks
> -- PMM
