Received: from eggs.gnu.org ([2001:4830:134:3::10]:47562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fWS4I-0003Dl-PA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fWS4H-0003lW-SH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:50:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180622124716.9179-1-f4bug@amsat.org>
References: <20180622124716.9179-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Jun 2018 12:49:27 -0700
Message-ID: <CAKmqyKMp8-ZAaTU2nxaMCqoR0JsbXoogR6t6Nq7UwU3B3o1AKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/register: Log unimplemented access
 via the 'unimp' debug level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Jun 22, 2018 at 5:47 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/register.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index d2d1636250..8ed7c6b927 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -203,7 +203,7 @@ void register_write_memory(void *opaque, hwaddr addr,
>      }
>
>      if (!reg) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to unimplemented regis=
ter " \
> +        qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register " =
\
>                        "at address: %#" PRIx64 "\n", reg_array->prefix, a=
ddr);
>          return;
>      }
> @@ -232,7 +232,7 @@ uint64_t register_read_memory(void *opaque, hwaddr ad=
dr,
>      }
>
>      if (!reg) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s:  read to unimplemented regis=
ter " \
> +        qemu_log_mask(LOG_UNIMP, "%s:  read to unimplemented register " =
\
>                        "at address: %#" PRIx64 "\n", reg_array->prefix, a=
ddr);

I'm not sure this is correct. These can be unimplemented because there
are gaps in the register memory map, so it is a guest error.

Alistair

>          return 0;
>      }
> --
> 2.18.0.rc2
>
>
