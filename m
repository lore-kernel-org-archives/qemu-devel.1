Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDQk-0004B7-Jh
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDEI-0002KB-9G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:53:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDEI-0002Jz-2a
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:53:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id r63-v6so7616343wma.4
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 05:53:13 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-8-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <38c8c109-c231-696e-2fb8-4fae6f3fb641@linaro.org>
Date: Sun, 21 Oct 2018 13:53:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-8-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 07/56] target/m68k: rename cpu_halted to
 cpu_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> To avoid a name clash with the soon-to-be-defined cpu_halted() helper.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Although for this usage it's probably better to avoid the
tcg_global_mem_new_i32 and just use tcg_gen_st_i32.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
