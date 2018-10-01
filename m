Received: from eggs.gnu.org ([2001:4830:134:3::10]:50998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g6xmO-0004J6-1Q
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g6xmH-0008EB-UL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:58:26 -0400
Date: Mon, 1 Oct 2018 14:58:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181001145809.3ff0e04a.cohuck@redhat.com>
In-Reply-To: <20180928093435.198573-1-frankja@linux.ibm.com>
References: <20180928093435.198573-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: Fence huge pages prior to 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, thuth@redhat.com

On Fri, 28 Sep 2018 11:34:35 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> As the kernel has no way of disallowing the start of a huge page
> backed VM, we can migrate a running huge backed VM to a host that has
> no huge page KVM support.
> 
> Let's glue huge page support support to the 3.1 machine, so we do not
> migrate to a destination host that doesn't have QEMU huge page support
> and can stop migration if KVM doesn't indicate support.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 10 ++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  target/s390x/kvm.c                 |  6 ++++++
>  3 files changed, 19 insertions(+)

Thanks, applied.
