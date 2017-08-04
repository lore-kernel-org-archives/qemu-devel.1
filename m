Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddcNl-0007sE-P1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddcDD-0000Pk-Hu
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:01:37 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddcDD-0000Lr-81
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:00:19 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m85so19349310wma.1
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 06:00:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Kj8wCp-BLS45ds-RmZbp7UK_8oEBcEKgpP98CE0jNcA@mail.gmail.com>
References: <CAFEAcA_Kj8wCp-BLS45ds-RmZbp7UK_8oEBcEKgpP98CE0jNcA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 13:59:57 +0100
Message-ID: <CAFEAcA9XUN0eaxnftrjL4UnnA86YugoQw823EPTq7BSiT2Sidg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Cleaning up handling of CPU exceptions accessing
 non-existent memory/devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

On 1 August 2017 at 11:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> My proposal is that we should define a new QOM CPU hook:
>   void (*do_transaction_failed)(CPUState *cpu, hwaddr physaddr, vaddr addr,
>                                 unsigned size, MMUAccessType access_type,
>                                 MemTxAttrs attrs, MemTxResult response);

I realised that we probably also want the 'uintptr_t retaddr'
and 'int mmu_idx' that tlb_fill() and the do_unaligned_access
hook both already have.

I have some patches mostly-ready which implement the
common code changes plus the ARM mode implementation of the
hook function.

thanks
-- PMM
