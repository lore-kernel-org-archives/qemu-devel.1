Received: from eggs.gnu.org ([2001:4830:134:3::10]:36712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1epJbM-0006d4-TD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1epJbL-0001ZC-Ef
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:05:52 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:46697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1epJbL-0001Yl-5N
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:05:51 -0500
Received: by mail-ot0-x22f.google.com with SMTP id g97so2708519otg.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 12:05:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223101032.GA31076@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<20180223101032.GA31076@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Feb 2018 09:05:49 +1300
Message-ID: <CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

Dear Daniel,

We've had this discussion on a recent pull request where some code was
going to be copied directly from hw/arm/virt.c to hw/riscv/virt.c and we
have subsequently relicensed the recipient file as GPLv2+. This code has
not yet been incorporated into the port. Besides naming conventions and use
of some common APIs, however the logic in hw/riscv/virt.c is original work.
Try diffing them. I wrote the device tree code from scratch and we have a
unique memory map, and the other functions are dervied from other RISC-V
machines which are MIT licensed.

- https://github.com/riscv/riscv-qemu/pull/109

In any case, SiFive are happy to license their contributions as GPLv2+.
We'll need to get the main contributors to agree to re-license to GPLv2+ or
fall back to having GPLv2+ prefix the MIT license, as MIT is compatible
with GPLv2+. Stefan O'Rear has commented that he is happy for his code to
be GPLv2+ and so is SiFive, but we'll need to get confirmation from Sagar,
one of the main port contributors, and potentially the whole list of
contributors to do complete due diligence on re-licensing. i.e. if we want
to eradicate MIT license from the code-base.

SiFive have made substantial changes to all of the non-GPLv2+ files in the
port, and SiFive can license their contributions as GPLv2+ which would
allow us to prefix all files in hw/riscv with GPLv2+. The only issue is
that we must get approval from contributors to completely remove the MIT
license, as the original contributors licensed their code under that
license, as is the case for all of Fabrice's original code and many other
parts of the code base e.g. GPEX hw/pci-host/gpex.c.

SiFive have made substantial changes to all files in the RISC-V port, so we
would be empowered to at least prefix the MIT license with GPLv2+.

Is that acceptable? the MIT terms are compatible with GPLv2+ as MIT is a
"permissive-license".

'cc Sagar, Bastian, as they have been main contributors to the port in the
past...

Regards,
Michael.

On Fri, Feb 23, 2018 at 11:10 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com>
wrote:

> On Fri, Feb 23, 2018 at 01:11:46PM +1300, Michael Clark wrote:
> > QEMU RISC-V Emulation Support (RV64GC, RV32GC)
> >
> > This is hopefully the "fix remaining issues in-tree" release.
>
> This code seems to be a mixture of LGPLv2+ and MIT licensed code. The
> preferred license for QEMU contributions is GPLv2+. Is there a reason
> you need to diverge from this or can it be changed to be all GPLv2+ ?
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
