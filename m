Received: from eggs.gnu.org ([2001:4830:134:3::10]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cpyOH-0006nm-7R
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cpyOD-0002nI-Ap
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cpyOD-0002my-5D
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:34:29 -0400
Date: Mon, 20 Mar 2017 16:34:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170320163316-mutt-send-email-mst@kernel.org>
References: <1488180523-18137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170313160619.28622002@t450s.home>
	<58CFD01F.1060508@cn.fujitsu.com>
	<20170320083056.3f2a5603@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320083056.3f2a5603@t450s.home>
Subject: Re: [Qemu-devel] [PATCH] vfio pci: kernel support of error recovery
 only for non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Mon, Mar 20, 2017 at 08:30:56AM -0600, Alex Williamson wrote:
> > > What about the case where the user has not registered for receiving
> > > non-fatal errors, now we send an error signal on both error_detected
> > > and slot_reset.  Is that useful/desirable?
> > >   
> > 
> > Not desirable, but seems not harmful, guest user will stop anyway. How
> > to avoid this case gracefully seems not easy.
> 
> "Not harmful" is presuming the behavior of the user.  QEMU might not be
> the only consumer of these events.  Is it possible to receive a
> slot_reset without first receiving an error_detected?  If not then we
> can easily track our action for one to decide on the behavior for the
> other.  Thanks,
> 
> Alex

I would just pass maximum info to userspace and let it decide.

-- 
MST
