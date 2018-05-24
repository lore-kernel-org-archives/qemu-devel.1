Received: from eggs.gnu.org ([2001:4830:134:3::10]:50884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLyCf-0003wk-6U
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLyCa-0003Qp-7q
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:55:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180524213756.7528-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b3d15f99-2e67-c0d4-7741-3af67d566734@amsat.org>
Date: Thu, 24 May 2018 18:55:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180524213756.7528-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] arm: fix malloc type mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Cc'ing qemu-devel for patchew and co

On 05/24/2018 06:37 PM, Paolo Bonzini wrote:
> cpregs_keys is an uint32_t* so the allocation should use uint32_t.
> g_new is even better because it is type-safe.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/gdbstub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index e80cfb47c7..0c64c0292e 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -157,8 +157,7 @@ int arm_gen_dynamic_xml(CPUState *cs)
>      RegisterSysregXmlParam param = {cs, s};
>  
>      cpu->dyn_xml.num_cpregs = 0;
> -    cpu->dyn_xml.cpregs_keys = g_malloc(sizeof(uint32_t *) *
> -                                        g_hash_table_size(cpu->cp_regs));
> +    cpu->dyn_xml.cpregs_keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
>      g_string_printf(s, "<?xml version=\"1.0\"?>");
>      g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
>      g_string_append_printf(s, "<feature name=\"org.qemu.gdb.arm.sys.regs\">");
> 
