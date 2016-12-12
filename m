Received: from eggs.gnu.org ([2001:4830:134:3::10]:42395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNRZ-0000fd-4b
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNRT-00052H-Qr
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:02:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNRT-00050l-L0
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:02:43 -0500
Date: Mon, 12 Dec 2016 10:02:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212100236.GA15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161210153038.9184-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161210153038.9184-1-maxime.coquelin@redhat.com>
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

On Sat, Dec 10, 2016 at 04:30:35PM +0100, Maxime Coquelin wrote:
> Thanks for the reviews,
> 
> This series implements Virtio spec update from Aaron Conole which
> defines a way for the host to expose its max MTU to the guest.
> 
> "host_mtu" parameter is added to provide QEMU with the MTU value,
> and the backend, if supported, gets notified of the MTU value when the
> MTU feature neogotiation succeeds.
> 
> Only user backend currently supports MTU notification. A new protocol
> feature has been implemented for sending MTU value to the backend.
> 
> For kernel backend, it is expected the management tool also configures
> the tap/macvtap interface with same MTU value.
> Daniel, I would be interrested about your feedback on this implementation
> from management tool point of view.

I can't give real feedback yet, as I'm not seeing clear information on
what problem this series is designed to solve....

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
