Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ebSVW-0001Sz-TL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ebSVU-0002n0-9G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:46:34 -0500
Message-ID: <1516113980.3278.1.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 16 Jan 2018 15:46:20 +0100
In-Reply-To: <20180116135459.GN30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, paulus@ozlabs.org, qemu-devel@nongnu.org

On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
> > Correct me if I'm wrong, but it seems to me like there's no way
> > to figure out through QMP whether these new machine options can be
> > used for a given QEMU binary.
> 
> Uh, I don't think so.  These are machine options like any other (just
> constructed a bit differently).  So they'll appear in qemu -machine
> pseries,? and I believe that info can also be retrieved with QMP.

Yes, they will indeed show up in the output of -machine pseries,?
but there's AFAICT no way to retrieve them via QMP. And libvirt
can't afford to spawn a QEMU process for each machine type
implemented by each QEMU binary installed on the system just to
figure out what properties they support; in fact, we've been
pushing away from that approach - which was used initially - for
years and we're now at the point where we only fall back to it
for positively ancient QEMU versions. So the information needs
to be available through QMP for libvirt to consume it.

-- 
Andrea Bolognani / Red Hat / Virtualization
