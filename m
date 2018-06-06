Received: from eggs.gnu.org ([2001:4830:134:3::10]:48307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fQak0-0003CT-Lh
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fQak0-0005xT-2S
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:52:52 -0400
MIME-Version: 1.0
In-Reply-To: <20180606152128.449-6-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
	<20180606152128.449-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Jun 2018 08:52:18 -0700
Message-ID: <CAKmqyKMcru62C=vUamPyR+CayG-aN3kW9RW7+RCYFY2kt5_T2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/core/register: Add trailing '\n'
 to qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jun 6, 2018 at 8:21 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/register.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 0741a1af32..d2d1636250 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -96,7 +96,7 @@ void register_write(RegisterInfo *reg, uint64_t val, ui=
nt64_t we,
>      if (test) {
>          qemu_log_mask(LOG_UNIMP,
>                        "%s:%s writing %#" PRIx64 " to unimplemented bits:=
" \
> -                      " %#" PRIx64 "",
> +                      " %#" PRIx64 "\n",
>                        prefix, reg->access->name, val, ac->unimp);
>      }
>
> --
> 2.17.1
>
>
