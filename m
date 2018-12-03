Received: from eggs.gnu.org ([2001:4830:134:3::10]:60806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTtIN-0007fv-VT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTtIN-0005GL-1i
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:50:15 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTtIM-0005Fv-TK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:50:14 -0500
Received: by mail-oi1-x241.google.com with SMTP id x23so11899807oix.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 10:50:14 -0800 (PST)
MIME-Version: 1.0
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 18:50:03 +0000
Message-ID: <CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 3 Dec 2018 at 11:04, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> The first patches are simple cleanups:
>      - patch 1 move the pvpanic device with the 'ocmmon objects' so we compile
>                it once for the x86/arm/aarch64 archs,
>      - patch 2 simply renames ISA fields/definitions to generic ones.
>
>      Then instead of add/use the MMIO pvpanic device in the virt machine in an
>      unique patch, I split it in two distinct patches:
>      - patch 3 uses Peng Hao's work, but add the MMIO interface to the existing
>         device (no logical change).
>      - patch 4 is Peng Hao's work in the virt machine (no logical change).
>      - patch 5 add pvpanic device in acpi table in virt machine
>      v2 from Peng Hao is:
>      https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html

I would still prefer to see a more detailed examination of whether
we can do this with a PCI device before we commit to taking the
MMIO version into the virt board.

thanks
-- PMM
