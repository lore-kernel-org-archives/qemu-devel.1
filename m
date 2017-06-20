Received: from eggs.gnu.org ([2001:4830:134:3::10]:34245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQWi-00052X-Ix
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQWh-00010q-JJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:17:32 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dNQWh-00010C-D0
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:17:31 -0400
Received: by mail-wr0-x241.google.com with SMTP id y25so18588910wrd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:17:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497973886-26257-4-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
	<1497973886-26257-4-git-send-email-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Jun 2017 14:16:59 -0700
Message-ID: <CAKmqyKNg5uu-=Bb0YLnQipVY71qEz9JvCA19oLMSj76+2oyV8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 3/8] target-microblaze: Add CPU versions
 9.4, 9.5 and 9.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistai@xilinx.com>

On Tue, Jun 20, 2017 at 8:51 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add CPU versions 9.4, 9.5 and 9.6.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/microblaze/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 4bc77df..982cb61 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -64,6 +64,9 @@ static const struct {
>      {"9.1", 0x1D},
>      {"9.2", 0x1F},
>      {"9.3", 0x20},
> +    {"9.4", 0x21},
> +    {"9.5", 0x22},
> +    {"9.6", 0x23},
>      {NULL, 0},
>  };
>
> --
> 2.7.4
>
>
