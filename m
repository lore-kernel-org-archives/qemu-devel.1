Received: from eggs.gnu.org ([209.51.188.92]:52817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hG09L-000253-LD
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hG09K-0003fN-5z
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:51:47 -0400
Date: Mon, 15 Apr 2019 13:51:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190415135126.2fa9b12b.cohuck@redhat.com>
In-Reply-To: <20190301093902.27799-1-cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/6] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri,  1 Mar 2019 10:38:56 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3
> 
> The companion QEMU patches are available at
> https://github.com/cohuck/qemu vfio-ccw-caps]
> 
> Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> device. This tends to work well for the most common 'good path' scenarios;
> however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> clearing pending requests at the device is currently not supported.
> This may be a problem for e.g. error recovery.
> 
> This patch series introduces capabilities (similar to what vfio-pci uses)
> and exposes a new async region for handling hsch/csch.

One more gentle ping for an ack/r-b for patches 4 and 6.

I could go ahead and merge patches 1-3 and then patches 1+3 of Farhan's
series, but I'd really like to merge patches 4-6 as well so I can later
merge the QEMU part after a headers update to 5.2-rc...
