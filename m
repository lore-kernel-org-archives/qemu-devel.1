Received: from eggs.gnu.org ([2001:4830:134:3::10]:40560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo7oD-0005L6-EH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo7oA-0000kj-6L
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:18:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eo7oA-0000kc-18
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:18:10 -0500
References: <20180209195239.16048-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79e56725-80cb-699a-8f2f-d53428b41021@redhat.com>
Date: Tue, 20 Feb 2018 14:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180209195239.16048-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] cpus: single-threaded TCG CPU
 creation improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 09/02/2018 20:52, David Hildenbrand wrote:
> While looking into CPU hotplug for s390x TCG, I noticed that
> single-threaded TCG does not properly inititalize CPUs > 1. Fix this
> and cleanup the code a bit.
> 
> David Hildenbrand (3):
>   cpus: properly inititalize CPU > 1 under single-threaded TCG
>   cpus: wait for CPU creation at central place
>   cpus: CPU threads are always created initially for one CPU only
> 
>  cpus.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 

Queued, thanks.

Paolo
