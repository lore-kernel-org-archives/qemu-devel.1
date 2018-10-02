Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7MNk-0004lK-VN
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7MNh-00011b-Hh
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:14:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7MNg-0000zn-SL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:14:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so50671wru.9
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 08:14:24 -0700 (PDT)
References: <20181002150304.2287-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <601205ea-a318-8a2a-1ce8-00a946342f1b@redhat.com>
Date: Tue, 2 Oct 2018 17:14:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181002150304.2287-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Don't read r4 from v8M
 exception stackframe twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/10/2018 17:03, Peter Maydell wrote:
> A cut-and-paste error meant we were reading r4 from the v8M
> callee-saves exception stack frame twice. This is harmless
> since it just meant we did two memory accesses to the same
> location, but it's unnecessary. Delete it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 073fb3c5cb0..5e721a65272 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7303,7 +7303,6 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>              }
>  
>              pop_ok = pop_ok &&
> -                v7m_stack_read(cpu, &env->regs[4], frameptr + 0x8, mmu_idx) &&
>                  v7m_stack_read(cpu, &env->regs[4], frameptr + 0x8, mmu_idx) &&
>                  v7m_stack_read(cpu, &env->regs[5], frameptr + 0xc, mmu_idx) &&
>                  v7m_stack_read(cpu, &env->regs[6], frameptr + 0x10, mmu_idx) &&
> 
