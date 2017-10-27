Received: from eggs.gnu.org ([2001:4830:134:3::10]:45955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7yg0-0004kF-WF
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7yfw-0001AO-6F
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:03:32 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:47552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7yfv-00018s-Vk
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:03:28 -0400
Received: by mail-wm0-x243.google.com with SMTP id r196so1559525wmf.2
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 00:03:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171026135814.20773-1-richard.henderson@linaro.org>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2017 08:03:06 +0100
Message-ID: <CAFEAcA8mVtira5AMwwASg9+eRx=nge-SR2YEnNnEoxF86wNHqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 26 October 2017 at 14:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Fix the build for --disable-tcg.
>
> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c            | 2 ++
>  target/i386/cpu.c           | 2 ++
>  target/mips/cpu.c           | 2 ++
>  target/ppc/translate_init.c | 2 ++
>  target/s390x/cpu.c          | 2 ++
>  5 files changed, 10 insertions(+)
>

Applied to master as a buildfix, thanks.

-- PMM
