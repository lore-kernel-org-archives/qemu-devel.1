Received: from eggs.gnu.org ([209.51.188.92]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmOln-0000ag-Vm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmOln-0007ik-30
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:05:07 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Wed, 23 Jan 2019 20:04:57 +0000
Message-ID: <20190123200459.GE5213@quinoa.localdomain>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<CAFEAcA8Kvx9ATDgj5mOqcJGQf_T-Sw0ut5N6w3CBs9pBA4d1_A@mail.gmail.com>
In-Reply-To: <CAFEAcA8Kvx9ATDgj5mOqcJGQf_T-Sw0ut5N6w3CBs9pBA4d1_A@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7333B513CCAB54798913EE8CEC62CDD@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Jan 18 14:13, Peter Maydell wrote:
> On Tue, 11 Dec 2018 at 15:20, Aaron Lindsay
> <aaron@os.amperecomputing.com> wrote:
> >
> > The ARM PMU implementation currently contains a basic cycle counter, bu=
t
> > it is often useful to gather counts of other events, filter them based
> > on execution mode, and/or be notified on counter overflow. These patche=
s
> > flesh out the implementations of various PMU registers including
> > PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
> > arbitrary counter types, implement mode filtering, send interrupts on
> > counter overflow, and add instruction, cycle, and software increment
> > events.
> >
> > Since v9 [1] I have made the following changes:
> > * Added a clarifying comment about how the PMU timer's migration is
> >   handled
> > * Added a check against implementing PMCEID[23] if ID_DFR0.PerfMon =3D=
=3D
> >   0xf
> > * Added TRACEFILT to the ID_DFR0 field definitions
> >
> > [1] - https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00805.ht=
ml
> >
>=20
> Richard has made some comments on patch 14; since 1-13 have
> all been reviewed now I'm going to apply those to target-arm.next.

Thanks.

I also apologize - I just uncovered a bug I should've caught sooner, and
sent out a fix to the list as:

	Subject: [PATCH] target/arm: Don't clear supported PMU events when
	initializing PMCEID1

-Aaron
