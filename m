Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fY6US-0004vP-Qo
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fY6UR-0000Th-Gp
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:11:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fY6UR-0000Ri-Am
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:11:51 -0400
Date: Wed, 27 Jun 2018 11:11:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180627111143.32651114.cohuck@redhat.com>
In-Reply-To: <20180626204312-mutt-send-email-mst@kernel.org>
References: <20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
	<20180622214259-mutt-send-email-mst@kernel.org>
	<CADGSJ22e=Sa8S-HqM4XtOa6ngBKPL73SiQRPh8PUzQgRaie5oA@mail.gmail.com>
	<20180623003022-mutt-send-email-mst@kernel.org>
	<CADGSJ22oFhP955cuTmMWeSt0UOsG5K1A--c34QUSMx5z3Up2SA@mail.gmail.com>
	<20180623012934-mutt-send-email-mst@kernel.org>
	<CADGSJ21HNd4VYNcCt4H0gJ_CCx1GUFpHrDof2N=4WqhD24Zc2A@mail.gmail.com>
	<20180626170813.4db094a1.cohuck@redhat.com>
	<20180626204312-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Tue, 26 Jun 2018 20:50:20 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 26, 2018 at 05:08:13PM +0200, Cornelia Huck wrote:
> > On Fri, 22 Jun 2018 17:05:04 -0700
> > Siwei Liu <loseweigh@gmail.com> wrote:
> >   
> > > On Fri, Jun 22, 2018 at 3:33 PM, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > > > I suspect the diveregence will be lost on most users though
> > > > simply because they don't even care about vfio. They just
> > > > want things to go fast.    
> > > 
> > > Like Jason said, VF isn't faster than virtio-net in all cases. It
> > > depends on the workload and performance metrics: throughput, latency,
> > > or packet per second.  
> > 
> > So, will it be guest/admin-controllable then where the traffic flows
> > through? Just because we do have a vf available after negotiation of
> > the feature bit, it does not necessarily mean we want to use it? Do we
> > (the guest) even want to make it visible in that case?  
> 
> I think these ideas belong to what Alex Duyck wanted to do:
> some kind of advanced device that isn't tied to
> any network interfaces and allows workload and performance
> specific tuning.
> 
> Way out of scope for a simple failover, and more importantly,
> no one is looking at even enumerating the problems involved,
> much less solving them.

So, for simplicity's sake, we need to rely on the host admin
configuring the vm for its guest's intended use case. Sounds fair, but
probably needs a note somewhere.
