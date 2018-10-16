Received: from eggs.gnu.org ([2001:4830:134:3::10]:42217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gCSSR-0007t5-Vj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gCSSO-0007SW-OG
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:44:35 -0400
Date: Tue, 16 Oct 2018 18:44:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181016184425.67efdfdb.cohuck@redhat.com>
In-Reply-To: <20181016115817.14605-1-cohuck@redhat.com>
References: <20181016115817.14605-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: report correct error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 16 Oct 2018 13:58:17 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> If ioctl(..., VFIO_DEVICE_RESET) fails, we want to report errno
> instead of ret (which is always -1 on error).
> 
> Fixes Coverity issue CID 1396176.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/vfio/ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued to s390-next.
