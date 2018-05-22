Received: from eggs.gnu.org ([2001:4830:134:3::10]:54606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fL5qx-0008OH-Nw
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fL5qs-00023h-Rk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:53:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fL5qs-00023H-Mt
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:53:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1526752108-21204-1-git-send-email-patryk@fala.ehost.pl>
Date: Tue, 22 May 2018 13:53:09 +0200
In-Reply-To: <1526752108-21204-1-git-send-email-patryk@fala.ehost.pl> (Patryk
	Olszewski's message of "Sat, 19 May 2018 19:48:28 +0200")
Message-ID: <87o9h7q53u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Remove unwanted crlf conversion in serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patryk Olszewski <patryk@fala.ehost.pl>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Patryk Olszewski <patryk@fala.ehost.pl> writes:

> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
> ---
>  chardev/char-serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index feb52e5..ae548d2 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
>  
>      tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                       | INLCR | IGNCR | ICRNL | IXON);
> -    tty.c_oflag |= OPOST;
> +    tty.c_oflag &= ~OPOST;
>      tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
>      tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
>      switch (data_bits) {

This change may well make sense, but your commit message needs to
explain *why*.

For what it's worth, POSIX documents OPOST as "Post-process output", and
the Linux manual page as "Enable implementation-defined output
processing."
