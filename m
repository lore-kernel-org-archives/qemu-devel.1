Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diJC5-00021V-Bh
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diJC2-0001kn-7T
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:42:33 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diJC2-0001kh-3J
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:42:30 -0400
Received: by mail-qk0-x243.google.com with SMTP id a77so5762612qkb.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 04:42:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817092225.4264-1-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45abb113-ccb0-8afe-a466-52872ebf7b7f@amsat.org>
Date: Thu, 17 Aug 2017 08:42:25 -0300
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 06:22 AM, David Hildenbrand wrote:
> cpu.h is accessed outside of target/s390x. It should only contain
> what is expected to be accessed outside of this folder. Therefore, create
> internal.h and move a lot to that file. In addition, introduce
> kvm-stub.c and kvm_390x.h for kvm specific functions.
> 
> Let's see what compilers think about this version.
> 
> RFC -> v1:
> - (hopefully) fixed a compile error
> - move some functions from cpu.h to the only c file they are used in
> - move kvm function and stubs to kvm_s390x.h and kvm-stub.c
> - smaller requested style fixes
> 
> 
> David Hildenbrand (10):
>    target/s390x: move cc_name() to cc_helper.c
>    target/s390x: move cpu_mmu_idx_to_asc() to excp_helper.c
>    target/s390x: move psw_key_valid() to mem_helper.c
>    target/s390x: move s390_do_cpu_reset() to diag.c
>    target/s390x: move get_per_in_range() to misc_helper.c
>    target/s390x: introduce internal.h
>    target/s390x: move a couple of functions to cpu.c
>    s390x: avoid calling kvm_ functions outside of target/s390x/
>    s390x/kvm: move KVM declarations and stubs to separate files
>    target/s390x: cleanup cpu.h

for this series but 9 "move KVM declarations and stubs to separate files":

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
