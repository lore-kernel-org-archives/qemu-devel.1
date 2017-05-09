Received: from eggs.gnu.org ([2001:4830:134:3::10]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d7sf3-0006aT-75
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d7sf2-0004P4-7Q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:05:53 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170508233918.9043-11-f4bug@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 May 2017 17:05:20 -0700
Message-ID: <CAKmqyKOtw76BeqnQ62-pwD8S1ZqnAaYXLAdeBu1xyJjRxWcmOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/11] register: display register prefix
 (name) since it is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Mon, May 8, 2017 at 4:39 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/core/register.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index dc335a79a9..b5988c9cc3 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -195,8 +195,8 @@ void register_write_memory(void *opaque, hwaddr addr,
>      }
>
>      if (!reg) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "Write to unimplemented register =
at " \
> -                      "address: %#" PRIx64 "\n", addr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to unimplemented regis=
ter " \
> +                      "at address: %#" PRIx64 "\n", reg_array->prefix, a=
ddr);
>          return;
>      }
>
> @@ -224,8 +224,8 @@ uint64_t register_read_memory(void *opaque, hwaddr ad=
dr,
>      }
>
>      if (!reg) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "Read to unimplemented register a=
t " \
> -                      "address: %#" PRIx64 "\n", addr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s:  read to unimplemented regis=
ter " \
> +                      "at address: %#" PRIx64 "\n", reg_array->prefix, a=
ddr);
>          return 0;
>      }
>
> --
> 2.11.0
>
>
