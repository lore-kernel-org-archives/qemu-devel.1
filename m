Received: from eggs.gnu.org ([208.118.235.92]:48381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gTurR-0000uk-8j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gTurQ-0001YD-Cn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:30:33 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Mon, 3 Dec 2018 20:30:18 +0000
Message-ID: <20181203203003.GA5549@quinoa.localdomain>
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-9-aaron@os.amperecomputing.com>
	<CAFEAcA_kcjm2F_1h2hRC_wW4hdozCQDzY1RmRTGTkEH+De+-Ag@mail.gmail.com>
In-Reply-To: <CAFEAcA_kcjm2F_1h2hRC_wW4hdozCQDzY1RmRTGTkEH+De+-Ag@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A82AE2FB37C6A84B87DB573DC5DB82D2@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 08/13] target/arm: Add array for
 supported PMU events, generate PMCEID[01]_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On Nov 30 16:14, Peter Maydell wrote:
> On Tue, 20 Nov 2018 at 21:26, Aaron Lindsay
> <aaron@os.amperecomputing.com> wrote:
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 50de58e4a2..32c3397948 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -993,6 +993,16 @@ void pmu_op_finish(CPUARMState *env);
> >  void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
> >  void pmu_post_el_change(ARMCPU *cpu, void *ignored);
> >
> > +/*
> > + * get_pmceid
> > + * @env: CPUARMState
> > + *
> > + * Return the PMCEID[01]_EL0 register values corresponding to the coun=
ters
> > + * which are supported given the current configuration (`which` is 0 o=
r 1 to
> > + * indicate which PMCEID should be returned)
> > + */
>=20
> Nit: you should have a line here below the one for "@env"
> for the "@which" parameter, and the reference to it in
> the text should just be "@which", not "`which`" (or just
> put that description in the line saying what @which is
> rather than having it in a parenthetical).

Thanks, I've fixed this for v9.

-Aaron
