Received: from eggs.gnu.org ([209.51.188.92]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h171G-00086T-9Q
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h16nR-0001Bo-JC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:55:38 -0500
Date: Tue, 5 Mar 2019 10:55:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190305105528.60d4e4c3.cohuck@redhat.com>
In-Reply-To: <1551775581-27989-1-git-send-email-thuth@redhat.com>
References: <1551775581-27989-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target/s390x: Remove non-architected
 entries from struct LowCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, "Jason J. Herne" <jjherne@linux.ibm.com>

On Tue,  5 Mar 2019 09:46:21 +0100
Thomas Huth <thuth@redhat.com> wrote:

> There are some fields in our struct LowCore which apparently have
> been copied from a very old version of the Linux kernel. These
> fields are not architected in the "Principles of Operation", and
> only used on these memory locations in Linux kernels older than
> 2.6.29. Newer Linux kernels moved the entries to different locations
> or are not using them at all anymore. Thus we should never access
> these fields from the QEMU side, so they should be removed.
> 
> While we're at it, also add a QEMU_BUILD_BUG_MSG() statement to

s/QEMU_BUILD_BUG_MSG/QEMU_BUILD_BUG_ON/ :)

(fixed up while applying)

> assert that struct LowCore has the right size.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Use QEMU_BUILD_BUG_ON instead of QEMU_BUILD_BUG_MSG
> 
>  target/s390x/internal.h | 41 ++---------------------------------------
>  1 file changed, 2 insertions(+), 39 deletions(-)

Thanks, applied.
