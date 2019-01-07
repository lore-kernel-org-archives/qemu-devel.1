Received: from eggs.gnu.org ([209.51.188.92]:40106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggWGu-0003Wo-UJ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggWGs-00005v-Tq
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:52:56 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggWGq-0008L7-Vn
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:52:54 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so529804otk.3
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20190104142921.878-1-f4bug@amsat.org>
In-Reply-To: <20190104142921.878-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:52:34 +0000
Message-ID: <CAFEAcA9ex7D5VQNEv+Nc2F_baFATjVZA4sJjL-S2BuPGQFD1=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/allwinner-a10: Add the 'A' SRAM
 and the SRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Charlie Smurthwaite <charlie@atech.media>, Beniamino Galvani <b.galvani@gmail.com>

On Fri, 4 Jan 2019 at 14:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> From the "A10 User Manual V1.20" p.29: "3.2. Memory Mapping" and:
>
>  7. System Control
>   7.1. Overview
>
>   A10 embeds a high-speed SRAM which has been split into five segments.
>   See detailed memory mapping in following table:
>
>   Area          Address        Size (Bytes)
>    A1    0x00000000-0x00003FFF 16K
>    A2    0x00004000-0x00007FFF 16K
>    A3    0x00008000-0x0000B3FF 13K
>    A4    0x0000B400-0x0000BFFF  3K
>
> Since for emulation purpose we don't need the segmentations, we simply de=
fine
> the 'A' area as a single 48KB SRAM.
>
> We don't implement the following others areas:
> - 'B': 'Secure RAM' (64K),
> - 'C': Debug/ISP SRAM
> - 'D': USB SRAM
>
> (qemu) info mtree
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-000000000000bfff (prio 0, ram): sram A
>     0000000001c00000-0000000001c00fff (prio -1000, i/o): a10-sram-ctrl
>     0000000001c0b000-0000000001c0bfff (prio 0, i/o): aw_emac
>     0000000001c18000-0000000001c18fff (prio 0, i/o): ahci
>       0000000001c18080-0000000001c180ff (prio 0, i/o): allwinner-ahci
>     0000000001c20400-0000000001c207ff (prio 0, i/o): allwinner-a10-pic
>     0000000001c20c00-0000000001c20fff (prio 0, i/o): allwinner-A10-timer
>     0000000001c28000-0000000001c2801f (prio 0, i/o): serial
>     0000000040000000-0000000047ffffff (prio 0, ram): cubieboard.ram
>
> Reported-by: Charlie Smurthwaite <charlie@atech.media>
> Tested-by: Charlie Smurthwaite <charlie@atech.media>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: Set owner=3DSoC in memory_region_init_ram() to avoid leak
>     when SoC is destroyed (Peter Maydell)



Applied to target-arm.next, thanks.

-- PMM
