Received: from eggs.gnu.org ([2001:4830:134:3::10]:53640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frh2r-0005ed-JI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frgqG-0007dO-I7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:51:21 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frgqG-0007co-2t
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:51:20 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so24743147ois.1
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 02:51:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180802155147.1863-1-peter.maydell@linaro.org>
References: <20180802155147.1863-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 10:50:58 +0100
Message-ID: <CAFEAcA_ziFp5sFaSMtTeAWWYgiVLfHM_XyLvMCh6JTM9-voA-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] mips: convert devices away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, "patches@linaro.org" <patches@linaro.org>

On 2 August 2018 at 16:51, Peter Maydell <peter.maydell@linaro.org> wrote:
> These patches convert a couple of devices used only by MIPS
> boards from using the old_mmio MemoryRegionOps accessor functions.
>
>  * vga-isa-mm: used by the MIPS 'jazz' boards "magnum" and "pica61"
>  * bonito pci controller: used by the MIPS "fulong2e" board
>
> Tested only with "make check".
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/display/vga-isa-mm: Convert away from old_mmio
>   hw/pci-host/bonito: Move away from old_mmio accessors

Ping -- other than a minor tweak to a commit message this
patchset has been reviewed. MIPS folks, could you take this
via your mips tree ?

thanks
-- PMM
