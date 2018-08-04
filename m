Received: from eggs.gnu.org ([2001:4830:134:3::10]:49379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fm0Z8-00071T-S3
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 13:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fm0Z4-0005FE-VM
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 13:42:10 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fm0Z4-0005EM-MX
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 13:42:06 -0400
Received: by mail-pl0-x241.google.com with SMTP id d5-v6so3920805pll.4
	for <qemu-devel@nongnu.org>; Sat, 04 Aug 2018 10:42:06 -0700 (PDT)
References: <20180802155147.1863-1-peter.maydell@linaro.org>
	<20180802155147.1863-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <785a0974-bfad-a128-e8a2-9b4f1533e2f4@linaro.org>
Date: Sat, 4 Aug 2018 10:42:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180802155147.1863-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/pci-host/bonito: Move away from
 old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, patches@linaro.org

On 08/02/2018 08:51 AM, Peter Maydell wrote:
> Move away from the old_mmio MemoryRegion accessors in the
> bonito pci controller.
> 
> This device is used only in the MIPS "fulong2e" machine.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/pci-host/bonito.c | 145 +++++--------------------------------------
>  1 file changed, 15 insertions(+), 130 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
