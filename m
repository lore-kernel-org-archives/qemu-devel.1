Received: from eggs.gnu.org ([2001:4830:134:3::10]:54442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNF5S-0006Um-TR
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNF5P-0006qe-PR
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:36:54 -0500
Date: Fri, 8 Dec 2017 10:36:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171208103645.5e0467d5.cohuck@redhat.com>
In-Reply-To: <20171207153141.15523-3-david@redhat.com>
References: <20171207153141.15523-1-david@redhat.com>
	<20171207153141.15523-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 2/5] s390x/tcg: fix and cleanup
 mcck injection
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

On Thu,  7 Dec 2017 16:31:38 +0100
David Hildenbrand <david@redhat.com> wrote:

> The architecture mode indication wasn't stored. The split of certain
> 64bit fields was unnecessary. Also, the complete clock comparator, not
> just bit 0-55 (starting at byte 1) was stored.
> 
> We now generate a proper MCIC via the same helper we use for KVM.
> 
> There is be more to clean up, but we will change the other parts later on

s/is be/is/

> either way.

No surprise as I had no idea what I was doing when I initially wrote
this :)

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 12 ++++++------
>  target/s390x/internal.h    |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
