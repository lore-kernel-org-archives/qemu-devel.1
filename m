Received: from eggs.gnu.org ([209.51.188.92]:51551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hMTFx-0000Hx-Tk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hMTFw-0006uj-1q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:09:20 -0400
Date: Fri, 3 May 2019 10:09:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190503100912.468652e7.cohuck@redhat.com>
In-Reply-To: <20190502155516.12415-1-cohuck@redhat.com>
References: <20190502155516.12415-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/ipl: cast to SCSIDevice directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.ibm.com>

On Thu,  2 May 2019 17:55:16 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Coverity notes that the result of object_dynamic_cast() to
> SCSIDevice is not checked in s390_gen_initial_iplp(); as
> we know that we always have a SCSIDevice in that branch,
> we can instead cast via SCSI_DEVICE directly.
> 
> Coverity: CID 1401098
> Fixes: 44445d8668f4 ("s390 vfio-ccw: Add bootindex property and IPLB data")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/ipl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Queued to s390-next.
