Received: from eggs.gnu.org ([2001:4830:134:3::10]:38719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSq1-00038Z-9l
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSpv-0007tB-Nh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:07:45 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:43876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSpv-0007t0-Hl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:07:39 -0500
Received: by mail-ot0-x230.google.com with SMTP id p36so5809564otd.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:07:39 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 15:07:18 +0000
Message-ID: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU virt board: extending various limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>

We've had discussions before about the various limits in the virt
board imposed by its current address space layout:
 * number of CPUs limited to 123 (not enough space for more redistributors)
 * number of PCIe devices limited by size of ECAM space
 * max memory size limits
 * (anything else?)

If we want to try to fix these this release cycle now would be a good
point to figure out our approach so that we have plenty of time to do
it in.

(Relatedly, I notice patches on list for kvm that allow userspace to
set the guest physical address size, which may affect how we want
to do this.)

I'm not going to have time to look at this but am happy to provide
my opinions on whatever proposals other people would like to suggest.

Probably the first thing to do is figure out whether we can
raise these limits without having to have a flag day (ie just
with changing the device tree we provide the guest), or if we
really have a hard compat break here. We should also try to
fix all these things at once rather than potentially breaking
guests several times...

thanks
-- PMM
