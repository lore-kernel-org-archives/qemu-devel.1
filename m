Received: from eggs.gnu.org ([2001:4830:134:3::10]:35363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej3HO-0005tR-Pi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej3HL-00065S-Ls
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:27:22 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ej3HL-00064t-C1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:27:19 -0500
References: <20180206124431.31433.91946.stgit@pasha-VirtualBox>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0dfe3d4e-fc7e-8fdf-214c-f1c7a0b6f027@vivier.eu>
Date: Tue, 6 Feb 2018 14:27:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180206124431.31433.91946.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: huth@tuxfamily.org, dovgaluk@ispras.ru

Le 06/02/2018 à 13:44, Pavel Dovgalyuk a écrit :
> This patch implements movep instruction. It moves data between a data register
> and alternate bytes within the address space starting at the location
> specified and incrementing by two.
> 
> It was designed for the original 68000 and used in firmwares for
> interfacing the 8-bit peripherals through the 16-bit data bus.

Did you test this change with some kind of firmware?

> Without this patch opcode for this instruction is recognized as some bitop.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> 
> --
> 
> v4: - fixed offset calculation misprint
> 
> v3: - simplified movep function code
>     - joined movep masks
> 
> v2: - disabled movep for Coldfire
>     - fixed gen_store/load usage
> ---
>  target/m68k/cpu.c       |    2 ++
>  target/m68k/cpu.h       |    1 +
>  target/m68k/translate.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)

Tested-by: Laurent Vivier <laurent@vivier.eu>

I've checked we have the same result on a real 68040

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
