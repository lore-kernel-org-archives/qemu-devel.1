Received: from eggs.gnu.org ([2001:4830:134:3::10]:60961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKnPC-0001sN-7p
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKnOT-0004ZC-EQ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:39:10 -0500
Date: Fri, 1 Dec 2017 16:38:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171201163814.3e010e1c.cohuck@redhat.com>
In-Reply-To: <20171130162744.25442-1-david@redhat.com>
References: <20171130162744.25442-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12 00/16] s390x/tcg: cleanup and
 fix program interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Thu, 30 Nov 2017 17:27:28 +0100
David Hildenbrand <david@redhat.com> wrote:

> I have quite some patches on my queue for 2.12. (booting Fedora 26/27
> guests, floating interrupts, machine checks, missing instructions ...)
> 
> So let's start slowly  This series gets rid of program_interrupt() and
> potential_page_fault(). We now always properly restore the cpu state when
> injecting/delivering a program interrupt. So there is no need to update
> the state via potential_page_fault() anymore.
> 
> In addition, handling for program interrupts comming via
> s390_cpu_virt_mem_rw() was missing something for the TCG case. Also fixed.

Thanks, queued to s390-next.
