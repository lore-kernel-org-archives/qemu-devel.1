Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diKaT-0005gA-Ha
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diKaO-0000LP-Jf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diKaO-0000L1-Cf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:11:44 -0400
Date: Thu, 17 Aug 2017 15:11:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817151134.612bcb0e.cohuck@redhat.com>
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 00/10] target/s390x: cleanup
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On Thu, 17 Aug 2017 11:22:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> cpu.h is accessed outside of target/s390x. It should only contain
> what is expected to be accessed outside of this folder. Therefore, create
> internal.h and move a lot to that file. In addition, introduce
> kvm-stub.c and kvm_390x.h for kvm specific functions.
> 
> Let's see what compilers think about this version.

It seems they like it :)

> 
> RFC -> v1:
> - (hopefully) fixed a compile error
> - move some functions from cpu.h to the only c file they are used in
> - move kvm function and stubs to kvm_s390x.h and kvm-stub.c
> - smaller requested style fixes
> 
> 
> David Hildenbrand (10):
>   target/s390x: move cc_name() to cc_helper.c
>   target/s390x: move cpu_mmu_idx_to_asc() to excp_helper.c
>   target/s390x: move psw_key_valid() to mem_helper.c
>   target/s390x: move s390_do_cpu_reset() to diag.c
>   target/s390x: move get_per_in_range() to misc_helper.c
>   target/s390x: introduce internal.h
>   target/s390x: move a couple of functions to cpu.c
>   s390x: avoid calling kvm_ functions outside of target/s390x/
>   s390x/kvm: move KVM declarations and stubs to separate files
>   target/s390x: cleanup cpu.h

Generally, this looks good. I'll probably apply patches 1-8. For patch
9, I'll wait for an update (no need to resend the whole series). Still
undecided about patch 10.
