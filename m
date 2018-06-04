Received: from eggs.gnu.org ([2001:4830:134:3::10]:40926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPnpK-0003iD-9v
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPnpF-0007pp-Dm
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:39:06 -0400
Date: Mon, 4 Jun 2018 13:38:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180604133853.7c0f7933.cohuck@redhat.com>
In-Reply-To: <20180525113708.29856-2-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/7] s390x/tod: factor out TOD into
 separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>

On Fri, 25 May 2018 13:37:02 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's treat this like a separate device. TCG will have to store the
> actual state/time later on.
> 
> Include cpu-qom.h in kvm_s390x.h (due to S390CPU) to compile tod-kvm.c.

Can't you include it in tod-kvm.c instead? Why was it not needed before?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/Makefile.objs     |   3 +
>  hw/s390x/s390-virtio-ccw.c |  57 +-----------------
>  hw/s390x/tod-kvm.c         |  64 ++++++++++++++++++++
>  hw/s390x/tod-qemu.c        |  47 +++++++++++++++
>  hw/s390x/tod.c             | 120 +++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/tod.h     |  46 ++++++++++++++
>  target/s390x/cpu.c         |  32 ----------
>  target/s390x/cpu.h         |   2 -
>  target/s390x/kvm_s390x.h   |   2 +
>  9 files changed, 285 insertions(+), 88 deletions(-)
>  create mode 100644 hw/s390x/tod-kvm.c
>  create mode 100644 hw/s390x/tod-qemu.c
>  create mode 100644 hw/s390x/tod.c
>  create mode 100644 include/hw/s390x/tod.h

Otherwise, looks good.
