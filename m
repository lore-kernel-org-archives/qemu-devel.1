Received: from eggs.gnu.org ([2001:4830:134:3::10]:37665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdi4-0003j8-Co
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdi3-0003SD-Ho
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:03:44 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVdi3-0003Rt-3Q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:03:43 -0400
Received: by mail-oi0-x243.google.com with SMTP id i205-v6so3124750oib.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618161729.334-3-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 15:03:21 +0100
Message-ID: <CAFEAcA8HzQrQE1bQo_N27s4F5eLreX8wb3n=zQBZ9j60KQX=rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/26] chardev: remove
 qemu_chr_fe_write_all() counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 18 June 2018 at 17:17, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
> There is no obvious reason to have a loop counter. This limits from
> reading several megabytes large buffers in one go, since socket
> read/write usually have a limit.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-fe.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index b1f228e8b5..f158f158f8 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -56,7 +56,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_=
t *buf, int len)
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>  {
>      Chardev *s =3D be->chr;
> -    int offset =3D 0, counter =3D 10;
> +    int offset =3D 0;
>      int res;

Subject says "qemu_char_fe_write_all()" but patch is changing
qemu_chr_fe_read_all()...

thanks
-- PMM
