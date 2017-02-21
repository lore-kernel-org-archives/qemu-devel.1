Received: from eggs.gnu.org ([2001:4830:134:3::10]:37766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgBj7-0005wN-33
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgBj6-000248-Ap
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:47:37 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgBj6-00023r-4Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:47:36 -0500
Received: by mail-wm0-x234.google.com with SMTP id 196so29530327wmm.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 06:47:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <332706f6-7b54-89db-6b89-5684362fb2e3@ispras.ru>
References: <076b0d94-738e-252c-1ed8-4640a864ac34@ispras.ru>
	<CAFEAcA-zURkUb28wVA347AFJX5Wa4GyXbFSVmUDH1BSXRMA+rQ@mail.gmail.com>
	<4d2f2d04-e294-bdad-4f77-9a0171357d05@ispras.ru>
	<332706f6-7b54-89db-6b89-5684362fb2e3@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 14:47:14 +0000
Message-ID: <CAFEAcA-cQwhF5B8cZHVZsJvde_NHhL8iPr4ATr0y=a2yyg1n1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] ARM i.MX timers: fix software reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kurban Mallachiev <mallachiev@ispras.ru>
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, QEMU Developers <qemu-devel@nongnu.org>

On 19 February 2017 at 19:00, Kurban Mallachiev <mallachiev@ispras.ru> wrote:
> Hello!
>
> Problem: function imx_gpt_reset is used for soft (requested by guest) and
> hard resets. But soft and hard resets should have different behaviour (hard
> reset should clear all registers, while soft reset should preserve some
> bits).
>
> Patch changelog:
> v1 -> v2: use different approach, patch completely rewritten
> v2 -> v3: in software reset add preserving of CLKSRC bit as manual says
>
> ---
> Software reset function clears CR bits that should not be cleared and
> preserve bits that should be cleared.
>
> Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>

Thanks for this patch -- I have added it to my target-arm queue
(with a few tweaks).

Unfortunately your mail client mangled the patch a bit, and I had
to apply it manually. I'm happy to do that for occasional contributions,
but if you're planning to submit a lot of patches in the near future
you might like to look at your patch submission workflow (we usually
recommend 'git send-email').

thanks
-- PMM
