Received: from eggs.gnu.org ([2001:4830:134:3::10]:37673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzgPE-0002mC-4M
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzgPB-0003sO-39
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzgPA-0003s3-TP
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:55:53 -0400
Date: Wed, 4 Oct 2017 11:55:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004115548.60bfdda2.cohuck@redhat.com>
In-Reply-To: <20171004090032.27365-1-cohuck@redhat.com>
References: <20171004090032.27365-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: sort some devices into categories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On Wed,  4 Oct 2017 11:00:32 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Add missing categorizations for some s390x devices:
> - zpci device -> misc
> - 3270 -> display
> - vfio-ccw -> misc
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/3270-ccw.c     | 1 +
>  hw/s390x/s390-pci-bus.c | 1 +
>  hw/vfio/ccw.c           | 1 +
>  3 files changed, 3 insertions(+)

Queued to s390-next.
