Received: from eggs.gnu.org ([2001:4830:134:3::10]:46654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlEwa-00061K-Le
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlEwZ-0004ue-FE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:46:40 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlEwU-0004sd-UC
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:46:39 -0400
Received: by mail-wr0-x234.google.com with SMTP id a47so7561834wra.4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 06:46:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825131956.GK2772@umbus.fritz.box>
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
	<CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
	<0e7817c4-4189-c620-e71c-d935076286ad@redhat.com>
	<20170825131956.GK2772@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 14:46:13 +0100
Message-ID: <CAFEAcA9+fOtEBVkFiZ7Lxh0rbkZsYwdt3YxA2fQTO1ucbmZB5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>

On 25 August 2017 at 14:19, David Gibson <david@gibson.dropbear.id.au> wrote:
> Hm.  Why do we need to construct full ASes for virtio-blk, rather than
> just MRs?

It's the PCI layer that's doing it, but the overall reason is because
virtio-blk needs to make memory transactions (DMA reads and writes).
The AddressSpace is our construct for "thing you use to be able
to efficiently make memory transactions on a MemoryRegion".
(This is what the FlatView and AddressSpaceDispatch data structures
are for -- they let you efficiently go from "write to address 0x4000
in this thing" to the actual destination RAM or device read/write
pointers.)

thanks
-- PMM
