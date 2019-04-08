Received: from eggs.gnu.org ([209.51.188.92]:39322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hDXkm-0004wE-8M
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hDXkl-0005Wj-6Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:08:16 -0400
Date: Mon, 8 Apr 2019 19:07:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190408190747.12e3618b.cohuck@redhat.com>
In-Reply-To: <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 8 Apr 2019 13:02:12 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 03/01/2019 04:38 AM, Cornelia Huck wrote:
> > When we get a solicited interrupt, the start function may have
> > been cleared by a csch, but we still have a channel program
> > structure allocated. Make it safe to call the cp accessors in
> > any case, so we can call them unconditionally.
> > 
> > While at it, also make sure that functions called from other parts
> > of the code return gracefully if the channel program structure
> > has not been initialized (even though that is a bug in the caller).
> > 
> > Reviewed-by: Eric Farman<farman@linux.ibm.com>
> > Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> > ---  
> 
> Hi Connie,
> 
> My series of fixes for vfio-ccw depends on this patch as I would like to 
> call cp_free unconditionally :) (I had developed my code on top of your 
> patches).
> 
> Could we pick this patch up as well when/if you pick up my patch series? 
> I am in the process of sending out a v2.
> 
> Regarding this patch we could merge it as a stand alone patch, separate 
> from this series. And also the patch LGTM
> 
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

Actually, I wanted to ask how people felt about merging this whole
series for the next release :) It would be one thing less on my plate...
