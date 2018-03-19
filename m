Received: from eggs.gnu.org ([2001:4830:134:3::10]:37196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1exyi6-0002tU-Vl
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1exyi6-0004kz-6P
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:36:39 -0400
Date: Mon, 19 Mar 2018 13:36:24 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180319173624.GC24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-21-git-send-email-alindsay@codeaurora.org>
	<b8b7a898-b714-3563-7f7a-84374db2b283@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b8b7a898-b714-3563-7f7a-84374db2b283@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 20/22] target/arm: PMU: Add
 instruction and cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On Mar 18 23:48, Philippe Mathieu-Daud=E9 wrote:
> On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> > The instruction event is only enabled when icount is used, cycles are
> > always supported. Always defining get_cycle_count (but altering its
> > behavior depending on CONFIG_USER_ONLY) allows us to remove some
> > CONFIG_USER_ONLY #defines throughout the rest of the code.
> >=20
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> [...]>  #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
> >  static const pm_event pm_events[] =3D {
> > +#ifndef CONFIG_USER_ONLY
> > +    { .number =3D 0x008, /* INST_RETIRED */
>=20
> "Instruction architecturally executed" seems more explicit to me.

I've updated v4 to include this wording as well.

> > +      .supported =3D instructions_supported,
> > +      .get_count =3D instructions_get_count
> > +    },
> > +    { .number =3D 0x011, /* CPU_CYCLES */
> > +      .supported =3D event_always_supported,
> > +      .get_count =3D cycles_get_count
> > +    },
> > +#endif
> [...]

-Aaron

--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies=
, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
