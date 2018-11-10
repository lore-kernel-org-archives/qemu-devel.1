Received: from eggs.gnu.org ([2001:4830:134:3::10]:40577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLOmX-0000EB-Dp
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 03:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLOmR-0004BG-O1
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 03:38:16 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLOmQ-00043G-IA
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 03:38:11 -0500
Received: by mail-wm1-x341.google.com with SMTP id p2-v6so3857614wmc.2
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 00:38:02 -0800 (PST)
References: <20181109191933.6641-1-palmer@sifive.com>
	<20181109191933.6641-2-palmer@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6e88f7e-aaef-5d0e-be10-cce1a6e4bdeb@linaro.org>
Date: Sat, 10 Nov 2018 09:37:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181109191933.6641-2-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1] RISC-V: Respect fences for
 user-only emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

On 11/9/18 8:19 PM, Palmer Dabbelt wrote:
> Our current fence implementation ignores fences for the user-only
> configurations.  This is incorrect but unlikely to manifest: it requires
> multi-threaded user-only code that takes advantage of the weakness in
> the host's memory model and can be inlined by TCG.
> 
> This patch simply treats fences the same way for all our emulators.
> I've given it to testing as I don't want to construct a test that would
> actually trigger the failure.
> 
> Our fence implementation has an additional deficiency where we map all
> RISC-V fences to full fences.  Now that we have a formal memory model
> for RISC-V we can start to take advantage of the strength bits on our
> fence instructions.  This requires a bit more though, so I'm going to
> split it out because the implementation is still correct without taking
> advantage of these weaker fences.
> 
> Thanks to Richard Henderson for pointing out both of the issues.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/translate.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
