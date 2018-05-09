Received: from eggs.gnu.org ([2001:4830:134:3::10]:38866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGWA4-0006AR-3O
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGWA3-0001QO-ES
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:58:08 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:44088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGWA3-0001Q0-6I
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:58:07 -0400
Received: by mail-lf0-x244.google.com with SMTP id h197-v6so52891763lfg.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 13:58:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-15-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-15-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 May 2018 13:57:34 -0700
Message-ID: <CAKmqyKNrTDDPEBX6iVjFiLHC-kWYFjM2mTH3wfSv9ayEu=1gFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 14/36] target-microblaze: Name special
 registers we support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>

On Tue, May 8, 2018 at 10:31 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Name special registers we support.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index c971fe3b72..6cc92d09c9 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -105,8 +105,8 @@ static const char *regnames[] =
>
>  static const char *special_regnames[] =
>  {
> -    "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
> -    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
> +    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
> +    "sr8", "sr9", "sr10", "rbtr", "sr12", "redr"
>  };
>
>  static inline void t_sync_flags(DisasContext *dc)
> --
> 2.14.1
>
>
