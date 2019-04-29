Received: from eggs.gnu.org ([209.51.188.92]:47537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL8pZ-000839-EY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL8pY-0001YO-HW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:08:37 -0400
Date: Mon, 29 Apr 2019 18:08:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190429180817.540c2f82.cohuck@redhat.com>
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/9] s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On Mon, 29 Apr 2019 05:02:41 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Adding gen15.
> 
> v2->v3: - merge  deprecation patch into gen 15 patch
> 	- fix comments
> 	- use gen15a and gen15b instead of cpuid
> v1->v2: - rework csske deprecation
> 	- white space fixes
> 	- also require msa4 for msa9
> 
> Christian Borntraeger (9):
>   linux header sync

I think we can do that sync once the companion kernel series hits the
kvm next branch.

>   s390x/cpumodel: ignore csske for expansion
>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
>   s390x/cpumodel: msa9 facility

This seems to be the only patch that does not yet have a R-b from David
-- David, do you plan to review this one as well?

>   s390x/cpumodel: vector enhancements
>   s390x/cpumodel: enhanced sort facility
>   s390x/cpumodel: add Deflate-conversion facility
>   s390x/cpumodel: add gen15 defintions
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
> 
>  linux-headers/asm-s390/kvm.h    |   5 +-
>  target/s390x/cpu_features.c     |  54 ++++++++++++++++
>  target/s390x/cpu_features.h     |   3 +
>  target/s390x/cpu_features_def.h |  49 +++++++++++++++
>  target/s390x/cpu_models.c       |  13 ++--
>  target/s390x/gen-features.c     | 105 ++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c              |  18 ++++++
>  7 files changed, 242 insertions(+), 5 deletions(-)
> 

Only thing I noticed were some minor typos in some commit messages, I
can fix up while applying.
