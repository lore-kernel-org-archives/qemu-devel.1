Received: from eggs.gnu.org ([2001:4830:134:3::10]:52887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQ4LJ-0001G2-24
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQ4LI-0006aR-6v
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:12:41 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Wed, 28 Jun 2017 01:12:36 -0300
Message-ID: <CAAdtpL7j3exbvgft+6fKfTBOXz4OZ+-8d-TZoxo8HZT1abgsMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 2/4] util/oslib-win32: Remove invalid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair23@gmail.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On Tue, Jun 27, 2017 at 8:57 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> There is no way nhandles can be zero in this section so that part of the
> if statement will always be false. Let's just remove it to make the code
> easier to read.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 80e4668935..7ec0f8e083 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *hand=
les, gint nhandles,
>          /* If we have a timeout, or no handles to poll, be satisfied
>           * with just noticing we have messages waiting.
>           */
> -        if (timeout !=3D 0 || nhandles =3D=3D 0) {
> +        if (timeout !=3D 0) {
>              return 1;
>          }
>
> --
> 2.11.0
>
>
