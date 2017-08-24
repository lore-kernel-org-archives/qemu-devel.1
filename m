Received: from eggs.gnu.org ([2001:4830:134:3::10]:56286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkrHX-0005n2-2j
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkrHR-0000NT-PF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkrHR-0000Lg-Ie
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:37 -0400
Date: Thu, 24 Aug 2017 14:30:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824143025.51e1f5cd.cohuck@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 00/18] target/s390x: cleanup
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
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Fri, 18 Aug 2017 13:43:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> ... now featuring even more cleanups.
> 
> cpu.h is accessed outside of target/s390x. It should only contain
> what is expected to be accessed outside of this folder. Therefore, create
> internal.h and move a lot to that file. In addition, introduce
> kvm-stub.c and kvm_390x.h for kvm specific functions.
> 
> Hopefully I haven't messed anything up. This now also compiles with
> --disable-tcg.

Thanks, applied.

The cleanups discussed (cpu-all.h, s390-virtio.[ch]) can be done
separately.
