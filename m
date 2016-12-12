Received: from eggs.gnu.org ([2001:4830:134:3::10]:34664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNwP-0005OK-IU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNwM-0002cC-EU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNwM-0002bz-8t
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:34:38 -0500
Date: Mon, 12 Dec 2016 10:34:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212103432.GH15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161210153038.9184-1-maxime.coquelin@redhat.com>
	<20161212100236.GA15611@redhat.com>
	<cc475d20-6e77-17ab-b41e-56a6d4bf81b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc475d20-6e77-17ab-b41e-56a6d4bf81b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] virtio-net: Add support to MTU
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, aconole@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, yuanhan.liu@linux.intel.com, fbl@redhat.com, mlureau@redhat.com, ktraynor@redhat.com

On Mon, Dec 12, 2016 at 11:12:56AM +0100, Maxime Coquelin wrote:
> Hi Daniel,
> 
> On 12/12/2016 11:02 AM, Daniel P. Berrange wrote:
> > On Sat, Dec 10, 2016 at 04:30:35PM +0100, Maxime Coquelin wrote:
> > > Thanks for the reviews,
> > > 
> > > This series implements Virtio spec update from Aaron Conole which
> > > defines a way for the host to expose its max MTU to the guest.
> > > 
> > > "host_mtu" parameter is added to provide QEMU with the MTU value,
> > > and the backend, if supported, gets notified of the MTU value when the
> > > MTU feature neogotiation succeeds.
> > > 
> > > Only user backend currently supports MTU notification. A new protocol
> > > feature has been implemented for sending MTU value to the backend.
> > > 
> > > For kernel backend, it is expected the management tool also configures
> > > the tap/macvtap interface with same MTU value.
> > > Daniel, I would be interrested about your feedback on this implementation
> > > from management tool point of view.
> > 
> > I can't give real feedback yet, as I'm not seeing clear information on
> > what problem this series is designed to solve....
> 
> Right, I agree it is missing a bit of context here, I'll add more about
> the background in next revision.
> 
> The goal of this series is to address two things:
> 1. Providing a way for the guests to use the same MTU as the host,
>    in order to have a consistent MTU value across the infrastructure.

Ok, currently libvirt sets the MTU of the tap device based on the MTU
of the device it will be attached to. This change means we need to pass
that MTU value into QEMU via the -netdev command line so it can inform
the guest what the MTU is.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
