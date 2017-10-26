Received: from eggs.gnu.org ([2001:4830:134:3::10]:45846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e7m6V-0005q6-Ra
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 13:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e7m6S-0008F8-PX
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 13:38:03 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e7m6S-0008ET-Hf
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 13:38:00 -0400
Date: Thu, 26 Oct 2017 13:37:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171026173758.GA2334@flamenco>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026135814.20773-1-richard.henderson@linaro.org>
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com

On Thu, Oct 26, 2017 at 15:58:14 +0200, Richard Henderson wrote:
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

AFAIK the only target that is so far supposed to work with
--disable-tcg is i386. The configure script however lets you try to
build without TCG if the host has an alternative accelerator (e.g. KVM),
but that build is likely to fail. [ just confirmed this with aarch64 ]

That said, I like that this patch takes care of other targets too.

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
