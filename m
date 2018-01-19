Received: from eggs.gnu.org ([2001:4830:134:3::10]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecVFZ-000053-EL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecVFV-0002EQ-HA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:54:25 -0500
Date: Fri, 19 Jan 2018 12:54:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180119125416.25c1dd7c.cohuck@redhat.com>
In-Reply-To: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: fix storage attributes
 migration for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com

On Thu, 18 Jan 2018 18:51:44 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Fix storage attribute migration so that it does not fail for guests
> with more than a few GB of RAM.
> With such guests, the index in the buffer would go out of bounds,
> usually by large amounts, thus receiving -EFAULT from the kernel.
> Migration itself would be successful, but storage attributes would then
> not be migrated completely.
> 
> This patch fixes the out of bounds access, and thus migration of all
> storage attributes when the guest have large amounts of memory.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")
> ---
>  hw/s390x/s390-stattrib-kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.
