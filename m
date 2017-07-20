Received: from eggs.gnu.org ([2001:4830:134:3::10]:55721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY80g-0001c9-3P
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY80e-0002sC-Us
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:44:42 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dY80e-0002rp-Jq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:44:40 -0400
Received: by mail-lf0-x242.google.com with SMTP id k82so879203lfg.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-6-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-6-git-send-email-sf@sfritsch.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Jul 2017 09:44:28 +0000
Message-ID: <CAJ+F1C+jaaM3RO+daipiUNnVmLjZOVd3vGjT=p=E0cKUtQp_aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] usb-ccid: Fix USB descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 11:09 AM Stefan Fritsch <sf@sfritsch.de> wrote:

> From: Stefan Fritsch <stefan_fritsch@genua.de>
>
> - We want to support both T=3D0 and T=3D1. Additionally, note that all
>   fields in USB descriptors are little endian and the supported
>   protocols are in the lowest byte the of the 32-Bit dwProtocols field.
> - We want APDU level exchanges. This saves us from PPS exchanges and from
>   APDU reassembly from T=3D1 packets.
>
>
Did you test this with various versions of Windows?


> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
> ---
>  hw/usb/dev-smartcard-reader.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
> index 769949144b..bc4dc35d3f 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -353,8 +353,8 @@ static const uint8_t qemu_ccid_descriptor[] =3D {
>                       */
>          0x07,       /* u8  bVoltageSupport; 01h - 5.0v, 02h - 3.0, 03 -
> 1.8 */
>
> -        0x00, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR =3D 0000h.*/
> -        0x01, 0x00, /* PPPP: 0001h =3D Protocol T=3D0, 0002h =3D Protoco=
l T=3D1 */
> +        0x03, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR =3D 0000h.*/
> +        0x00, 0x00, /* PPPP: 0001h =3D Protocol T=3D0, 0002h =3D Protoco=
l T=3D1 */
>                      /* u32 dwDefaultClock; in kHZ (0x0fa0 is 4 MHz) */
>          0xa0, 0x0f, 0x00, 0x00,
>                      /* u32 dwMaximumClock; */
> @@ -397,7 +397,7 @@ static const uint8_t qemu_ccid_descriptor[] =3D {
>                       * insertion and removal. Must set bit 5 in
> bmAttributes
>                       * in Configuration descriptor if 100000 is set.
>                       */
> -        0xfe, 0x04, 0x01, 0x00,
> +        0xfe, 0x04, 0x04, 0x00,
>                      /*
>                       * u32 dwMaxCCIDMessageLength; For extended APDU in
>                       * [261 + 10 , 65544 + 10]. Otherwise the minimum is
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
