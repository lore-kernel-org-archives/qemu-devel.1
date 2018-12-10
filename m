Received: from eggs.gnu.org ([2001:4830:134:3::10]:41082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gWNOD-0003SC-Ma
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gWNOA-0005hw-IM
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:22:33 -0500
Date: Mon, 10 Dec 2018 16:22:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181210162219.7edcc6a9.cohuck@redhat.com>
In-Reply-To: <20181210120436.30522-1-peter.maydell@linaro.org>
References: <20181210120436.30522-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/virtio-ccw.c: Don't take address
 of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

On Mon, 10 Dec 2018 12:04:36 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
> 
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci
> (with a couple of long lines manually wrapped).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, applied.
