Received: from eggs.gnu.org ([2001:4830:134:3::10]:33804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7zVO-0000pA-B7
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7zVK-0007KT-BL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:24:22 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7zVK-0007KG-4Z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:24:18 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n198so22860281wmg.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 00:24:18 -0700 (PDT)
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-9-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508233918.9043-9-f4bug@amsat.org>
Date: Tue, 09 May 2017 08:25:01 +0100
Message-ID: <87o9v28pbm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/11] hw/sparc: use ARRAY_SIZE() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sparc64/sun4u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index d347b6616d..525d6f44a0 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -214,7 +214,7 @@ static void isa_irq_handler(void *opaque, int n, int level)
>      qemu_irq *irqs = opaque;
>      int ivec;
>
> -    assert(n < 16);
> +    assert(n < ARRAY_SIZE(isa_irq_to_ivec));
>      ivec = isa_irq_to_ivec[n];
>      EBUS_DPRINTF("Set ISA IRQ %d level %d -> ivec 0x%x\n", n, level, ivec);
>      if (ivec) {

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
