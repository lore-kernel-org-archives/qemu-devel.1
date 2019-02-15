Received: from eggs.gnu.org ([209.51.188.92]:53984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guc3K-0005xz-16
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guc3J-0000Rh-5o
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:53:09 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1guc3I-0008V6-Td
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:53:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id v13so10032714wrw.5
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-10-philmd@redhat.com>
In-Reply-To: <20190214201939.494-10-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Feb 2019 12:52:21 +0100
Message-ID: <CAJ+F1CJYRYH0uE8NZqPquQ+0PHHZ_fN2yBOR=zLOtbKvBwDMrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 9/9] ccid-card-passthru: Use size_t for
 index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 14, 2019 at 9:27 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The variable 'opt_bytes' is an index to the data[] array.
> Use size_t for indexes.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/ccid-card-passthru.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 083eb5ca08..664e8a1b54 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -152,7 +152,7 @@ static void ccid_card_vscard_handle_init(
>  static int check_atr(PassthruState *card, uint8_t *data, size_t len)
>  {
>      size_t historical_length;
> -    int opt_bytes;
> +    size_t opt_bytes;
>      int td_count =3D 0;
>      int td;
>
> @@ -192,12 +192,13 @@ static int check_atr(PassthruState *card, uint8_t *=
data, size_t len)
>      }
>      if (len > 2 + historical_length + opt_bytes) {
>          DPRINTF(card, D_WARN,
> -            "atr too long: len %zu, but hist/opt %zu/%d, T1 0x%X\n",
> +            "atr too long: len %zu, but hist/opt %zu/%zu, T1 0x%X\n",
>              len, historical_length, opt_bytes, data[1]);
>          /* let it through */
>      }
>      DPRINTF(card, D_VERBOSE,
> -            "atr passes check: %zu total length, %zu historical, %d opti=
onal\n",
> +            "atr passes check: %zu total length,"
> +            " %zu historical, %zu optional\n",
>              len, historical_length, opt_bytes);
>
>      return 1;
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
