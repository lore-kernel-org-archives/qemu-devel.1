Received: from eggs.gnu.org ([2001:4830:134:3::10]:42468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKY8-0002iB-7y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKY7-00030P-C7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:56 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKY7-0002zV-4d
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:55 -0400
Received: by mail-lf0-x244.google.com with SMTP id j193-v6so27798031lfg.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-7-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-7-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:09:28 +0000
Message-ID: <CAKmqyKNXTVSdegDESxdyiEgK4kLVyj9M9yyE0-3CXtkeRPavig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 06/29] target-microblaze: Correct the
 PVR array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:28 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Correct the PVR array size, there are 13 PVR registers.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 994496515f..2304c24b7d 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -277,7 +277,7 @@ struct CPUMBState {
>       /* These fields are preserved on reset.  */

>       struct {
> -        uint32_t regs[16];
> +        uint32_t regs[13];
>       } pvr;
>   };

> --
> 2.14.1
