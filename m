Received: from eggs.gnu.org ([2001:4830:134:3::10]:56332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fiecd-0004qC-9L
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 07:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fieca-0000W9-9z
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 07:39:55 -0400
Date: Thu, 26 Jul 2018 13:39:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180726133945.25994294.cohuck@redhat.com>
In-Reply-To: <20180725143617.8731-1-mimu@linux.ibm.com>
References: <20180725143617.8731-1-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodel: enum type S390FeatGroup
 now gets generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com

On Wed, 25 Jul 2018 16:36:17 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> The enumeration type S390FeatGroup is now generated as well.
> This shall simplify the definition of new feature groups
> without the requirement to modify existing code.

So can we expect new feature groups soon? :)

> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  target/s390x/cpu_features.c |  1 -
>  target/s390x/cpu_features.h | 19 +------------------
>  target/s390x/gen-features.c | 18 +++++++++++++++++-
>  3 files changed, 18 insertions(+), 20 deletions(-)

Thanks, applied.
