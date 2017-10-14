Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3Mhp-0003YW-7g
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 09:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3Mho-0002ys-FE
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 09:42:21 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:55191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e3Mho-0002yo-8A
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 09:42:20 -0400
Received: by mail-wr0-x230.google.com with SMTP id o44so2668253wrf.11
	for <qemu-devel@nongnu.org>; Sat, 14 Oct 2017 06:42:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013232114.GD3246@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-3-anatol.pomozov@gmail.com>
	<20171013192550.GC3246@localhost.localdomain>
	<CAOMFOmW+r86WHWPUMtG54BrAQXqSWZ67oF-6G697ox-7AKL4GA@mail.gmail.com>
	<20171013232114.GD3246@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Oct 2017 14:41:58 +0100
Message-ID: <CAFEAcA-zYJUOqH=WU_XnyxEfiZM7a2yqmzndTrf=pKkp=1wUGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 14 October 2017 at 00:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I don't believe the spec restricts that, but I don't see why it
> would be useful to load an ELF file that doesn't match the target
> architecture (e.g. loading non-x86 ELF files on a x86 machine
> like PC).

Agreed. If we have non i386 boards that want to use multiboot
we should probably move the common code out of hw/i386...

thanks
-- PMM
