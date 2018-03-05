Received: from eggs.gnu.org ([2001:4830:134:3::10]:59316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1espdO-0002Fx-8B
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1espdK-0000zn-DA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:54:30 -0500
Date: Mon, 5 Mar 2018 13:54:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305135414.11681139.cohuck@redhat.com>
In-Reply-To: <20180228195320.165230-1-borntraeger@de.ibm.com>
References: <20180228195320.165230-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of
 IPL clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>

On Wed, 28 Feb 2018 19:53:20 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> When a guests reboots with diagnose 308 subcode 3 it requests the memory
> to be cleared. We did not do it so far. This does not only violate the
> architecture, it also misses the chance to free up that memory on
> reboot, which would help on host memory over commitment.  By using
> ram_block_discard_range we can cover both cases.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

So, this needs more thought (and additional kernel changes)? (Trying to
pick up patches that make sense for 2.12.)
