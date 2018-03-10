Received: from eggs.gnu.org ([2001:4830:134:3::10]:38090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulC5-0005p9-TW
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulC2-0007lw-Nt
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:34:17 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulC2-0007ix-HV
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:34:14 -0500
Received: by mail-wm0-x241.google.com with SMTP id h21so9644595wmd.1
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:34:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-4-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f48fe5c-dc3a-008c-6d60-c1eb1ab0743b@amsat.org>
Date: Sat, 10 Mar 2018 21:34:11 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-4-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/23] RISC-V: Make virt board
 description match spike
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/09/2018 05:12 AM, Michael Clark wrote:
> This makes 'qemu-system-riscv64 -machine help' output more tidy
> and consistent.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a402856..0055439 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -404,7 +404,7 @@ static const TypeInfo riscv_virt_board_device = {
>  
>  static void riscv_virt_board_machine_init(MachineClass *mc)
>  {
> -    mc->desc = "RISC-V VirtIO Board (Privileged spec v1.10)";
> +    mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
>      mc->init = riscv_virt_board_init;
>      mc->max_cpus = 8; /* hardcoded limit in BBL */
>  }
> 
