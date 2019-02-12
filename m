Received: from eggs.gnu.org ([209.51.188.92]:60973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtXrJ-00025b-3M
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtXrC-00086X-4N
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:12:21 -0500
Date: Tue, 12 Feb 2019 14:12:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190212141206.599c71a7.cohuck@redhat.com>
In-Reply-To: <20190212112323.15904-1-david@redhat.com>
References: <20190212112323.15904-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x: add zPCI feature to "qemu" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 12 Feb 2019 12:23:23 +0100
David Hildenbrand <david@redhat.com> wrote:

> As we now always have PCI support, let's add it to the "qemu" CPU model,
> taking care of backwards compatibility.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> - Use correct model identifiction of the z12 we emulate
> 
>  hw/s390x/s390-virtio-ccw.c  | 3 +++
>  target/s390x/gen-features.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 

Played around a bit with different machines and cpu models and got what
I expected.

Thanks, applied.
