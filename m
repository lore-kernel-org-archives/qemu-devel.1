Received: from eggs.gnu.org ([2001:4830:134:3::10]:44732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXXSc-0000AZ-CB
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXXSa-0007xM-PZ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:15:21 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXXSa-0007v9-Ap
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:15:20 -0500
Received: by mail-it0-x241.google.com with SMTP id u62so2679710ita.2
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 11:15:19 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1515108094-11508-1-git-send-email-mst@redhat.com>
References: <1515108094-11508-1-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 5 Jan 2018 16:15:18 -0300
Message-ID: <CAAdtpL4WQhtLOZcRSTFvTbLGs7f4miRKTPtE-uqrP0h2qOm32A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] isa/piix: move to mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi Michael,

On Thu, Jan 4, 2018 at 8:21 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> This device is only used on mips, move to the correct maintainer
> section.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0255113..ab30f1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -175,6 +175,7 @@ F: include/hw/intc/mips_gic.h
>  F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
>  F: disas/mips.c
> +F: hw/isa/piix4.c

NACK this isn't the correct section (MIPS architecture),

The section you want to update is the "Malta board" one.

Now the 82371 devices are broadly use with X86 machines, so I am a bit
reluctant to this change.

Maybe I am misunderstanding the 'X86 machines PC' entry, but I see you
are the unique maintainer of this entry which status is "Supported:
Someone is actually paid to look after this".
My guess is you are paid to work on _recent_ PC machines and you are
probably receiving too many patches.

I suggest we split this section in "recent PC" vs "outdated PC".
It might be hard to draw a line, but maybe i440FX vs Q35 is a good one.

If you agree to unburden some files you don't find relevant to the
"recent PC" entry,
Herv=C3=A9 and I volunteer for the "outdated PC" one with a "Odd Fixes" sta=
tus
(has a maintainer but they don't have time to do much other than throw
the odd patch in).

I hope you won't take this suggestion badly, we just offer help :)

Regards,

Phil.

>  Moxie
>  M: Anthony Green <green@moxielogic.com>
> @@ -849,7 +850,6 @@ F: hw/pci-host/q35.c
>  F: hw/pci-host/pam.c
>  F: include/hw/pci-host/q35.h
>  F: include/hw/pci-host/pam.h
> -F: hw/isa/piix4.c
>  F: hw/isa/lpc_ich9.c
>  F: hw/i2c/smbus_ich9.c
>  F: hw/acpi/piix4.c
> --
> MST
