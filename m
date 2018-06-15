Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTj7d-0002hy-EZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTj7Z-000824-El
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:26:13 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36386
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fTj7Z-00081P-8C
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:26:09 -0400
References: <20180614233935.26585-1-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <24d63869-1793-e0a5-d00d-51e461c7c174@ilande.co.uk>
Date: Fri, 15 Jun 2018 08:25:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180614233935.26585-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/isa/smc37c669: Change the parallel I/O
 base to 378H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org

On 15/06/18 00:39, Philippe Mathieu-Daudé wrote:

> On the Alpha DP264 machine, the Cirrus VGA is I/O mapped
> in the 3C0H-3CFH range, thus I/O base used by the parallel
> device clashes, and since a4cb773928e the VGA is not
> working:
> 
> (qemu) info mtree
> address-space: memory
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      00000801fc000000-00000801fdffffff (prio 0, i/o): pci0-io
>        ...
>        00000801fc0003b4-00000801fc0003b5 (prio 0, i/o): vga
>        00000801fc0003ba-00000801fc0003ba (prio 0, i/o): vga
>        00000801fc0003bc-00000801fc0003c3 (prio 0, i/o): parallel
>                                      ^^^                ^^^^^^^^
>        00000801fc0003c0-00000801fc0003cf (prio 0, i/o): vga
>                     ^^^
>        00000801fc0003d4-00000801fc0003d5 (prio 0, i/o): vga
>        00000801fc0003da-00000801fc0003da (prio 0, i/o): vga
>        ...
> 
> As there is no particular reason to use this base address
> (introduced in 7bea0dd434e), change to 378H which is the
> default on PC machines.
> 
> Reported-by: Emilio G. Cota <cota@braap.org>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> RFC: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg04011.html
> 
>   hw/isa/smc37c669-superio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
> index aa233c6967..64466a9373 100644
> --- a/hw/isa/smc37c669-superio.c
> +++ b/hw/isa/smc37c669-superio.c
> @@ -37,7 +37,7 @@ static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
>   
>   static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index)
>   {
> -    return 0x3bc;
> +    return 0x378;
>   }
>   
>   static unsigned int get_parallel_irq(ISASuperIODevice *sio, uint8_t index)

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
