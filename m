Received: from eggs.gnu.org ([209.51.188.92]:45512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtEW1-0002Xu-Q4
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtEVz-0003Yx-Kl
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:05 -0500
Date: Mon, 11 Feb 2019 17:13:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211171354.40be0856.cohuck@redhat.com>
In-Reply-To: <1981d9bc-e950-62ef-d2d2-66a17771c8f4@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190206150016.6fdfaf8f.cohuck@redhat.com>
	<1981d9bc-e950-62ef-d2d2-66a17771c8f4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 8 Feb 2019 16:19:58 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 02/06/2019 09:00 AM, Cornelia Huck wrote:
> > On Wed, 30 Jan 2019 14:22:06 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> [This is the Linux kernel part, git tree is available at
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3  
> > 
> > I've pushed out the changes I've made so far (patch 1) to
> > vfio-ccw-eagain-caps-v3.5. I'll wait a bit for more comments before
> > sending a new version.
> >   
> 
> Thanks for that branch...  For patch 1 in v3.5:
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Thanks!

> 
> >>
> >> The companion QEMU patches are available at
> >> https://github.com/cohuck/qemu vfio-ccw-caps
> >> This is the previously posted v2 version, which should continue to work.]  
> > 
> > I would not mind if somebody looked at those as well :)  
> 
> Not precluding anyone else from doing so :) ... I'd planned on looking 
> at them as I get into the meat of patches 4-6 on the kernel side, where 
> the overlap occurs.  I'm getting close.  :)

Cool :) I'll wait a bit more before resending, then. (I'll probably
rebase the QEMU side as well when I do resend.)

> 
> FWIW, I've been running with both series for the last week or two, along 
> with some host kernel traces to prove things got executed the way I 
> thought, and it's seemed to be working well.  So that makes me 
> optimistic for the later patches.

That's good news, thanks for testing. Do you have a special test load
that you run in the guest that you can share?
