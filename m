Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWom7-0006Ko-SE
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWom7-0007Wo-3F
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:04:47 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWom6-0007Wf-TY
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:04:47 -0400
Received: by mail-ot0-x241.google.com with SMTP id a5-v6so11068527otf.12
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 13:04:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529689531-4024-1-git-send-email-cota@braap.org>
References: <1529689531-4024-1-git-send-email-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Jun 2018 21:04:25 +0100
Message-ID: <CAFEAcA_7RESM8yWZsjQi7fhnJ0kx_tG7S+rPNKMOe+2PUnOV3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: fix --disable-tcg build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 22 June 2018 at 18:45, Emilio G. Cota <cota@braap.org> wrote:
> Fix the --disable-tcg breakage introduced by tb_lock's removal by
> relying on the fact that tcg_enabled() is set to 0 at
> compile-time under --disable-tcg.
>
> While at it, add further asserts to fix builds that enable both
> --disable-tcg and --enable-debug, which were broken even before
> tb_lock's removal.
>
> Tested to build x86_64-softmmu and i386-softmmu targets.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Applied to master as a fix for the travis builds; thanks.

-- PMM
