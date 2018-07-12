Received: from eggs.gnu.org ([2001:4830:134:3::10]:39920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fdihQ-0000Rz-4S
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fdihL-0005LR-5L
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:00:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fdihL-0005KR-0j
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:00:23 -0400
Date: Fri, 13 Jul 2018 00:00:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180712235500-mutt-send-email-mst@kernel.org>
References: <20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
	<9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
	<20180710045101-mutt-send-email-mst@kernel.org>
	<CADGSJ20H1S88S6AsYoLMns3XH+YVKh006Dqu808X7Ug+2Mgdnw@mail.gmail.com>
	<20180711115344.633eba9e.cohuck@redhat.com>
	<CADGSJ20A=sbwQQ-_YQEVwoCXwTvosCEnD2iKa0kS6ZGvbgy4rg@mail.gmail.com>
	<20180712133121.3b5f2bae.cohuck@redhat.com>
	<CADGSJ214vdTGC=-hj9pMOTqQNcZ0NaYu_r4cy2=2BB4CausWdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ214vdTGC=-hj9pMOTqQNcZ0NaYu_r4cy2=2BB4CausWdw@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siwei Liu <loseweigh@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>, si-wei liu <si-wei.liu@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Netdev <netdev@vger.kernel.org>

On Thu, Jul 12, 2018 at 01:52:53PM -0700, Siwei Liu wrote:
> The definition is incomplete due to lack of spec. There's no "host"
> part defined yet in the host-guest interface. If match by MAC is an
> interface, the same must be done on the host(device) side as well,
> which has been agreed not the way to go. However, I don't think that's
> what the author intends to do by interpreting his QEMU patch - it
> missed the other parts as well, such as the feature negotiation and
> how it interacts with the paired device.
> 
> What I said is that match by MAC is just a guest implementation that
> one can change at any time. We now have the group ID on QEMU, why
> still sticking to matching by MAC? It shoulnd't be a host-guest
> interface in the first place anyway.

I think that match by MAC is a simple portable way to match devices.
E.g. it will work seamlessly with niche things like zPCI. However
there are other niche use-cases that aren't addressed by match by MAC
such as PF pass-through as a primary, and the pci bridge trick addresses
that at cost of some portability.

So I see no issues supporting both mechanisms, but others on the TC
might feel differently.

-- 
MST
