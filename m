Received: from eggs.gnu.org ([2001:4830:134:3::10]:58644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUqi-00087a-4N
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUqg-0006dU-LO
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:10:27 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fJUqg-0006cn-FL
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:10:26 -0400
Received: by mail-ot0-x230.google.com with SMTP id 77-v6so7375217otd.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 19:10:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526400000-66561-1-git-send-email-imammedo@redhat.com>
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
	<1526400000-66561-1-git-send-email-imammedo@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 18 May 2018 14:10:24 +1200
Message-ID: <CAHNT7NtoqQDpQCMF9C92KHvn6jLAy0K1fOJaT6nTTAAJ0s+utQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Wed, May 16, 2018 at 4:00 AM, Igor Mammedov <imammedo@redhat.com> wrote:

> cpu_init() was removed since 2.12, so drop the define that is now unused.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>

---
> v2:
>   * refine commit message (Eric Blake <eblake@redhat.com>)
> ---
>  target/riscv/cpu.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34abc38..0562a02 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -251,7 +251,6 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr
> address, int size,
>  char *riscv_isa_string(RISCVCPU *cpu);
>  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>
> -#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
>  #define cpu_signal_handler cpu_riscv_signal_handler
>  #define cpu_list riscv_cpu_list
>  #define cpu_mmu_index riscv_cpu_mmu_index
> --
> 2.7.4
>
>
