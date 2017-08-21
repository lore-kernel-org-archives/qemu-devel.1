Received: from eggs.gnu.org ([2001:4830:134:3::10]:39646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djkfN-0005Io-Is
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djkfH-0006Ms-89
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djkfH-0006KQ-1o
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:14:39 -0400
Date: Mon, 21 Aug 2017 13:14:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821131430.6e9f5a86.cohuck@redhat.com>
In-Reply-To: <8b3324b0-525f-2c2a-eeb0-95192db9f86f@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-9-david@redhat.com>
	<20170821120844.32b69bda.cohuck@redhat.com>
	<8b3324b0-525f-2c2a-eeb0-95192db9f86f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 08/18] target/s390x: move
 gtod_*() declarations to s390-virtio.h
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

On Mon, 21 Aug 2017 13:05:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.08.2017 12:08, Cornelia Huck wrote:

> > In s390-virtio.c, the only thing used outside of s390-virtio-ccw.c is
> > s390_cpuaddr2state(), and the only place that uses it for something
> > other than getting a dummy cpu is the kvm sigp target code. Can we
> > replace that last usage with a different construct?  
> 
> As CPUs are stored in s390-virtio.c (S390CPU **cpu_states) this is not
> possible. We could only get access to cpu #x via qom /machine/cpu[#x],
> but I guess that won't have best performance :)
> 
> We could move that definition into the machine state (which would make
> sense, as the cpus belong to a machine).

The machine state looks like a better place than s390-virtio.c.

> 
> > 
> > In s390-virtio.h, the s390_register_virtio_hypercall() interface is the
> > only thing that still makes sense to be exported.
> >   
> 
> Anyhow, I would prefer to have these cleanups in a separate series.
> Nevertheless they make perfect sense.

This is certainly material for a different series :) Just thought I'd
write down what I noticed.
