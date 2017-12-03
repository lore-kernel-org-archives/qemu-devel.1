Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eLV8D-0007WW-PG
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eLV8C-0003mp-PT
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:20:33 -0500
MIME-Version: 1.0
In-Reply-To: <20171201232433.25193-5-eblake@redhat.com>
References: <20171201232433.25193-1-eblake@redhat.com>
	<20171201232433.25193-5-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 3 Dec 2017 15:20:30 +0100
Message-ID: <CAJ+F1C+F-pHW2RAMZHAEizSG6-E3mf+6sUe7r3GAoGsq5fUUMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] chardev: Clean up previous patch
 indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Sat, Dec 2, 2017 at 12:24 AM, Eric Blake <eblake@redhat.com> wrote:
> The previous patch left in an extra scope layer for ease of
> review; time to remove it.  No semantic change.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


 ---
>  chardev/char-serial.c | 66 +++++++++++++++++++++++++--------------------=
------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 10162f9fa3..93392c528c 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -71,66 +71,64 @@ static void tty_serial_init(int fd, int speed,
>      }
>
>      speed =3D speed * 10 / 11;
> -    {
> -        check_speed(50);
> -        check_speed(75);
> -        check_speed(110);
> -        check_speed(134);
> -        check_speed(150);
> -        check_speed(200);
> -        check_speed(300);
> -        check_speed(600);
> -        check_speed(1200);
> -        check_speed(1800);
> -        check_speed(2400);
> -        check_speed(4800);
> -        check_speed(9600);
> -        check_speed(19200);
> -        check_speed(38400);
> -        /* Non-Posix values follow. They may be unsupported on some syst=
ems. */
> -        check_speed(57600);
> -        check_speed(115200);
> +    check_speed(50);
> +    check_speed(75);
> +    check_speed(110);
> +    check_speed(134);
> +    check_speed(150);
> +    check_speed(200);
> +    check_speed(300);
> +    check_speed(600);
> +    check_speed(1200);
> +    check_speed(1800);
> +    check_speed(2400);
> +    check_speed(4800);
> +    check_speed(9600);
> +    check_speed(19200);
> +    check_speed(38400);
> +    /* Non-Posix values follow. They may be unsupported on some systems.=
 */
> +    check_speed(57600);
> +    check_speed(115200);
>  #ifdef B230400
> -        check_speed(230400);
> +    check_speed(230400);
>  #endif
>  #ifdef B460800
> -        check_speed(460800);
> +    check_speed(460800);
>  #endif
>  #ifdef B500000
> -        check_speed(500000);
> +    check_speed(500000);
>  #endif
>  #ifdef B576000
> -        check_speed(576000);
> +    check_speed(576000);
>  #endif
>  #ifdef B921600
> -        check_speed(921600);
> +    check_speed(921600);
>  #endif
>  #ifdef B1000000
> -        check_speed(1000000);
> +    check_speed(1000000);
>  #endif
>  #ifdef B1152000
> -        check_speed(1152000);
> +    check_speed(1152000);
>  #endif
>  #ifdef B1500000
> -        check_speed(1500000);
> +    check_speed(1500000);
>  #endif
>  #ifdef B2000000
> -        check_speed(2000000);
> +    check_speed(2000000);
>  #endif
>  #ifdef B2500000
> -        check_speed(2500000);
> +    check_speed(2500000);
>  #endif
>  #ifdef B3000000
> -        check_speed(3000000);
> +    check_speed(3000000);
>  #endif
>  #ifdef B3500000
> -        check_speed(3500000);
> +    check_speed(3500000);
>  #endif
>  #ifdef B4000000
> -        check_speed(4000000);
> +    check_speed(4000000);
>  #endif
> -        spd =3D B115200;
> -    }
> +    spd =3D B115200;
>
>  #undef check_speed
>   done:
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
