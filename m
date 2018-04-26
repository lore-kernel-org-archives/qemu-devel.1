Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBk56-0002lO-T1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBk56-0007oc-70
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:49:16 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBk55-0007oU-Va
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:49:16 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4-v6so4960931lfc.1
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-11-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 16:48:49 +0000
Message-ID: <CAKmqyKMaXs0+id2eUBbtyUXAZW7rJWC9wcX9E79tsuWF7-W+Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 10/35] RISC-V: Remove erroneous comment
 from translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Wed, Apr 25, 2018 at 5:00 PM Michael Clark <mjc@sifive.com> wrote:

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/translate.c | 1 -
>   1 file changed, 1 deletion(-)

> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 808eab7..c3a029a 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -280,7 +280,6 @@ static void gen_arith(DisasContext *ctx, uint32_t
opc, int rd, int rs1,
>           tcg_gen_andi_tl(source2, source2, 0x1F);
>           tcg_gen_sar_tl(source1, source1, source2);
>           break;
> -        /* fall through to SRA */
>   #endif
>       case OPC_RISC_SRA:
>           tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
> --
> 2.7.0
