Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E8C11D28
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B8B24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="O6yB2NQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B8B24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4z02-0000Lo-6w
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4yz6-0007yy-8C
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4yz3-0005fu-Tl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:28:12 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46455 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4yys-0004r3-Do; Thu, 20 Feb 2020 22:27:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Nxjc2qP6z9sRl; Fri, 21 Feb 2020 14:27:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582255668;
 bh=G+z8gUCKUfHe/W23l+LjfK0aRoRSg3UJJl0zdqsGtkA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O6yB2NQFlvysAE0s4VmDFc8G+I15V9tOcocUnsHNj51bfVbTud09M7vOieapbuSl2
 msPaElQuTEm3xyPOndTC/407lF5FUCva1iqvlEkGPbkTNMT0H2qDOQh3oCXI/2WqoQ
 s9+sFEtOLyOdgdDQoqk5+RXF2EyhtpuYIBpyw308=
Date: Fri, 21 Feb 2020 08:46:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 19/20] Let cpu_[physical]_memory() calls pass a
 boolean 'is_write' argument
Message-ID: <20200220214633.GA2298@umbus.fritz.box>
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-20-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20200220130548.29974-20-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 02:05:47PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Use an explicit boolean type.
>=20
> This commit was produced with the included Coccinelle script
> scripts/coccinelle/exec_rw_const.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  scripts/coccinelle/exec_rw_const.cocci | 14 ++++++++++++++
>  include/exec/cpu-common.h              |  4 ++--
>  hw/display/exynos4210_fimd.c           |  3 ++-
>  hw/display/milkymist-tmu2.c            |  8 ++++----
>  hw/display/omap_dss.c                  |  2 +-
>  hw/display/ramfb.c                     |  2 +-
>  hw/misc/pc-testdev.c                   |  2 +-
>  hw/nvram/spapr_nvram.c                 |  4 ++--
>  hw/ppc/ppc440_uc.c                     |  6 ++++--
>  hw/ppc/spapr_hcall.c                   |  4 ++--
>  hw/s390x/ipl.c                         |  2 +-
>  hw/s390x/s390-pci-bus.c                |  2 +-
>  hw/s390x/virtio-ccw.c                  |  2 +-
>  hw/xen/xen_pt_graphics.c               |  2 +-
>  target/i386/hax-all.c                  |  4 ++--
>  target/s390x/excp_helper.c             |  2 +-
>  target/s390x/helper.c                  |  6 +++---
>  17 files changed, 43 insertions(+), 26 deletions(-)
>=20
> diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/=
exec_rw_const.cocci
> index ee98ce988e..54b1cab8cd 100644
> --- a/scripts/coccinelle/exec_rw_const.cocci
> +++ b/scripts/coccinelle/exec_rw_const.cocci
> @@ -11,6 +11,20 @@ expression E1, E2, E3, E4, E5;
>  |
>  - address_space_rw(E1, E2, E3, E4, E5, 1)
>  + address_space_rw(E1, E2, E3, E4, E5, true)
> +|
> +
> +- cpu_physical_memory_rw(E1, E2, E3, 0)
> ++ cpu_physical_memory_rw(E1, E2, E3, false)
> +|
> +- cpu_physical_memory_rw(E1, E2, E3, 1)
> ++ cpu_physical_memory_rw(E1, E2, E3, true)
> +|
> +
> +- cpu_physical_memory_map(E1, E2, 0)
> ++ cpu_physical_memory_map(E1, E2, false)
> +|
> +- cpu_physical_memory_map(E1, E2, 1)
> ++ cpu_physical_memory_map(E1, E2, true)
>  )
> =20
>  // Use address_space_write instead of casting to non-const
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6bfe201779..e7fd5781ea 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -74,12 +74,12 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
>  static inline void cpu_physical_memory_read(hwaddr addr,
>                                              void *buf, hwaddr len)
>  {
> -    cpu_physical_memory_rw(addr, buf, len, 0);
> +    cpu_physical_memory_rw(addr, buf, len, false);
>  }
>  static inline void cpu_physical_memory_write(hwaddr addr,
>                                               const void *buf, hwaddr len)
>  {
> -    cpu_physical_memory_rw(addr, (void *)buf, len, 1);
> +    cpu_physical_memory_rw(addr, (void *)buf, len, true);
>  }
>  void *cpu_physical_memory_map(hwaddr addr,
>                                hwaddr *plen,
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index c1071ecd46..ec6776680e 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -1164,7 +1164,8 @@ static void fimd_update_memory_section(Exynos4210fi=
mdState *s, unsigned win)
>          goto error_return;
>      }
> =20
> -    w->host_fb_addr =3D cpu_physical_memory_map(fb_start_addr, &fb_mappe=
d_len, 0);
> +    w->host_fb_addr =3D cpu_physical_memory_map(fb_start_addr, &fb_mappe=
d_len,
> +                                              false);
>      if (!w->host_fb_addr) {
>          DPRINT_ERROR("Failed to map window %u framebuffer\n", win);
>          goto error_return;
> diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
> index 199f1227e7..513c0d5bab 100644
> --- a/hw/display/milkymist-tmu2.c
> +++ b/hw/display/milkymist-tmu2.c
> @@ -218,7 +218,7 @@ static void tmu2_start(MilkymistTMU2State *s)
>      glGenTextures(1, &texture);
>      glBindTexture(GL_TEXTURE_2D, texture);
>      fb_len =3D 2ULL * s->regs[R_TEXHRES] * s->regs[R_TEXVRES];
> -    fb =3D cpu_physical_memory_map(s->regs[R_TEXFBUF], &fb_len, 0);
> +    fb =3D cpu_physical_memory_map(s->regs[R_TEXFBUF], &fb_len, false);
>      if (fb =3D=3D NULL) {
>          glDeleteTextures(1, &texture);
>          glXMakeContextCurrent(s->dpy, None, None, NULL);
> @@ -262,7 +262,7 @@ static void tmu2_start(MilkymistTMU2State *s)
> =20
>      /* Read the QEMU dest. framebuffer into the OpenGL framebuffer */
>      fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
> -    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 0);
> +    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, false);
>      if (fb =3D=3D NULL) {
>          glDeleteTextures(1, &texture);
>          glXMakeContextCurrent(s->dpy, None, None, NULL);
> @@ -281,7 +281,7 @@ static void tmu2_start(MilkymistTMU2State *s)
> =20
>      /* Map the texture */
>      mesh_len =3D MESH_MAXSIZE*MESH_MAXSIZE*sizeof(struct vertex);
> -    mesh =3D cpu_physical_memory_map(s->regs[R_VERTICESADDR], &mesh_len,=
 0);
> +    mesh =3D cpu_physical_memory_map(s->regs[R_VERTICESADDR], &mesh_len,=
 false);
>      if (mesh =3D=3D NULL) {
>          glDeleteTextures(1, &texture);
>          glXMakeContextCurrent(s->dpy, None, None, NULL);
> @@ -298,7 +298,7 @@ static void tmu2_start(MilkymistTMU2State *s)
> =20
>      /* Write back the OpenGL framebuffer to the QEMU framebuffer */
>      fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
> -    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 1);
> +    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, true);
>      if (fb =3D=3D NULL) {
>          glDeleteTextures(1, &texture);
>          glXMakeContextCurrent(s->dpy, None, None, NULL);
> diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
> index 637aae8d39..32dc0d6aa7 100644
> --- a/hw/display/omap_dss.c
> +++ b/hw/display/omap_dss.c
> @@ -632,7 +632,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_=
s *s)
>      len =3D s->rfbi.pixels * 2;
> =20
>      data_addr =3D s->dispc.l[0].addr[0];
> -    data =3D cpu_physical_memory_map(data_addr, &len, 0);
> +    data =3D cpu_physical_memory_map(data_addr, &len, false);
>      if (data && len !=3D s->rfbi.pixels * 2) {
>          cpu_physical_memory_unmap(data, len, 0, 0);
>          data =3D NULL;
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index cd94940223..7ba07c80f6 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -57,7 +57,7 @@ static DisplaySurface *ramfb_create_display_surface(int=
 width, int height,
>      }
> =20
>      size =3D (hwaddr)linesize * height;
> -    data =3D cpu_physical_memory_map(addr, &size, 0);
> +    data =3D cpu_physical_memory_map(addr, &size, false);
>      if (size !=3D (hwaddr)linesize * height) {
>          cpu_physical_memory_unmap(data, size, 0, 0);
>          return NULL;
> diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
> index 0fb84ddc6b..8aa8e6549f 100644
> --- a/hw/misc/pc-testdev.c
> +++ b/hw/misc/pc-testdev.c
> @@ -125,7 +125,7 @@ static void test_flush_page_write(void *opaque, hwadd=
r addr, uint64_t data,
>                              unsigned len)
>  {
>      hwaddr page =3D 4096;
> -    void *a =3D cpu_physical_memory_map(data & ~0xffful, &page, 0);
> +    void *a =3D cpu_physical_memory_map(data & ~0xffful, &page, false);
> =20
>      /* We might not be able to get the full page, only mprotect what we =
actually
>         have mapped */
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index 877ddef7b9..15d08281d4 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -89,7 +89,7 @@ static void rtas_nvram_fetch(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
> =20
>      assert(nvram->buf);
> =20
> -    membuf =3D cpu_physical_memory_map(buffer, &len, 1);
> +    membuf =3D cpu_physical_memory_map(buffer, &len, true);
>      memcpy(membuf, nvram->buf + offset, len);
>      cpu_physical_memory_unmap(membuf, len, 1, len);
> =20
> @@ -127,7 +127,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
>          return;
>      }
> =20
> -    membuf =3D cpu_physical_memory_map(buffer, &len, 0);
> +    membuf =3D cpu_physical_memory_map(buffer, &len, false);
> =20
>      alen =3D len;
>      if (nvram->blk) {
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 1a6a8fac22..d5ea962249 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -909,8 +909,10 @@ static void dcr_write_dma(void *opaque, int dcrn, ui=
nt32_t val)
> =20
>                      sidx =3D didx =3D 0;
>                      width =3D 1 << ((val & DMA0_CR_PW) >> 25);
> -                    rptr =3D cpu_physical_memory_map(dma->ch[chnl].sa, &=
rlen, 0);
> -                    wptr =3D cpu_physical_memory_map(dma->ch[chnl].da, &=
wlen, 1);
> +                    rptr =3D cpu_physical_memory_map(dma->ch[chnl].sa, &=
rlen,
> +                                                   false);
> +                    wptr =3D cpu_physical_memory_map(dma->ch[chnl].da, &=
wlen,
> +                                                   true);
>                      if (rptr && wptr) {
>                          if (!(val & DMA0_CR_DEC) &&
>                              val & DMA0_CR_SAI && val & DMA0_CR_DAI) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index b8bb66b5c0..caf55ab044 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -832,7 +832,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>      if (!is_ram_address(spapr, dst) || (dst & ~TARGET_PAGE_MASK) !=3D 0)=
 {
>          return H_PARAMETER;
>      }
> -    pdst =3D cpu_physical_memory_map(dst, &len, 1);
> +    pdst =3D cpu_physical_memory_map(dst, &len, true);
>      if (!pdst || len !=3D TARGET_PAGE_SIZE) {
>          return H_PARAMETER;
>      }
> @@ -843,7 +843,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>              ret =3D H_PARAMETER;
>              goto unmap_out;
>          }
> -        psrc =3D cpu_physical_memory_map(src, &len, 0);
> +        psrc =3D cpu_physical_memory_map(src, &len, false);
>          if (!psrc || len !=3D TARGET_PAGE_SIZE) {
>              ret =3D H_PARAMETER;
>              goto unmap_out;
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 7773499d7f..0817874b48 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -626,7 +626,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      uint8_t *addr;
>      uint64_t len =3D 4096;
> =20
> -    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, 1);
> +    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, true);
>      if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
>          error_report("Cannot set QEMU IPL parameters");
>          return;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 7c6a2b3c63..ed8be124da 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -641,7 +641,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8=
_t to_be_set)
>      hwaddr len =3D 1;
>      uint8_t *ind_addr;
> =20
> -    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, 1);
> +    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
>          s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
>          return -1;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 13f57e7b67..50cf95b781 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -790,7 +790,7 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, u=
int64_t ind_loc,
>      hwaddr len =3D 1;
>      uint8_t *ind_addr;
> =20
> -    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, 1);
> +    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
>          error_report("%s(%x.%x.%04x): unable to access indicator",
>                       __func__, sch->cssid, sch->ssid, sch->schid);
> diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
> index b69732729b..b11e4e0546 100644
> --- a/hw/xen/xen_pt_graphics.c
> +++ b/hw/xen/xen_pt_graphics.c
> @@ -222,7 +222,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenH=
ostPCIDevice *dev,
>      }
> =20
>      /* Currently we fixed this address as a primary for legacy BIOS. */
> -    cpu_physical_memory_rw(0xc0000, bios, bios_size, 1);
> +    cpu_physical_memory_rw(0xc0000, bios, bios_size, true);
>  }
> =20
>  uint32_t igd_read_opregion(XenPCIPassthroughState *s)
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index a9cc51e6ce..38936d7af6 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, str=
uct hax_fastmmio *hft)
>           *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
>           */
>          uint64_t value;
> -        cpu_physical_memory_rw(hft->gpa, &value, hft->size, 0);
> -        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, 1);
> +        cpu_physical_memory_rw(hft->gpa, &value, hft->size, false);
> +        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, true);
>      }
> =20
>      return 0;
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 1e9d6f20c1..3b58d10df3 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -393,7 +393,7 @@ static int mchk_store_vregs(CPUS390XState *env, uint6=
4_t mcesao)
>      MchkExtSaveArea *sa;
>      int i;
> =20
> -    sa =3D cpu_physical_memory_map(mcesao, &len, 1);
> +    sa =3D cpu_physical_memory_map(mcesao, &len, true);
>      if (!sa) {
>          return -EFAULT;
>      }
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index a3a49164e4..b810ad431e 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -151,7 +151,7 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
>      LowCore *lowcore;
>      hwaddr len =3D sizeof(LowCore);
> =20
> -    lowcore =3D cpu_physical_memory_map(env->psa, &len, 1);
> +    lowcore =3D cpu_physical_memory_map(env->psa, &len, true);
> =20
>      if (len < sizeof(LowCore)) {
>          cpu_abort(env_cpu(env), "Could not map lowcore\n");
> @@ -246,7 +246,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool=
 store_arch)
>      hwaddr len =3D sizeof(*sa);
>      int i;
> =20
> -    sa =3D cpu_physical_memory_map(addr, &len, 1);
> +    sa =3D cpu_physical_memory_map(addr, &len, true);
>      if (!sa) {
>          return -EFAULT;
>      }
> @@ -298,7 +298,7 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr,=
 hwaddr len)
>      hwaddr save =3D len;
>      int i;
> =20
> -    sa =3D cpu_physical_memory_map(addr, &save, 1);
> +    sa =3D cpu_physical_memory_map(addr, &save, true);
>      if (!sa) {
>          return -EFAULT;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5O/jcACgkQbDjKyiDZ
s5LKqQ//Y0MOoydRoNQyGadMN6IsO4LqzWL2w/z5cCdHZyt3oly20oHOUETuSw1B
OaGPs0LzoQPkBnWPUka6Rq/MWT8bkKModAuO+i1PLxnuJ08FjmVbmR0BPTmsDAAu
OVhdRclHexYP3WrkRQde5y/I0qeHJTWViFK6rhVRFH0FBi0+x6KKvqrXHoGY1E17
/nY9hnGICRzhyNMdJNN8dMF717JDJ4V+wEj7LsoBEekG7qDcU6daBjRJqDxmU8bn
HrlLbZRiS9j0WCNGq3ocjIL+e8ujr3E2Egwz576dBaK4C3TBoTzYM+GpHmQVubUS
0vkLNXwPZL/5HoH7Aab/9jPuMra4ifytppTJ9kuLBUlQ0TY1iYpGz+D4DOhNdYIf
KonQuwAB2Uk53XHFqrrJF+PkMd7SnFqwC2BCZckJmV/Xjlm0Pu7zW1PezCpTZPCM
5DSORkhRqcJ7Zg6d8fBurn+FfMpjCjqeTzSTU27183AEJp2bMfneeP+wQOuWuUWW
SgnlUehymh0kcfPdNpCKCLSJlzpwJokWrBhzRsZJ+OcOzmZaLr/EJhrCx4NDkj6G
MwiW++72a/b+VfrYH0FQys62aW5PoXK6VZ2TLuNCY2eqpoMChNkXchFgmnvga34F
ssFw22e/Yi8fXSi0vj8QiwVqH+8lDOOaO/03w0/bcY3cc4Vu16A=
=H5IH
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

