Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMFld-0007W8-4n
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMFlX-0005K0-Ev
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:12:51 -0500
Date: Mon, 12 Nov 2018 18:12:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181112181222.159680ba.cohuck@redhat.com>
In-Reply-To: <20181105110313.29312-2-david@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/4] s390x/zpci: drop msix.available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

On Mon,  5 Nov 2018 12:03:10 +0100
David Hildenbrand <david@redhat.com> wrote:

> I fail to see why this is useful as we require MSIX always and
> completely fail adding a device.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 --
>  hw/s390x/s390-pci-bus.h | 1 -
>  2 files changed, 3 deletions(-)

Thanks, queued to s390-next.
