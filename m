Received: from eggs.gnu.org ([2001:4830:134:3::10]:39211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCR1R-0005oc-GC
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCR1Q-0003e7-Pu
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:12:37 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCR1Q-0003cn-6q
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:12:36 -0400
Received: by mail-oi1-x243.google.com with SMTP id 22-v6so18366517oiz.2
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 08:12:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016150300.65172-1-liq3ea@163.com>
References: <20181016150300.65172-1-liq3ea@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:12:14 +0100
Message-ID: <CAFEAcA849ZCLXuBfeG4qm-4ORRqbRm32D4i0aLt7BXFpkJCC_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pc_init1: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 16 October 2018 at 16:03, Li Qiang <liq3ea@163.com> wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/i386/pc_piix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index dc09466b3e..0133668ce2 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -111,7 +111,7 @@ static void pc_init1(MachineState *machine,
>       *    so legacy non-PAE guests can get as much memory as possible in
>       *    the 32bit address space below 4G.
>       *
> -     *  - Note that Xen has its own ram setp code in xen_ram_init(),
> +     *  - Note that Xen has its own ram setup code in xen_ram_init(),
>       *    called via xen_hvm_init().
>       *
>       * Examples:
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
