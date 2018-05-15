Received: from eggs.gnu.org ([2001:4830:134:3::10]:48198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIb7A-0005Wn-QM
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIb77-0001a6-LI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:39:44 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIb77-0001a0-GF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:39:41 -0400
Received: by mail-qt0-x242.google.com with SMTP id m9-v6so539559qtb.5
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:39:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1a2bc42d-2e93-776a-3d28-b60923883542@amsat.org>
Date: Tue, 15 May 2018 11:39:35 -0300
MIME-Version: 1.0
In-Reply-To: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mjc@sifive.com, palmer@sifive.com

On 05/15/2018 08:16 AM, Igor Mammedov wrote:
> cpu_init() was removed since 2.12, so drop define that now isn't used
> nad point to nowhere.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/cpu.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34abc38..0562a02 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -251,7 +251,6 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
>  char *riscv_isa_string(RISCVCPU *cpu);
>  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>  
> -#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
>  #define cpu_signal_handler cpu_riscv_signal_handler
>  #define cpu_list riscv_cpu_list
>  #define cpu_mmu_index riscv_cpu_mmu_index
> 
