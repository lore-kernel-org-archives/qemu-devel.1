Received: from eggs.gnu.org ([2001:4830:134:3::10]:47785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f13m7-0004Iu-Ai
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f13m4-0007Zs-7b
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:37:31 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:40371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f13m4-0007Zi-24
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:37:28 -0400
Received: by mail-ot0-x236.google.com with SMTP id w12-v6so1369827otj.7
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 22:37:27 -0700 (PDT)
References: <20180326191603.10217-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9a87b45-e6e7-f6f7-4dc2-7d9db7229dd2@linaro.org>
Date: Wed, 28 Mar 2018 13:37:16 +0800
MIME-Version: 1.0
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 00/19] linux-user: move arch
 specific parts from main.c to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org

On 03/27/2018 03:15 AM, Laurent Vivier wrote:
> This series moves from main.c the architecture specific parts
> to the architecture directory.
> 
> This is the continuation of my series
>   "linux-user: move arch specific parts to arch directories"
> that includes since the v2 only the signal.c parts.
> 
> For each architecture, there are two parts:
> 
>   - cpu_loop(), and the function with its
>     dependencies is moved to <arch>/cpu_loop.c
> 
>   - the prologue of the cpu_loop(), that was inlined
>     in main(). We move it to a new function in
>     <arch>/cpu_loop.c, target_cpu_copy_regs().
> 
> The first patch adds the skeleton to move the
> parts to the architecture directories, a cpu_loop.c
> file with an empty target_cpu_copy_regs() function,
> called from main().
> 
> There is no change in the code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
