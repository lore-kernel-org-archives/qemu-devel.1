Received: from eggs.gnu.org ([2001:4830:134:3::10]:52723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHyMe-0000xI-FV
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHyMb-0007Fu-Nk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:12:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHyMb-0007FN-HR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:12:33 -0400
Received: by mail-oi0-x242.google.com with SMTP id d99so11614645oic.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 13:12:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb3e62b0-9f76-5ccc-90b8-047d1a67f2be@amsat.org>
Date: Mon, 5 Jun 2017 17:12:27 -0300
MIME-Version: 1.0
In-Reply-To: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] char-socket: Don't report TCP
 socket waiting as an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: alistair23@gmail.com

On 06/05/2017 03:34 PM, Alistair Francis wrote:
> When QEMU is waiting for a TCP socket connection it reports that message as
> an error. This isn't an error though, so let's change the report to just
> use qemu_log().
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>
>  chardev/char-socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..a9884fa85b 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -27,6 +27,7 @@
>  #include "io/channel-tls.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qemu/log.h"
>  #include "qapi/clone-visitor.h"
>
>  #include "chardev/char-io.h"
> @@ -765,7 +766,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>       * in TLS and telnet cases, only wait for an accepted socket */
>      while (!s->ioc) {
>          if (s->is_listen) {
> -            error_report("QEMU waiting for connection on: %s",
> +            qemu_log("QEMU waiting for connection on: %s",
>                           chr->filename);
>              qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
>              tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
>
