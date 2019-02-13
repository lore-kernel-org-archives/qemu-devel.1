Received: from eggs.gnu.org ([209.51.188.92]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gtuVJ-0003lg-Eu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gtuVF-0002rC-Lz
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:23:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gtuVF-0002oq-He
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:23:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so1304847qka.2
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 05:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20190213123446.1768-1-philmd@redhat.com>
In-Reply-To: <20190213123446.1768-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 14:22:50 +0100
Message-ID: <CAMxuvaxbiwiJUGSD=RjKGqPxH=9tGL-0VUKvRNLwR+Kn2_VKCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] chardev/wctablet: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Anatoli Huseu1 <avg.tolik@gmail.com>

Hi

On Wed, Feb 13, 2019 at 1:34 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The correct name is Wacom.
> Fix the typo which is present since 378af96155d.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Use correct English in description

thanks, I'll queue the patch in next chardev PR.

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
