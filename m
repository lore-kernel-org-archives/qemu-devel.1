Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F81C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E150520838
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSvN4hHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E150520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5pR-00041w-VZ
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5o8-000251-BM; Sun, 06 Sep 2020 21:18:56 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:34871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5o5-0003SK-3G; Sun, 06 Sep 2020 21:18:56 -0400
Received: by mail-oo1-xc42.google.com with SMTP id k13so2956187oor.2;
 Sun, 06 Sep 2020 18:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Pgm7guJikuCtm948Ra9ie/IRNBNn0RwaFbloQ4gY1QE=;
 b=hSvN4hHOW1Wth1svXvpZedWiG/Cx/1EZvdZ9UU1wHIYSS0M+hJ8gPX+Ba29ivcdGOt
 alqcrmX4HJlcivSDFcEjkGg7bvXMdQ34mGbpspnRHTIujxnO87m9RF9S52Ymfg/SqA/T
 ySpi2/Z23qNtqFIultsxz3fO0OyOZSK6DU6EuXQg7BktZ5h30vl2NeqKngCMC1999ZBo
 EL/0btVOug6kRiOkRrhdcQi06fgwrOMcOQcLFED6TC49N70aximDJ0Hz8hyGboP/AsYt
 HJxcyW2WVIPSkfSq2qN+SDra5H/mvyq7yYZJrSVFVCwCXpyKHPAmhauQTqLnGqo6Iu+l
 pn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Pgm7guJikuCtm948Ra9ie/IRNBNn0RwaFbloQ4gY1QE=;
 b=t4EheI0aK48Xa4nR5OYvUzyM/nDHNEHizuVrdszpO2///KxOzydSmNXRvcDbIZhDgT
 HyPOqwLv8B8M00lkeo7va92m+8F4NoG7Hfwx/dyd0yRZnI37NNCSCMxkQvg3lQiw2PT+
 veMehA+VStK2LHsmL77Zrz8ZaOVDoGMGI0npfeWPaCxZIfyOiWarqKAYLGGp8BN4cjfy
 9CVACf+5gwAztzhHAcK45QUq0zMMWF5QqdZHxp+vaEFQno3AarkESOa2vznmJ2G/BdcV
 LFDUPFL52sqTMwaFvgfUlKUjJYFLQJWc8lNS/R88dELu0OVr1AiX8l7pzsO4LAsXyAC5
 XfzA==
X-Gm-Message-State: AOAM53335C1C7LVUiyrvMeC2grMtoVlKh99r110+mkda67Ll1CoNUB+V
 I6rsdS/5eKHB59Kehsg5bSy/9eKCFmXO/FHlg70=
X-Google-Smtp-Source: ABdhPJzt2mF3a9BH/91RVQssFQKYTP/9hu8Ejll6rixV1o+rjQxPticG71snyaaBMW7YafrXuum3oQ0y/N2U9JXDhdk=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr13380530ooj.1.1599441531035;
 Sun, 06 Sep 2020 18:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-14-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-14-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:18:14 +0800
Message-ID: <CAKXe6SLqsDC7EfMjwu519HxsUC49zU=oXGyC-R_Z1YerZNtNLA@mail.gmail.com>
Subject: Re: [PATCH 13/13] dma: Let dma_memory_map() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Qemu Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:52=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Let devices specify transaction attributes when calling
> dma_memory_map().
>
> Patch created mechanically using spatch with this script:
>
>   @@
>   expression E1, E2, E3, E4;
>   @@
>   - dma_memory_map(E1, E2, E3, E4)
>   + dma_memory_map(E1, E2, E3, E4, MEMTXATTRS_UNSPECIFIED)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/hw/pci/pci.h    | 3 ++-
>  include/sysemu/dma.h    | 5 +++--
>  dma-helpers.c           | 3 ++-
>  hw/display/virtio-gpu.c | 8 ++++++--
>  hw/hyperv/vmbus.c       | 8 +++++---
>  hw/ide/ahci.c           | 9 ++++++---
>  hw/usb/libhw.c          | 3 ++-
>  hw/virtio/virtio.c      | 6 ++++--
>  8 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 0c3217e019c..a221dfb3b08 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -831,7 +831,8 @@ static inline void *pci_dma_map(PCIDevice *dev, dma_a=
ddr_t addr,
>  {
>      void *buf;
>
> -    buf =3D dma_memory_map(pci_get_address_space(dev), addr, plen, dir);
> +    buf =3D dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
> +                         MEMTXATTRS_UNSPECIFIED);
>      return buf;
>  }
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index b9cb9c8944b..bb8b0a059f5 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -203,16 +203,17 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_ad=
dr_t addr,
>   * @addr: address within that address space
>   * @len: pointer to length of buffer; updated on return
>   * @dir: indicates the transfer direction
> + * @attrs: memory attributes
>   */
>  static inline void *dma_memory_map(AddressSpace *as,
>                                     dma_addr_t addr, dma_addr_t *len,
> -                                   DMADirection dir)
> +                                   DMADirection dir, MemTxAttrs attrs)
>  {
>      hwaddr xlen =3D *len;
>      void *p;
>
>      p =3D address_space_map(as, addr, &xlen, dir =3D=3D DMA_DIRECTION_FR=
OM_DEVICE,
> -                          MEMTXATTRS_UNSPECIFIED);
> +                          attrs);
>      *len =3D xlen;
>      return p;
>  }
> diff --git a/dma-helpers.c b/dma-helpers.c
> index 6c3b2200f16..0507a6f95b9 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -143,7 +143,8 @@ static void dma_blk_cb(void *opaque, int ret)
>      while (dbs->sg_cur_index < dbs->sg->nsg) {
>          cur_addr =3D dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_b=
yte;
>          cur_len =3D dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byt=
e;
> -        mem =3D dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir=
);
> +        mem =3D dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir=
,
> +                             MEMTXATTRS_UNSPECIFIED);
>          /*
>           * Make reads deterministic in icount mode. Windows sometimes is=
sues
>           * disk read requests with overlapping SGs. It leads
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c1500..be7f5cdee46 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -648,7 +648,9 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>          hwaddr len =3D l;
>          (*iov)[i].iov_len =3D l;
>          (*iov)[i].iov_base =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
> -                                            a, &len, DMA_DIRECTION_TO_DE=
VICE);
> +                                            a, &len,
> +                                            DMA_DIRECTION_TO_DEVICE,
> +                                            MEMTXATTRS_UNSPECIFIED);
>          if (addr) {
>              (*addr)[i] =3D a;
>          }
> @@ -1049,7 +1051,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e, size_t size,
>              hwaddr len =3D res->iov[i].iov_len;
>              res->iov[i].iov_base =3D
>                  dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
> -                               res->addrs[i], &len, DMA_DIRECTION_TO_DEV=
ICE);
> +                               res->addrs[i], &len,
> +                               DMA_DIRECTION_TO_DEVICE,
> +                               MEMTXATTRS_UNSPECIFIED);
>
>              if (!res->iov[i].iov_base || len !=3D res->iov[i].iov_len) {
>                  /* Clean up the half-a-mapping we just created... */
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 75af6b83dde..56621d72e5b 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -372,7 +372,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *b=
uf, uint32_t len)
>
>              maddr =3D (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off=
_in_page;
>
> -            iter->map =3D dma_memory_map(iter->as, maddr, &mlen, iter->d=
ir);
> +            iter->map =3D dma_memory_map(iter->as, maddr, &mlen, iter->d=
ir,
> +                                       MEMTXATTRS_UNSPECIFIED);
>              if (mlen !=3D pgleft) {
>                  dma_memory_unmap(iter->as, iter->map, mlen, iter->dir, 0=
);
>                  iter->map =3D NULL;
> @@ -488,7 +489,8 @@ int vmbus_map_sgl(VMBusChanReq *req, DMADirection dir=
, struct iovec *iov,
>                  goto err;
>              }
>
> -            iov[ret_cnt].iov_base =3D dma_memory_map(sgl->as, a, &l, dir=
);
> +            iov[ret_cnt].iov_base =3D dma_memory_map(sgl->as, a, &l, dir=
,
> +                                                   MEMTXATTRS_UNSPECIFIE=
D);
>              if (!l) {
>                  ret =3D -EFAULT;
>                  goto err;
> @@ -564,7 +566,7 @@ static vmbus_ring_buffer *ringbuf_map_hdr(VMBusRingBu=
fCommon *ringbuf)
>      dma_addr_t mlen =3D sizeof(*rb);
>
>      rb =3D dma_memory_map(ringbuf->as, ringbuf->rb_addr, &mlen,
> -                        DMA_DIRECTION_FROM_DEVICE);
> +                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIE=
D);
>      if (mlen !=3D sizeof(*rb)) {
>          dma_memory_unmap(ringbuf->as, rb, mlen,
>                           DMA_DIRECTION_FROM_DEVICE, 0);
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index b696c6291a3..fe1a4e2b1a2 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -249,7 +249,8 @@ static void map_page(AddressSpace *as, uint8_t **ptr,=
 uint64_t addr,
>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>      }
>
> -    *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
> +    *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE,
> +                          MEMTXATTRS_UNSPECIFIED);
>      if (len < wanted) {
>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>          *ptr =3D NULL;
> @@ -938,7 +939,8 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUS=
GList *sglist,
>
>      /* map PRDT */
>      if (!(prdt =3D dma_memory_map(ad->hba->as, prdt_addr, &prdt_len,
> -                                DMA_DIRECTION_TO_DEVICE))){
> +                                DMA_DIRECTION_TO_DEVICE,
> +                                MEMTXATTRS_UNSPECIFIED))) {
>          trace_ahci_populate_sglist_no_map(ad->hba, ad->port_no);
>          return -1;
>      }
> @@ -1299,7 +1301,8 @@ static int handle_cmd(AHCIState *s, int port, uint8=
_t slot)
>      tbl_addr =3D le64_to_cpu(cmd->tbl_addr);
>      cmd_len =3D 0x80;
>      cmd_fis =3D dma_memory_map(s->as, tbl_addr, &cmd_len,
> -                             DMA_DIRECTION_FROM_DEVICE);
> +                             DMA_DIRECTION_FROM_DEVICE,
> +                             MEMTXATTRS_UNSPECIFIED);
>      if (!cmd_fis) {
>          trace_handle_cmd_badfis(s, port);
>          return -1;
> diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
> index 9c33a1640f7..f350eae443d 100644
> --- a/hw/usb/libhw.c
> +++ b/hw/usb/libhw.c
> @@ -36,7 +36,8 @@ int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
>
>          while (len) {
>              dma_addr_t xlen =3D len;
> -            mem =3D dma_memory_map(sgl->as, base, &xlen, dir);
> +            mem =3D dma_memory_map(sgl->as, base, &xlen, dir,
> +                                 MEMTXATTRS_UNSPECIFIED);
>              if (!mem) {
>                  goto err;
>              }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e9830252176..c951131ba39 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1320,7 +1320,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, =
unsigned int *p_num_sg,
>          iov[num_sg].iov_base =3D dma_memory_map(vdev->dma_as, pa, &len,
>                                                is_write ?
>                                                DMA_DIRECTION_FROM_DEVICE =
:
> -                                              DMA_DIRECTION_TO_DEVICE);
> +                                              DMA_DIRECTION_TO_DEVICE,
> +                                              MEMTXATTRS_UNSPECIFIED);
>          if (!iov[num_sg].iov_base) {
>              virtio_error(vdev, "virtio: bogus descriptor or out of resou=
rces");
>              goto out;
> @@ -1369,7 +1370,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev,=
 struct iovec *sg,
>          sg[i].iov_base =3D dma_memory_map(vdev->dma_as,
>                                          addr[i], &len, is_write ?
>                                          DMA_DIRECTION_FROM_DEVICE :
> -                                        DMA_DIRECTION_TO_DEVICE);
> +                                        DMA_DIRECTION_TO_DEVICE,
> +                                        MEMTXATTRS_UNSPECIFIED);
>          if (!sg[i].iov_base) {
>              error_report("virtio: error trying to map MMIO memory");
>              exit(1);
> --
> 2.26.2
>
>

