Received: from eggs.gnu.org ([2001:4830:134:3::10]:34188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fIbsT-00050W-7a
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fIbsQ-0007cH-2k
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:28:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fIbsP-0007Zu-UF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:28:34 -0400
Received: by mail-it0-f68.google.com with SMTP id y189-v6so2490715itb.2
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:28:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515152500.19460-2-f4bug@amsat.org>
References: <20180515152500.19460-1-f4bug@amsat.org>
	<20180515152500.19460-2-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 May 2018 17:28:31 +0200
Message-ID: <CAMxuvawA5g7oZ4rF4+69Tko8_bZ1+k1JbPvgYe6mYVUccMYoyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/isa/superio: Fix inconsistent
 use of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Tue, May 15, 2018 at 5:24 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> 4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
> use of Chardev->be. Also, this CharBackend member is private and is
> not supposed to be accessible.
>
> Fix it by removing the inconsistent check.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/isa/isa-superio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 76286c81a1..bb88251f95 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -43,7 +43,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
>          if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of parallel_hds[] *=
/
>              chr =3D parallel_hds[i];
> -            if (chr =3D=3D NULL || chr->be) {
> +            if (chr =3D=3D NULL) {
>                  name =3D g_strdup_printf("discarding-parallel%d", i);
>                  chr =3D qemu_chr_new(name, "null");
>              } else {
> @@ -83,7 +83,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
>          if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of serial_hd() */
>              chr =3D serial_hd(i);
> -            if (chr =3D=3D NULL || chr->be) {
> +            if (chr =3D=3D NULL) {
>                  name =3D g_strdup_printf("discarding-serial%d", i);
>                  chr =3D qemu_chr_new(name, "null");
>              } else {
> --
> 2.17.0
>
