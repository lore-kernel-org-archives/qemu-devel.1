Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ckmcu-0007si-9x
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ckmcq-0003F1-8z
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:00:12 -0500
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d5475df8-290b-07d4-d177-979d78850615@redhat.com>
Date: Mon, 6 Mar 2017 08:00:01 +0100
MIME-Version: 1.0
In-Reply-To: <cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/13] ppc: Add SM501 device in config
 for ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org

On 13.12.2016 22:00, BALATON Zoltan wrote:
> This is not used by default on any emulated machine yet but it is
> still useful to have it compiled so it can be added from the command
> line for clients that can use it (e.g. MorphOS has no driver for any
> other emulated video cards but can output via SM501)
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  default-configs/ppc-softmmu.mak    | 1 +
>  default-configs/ppcemb-softmmu.mak | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-soft=
mmu.mak
> index 09c1d45..1f1cd85 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -45,6 +45,7 @@ CONFIG_OPENPIC_KVM=3D$(and $(CONFIG_E500),$(CONFIG_KV=
M))
>  CONFIG_PLATFORM_BUS=3Dy
>  CONFIG_ETSEC=3Dy
>  CONFIG_LIBDECNUMBER=3Dy
> +CONFIG_SM501=3Dy
>  # For PReP
>  CONFIG_SERIAL_ISA=3Dy
>  CONFIG_MC146818RTC=3Dy
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcem=
b-softmmu.mak
> index 7f56004..94340de 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -15,3 +15,4 @@ CONFIG_I8259=3Dy
>  CONFIG_XILINX=3Dy
>  CONFIG_XILINX_ETHLITE=3Dy
>  CONFIG_LIBDECNUMBER=3Dy
> +CONFIG_SM501=3Dy

Looks like there are indeed embedded PPC devices that are shipped with
the SM501 controller (e.g. the TQM5200), so I think this makes sense:

Reviewed-by: Thomas Huth <thuth@redhat.com>

Note: In case you respin the series, you might want to add this
CONFIG_SM501 to ppc64-softmmu.mak, too, since it is a superset of the
32-bit config (i.e. it can also emulate the 32-bit embedded chips).

 Thomas
