Received: from eggs.gnu.org ([209.51.188.92]:38911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gz8Qx-0005K5-A0
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gz8Qw-0005rt-9a
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:16:15 -0500
Message-ID: <1551309360.2210.16.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 28 Feb 2019 10:16:00 +1100
In-Reply-To: <20190227061611.GB6872@umbus.fritz.box>
References: <20190227043008.12059-1-sjitindarsingh@gmail.com>
	<20190227061611.GB6872@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v2 1/4] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org

On Wed, 2019-02-27 at 17:16 +1100, David Gibson wrote:
> On Wed, Feb 27, 2019 at 03:30:05PM +1100, Suraj Jitindar Singh wrote:
> > Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
> > availability of the large decrementer for a guest.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> This series looks good now, except for one nit...
> 
> > ---
> >  hw/ppc/spapr.c         |  2 ++
> >  hw/ppc/spapr_caps.c    | 17 +++++++++++++++++
> >  include/hw/ppc/spapr.h |  5 ++++-
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index b6a571b6f1..acf62a2b9f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2077,6 +2077,7 @@ static const VMStateDescription vmstate_spapr
> > = {
> >          &vmstate_spapr_irq_map,
> >          &vmstate_spapr_cap_nested_kvm_hv,
> >          &vmstate_spapr_dtb,
> > +        &vmstate_spapr_cap_large_decr,
> >          NULL
> >      }
> >  };
> > @@ -4288,6 +4289,7 @@ static void
> > spapr_machine_class_init(ObjectClass *oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /*
> > 64kiB */
> >      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =
> > SPAPR_CAP_OFF;
> > +    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
> 
> ... since this is now a boolean, it should use SPAPR_CAP_OFF /
> SPAPR_CAP_ON instead of bare 0 and 1.

True, do you want me to fix-up and resend? Or can you fix it when you
apply?

> 
