Received: from eggs.gnu.org ([2001:4830:134:3::10]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRM80-0005kd-Ki
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRM7u-0007R1-ST
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:01:04 -0500
Date: Mon, 26 Nov 2018 20:00:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181126200051.0e634899.cohuck@redhat.com>
In-Reply-To: <fb3c895c-3e3a-8588-5fee-85910840a794@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<fb3c895c-3e3a-8588-5fee-85910840a794@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 26 Nov 2018 13:57:06 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> > [This is the Linux kernel part, git tree is available at
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps
> > 
> > The companion QEMU patches are available at
> > https://github.com/cohuck/qemu vfio-ccw-caps]
> > 
> > Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> > device. This tends to work well for the most common 'good path' scenarios;
> > however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> > clearing pending requests at the device is currently not supported.
> > This may be a problem for e.g. error recovery.
> > 
> > This patch series introduces capabilities (similar to what vfio-pci uses)
> > and exposes a new async region for handling hsch/csch.
> > 
> > Very lightly tested (I can interact with a dasd as before; I have not
> > found a reliable way to trigger hsch/csch in the Linux dasd guest driver.)
> >   
> 
> I was able to trigger the guest DASD driver to issue a csch instruction, 
> and from my brief testing it seems to be working just like it would on 
> the LPAR. (I basically tested with 2 threads trying to issue DASD device 
> reserve and release ioctls, on the same DASD device, in a busy loop).
> 
> I am going to spend some time doing a deeper review.

Cool, thanks a lot!
