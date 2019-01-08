Received: from eggs.gnu.org ([209.51.188.92]:35161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoEp-0005Qw-3I
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoEm-00052K-Si
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:03:58 -0500
Date: Tue, 8 Jan 2019 11:03:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108110338.60749ad6.cohuck@redhat.com>
In-Reply-To: <20190107193020.21744-3-ehabkost@redhat.com>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Eliminate unnecessary
 stringify() usage
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

On Mon,  7 Jan 2019 17:30:19 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> stringify() is useful when we need to use macros in compat_props
> (like when we set virtio-baloon-pci.class=PCI_CLASS_MEMORY_RAM at
> pc_i440fx_1_0_machine_options()), but it is pointless when we are
> already providing a number literal.
> 
> Replace stringify() with string literals when appropriate.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c |  8 ++--
>  hw/i386/pc.c      | 94 +++++++++++++++++++++++------------------------
>  hw/i386/pc_piix.c | 30 +++++++--------
>  hw/ppc/spapr.c    |  2 +-
>  4 files changed, 67 insertions(+), 67 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
