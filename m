Received: from eggs.gnu.org ([209.51.188.92]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gx7xJ-0001Ek-E5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gx7xI-0004ED-Fk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:21:21 -0500
Date: Fri, 22 Feb 2019 11:20:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190222112053.11ebfab5.cohuck@redhat.com>
In-Reply-To: <20190222081153.14206-4-david@redhat.com>
References: <20190222081153.14206-1-david@redhat.com>
	<20190222081153.14206-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] s390x/tcg: Save vregs to extended
 mchk save area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 22 Feb 2019 09:11:53 +0100
David Hildenbrand <david@redhat.com> wrote:

> If we have vector registers and the designation is not zero, we have
> to try to write the vector registers. If the designation is zero or
> if storing fails, we must not indicate validity. s390_build_validity_mcic()
> automatically already sets validity if the vector instruction facility
> is installed.
> 
> As long as we don't support the guarded-storage facility, the alignemnt &
> size of the area is always 1024 bytes.

s/alignemnt & size/alignment and size/

Can change while applying.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 46 ++++++++++++++++++++++++++++++++++++--
>  target/s390x/internal.h    |  4 +++-
>  2 files changed, 47 insertions(+), 3 deletions(-)
