Received: from eggs.gnu.org ([2001:4830:134:3::10]:56803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUQah-0008Lp-8I
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUQad-0000H5-CL
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:51:07 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUQad-0000Gk-5Y
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:51:03 -0400
Received: by mail-pl0-x244.google.com with SMTP id w8-v6so5852478ply.8
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 22:51:02 -0700 (PDT)
References: <20180614233935.26585-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b001bc3-10cc-67e5-d206-57ce6e0a9bca@linaro.org>
Date: Sat, 16 Jun 2018 19:50:56 -1000
MIME-Version: 1.0
In-Reply-To: <20180614233935.26585-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org

On 06/14/2018 01:39 PM, Philippe Mathieu-Daudé wrote:
> On the Alpha DP264 machine, the Cirrus VGA is I/O mapped
> in the 3C0H-3CFH range, thus I/O base used by the parallel
> device clashes, and since a4cb773928e the VGA is not
> working:
> 
> (qemu) info mtree
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     00000801fc000000-00000801fdffffff (prio 0, i/o): pci0-io
>       ...
>       00000801fc0003b4-00000801fc0003b5 (prio 0, i/o): vga
>       00000801fc0003ba-00000801fc0003ba (prio 0, i/o): vga
>       00000801fc0003bc-00000801fc0003c3 (prio 0, i/o): parallel
>                                     ^^^                ^^^^^^^^
>       00000801fc0003c0-00000801fc0003cf (prio 0, i/o): vga
>                    ^^^
>       00000801fc0003d4-00000801fc0003d5 (prio 0, i/o): vga
>       00000801fc0003da-00000801fc0003da (prio 0, i/o): vga
>       ...
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
>  hw/isa/smc37c669-superio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued to tgt-axp.


r~
