Received: from eggs.gnu.org ([2001:4830:134:3::10]:40863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRDA5-0007zB-UV
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRDA1-0001Q9-Cr
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:26:37 -0500
Date: Mon, 26 Nov 2018 10:26:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181126102623.0f8e9d3d.cohuck@redhat.com>
In-Reply-To: <20181124220757.43560d50@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181124220757.43560d50@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 0/3] vfio-ccw: support
 hsch/csch (kernel part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Sat, 24 Nov 2018 22:07:57 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 22 Nov 2018 17:54:29 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > [This is the Linux kernel part, git tree is available at
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git
> > vfio-ccw-caps
> > 
> > The companion QEMU patches are available at
> > https://github.com/cohuck/qemu vfio-ccw-caps]
> > 
> > Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> > device. This tends to work well for the most common 'good path'
> > scenarios; however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU,
> > things like clearing pending requests at the device is currently not
> > supported. This may be a problem for e.g. error recovery.
> > 
> > This patch series introduces capabilities (similar to what vfio-pci
> > uses) and exposes a new async region for handling hsch/csch.  
> 
> I'm on vacation and could not do more than skim over it real quick. FWIW
> it looks very promising. I intend to give it an in depth review once I'm
> back (i.e. second half of next week).

Thanks!

Please do not feel pressured, it did take me long enough to get this
out :)
