Received: from eggs.gnu.org ([2001:4830:134:3::10]:46678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzaQu-0002tA-8H
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzaQr-0006v3-4e
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:33:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzaQq-0006up-Uc
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:33:13 -0400
Date: Wed, 4 Oct 2017 00:33:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004033307.GG4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<2a93b997d0acd369f35d68981a23ba491443daf6.1507059418.git.alistair.francis@xilinx.com>
	<20171003203654.GD4760@localhost.localdomain>
	<CAKmqyKN+QnBAS6c4mAb2EiTVQv3Km6EdmGXCFC3hVogL96QK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKN+QnBAS6c4mAb2EiTVQv3Km6EdmGXCFC3hVogL96QK1Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Oct 03, 2017 at 02:41:17PM -0700, Alistair Francis wrote:
> On Tue, Oct 3, 2017 at 1:36 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Oct 03, 2017 at 01:05:13PM -0700, Alistair Francis wrote:
> >> List all possible valid CPU options.
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >> ---
> >>
> >>  hw/arm/xlnx-zcu102.c         | 10 ++++++++++
> >>  hw/arm/xlnx-zynqmp.c         | 16 +++++++++-------
> >>  include/hw/arm/xlnx-zynqmp.h |  1 +
> >>  3 files changed, 20 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> >> index 519a16ed98..039649e522 100644
> >> --- a/hw/arm/xlnx-zcu102.c
> >> +++ b/hw/arm/xlnx-zcu102.c
> >> @@ -98,6 +98,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
> >>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> >>                                &error_abort);
> >>
> >> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> >> +                            &error_fatal);
> >
> > Do you have plans to support other CPU types to xlnx_zynqmp in
> > the future?  If not, I wouldn't bother adding the cpu-type
> > property and the extra boilerplate code if it's always going to
> > be set to cortex-a53.
> 
> No, it'll always be A53.
> 
> I did think of that, but I also wanted to use the new option! I also
> think there is an advantage in sanely handling users '-cpu' option,
> before now we just ignored it, so I think it still does give a
> benefit. That'll be especially important on the Xilinx tree (sometimes
> people use our machines with a different CPU to 'benchmark' or test
> other CPUs with our CoSimulation setup). So I think it does make sense
> to keep in.

I see.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
