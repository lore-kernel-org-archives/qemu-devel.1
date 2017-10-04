Received: from eggs.gnu.org ([2001:4830:134:3::10]:58418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzkAk-00038u-Cq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzkAh-0001MA-8r
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:57:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzkAh-0001LD-2N
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:57:11 -0400
Date: Wed, 4 Oct 2017 15:57:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004155700.33813921.cohuck@redhat.com>
In-Reply-To: <20171004105751.24655-1-borntraeger@de.ibm.com>
References: <20171004105751.24655-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] s390/z14: extended TOD-clock support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed,  4 Oct 2017 12:57:49 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The last last remaining z14 item on my queue.

So the really last one? :)

> 
> v1->v2:
> - split patches
> - fix white spaces (also fixup kvm_s390_set_clock)
> - single phrase error message
> - use strerror
> 
> Collin L. Walling (2):
>   s390/kvm: Support for get/set of extended TOD-Clock for guest
>   s390/kvm: make TOD setting failures fatal for migration
> 
>  hw/s390x/s390-virtio-ccw.c |  7 ++-----
>  target/s390x/cpu.c         | 26 +++++++++++++++++++-------
>  target/s390x/kvm-stub.c    | 10 ++++++++++
>  target/s390x/kvm.c         | 35 ++++++++++++++++++++++++++++++++++-
>  target/s390x/kvm_s390x.h   |  2 ++
>  5 files changed, 67 insertions(+), 13 deletions(-)
> 

Thanks, applied.
