Received: from eggs.gnu.org ([209.51.188.92]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoB0-0004DL-T7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoAx-0005am-Lh
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:00:02 -0500
Date: Tue, 8 Jan 2019 10:59:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108105946.5fdd8e38.cohuck@redhat.com>
In-Reply-To: <20190107193020.21744-2-ehabkost@redhat.com>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: Eliminate
 SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org

On Mon,  7 Jan 2019 17:30:18 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The macro is only used in one place, where the purpose of the
> value is obvious.  Eliminate the macro so we don't need to rely
> on stringify().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/pci-host/spapr.h | 1 -
>  hw/ppc/spapr.c              | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
