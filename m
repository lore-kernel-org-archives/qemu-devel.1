Received: from eggs.gnu.org ([2001:4830:134:3::10]:44834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXQQ2-0000k3-8v
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXQPz-00084X-44
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:44:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXQPy-00082k-RO
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:44:10 -0500
References: <1515108094-11508-1-git-send-email-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd3e8757-94f8-60e4-eaea-4663a32b2aa8@redhat.com>
Date: Fri, 5 Jan 2018 12:44:00 +0100
MIME-Version: 1.0
In-Reply-To: <1515108094-11508-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 05/01/2018 00:21, Michael S. Tsirkin wrote:
> This device is only used on mips, move to the correct maintainer
> section.
>=20
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0255113..ab30f1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -175,6 +175,7 @@ F: include/hw/intc/mips_gic.h
>  F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
>  F: disas/mips.c
> +F: hw/isa/piix4.c
> =20
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
>=20
