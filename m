Received: from eggs.gnu.org ([2001:4830:134:3::10]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPxl0-0001pm-2x
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPxkv-0000Zj-37
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:10:46 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dPxku-0000ZN-PX
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:10:41 -0400
Received: by mail-lf0-x241.google.com with SMTP id g21so3716434lfk.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 14:10:40 -0700 (PDT)
Date: Tue, 27 Jun 2017 23:10:37 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170627211037.GE2201@toto>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<55b6931c368b67ece2f0bd7d8e83092727df1e3c.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b6931c368b67ece2f0bd7d8e83092727df1e3c.1498596157.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 3/3] char-socket: Report TCP socket
 waiting as a warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, alistair23@gmail.com

On Tue, Jun 27, 2017 at 01:45:48PM -0700, Alistair Francis wrote:
> When QEMU is waiting for a TCP socket connection it reports that message as
> an error. This isn't an error it is a warnign so let's change the report to
> use warning_report() instead.

Hi Alistair,

Isn't this more like an informational message rather than a warning?

A warning would indicate to me that something unexpected and perhaps wrong happened.
In this case, there's nothing wrong going on.

We may need more classes, like 'info:' and/or maybe others...

Cheers,
Edgar



> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..5a56628e74 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -765,7 +765,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>       * in TLS and telnet cases, only wait for an accepted socket */
>      while (!s->ioc) {
>          if (s->is_listen) {
> -            error_report("QEMU waiting for connection on: %s",
> +            warning_report("QEMU waiting for connection on: %s",
>                           chr->filename);
>              qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
>              tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
> -- 
> 2.11.0
> 
> 
