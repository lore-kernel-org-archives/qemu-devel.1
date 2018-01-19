Received: from eggs.gnu.org ([2001:4830:134:3::10]:44582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecVHI-0001AX-2x
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecVHE-0002nT-53
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:56:12 -0500
Date: Fri, 19 Jan 2018 12:56:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180119125600.6941ae46.cohuck@redhat.com>
In-Reply-To: <20180112125452.8569-1-david@redhat.com>
References: <20180112125452.8569-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: fixup TEST PROTECTION
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

On Fri, 12 Jan 2018 13:54:52 +0100
David Hildenbrand <david@redhat.com> wrote:

> CC == 2 can only happen due to a protection exception, not if memory is
> not available (PGM_ADDRESSING). So all PGM_ADDRESSING exceptions have to
> be forwarded to the guest.
> 
> Since the initial definition of TEST PROTECTION, we now read globals
> (e.g. PSW mask), so we have to correctly mark the instruction
> (otherwise, e.g. booting fedora 27 fails).
> 
> Also, the architecture explicitly specifies which exceptions are
> forwarded to the guest, this makes the code a little nicer.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h        |  2 ++
>  target/s390x/helper.h     |  2 +-
>  target/s390x/EM_helper.c | 41 +++++++++++++++++++----------------------
>  3 files changed, 22 insertions(+), 23 deletions(-)

Thanks, applied.
