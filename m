Received: from eggs.gnu.org ([2001:4830:134:3::10]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnMiv-0008ND-4E
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnMiu-0003JX-4O
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:29:21 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnMit-0003JO-Up
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:29:20 -0400
Received: by mail-wm0-x232.google.com with SMTP id f127so1825922wmf.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 03:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831035306.29170-2-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 11:28:58 +0100
Message-ID: <CAFEAcA-NbySdJ3Y-_3x4kbLFOzMEkQ3z5PxGF-4iEfrvXsAVGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 31 August 2017 at 04:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/char/serial.h |  1 +
>  hw/char/serial.c         | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index c4daf11a14..96bccb39e1 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space=
,
>                              hwaddr base, int it_shift,
>                              qemu_irq irq, int baudbase,
>                              Chardev *chr, enum device_endian end);
> +Chardev *serial_chr_nonnull(Chardev *chr);

For new globally-visible function declarations, can we
have a doc-comment form comment that documents the
function, please?

thanks
-- PMM
