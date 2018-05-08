Received: from eggs.gnu.org ([2001:4830:134:3::10]:34752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG3BN-0008Vd-IH
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG3BH-00049v-W3
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:01:33 -0400
Date: Tue, 8 May 2018 16:01:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508160117.0d6619f2.cohuck@redhat.com>
In-Reply-To: <388a5b5e-7ba1-4510-d2d3-88e2cc32ae94@linux.ibm.com>
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-3-cohuck@redhat.com>
	<388a5b5e-7ba1-4510-d2d3-88e2cc32ae94@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/ccw: make sure all ccw devices
 are properly reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 8 May 2018 15:42:17 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> > Thomas reported that the subchannel for a  3270 device that ended up
> > in a broken state (status pending even though not enabled) did not
> > get out of that state even after a reboot (which involves a subsytem
> > reset). The reason for this is that the 3270 device did not define
> > a reset handler.
> > 
> > Let's fix this by introducing a base reset handler (set up for all
> > ccw devices) that resets the subchannel and have virtio-ccw call
> > its virtio-specific reset procedure in addition to that.
> > 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> The 'all' from the subject is actually 'all except maybe vfio-ccw'
> AFAIU.

Yeah, but as it overwrites the default handler, it's on its own :)

Thanks for your review!
