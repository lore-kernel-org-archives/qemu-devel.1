Received: from eggs.gnu.org ([2001:4830:134:3::10]:52645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eK2lf-0006lk-B2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eK2lc-0008O0-9b
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:51:15 -0500
References: <20171128203326.6062-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d43c646d-fd59-12a6-c7a8-7b5dfac0b9de@redhat.com>
Date: Wed, 29 Nov 2017 14:51:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.12 00/15] s390x/tcg:
 cleanup and fix program interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 28.11.2017 21:33, David Hildenbrand wrote:
> I have quite some patches on my queue for 2.12. (booting Fedora 26/27
> guests, floating interrupts, machine checks, missing instructions ...)
>=20
> So let's start slowly :) This series gets rid of program_interrupt() an=
d
> potential_page_fault(). We now always properly restore the cpu state wh=
en
> injecting/delivering a program interrupt. So there is no need to update
> the state via potential_page_fault() anymore.

I think this series is basically a very good idea! But...
OK, this is kind of bike-shed-painting now, but since we're currently in
hard freeze anyway and got plenty of time for discussion:
Something that bothers me a little bit is the name of the new function
"program_interrupt_ra()" ... that would IMHO be OK if the old function
"program_interrupt" would still stay, but since that is removed and the
_ra function is the only generic way that is left to inject a program
interrupt, could we maybe name the new function somewhat nicer right
from the start? Something like "s390_program_interrupt" maybe (which is
similar to tcg_s390_program_interrupt and kvm_s390_program_interrupt
that we have already)?

 Thomas
