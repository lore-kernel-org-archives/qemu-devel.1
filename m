Received: from eggs.gnu.org ([2001:4830:134:3::10]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f45Wq-0004dX-Mb
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f45Wp-0002uC-Gk
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:06:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f45Wp-0002tu-BW
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:06:15 -0400
Received: by mail-oi0-x244.google.com with SMTP id j143-v6so22612362oih.11
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 07:06:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 15:05:53 +0100
Message-ID: <CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2018 at 05:31,  <alarson@ddci.com> wrote:
> Your patch (applied to 2.11 source release) changed the behavior
> somewhat, but did not fix the problem.  Attached is a binary that when
> run should show a CGA fontset and color bars.
>
> This command should "work":
>
> qemu-system-aarch64 -M virt,virtualization=on -cpu cortex-a53 -vga std
> -device secondary-vga -device virtio-net,netdev=vlan0,addr=2 -kernel
> icount-bug.bin -netdev user,id=vlan0
>
> If you add "-icount 2" the display will appear, but be mangled.
>
> I didn't spend too much time trimming the source code, so if you need
> to step by step debug walking through the guest code, I'll have to
> prune it down some more.
>
> For the record, the QEMU source I have is modified slightly to add ARM WFE
> support, something I will submit once this is all straightened out,
> but this bug appeared before I made that patch.

Hi; sorry for the delay in testing this. I've just tried your
attached test image with current head of git QEMU (commit
0e87fdc966d05f4e5ad86, which is the 2.12.0-rc2 release candidate),
and it gives me a correct display both with and without -icount 2.
So I think we've fixed this bug, probably with the combination
of commits 0790f86861079b19 and 87f963be66a3245, or possibly
a75a52d62418da.

thanks
-- PMM
