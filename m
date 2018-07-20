Received: from eggs.gnu.org ([2001:4830:134:3::10]:58254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgXYK-00014b-9M
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgXYJ-0001GC-CJ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:42:44 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgXYJ-0001Fw-5n
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:42:43 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so22093555oie.13
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 08:42:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180720153942.26821-1-andre.przywara@arm.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 16:42:22 +0100
Message-ID: <CAFEAcA--Uux1tTVDgR3tGZCXjQPNF4mgSnhC720Ez0AuWUQw3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 0/4] arm: add GICv2 MMIO
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Jones <drjones@redhat.com>, Eric Auger <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>

On 20 July 2018 at 16:39, Andre Przywara <andre.przywara@arm.com> wrote:
> I found this in one my branches: this is an updated version of what I sent
> end of 2016 [1]. I tried to address all comments that Drew and Eric had at
> the time.
> Please have a look whether this makes sense.
>
> Changelog v1..v2:
> - made many functions void
> - use symbolic name for first SPI being number 32
> - add test runs with one and three vCPUs
> - use gic_version() directly
> - factor out test_byte_access()
> - drop redundant "filling priorities" test
> - dropped GICv3 test
>
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022352.html
>
> Original cover letter:
> ======================
> The GIC spec mandates certain constraints on how to acccess the MMIO
> mapped registers, both in terms of which registers are available and also
> in terms of which bits within a register should be masked, for instance.
> Since we went through some lengths in the KVM emulation to implement this,
> it's about time to give this actually a test beyond what the kernel as a
> GIC user actually implements - for instance we ignore priorities in Linux.
>
> This series tries to attack some constraints, on a low-hanging-fruit base.
> It focusses on some generic registers and the PRIORITY and TARGETS registers
> of GICv2. GICv3 is not covered yet.
>
> This actually revealed genuine bugs in the KVM emulation in the past. KVM
> passes these tests now, but QEMU fails some UP and 3-way-SMP tests.

Would be interesting to see if we've fixed some of the QEMU emulation
bugs, either already in master or in Luc's on-list patchset that adds
support for emulation of the GICv2 virt extensions...

thanks
-- PMM
