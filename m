Received: from eggs.gnu.org ([209.51.188.92]:53578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gx74Q-0003oz-AR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gx6rQ-0000kz-PE
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:11:13 -0500
References: <20190222081153.14206-1-david@redhat.com>
	<20190222081153.14206-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0dfcafd5-7f73-1beb-929f-de2b66d9ea29@redhat.com>
Date: Fri, 22 Feb 2019 10:09:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190222081153.14206-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 22/02/2019 09.11, David Hildenbrand wrote:
> If we have vector registers and the designation is not zero, we have
> to try to write the vector registers. If the designation is zero or
> if storing fails, we must not indicate validity. s390_build_validity_mcic()
> automatically already sets validity if the vector instruction facility
> is installed.
> 
> As long as we don't support the guarded-storage facility, the alignemnt &
> size of the area is always 1024 bytes.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 46 ++++++++++++++++++++++++++++++++++++--
>  target/s390x/internal.h    |  4 +++-
>  2 files changed, 47 insertions(+), 3 deletions(-)

Looks also sane to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
