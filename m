Received: from eggs.gnu.org ([2001:4830:134:3::10]:50999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4LKL-0003UN-0S
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4LKF-00012m-Dr
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:26:09 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-37-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7bf3fd02-7df4-456e-124c-8079b90e5fb8@redhat.com>
Date: Tue, 17 Oct 2017 08:25:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-37-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 36/39] i386/pc: move pvpanic.c from
 hw/misc/ to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


Add at least a short patch description, please (not everybody can read
your mind ;-))

On 17.10.2017 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  default-configs/i386-softmmu.mak   | 1 -
>  default-configs/x86_64-softmmu.mak | 1 -
>  hw/{misc =3D> i386}/pvpanic.c        | 0
>  hw/i386/Makefile.objs              | 2 +-
>  hw/misc/Makefile.objs              | 1 -
>  5 files changed, 1 insertion(+), 4 deletions(-)
>  rename hw/{misc =3D> i386}/pvpanic.c (100%)
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index dbc4e65652..541ec8604d 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -46,7 +46,6 @@ CONFIG_LPC_ICH9=3Dy
>  CONFIG_PCI_Q35=3Dy
>  CONFIG_APIC=3Dy
>  CONFIG_IOAPIC=3Dy
> -CONFIG_PVPANIC=3Dy

Looks like QEMU currently can not be build without CONFIG_PVPANIC, so
this config switch is useless, indeed. Should be OK to remove it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
