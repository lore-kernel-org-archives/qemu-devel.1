Received: from eggs.gnu.org ([2001:4830:134:3::10]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eBg2v-0007Ny-5R
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eBg2r-0002zO-6c
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:58:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eBg2r-0002yt-0m
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:58:25 -0500
References: <20171106115347.19873-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b691e0e4-0131-202a-feb2-97659816477b@redhat.com>
Date: Mon, 6 Nov 2017 12:58:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171106115347.19873-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: restrict vmcoreinfo to
 fw_cfg+dma capable targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, danielhb@linux.vnet.ibm.com

On 06.11.2017 12:53, Marc-Andr=C3=A9 Lureau wrote:
> vmcoreinfo is built for all targets. However, it requires fw_cfg with
> DMA operations support (write operation). Restrict vmcoreinfo exposure
> to architectures that are supporting FW_CFG_DMA, that is arm-virt and
> x86 only atm.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  default-configs/arm-softmmu.mak    | 2 ++
>  default-configs/i386-softmmu.mak   | 1 +
>  default-configs/x86_64-softmmu.mak | 1 +
>  hw/misc/Makefile.objs              | 2 +-
>  4 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> index 5059d134c8..d37edc4312 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -130,3 +130,5 @@ CONFIG_SMBIOS=3Dy
>  CONFIG_ASPEED_SOC=3Dy
>  CONFIG_GPIO_KEY=3Dy
>  CONFIG_MSF2=3Dy
> +
> +CONFIG_FW_CFG_DMA=3Dy

Maybe remove the empty line?

Apart from that, patch looks good to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
