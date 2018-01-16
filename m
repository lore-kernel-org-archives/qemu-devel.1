Received: from eggs.gnu.org ([2001:4830:134:3::10]:41373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ebRaP-0002Ux-W1
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ebRaK-00033C-EX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:47:34 -0500
Message-ID: <1516110433.10494.5.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 16 Jan 2018 14:47:13 +0100
In-Reply-To: <20180115063235.7518-1-sjitindarsingh@gmail.com>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Mon, 2018-01-15 at 17:32 +1100, Suraj Jitindar Singh wrote:
> The following patch series adds 3 new tristate capabilities and their
> associated handling.
> 
> A new H-Call is implemented which a guest will use to query the
> requirement for and availability of workarounds for certain cpu
> behaviours.
> 
> Applies on top of David's tree: ppc-for-2.12
> 
> The first patch from the previous revision has already been merged:
> hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal representation
> 
> The main changes to V3 are:
> - Split up the addition of the tristate caps into 5 patches
>   - 1/6 query the caps from the hypervisor and parse the new return format
>   - 2/6 add support for the new caps
>   - 3-5/6 add each of the three new caps
> - Patch 6/6 Unchanged

Correct me if I'm wrong, but it seems to me like there's no way
to figure out through QMP whether these new machine options can be
used for a given QEMU binary.

If so, that's very unfortunate because it means that libvirt has
only two options: 1) just use them if the user requests the
corresponding feature, which will lead to older QEMU binaries
simply refusing to start; or 2) perform a version number check,
which will not be accurate if downstream backports are involved.

Would this information be added to the MachineInfo struct, so that
query-machines reports it? Or would a new QMP command be more
appropriate for the task?

Alternatively, if there's any witness we can use instead of an
explicit capability, let me know. But I still think we should
think about a better long-term solution, especially because this
seems to be happening quite frequently lately: see the hpt-resizing
and max-cpu-compat machine properties, which are just as opaque
from an introspection point of view.

Sorry for not bringing this up earlier.

-- 
Andrea Bolognani / Red Hat / Virtualization
