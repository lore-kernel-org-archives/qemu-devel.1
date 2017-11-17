Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eFbjo-00078M-45
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eFbjk-0002rc-Vu
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:11:00 -0500
Date: Fri, 17 Nov 2017 09:10:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171117091049.4c584ea5.cohuck@redhat.com>
In-Reply-To: <20171116182335.7168a489.cohuck@redhat.com>
References: <20171116170526.12643-1-david@redhat.com>
	<20171116182335.7168a489.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 0/3] s390x: fixes for SIGP and
 DIAG 308
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Thu, 16 Nov 2017 18:23:35 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 16 Nov 2017 18:05:23 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
> > First one also applies to KVM SIGP handling. The other two only
> > apply to TCG (allowing to IPL from disk with more than 1 VCPU- I
> > never tested that before).
> > 
> > David Hildenbrand (3):
> >   s390x: fix storing CPU status (again)
> >   s390x/tcg: fix DIAG 308 with > 1 VCPU (single threaded TCG)
> >   s390x/tcg: fix DIAG 308 with > 1 VCPU (MTTCG)
> > 
> >  target/s390x/diag.c        | 4 ----
> >  target/s390x/helper.c      | 2 +-
> >  target/s390x/misc_helper.c | 2 ++
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >   
> 
> Thanks, queued to s390-fixes.

Patch 2 still needs discussion, I think. I'll dequeue it again and
leave 1 + 3.

Comments?
