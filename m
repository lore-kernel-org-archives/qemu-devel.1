Received: from eggs.gnu.org ([209.51.188.92]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goosR-0000OV-NL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goosQ-0002q6-PA
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:21:59 -0500
Date: Wed, 30 Jan 2019 13:21:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190130132152.303abf14.cohuck@redhat.com>
In-Reply-To: <38f1205b-7ccf-f8ba-112f-c7c65ab688f4@redhat.com>
References: <1548834906-133241-1-git-send-email-imammedo@redhat.com>
	<20190130104155.08cc0ac9.cohuck@redhat.com>
	<38f1205b-7ccf-f8ba-112f-c7c65ab688f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390x: remove direct reference to
 mem_path global from s390x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Wed, 30 Jan 2019 12:18:44 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 30.01.19 10:41, Cornelia Huck wrote:
> > On Wed, 30 Jan 2019 08:55:06 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> >> I plan to deprecate -mem-path option and replace it with memory-backend,
> >> for that it's necessary to get rid of mem_path global variable.
> >> Do it for s390x case, replacing it with alternative way to enable
> >> 1Mb hugepages capability.
> >>
> >> Todo that replace qemu_mempath_getpagesize() with qemu_getrampagesize()
> >> which also checks for -mem-path provided RAM.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> v4:
> >>   * fix typos in commit message
> >>   * add include "exec/ram_addr.h" to make sure it compiles on ppc host
> >> v2:
> >>   * s/qemu_mempath_getpagesize/qemu_getrampagesiz/ and drop the rest of changes
> >>           David Hildenbrand <david@redhat.com>  
> > 
> > Something odd happened here -- I presume you did not want to drop
> > David's R-b?
> > 
> > [I can re-add while applying, no need to resend.]
> >   
> 
> Indeed, please add
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Done, and applied. Thanks!

> 
> >> ---
> >>  target/s390x/kvm.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)  
> 
> 
