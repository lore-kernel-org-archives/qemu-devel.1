Received: from eggs.gnu.org ([2001:4830:134:3::10]:41289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7Pmm-0004iV-J0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 13:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7Pml-0000AR-Kd
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 13:48:12 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7Pml-00009F-DX
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 13:48:11 -0400
Received: by mail-wm0-x243.google.com with SMTP id t139so3523631wmt.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2017 18:47:49 +0100
Message-ID: <CAFEAcA8DGeoNWxr9Y-vRXmtR5=7+EMQqfpt5cs7x2qTcfRZR4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv4 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to lance.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Jason Wang <jasowang@redhat.com>

On 25 October 2017 at 16:59, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This enables them to be used outside of lance.c.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>


> diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
> new file mode 100644
> index 0000000..c112fbc
> --- /dev/null
> +++ b/include/hw/net/lance.h
> @@ -0,0 +1,41 @@
> +/*
> + * QEMU AMD PC-Net II (Am79C970A) emulation

Filename says this is Lance ethernet, but the comment says it's PC-Net ?

> +#define TYPE_LANCE "lance"
> +#define SYSBUS_PCNET(obj) \
> +    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)

It's a bit weird that the OBJECT_CHECK macro name
and the state structure name don't line up with
the device name, but this is just code motion so
not a problem.

Other than fixing the comment,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(In an ideal world pcnet.h would be in include/.)

thanks
-- PMM
