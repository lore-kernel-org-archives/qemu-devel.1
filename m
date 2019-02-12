Received: from eggs.gnu.org ([209.51.188.92]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtZkX-0007ky-0w
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtZkV-00011Z-58
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:13:28 -0500
MIME-Version: 1.0
References: <20190212145722.31891-1-philmd@redhat.com>
In-Reply-To: <20190212145722.31891-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Feb 2019 16:13:08 +0100
Message-ID: <CAJ+F1CKSOKYpfY8Pa6K-cttjopq2Tc_SEHvW2biU9E2WFYjAjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev/wctablet: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Anatoli Huseu1 <avg.tolik@gmail.com>, qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 12, 2019 at 4:12 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The correct name is Wacom.
> Fix the typo present this the origin of this file (378af96155d).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/wctablet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 969d014574..35dbd29a33 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -177,7 +177,7 @@ static void wctablet_input_sync(DeviceState *dev)
>  }
>
>  static QemuInputHandler wctablet_handler =3D {
> -    .name  =3D "QEMU Wacome Pen Tablet",
> +    .name  =3D "QEMU Wacom Pen Tablet",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>      .event =3D wctablet_input_event,
>      .sync  =3D wctablet_input_sync,
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
