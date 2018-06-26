Received: from eggs.gnu.org ([2001:4830:134:3::10]:49889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXpQS-0007Zt-Im
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXpQO-00026k-Ok
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:58:36 -0400
Date: Tue, 26 Jun 2018 16:58:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626165828.7c6fb093.cohuck@redhat.com>
In-Reply-To: <20180626123830.18282-1-borntraeger@de.ibm.com>
References: <20180626123830.18282-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/cpumodel: default enable bpb and
 ppa15 for z196 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Tue, 26 Jun 2018 14:38:30 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Most systems and host kernels provide the necessary building blocks for
> bpb and ppa15. We can reverse the logic and default enable those
> features, while still allowing to disable it via cpu model.
> 
> So let us add bpb and ppa15 to z196 and later default CPU model for the
> qemu 3.0 machine. (like -cpu z13).  Older machine types (e.g.
> s390-ccw-virtio-2.12) will retain the old value and not provide those
> bits in the default model.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  | 2 ++
>  target/s390x/gen-features.c | 2 ++
>  2 files changed, 4 insertions(+)

Thanks, applied.
