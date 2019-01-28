Received: from eggs.gnu.org ([209.51.188.92]:54606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goATz-0007jK-FF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goATy-0003QO-Ks
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:14:03 -0500
Date: Mon, 28 Jan 2019 18:13:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128181355.2d79cae7.cohuck@redhat.com>
In-Reply-To: <20190125170404.28c61eab@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190125152154.05120461.cohuck@redhat.com>
	<20190125170404.28c61eab@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Fri, 25 Jan 2019 17:04:04 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> Do we expect userspace/QEMU to fence the bad scenarios as tries to do
> today, or is this supposed to change to hardware should sort out
> requests whenever possible.

Does my other mail answer that?

> The problem I see with the let the hardware sort it out is that, for that
> to work, we need to juggle multiple translations simultaneously (or am I
> wrong?). Doing that does not appear particularly simple to me.

None in the first stage, at most two in the second stage, I guess.

> Furthermore we would go through all that hassle knowingly that the sole
> reason is working around bugs. We still expect our Linux guests
> serializing it's ssch() stuff as it does today. Thus I would except this
> code not getting the love nor the coverage that would guard against bugs
> in that code.

So, we should have test code for that? (Any IBM-internal channel I/O
exercisers that may help?)

We should not rely on the guest being sane, although Linux probably is
in that respect.
