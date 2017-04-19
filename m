Received: from eggs.gnu.org ([2001:4830:134:3::10]:56093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0lBd-0002k8-1Z
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0lBc-000194-BJ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:42:05 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0lBc-00018X-4o
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:42:04 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w64so74376009wma.0
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 01:42:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170418221724.5707-4-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-4-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Apr 2017 09:41:42 +0100
Message-ID: <CAFEAcA_Ky5SecogNFq3+RO8pX4sqxvsSbw0KihAv=8teqCSJbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v2 3/6] pci: Rename and change signatures of
 pci_bus_new() & related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 18 April 2017 at 23:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
> pci_bus_new*() and pci_register_bus() work only when the 'parent'
> argument is a PCI_HOST_BRIDGE object. Rename them to reflect that they
> are meant to initialize a bus that's in a PCI host bridge.
>
> The new function names are:
> * pci_host_bus_init() (replacing pci_bus_new())
> * pci_host_bus_init_inplace() (replacing pci_bus_new_inplace())
> * pci_host_bus_init_irqs() (replacing pci_register_bus())

This is moving these functions away from the convention that
we seem to mostly follow for buses (eg ISA, SCSI) of
foo_bus_new() to allocate and return a new bus, and
foo_bus_new_inplace() to initialize a bus that's inline in
some other struct.

I'm not sure this is a good idea unless we have a plan to
convert all the other QOM buses and document that this is
the right way to implement init for a bus.

thanks
-- PMM
