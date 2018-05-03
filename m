Received: from eggs.gnu.org ([2001:4830:134:3::10]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKsE-0004HU-3z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKsC-0003PX-Vl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:30:41 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKsC-0003OB-JM
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:30:40 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4-v6so27903637lfc.1
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-15-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-15-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:30:13 +0000
Message-ID: <CAKmqyKM8REvf4oJSdcwhwU2iD_vGbQsZqPnZj1MeHBAEAiCGiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 14/29] target-microblaze: Name special
 registers we support
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

> Name special registers we support.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index c971fe3b72..57cd00ab3e 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -105,8 +105,8 @@ static const char *regnames[] =

>   static const char *special_regnames[] =
>   {
> -    "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
> -    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
> +    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
> +    "sr8", "sr9", "sr10", "rbtr", "sr12", "rbtr"

Hey Edgar,

Where do the two rbtr registers come from?

Alistair

>   };

>   static inline void t_sync_flags(DisasContext *dc)
> --
> 2.14.1
