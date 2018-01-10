Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ496-00027D-Ka
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ495-0001YQ-OV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:21:32 -0500
Message-ID: <1515543680.1993.12.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 10 Jan 2018 11:21:20 +1100
In-Reply-To: <b8e59719-0b88-3cab-9d65-491cb35d5e03@linux.vnet.ibm.com>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-2-sjitindarsingh@gmail.com>
	<b8e59719-0b88-3cab-9d65-491cb35d5e03@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 1/3] hw/ppc/spapr_caps:
 Rework spapr_caps to use uint8 internal representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Tue, 2018-01-09 at 09:13 -0200, Murilo Opsfelder Araújo wrote:
> On 01/09/2018 07:21 AM, Suraj Jitindar Singh wrote:
> > Currently spapr_caps are tied to boolean values (on or off). This
> > patch
> > reworks the caps so that they can have any value between 0 and 127,
> > inclusive. This allows more capabilities with various values to be
> > represented in the same way internally. Capabilities are numbered
> > in
> > ascending order. The internal representation of capability values
> > is an
> > array of uint8s in the sPAPRMachineState, indexed by capability
> > number.
> > Note: The MSB (0x80) of a capability is reserved to track whether
> > the
> >       capability was set from the command line.
> > 
> > Capabilities can have their own name, description, options, getter
> > and
> > setter functions, type and allow functions. They also each have
> > their own
> > section in the migration stream. Capabilities are only migrated if
> > they
> > were explictly set on the command line, with the assumption that
> > otherwise the default will match.
> > 
> > On migration we ensure that the capability value on the destination
> > is greater than or equal to the capability value from the source.
> > So
> > long at this remains the case then the migration is considered
> > compatible and allowed to continue.
> > 
> > This patch implements generic getter and setter functions for
> > boolean
> > capabilities. It also converts the existings cap-htm, cap-vsx and
> > cap-dfp capabilities to this new format.
> 
> Hi, Suraj.
> 
> I've got the impression that this patch does a lot of things. What
> about
> splitting this patch into the following?
> 
> - rename spapr_has_cap() -> spapr_get_cap()
> - introduce each spapr_cap_[gs]et_bool() in separate patches
> - make use of spapr_cap[gs]et_bool()
> - convert capabilities internal representation to uint8
> - add each new capability separately

Absolutely. This was an RFC to get the code out there for comment.
I'll try to split it up further as suggested for the actual patch
series :)

> 
> Perhaps it can be broken into even smaller changes.
> 
> Cheers
> Murilo
> 
