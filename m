Received: from eggs.gnu.org ([2001:4830:134:3::10]:46815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMbEJ-0003lI-Qe
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMbEF-00072H-HL
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:07:55 -0500
Date: Tue, 13 Nov 2018 17:07:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181113170740.10117067.cohuck@redhat.com>
In-Reply-To: <20181113121710.18490-1-david@redhat.com>
References: <20181113121710.18490-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: properly fail if the zPCI
 device cannot be created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 13 Nov 2018 13:17:10 +0100
David Hildenbrand <david@redhat.com> wrote:

> Right now, errors during realize()/pre_plug/plug of the zPCI device
> would result in QEMU crashing instead of failing nicely when creating
> a zPCI device for a PCI device.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> - Fix setting of "target" property (key and value was inverted)
> 
>  hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Thanks, queued to s390-fixes.
