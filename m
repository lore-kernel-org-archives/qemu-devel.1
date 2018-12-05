Received: from eggs.gnu.org ([2001:4830:134:3::10]:43181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUUgt-0003Ny-SS
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUUgp-0004r8-PB
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:46:03 -0500
Date: Wed, 5 Dec 2018 11:45:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181205114547.6d1f2c2d.cohuck@redhat.com>
In-Reply-To: <874lbs2y8e.fsf@dusky.pond.sub.org>
References: <20181204172535.2799-1-armbru@redhat.com>
	<ae25db42-74e7-0870-46f8-7def27e5cf43@redhat.com>
	<874lbs2y8e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>, qemu-riscv@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>, Palmer Dabbelt <palmer@sifive.com>, Alex Williamson <alex.williamson@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 05 Dec 2018 09:07:13 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> > On 12/4/18 11:25 AM, Markus Armbruster wrote:  
> >> Clean up includes so that osdep.h is included first and headers
> >> which it implies are not included manually.
> >>
> >> This commit was created with scripts/clean-includes, with the changes
> >> to the following files manually reverted:

(...)

> >>      target/s390x/gen-features.c

(..)

> target/s390x/gen-features.c is a standalone program that is compiled in
> a way that breaks when we include osdep.h.  If that's fixable, fixing it
> would be nice.  Aside: not sure I'd have written this in C.

Yes, that file is a bit of an oddball. Might make sense to add a
comment there that it is standalone, so you can find that out without
looking at the Makefile. I don't think rewriting this to something else
is worth the effort.
