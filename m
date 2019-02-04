Received: from eggs.gnu.org ([209.51.188.92]:60543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gqbN2-00062r-Lk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gqbN1-0002NW-RD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:20:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gqbN1-0002M1-LO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:20:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so14798322qtc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 02:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20190123172740.32452-1-berrange@redhat.com>
	<20190123172740.32452-17-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-17-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 4 Feb 2019 11:20:42 +0100
Message-ID: <CAMxuvaxZTGVc_UBKrceaQ_czFrANcyQssQr-8bMYpNM73N9ZXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/16] chardev: ensure termios is fully
 initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>

On Wed, Jan 23, 2019 at 6:29 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> valgrind on the test-char.c code reports that 'struct termios' contains
> uninitialized memory.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 3299b46853..a8bae31b8d 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -57,7 +57,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
>  static void tty_serial_init(int fd, int speed,
>                              int parity, int data_bits, int stop_bits)
>  {
> -    struct termios tty;
> +    struct termios tty =3D {0};
>      speed_t spd;
>
>  #if 0
> --
> 2.20.1
>
