Received: from eggs.gnu.org ([209.51.188.92]:47204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjfQT-00036k-Pe
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 02:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjfQR-00082Z-LW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 02:15:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjfQR-0007qt-Bn
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 02:15:47 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-5-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <99cdf618-d63c-3362-9143-513cbad2febc@redhat.com>
Date: Wed, 16 Jan 2019 08:15:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-5-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/37] hw/m68k/Makefile.objs:
 Conditionally build boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> CONFIG_AN5206, CONFIG_MCF5206 and CONFIG_MCF5208 make
> variables created for m68k boards, and added to
> default-configs/m86k-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/m68k-softmmu.mak | 3 +++
>  hw/m68k/Makefile.objs            | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-so=
ftmmu.mak
> index 60f7cdfbf2..a179da9077 100644
> --- a/default-configs/m68k-softmmu.mak
> +++ b/default-configs/m68k-softmmu.mak
> @@ -2,3 +2,6 @@
> =20
>  CONFIG_COLDFIRE=3Dy
>  CONFIG_PTIMER=3Dy
> +CONFIG_AN5206=3Dy
> +CONFIG_MCF5206=3Dy
> +CONFIG_MCF5208=3Dy
> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
> index d1f089c08a..fa287edd0b 100644
> --- a/hw/m68k/Makefile.objs
> +++ b/hw/m68k/Makefile.objs
> @@ -1,2 +1,3 @@
> -obj-y +=3D an5206.o mcf5208.o
> -obj-y +=3D mcf5206.o mcf_intc.o
> +obj-$(CONFIG_AN5206) +=3D an5206.o
> +obj-$(CONFIG_MCF5206) +=3D mcf5206.o
> +obj-$(CONFIG_MCF5208) +=3D mcf5208.o mcf_intc.o

The naming of the files is a little bit unfortunate, but
there are only two Coldfire boards: an5206 and mcf5208evb.
mcf5206.c belongs to the an5206 board.
So may I suggest to only use two CONFIG switches like this:

obj-$(CONFIG_AN5206) +=3D an5206.o mcf5206.o
obj-$(CONFIG_MCF5208EVB) +=3D mcf5208.o mcf_intc.o

?

 Thanks,
  Thomas
