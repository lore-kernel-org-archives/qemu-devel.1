Received: from eggs.gnu.org ([2001:4830:134:3::10]:34748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1ew4Zr-0000Zg-Eu
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1ew4Zo-0000v6-8k
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:28:15 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:46064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1ew4Zn-0000ug-TL
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:28:12 -0400
Received: by mail-lf0-x241.google.com with SMTP id h127-v6so4189106lfg.12
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 04:28:11 -0700 (PDT)
Date: Wed, 14 Mar 2018 21:28:00 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20180314212800.000022dc@gmail.com>
In-Reply-To: <406abf99-4311-f08d-9f61-df72a9a3ef05@redhat.com>
References: <cover.1520867740.git.x1917x@gmail.com>
	<6067bc3c91c9ee629a35723dfb474ef168ff4ebf.1520867955.git.x1917x@gmail.com>
	<406abf99-4311-f08d-9f61-df72a9a3ef05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On Wed, 14 Mar 2018 11:48:46 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

>On 12/03/2018 19:33, Alexey Gerasimenko wrote:
>> xen_pci_slot_get_pirq --> xen_cmn_pci_slot_get_pirq
>> xen_piix3_set_irq     --> xen_cmn_set_irq  
>
>Don't abbrvt names, xen_hvm_ is a better prefix.

Agree, will rename xen_cmn_* to xen_hvm_*

>> +                    fprintf(stderr, "WARNING: guest domain
>> attempted to use PIRQ%c "
>> +                            "routing which is not supported for
>> Xen/Q35 currently\n",
>> +                            (char)(address - ICH9_LPC_PIRQE_ROUT +
>> 'E'));  
>
>Use error_report instead.

OK, will change to error_report().
There are multiple fprintf(stderr,...)'s still left in the file though,
an additional cleanup patch to replace all such instances to
error_report() calls might be needed later.
