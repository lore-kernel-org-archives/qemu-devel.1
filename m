Received: from eggs.gnu.org ([2001:4830:134:3::10]:39124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulK1-0000wX-5U
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulJy-0004G9-1a
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:42:29 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulJx-0004Fg-Pu
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:42:25 -0500
Received: by mail-wr0-x241.google.com with SMTP id n7so12058563wrn.5
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:42:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-16-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc46877d-1b67-ca40-aa41-b4f7fe643529@amsat.org>
Date: Sat, 10 Mar 2018 21:42:22 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-16-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/23] RISC-V: Use memory_region_is_ram
 in pte update
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
> After reading cpu_physical_memory_write and friends, it seems
> that memory_region_is_ram is a more appropriate interface,
> and matches the intent of the code that is calling it.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> index 162d5ec..fc550d3 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -235,7 +235,7 @@ restart:
>                  rcu_read_lock();
>                  mr = address_space_translate(cs->as, pte_addr,
>                      &addr1, &l, false);
> -                if (memory_access_is_direct(mr, true)) {
> +                if (memory_region_is_ram(mr)) {
>                      target_ulong *pte_pa =
>                          qemu_map_ram_ptr(mr->ram_block, addr1);
>  #if TCG_OVERSIZED_GUEST
> 
