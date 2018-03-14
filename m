Received: from eggs.gnu.org ([2001:4830:134:3::10]:54305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ew3xx-0006xP-2n
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ew3xu-0000DY-2O
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:49:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ew3xt-0000Co-Tr
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:49:01 -0400
References: <cover.1520867740.git.x1917x@gmail.com>
	<6067bc3c91c9ee629a35723dfb474ef168ff4ebf.1520867955.git.x1917x@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <406abf99-4311-f08d-9f61-df72a9a3ef05@redhat.com>
Date: Wed, 14 Mar 2018 11:48:46 +0100
MIME-Version: 1.0
In-Reply-To: <6067bc3c91c9ee629a35723dfb474ef168ff4ebf.1520867955.git.x1917x@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/30] pc/xen: Xen Q35 support: provide
 IRQ handling for PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Gerasimenko <x1917x@gmail.com>, xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On 12/03/2018 19:33, Alexey Gerasimenko wrote:
> xen_pci_slot_get_pirq --> xen_cmn_pci_slot_get_pirq
> xen_piix3_set_irq     --> xen_cmn_set_irq

Don't abbrvt names, xen_hvm_ is a better prefix.

> 
> +                    fprintf(stderr, "WARNING: guest domain attempted to use PIRQ%c "
> +                            "routing which is not supported for Xen/Q35 currently\n",
> +                            (char)(address - ICH9_LPC_PIRQE_ROUT + 'E'));

Use error_report instead.

Paolo
