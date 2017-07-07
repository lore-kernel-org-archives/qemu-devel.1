Received: from eggs.gnu.org ([2001:4830:134:3::10]:51768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTRV1-00012J-Pi
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTRUy-0000C6-MG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:32:39 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTRUy-0000Bg-Fr
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:32:36 -0400
Received: by mail-qk0-x244.google.com with SMTP id 16so3873614qkg.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 04:32:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<77970edd100d0ddbaeb433d0cb13c96b2be15006.1499381754.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28cc9a62-9cb3-5d39-444d-8541d7576f6d@amsat.org>
Date: Fri, 7 Jul 2017 08:32:29 -0300
MIME-Version: 1.0
In-Reply-To: <77970edd100d0ddbaeb433d0cb13c96b2be15006.1499381754.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/6] char-socket: Report TCP socket
 waiting as information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

On 07/06/2017 08:49 PM, Alistair Francis wrote:
> When QEMU is waiting for a TCP socket connection it reports that message as
> an error. This isn't an error it is just information so let's change the
> report to use info_report() instead.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>   chardev/char-socket.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..a050a686ea 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -765,8 +765,8 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>        * in TLS and telnet cases, only wait for an accepted socket */
>       while (!s->ioc) {
>           if (s->is_listen) {
> -            error_report("QEMU waiting for connection on: %s",
> -                         chr->filename);
> +            info_report("QEMU waiting for connection on: %s",
> +                        chr->filename);
>               qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
>               tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
>               qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, NULL);
> 
