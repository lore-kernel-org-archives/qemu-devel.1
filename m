Received: from eggs.gnu.org ([2001:4830:134:3::10]:49741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1flIl3-0007Hn-DX
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 14:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1flIl0-0003YJ-7G
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 14:55:33 -0400
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:47713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1flIkz-0003Xe-6W
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 14:55:30 -0400
References: <20180802155147.1863-1-peter.maydell@linaro.org>
	<20180802155147.1863-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <b2850ef9-59f2-b0c3-68df-e678cb18c239@reactos.org>
Date: Thu, 2 Aug 2018 20:55:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180802155147.1863-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/display/vga-isa-mm: Convert away
 from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

Le 02/08/2018 à 17:51, Peter Maydell a écrit :
> Convert the vga-isa-mm device away from the old_mmio
> MemoryRegion accessors.
> 
> This device is only used by the MIPS 'jazz' boards
> "magnum" and "pica61".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/vga-isa-mm.c | 60 +++++++++--------------------------------
>   1 file changed, 13 insertions(+), 47 deletions(-)
> 

Note: this device is only used by the MIPS "pica61" board, not the "magnum" one.
The commit message may be changed accordingly.

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
