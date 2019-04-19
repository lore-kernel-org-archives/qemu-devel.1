Received: from eggs.gnu.org ([209.51.188.92]:49838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHacp-0002NF-QV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaco-0002od-QC
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:47 -0400
MIME-Version: 1.0
References: <20190419061429.17695-1-ehabkost@redhat.com>
	<20190419061429.17695-3-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-3-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:00:18 -0700
Message-ID: <CAKmqyKO-djrG6QWXKeEMPNPvdXaVx14iWE7Cgq9TVh8C5_Ytpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/7] riscv: Don't split CPU model string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Apr 18, 2019 at 11:20 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> CPUClass::class_by_name is called after the CPU model name and
> options were already split, there's no need to split the string
> again.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: qemu-riscv@nongnu.org
> ---
>  target/riscv/cpu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..5e97a83c80 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -179,12 +179,9 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
>      char *typename;
> -    char **cpuname;
>
> -    cpuname = g_strsplit(cpu_model, ",", 1);
> -    typename = g_strdup_printf(RISCV_CPU_TYPE_NAME("%s"), cpuname[0]);
> +    typename = g_strdup_printf(RISCV_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);
> -    g_strfreev(cpuname);
>      g_free(typename);
>      if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
>          object_class_is_abstract(oc)) {
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>
