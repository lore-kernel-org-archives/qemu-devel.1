Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F476C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B378206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULJJWM5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B378206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgr9C-0007TU-GD
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr89-0006MT-Jx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:46:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr87-0003In-Ks
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:46:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so6394252wrr.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i9po+tm4cgs0An7m7JyrkArCV/kg0GuX8ZeRBZf2Nw8=;
 b=ULJJWM5NlzAPaSG7DSNYhA7ucB+pdHLURSTJIeZ/1FdXqXPlKhFLTP8p6ERCApLSux
 jsHbvlfP35xVZWOo7KeHrB5g7fPATZP1PjwVuKWv7032hB+l1ZxbhfV25a4wp+oAWFPT
 biySVBOmrkUjErZp7ND4jXWSrUUakC43MbxILYCYca5SIGxFQZ4hleGpJMlkQJ9lKM6U
 vs22vLwdiZu6IaRhldfxAaobwcI4R7SRVKIA99MPnqSiNpxSUIt/yk57ni8aoJaP5Iku
 pUIKHfJlYty5HMa7HgRpiJovQftIvuQ6PO6eFe+WSPypGJZSfUGOhvgnbRRds8PAVmKh
 0IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i9po+tm4cgs0An7m7JyrkArCV/kg0GuX8ZeRBZf2Nw8=;
 b=XyQVm8olNv1yG7rO9fcCnAkLm9x+q8/gsIomsm4eYB1u0SVfCs3b3PqSAeXvYL3eJ+
 EBgHby/zGa1Vw6NkEOsbRfgVGGQj41WNNYTh4ip8qGUHzHM1STAmEL+dywLN2uwNOZT6
 k8gYxl4NPsdqQX6C0EIoEQWdDLx0vAlqQRv9ZLByJziDQxhpFeUvHLg+ETyJb9OrNJd4
 lNdlNEg2qTaYQ9GszTG5rPHucrDso4qPVtpybP8wWM6hPntvt/No/VTu0mf79Hcu2tfg
 jLy7z3n+kg9+kx+N9GAw/2UgdkifVRKGP29zgktodEregSNQgfZrtNQKh3LOA7TsBFPY
 dzzg==
X-Gm-Message-State: AOAM5322DiYy4bS2xNHIRDYSsVAVuXkvYRCNI+NRh8RxabJe3onch4pg
 hFU+bA8d9OkpVbnKNmCONZ+vDn5aTfhP9yPpqXc=
X-Google-Smtp-Source: ABdhPJyI/ahYNx6oNxA2MdO2A7u/D2AiGtL+walfBgSsqzc1KYv3VP3DC+Jd422/1rnIi4hnuGO8s4RkWFdPAx62Y5s=
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr4488207wrt.381.1591281962081; 
 Thu, 04 Jun 2020 07:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-6-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-6-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:45:50 +0200
Message-ID: <CAJ+F1CLH7rG_iCNKM7-3ntrHiQECjcnaxbOui3vZ+oWvckE43Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] Lift max memory slots limit imposed by vhost-user
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="00000000000016620705a74334ce"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000016620705a74334ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> Historically, sending all memory regions to vhost-user backends in a
> single message imposed a limitation on the number of times memory
> could be hot-added to a VM with a vhost-user device. Now that backends
> which support the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS send memory
> regions individually, we no longer need to impose this limitation on
> devices which support this feature.
>
> With this change, VMs with a vhost-user device which supports the
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS can support a configurable
> number of memory slots, up to the maximum allowed by the target
> platform.
>
> Existing backends which do not support
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Suggested-by: Mike Cui <cui@nutanix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  docs/interop/vhost-user.rst |  7 +++---
>  hw/virtio/vhost-user.c      | 56
> ++++++++++++++++++++++++++++++---------------
>  2 files changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 037eefa..688b7c6 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1273,10 +1273,9 @@ Master message types
>    feature has been successfully negotiated, this message is submitted
>    by master to the slave. The slave should return the message with a
>    u64 payload containing the maximum number of memory slots for
> -  QEMU to expose to the guest. At this point, the value returned
> -  by the backend will be capped at the maximum number of ram slots
> -  which can be supported by vhost-user. Currently that limit is set
> -  at VHOST_USER_MAX_RAM_SLOTS =3D 8.
> +  QEMU to expose to the guest. The value returned by the backend
> +  will be capped at the maximum number of ram slots which can be
> +  supported by the target platform.
>
>  ``VHOST_USER_ADD_MEM_REG``
>    :id: 37
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 9358406..48b8081 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -35,11 +35,29 @@
>  #include <linux/userfaultfd.h>
>  #endif
>
> -#define VHOST_MEMORY_MAX_NREGIONS    8
> +#define VHOST_MEMORY_BASELINE_NREGIONS    8
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>  #define VHOST_USER_SLAVE_MAX_FDS     8
>
>  /*
> + * Set maximum number of RAM slots supported to
> + * the maximum number supported by the target
> + * hardware plaform.
> + */
> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
> +#include "hw/acpi/acpi.h"
> +#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS
> +
> +#elif defined(TARGET_PPC) || defined(TARGET_PPC_64)
> +#include "hw/ppc/spapr.h"
> +#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
> +
> +#else
> +#define VHOST_USER_MAX_RAM_SLOTS 512
> +#endif
> +
> +/*
>   * Maximum size of virtio device config space
>   */
>  #define VHOST_USER_MAX_CONFIG_SIZE 256
> @@ -127,7 +145,7 @@ typedef struct VhostUserMemoryRegion {
>  typedef struct VhostUserMemory {
>      uint32_t nregions;
>      uint32_t padding;
> -    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
> +    VhostUserMemoryRegion regions[VHOST_MEMORY_BASELINE_NREGIONS];
>  } VhostUserMemory;
>
>  typedef struct VhostUserMemRegMsg {
> @@ -222,7 +240,7 @@ struct vhost_user {
>      int slave_fd;
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
> -    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
> +    uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOTS];
>      /* Length of the region_rb and region_rb_offset arrays */
>      size_t             region_rb_len;
>      /* RAMBlock associated with a given region */
> @@ -237,7 +255,7 @@ struct vhost_user {
>
>      /* Our current regions */
>      int num_shadow_regions;
> -    struct vhost_memory_region shadow_regions[VHOST_MEMORY_MAX_NREGIONS]=
;
> +    struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
>  };
>
>  struct scrub_regions {
> @@ -392,7 +410,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *dev,
> int fd)
>  static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>                                     struct vhost_log *log)
>  {
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
>      bool shmfd =3D virtio_has_feature(dev->protocol_features,
>                                      VHOST_USER_PROTOCOL_F_LOG_SHMFD);
> @@ -470,7 +488,7 @@ static int vhost_user_fill_set_mem_table_msg(struct
> vhost_user *u,
>          mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd)=
;
>          if (fd > 0) {
>              if (track_ramblocks) {
> -                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
> +                assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
>                  trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
>                                                        reg->memory_size,
>
>  reg->guest_phys_addr,
> @@ -478,7 +496,7 @@ static int vhost_user_fill_set_mem_table_msg(struct
> vhost_user *u,
>                                                        offset);
>                  u->region_rb_offset[i] =3D offset;
>                  u->region_rb[i] =3D mr->ram_block;
> -            } else if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> +            } else if (*fd_num =3D=3D VHOST_MEMORY_BASELINE_NREGIONS) {
>                  error_report("Failed preparing vhost-user memory table
> msg");
>                  return -1;
>              }
> @@ -523,7 +541,7 @@ static void scrub_shadow_regions(struct vhost_dev *de=
v,
>                                   bool track_ramblocks)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    bool found[VHOST_MEMORY_MAX_NREGIONS] =3D {};
> +    bool found[VHOST_USER_MAX_RAM_SLOTS] =3D {};
>      struct vhost_memory_region *reg, *shadow_reg;
>      int i, j, fd, add_idx =3D 0, rm_idx =3D 0, fd_num =3D 0;
>      ram_addr_t offset;
> @@ -777,9 +795,9 @@ static int vhost_user_add_remove_regions(struct
> vhost_dev *dev,
>                                           bool track_ramblocks)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    struct scrub_regions add_reg[VHOST_MEMORY_MAX_NREGIONS];
> -    struct scrub_regions rem_reg[VHOST_MEMORY_MAX_NREGIONS];
> -    uint64_t shadow_pcb[VHOST_MEMORY_MAX_NREGIONS] =3D {};
> +    struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];
> +    struct scrub_regions rem_reg[VHOST_USER_MAX_RAM_SLOTS];
> +    uint64_t shadow_pcb[VHOST_USER_MAX_RAM_SLOTS] =3D {};
>      int nr_add_reg, nr_rem_reg;
>
>      msg->hdr.size =3D sizeof(msg->payload.mem_reg.padding) +
> @@ -803,7 +821,7 @@ static int vhost_user_add_remove_regions(struct
> vhost_dev *dev,
>
>      if (track_ramblocks) {
>          memcpy(u->postcopy_client_bases, shadow_pcb,
> -               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
>          /*
>           * Now we've registered this with the postcopy code, we ack to t=
he
>           * client, because now we're in the position to be able to deal
> with
> @@ -823,7 +841,7 @@ static int vhost_user_add_remove_regions(struct
> vhost_dev *dev,
>  err:
>      if (track_ramblocks) {
>          memcpy(u->postcopy_client_bases, shadow_pcb,
> -               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
>      }
>
>      return -1;
> @@ -835,7 +853,7 @@ static int vhost_user_set_mem_table_postcopy(struct
> vhost_dev *dev,
>                                               bool config_mem_slots)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num =3D 0;
>      VhostUserMsg msg_reply;
>      int region_i, msg_i;
> @@ -893,7 +911,7 @@ static int vhost_user_set_mem_table_postcopy(struct
> vhost_dev *dev,
>          }
>
>          memset(u->postcopy_client_bases, 0,
> -               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
>
>          /*
>           * They're in the same order as the regions that were sent
> @@ -942,7 +960,7 @@ static int vhost_user_set_mem_table(struct vhost_dev
> *dev,
>                                      struct vhost_memory *mem)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num =3D 0;
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
>      bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> @@ -1149,7 +1167,7 @@ static int vhost_set_vring_file(struct vhost_dev
> *dev,
>                                  VhostUserRequest request,
>                                  struct vhost_vring_file *file)
>  {
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D request,
> @@ -1845,7 +1863,7 @@ static int vhost_user_backend_init(struct vhost_dev
> *dev, void *opaque)
>          /* get max memory regions if backend supports configurable RAM
> slots */
>          if (!virtio_has_feature(dev->protocol_features,
>
>  VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
> -            u->user->memory_slots =3D VHOST_MEMORY_MAX_NREGIONS;
> +            u->user->memory_slots =3D VHOST_MEMORY_BASELINE_NREGIONS;
>          } else {
>              err =3D vhost_user_get_max_memslots(dev, &ram_slots);
>              if (err < 0) {
> @@ -1860,7 +1878,7 @@ static int vhost_user_backend_init(struct vhost_dev
> *dev, void *opaque)
>                  return -1;
>              }
>
> -            u->user->memory_slots =3D MIN(ram_slots,
> VHOST_MEMORY_MAX_NREGIONS);
> +            u->user->memory_slots =3D MIN(ram_slots,
> VHOST_USER_MAX_RAM_SLOTS);
>          }
>      }
>
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000016620705a74334ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Rapha=
el Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.norwi=
tz@nutanix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Historically, sending all memory regions to vhost-user backen=
ds in a<br>
single message imposed a limitation on the number of times memory<br>
could be hot-added to a VM with a vhost-user device. Now that backends<br>
which support the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS send memory<br>
regions individually, we no longer need to impose this limitation on<br>
devices which support this feature.<br>
<br>
With this change, VMs with a vhost-user device which supports the<br>
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS can support a configurable<br>
number of memory slots, up to the maximum allowed by the target<br>
platform.<br>
<br>
Existing backends which do not support<br>
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br>
Signed-off-by: Peter Turschmid &lt;<a href=3D"mailto:peter.turschm@nutanix.=
com" target=3D"_blank">peter.turschm@nutanix.com</a>&gt;<br>
Suggested-by: Mike Cui &lt;<a href=3D"mailto:cui@nutanix.com" target=3D"_bl=
ank">cui@nutanix.com</a>&gt;<br></blockquote><div><br></div><div>Reviewed-b=
y: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
---<br>
=C2=A0docs/interop/vhost-user.rst |=C2=A0 7 +++---<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 56 +++++++++++++++++++++=
+++++++++---------------<br>
=C2=A02 files changed, 40 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst<br>
index 037eefa..688b7c6 100644<br>
--- a/docs/interop/vhost-user.rst<br>
+++ b/docs/interop/vhost-user.rst<br>
@@ -1273,10 +1273,9 @@ Master message types<br>
=C2=A0 =C2=A0feature has been successfully negotiated, this message is subm=
itted<br>
=C2=A0 =C2=A0by master to the slave. The slave should return the message wi=
th a<br>
=C2=A0 =C2=A0u64 payload containing the maximum number of memory slots for<=
br>
-=C2=A0 QEMU to expose to the guest. At this point, the value returned<br>
-=C2=A0 by the backend will be capped at the maximum number of ram slots<br=
>
-=C2=A0 which can be supported by vhost-user. Currently that limit is set<b=
r>
-=C2=A0 at VHOST_USER_MAX_RAM_SLOTS =3D 8.<br>
+=C2=A0 QEMU to expose to the guest. The value returned by the backend<br>
+=C2=A0 will be capped at the maximum number of ram slots which can be<br>
+=C2=A0 supported by the target platform.<br>
<br>
=C2=A0``VHOST_USER_ADD_MEM_REG``<br>
=C2=A0 =C2=A0:id: 37<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 9358406..48b8081 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -35,11 +35,29 @@<br>
=C2=A0#include &lt;linux/userfaultfd.h&gt;<br>
=C2=A0#endif<br>
<br>
-#define VHOST_MEMORY_MAX_NREGIONS=C2=A0 =C2=A0 8<br>
+#define VHOST_MEMORY_BASELINE_NREGIONS=C2=A0 =C2=A0 8<br>
=C2=A0#define VHOST_USER_F_PROTOCOL_FEATURES 30<br>
=C2=A0#define VHOST_USER_SLAVE_MAX_FDS=C2=A0 =C2=A0 =C2=A08<br>
<br>
=C2=A0/*<br>
+ * Set maximum number of RAM slots supported to<br>
+ * the maximum number supported by the target<br>
+ * hardware plaform.<br>
+ */<br>
+#if defined(TARGET_X86) || defined(TARGET_X86_64) || \<br>
+=C2=A0 =C2=A0 defined(TARGET_ARM) || defined(TARGET_ARM_64)<br>
+#include &quot;hw/acpi/acpi.h&quot;<br>
+#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS<br>
+<br>
+#elif defined(TARGET_PPC) || defined(TARGET_PPC_64)<br>
+#include &quot;hw/ppc/spapr.h&quot;<br>
+#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS<br>
+<br>
+#else<br>
+#define VHOST_USER_MAX_RAM_SLOTS 512<br>
+#endif<br>
+<br>
+/*<br>
=C2=A0 * Maximum size of virtio device config space<br>
=C2=A0 */<br>
=C2=A0#define VHOST_USER_MAX_CONFIG_SIZE 256<br>
@@ -127,7 +145,7 @@ typedef struct VhostUserMemoryRegion {<br>
=C2=A0typedef struct VhostUserMemory {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t nregions;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t padding;<br>
-=C2=A0 =C2=A0 VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];<br=
>
+=C2=A0 =C2=A0 VhostUserMemoryRegion regions[VHOST_MEMORY_BASELINE_NREGIONS=
];<br>
=C2=A0} VhostUserMemory;<br>
<br>
=C2=A0typedef struct VhostUserMemRegMsg {<br>
@@ -222,7 +240,7 @@ struct vhost_user {<br>
=C2=A0 =C2=A0 =C2=A0int slave_fd;<br>
=C2=A0 =C2=A0 =C2=A0NotifierWithReturn postcopy_notifier;<br>
=C2=A0 =C2=A0 =C2=A0struct PostCopyFD=C2=A0 postcopy_fd;<br>
-=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0postcopy_cl=
ient_bases[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0postcopy_cl=
ient_bases[VHOST_USER_MAX_RAM_SLOTS];<br>
=C2=A0 =C2=A0 =C2=A0/* Length of the region_rb and region_rb_offset arrays =
*/<br>
=C2=A0 =C2=A0 =C2=A0size_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
egion_rb_len;<br>
=C2=A0 =C2=A0 =C2=A0/* RAMBlock associated with a given region */<br>
@@ -237,7 +255,7 @@ struct vhost_user {<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Our current regions */<br>
=C2=A0 =C2=A0 =C2=A0int num_shadow_regions;<br>
-=C2=A0 =C2=A0 struct vhost_memory_region shadow_regions[VHOST_MEMORY_MAX_N=
REGIONS];<br>
+=C2=A0 =C2=A0 struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM=
_SLOTS];<br>
=C2=A0};<br>
<br>
=C2=A0struct scrub_regions {<br>
@@ -392,7 +410,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *dev, in=
t fd)<br>
=C2=A0static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t ba=
se,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_log *log)=
<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int fds[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 int fds[VHOST_USER_MAX_RAM_SLOTS];<br>
=C2=A0 =C2=A0 =C2=A0size_t fd_num =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bool shmfd =3D virtio_has_feature(dev-&gt;protocol_feat=
ures,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTO=
COL_F_LOG_SHMFD);<br>
@@ -470,7 +488,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vho=
st_user *u,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mr =3D vhost_user_get_mr_data(reg-&gt;use=
rspace_addr, &amp;offset, &amp;fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (track_ramblocks) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(*fd_num &lt=
; VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(*fd_num &lt=
; VHOST_MEMORY_BASELINE_NREGIONS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vhost_u=
ser_set_mem_table_withfd(*fd_num, mr-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;memory_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;guest_phys_addr,<br=
>
@@ -478,7 +496,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vho=
st_user *u,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u-&gt;region_=
rb_offset[i] =3D offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u-&gt;region_=
rb[i] =3D mr-&gt;ram_block;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*fd_num =3D=3D VHOST_=
MEMORY_MAX_NREGIONS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*fd_num =3D=3D VHOST_=
MEMORY_BASELINE_NREGIONS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(=
&quot;Failed preparing vhost-user memory table msg&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -523,7 +541,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool track_ramblocks)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_user *u =3D dev-&gt;opaque;<br>
-=C2=A0 =C2=A0 bool found[VHOST_MEMORY_MAX_NREGIONS] =3D {};<br>
+=C2=A0 =C2=A0 bool found[VHOST_USER_MAX_RAM_SLOTS] =3D {};<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_memory_region *reg, *shadow_reg;<br>
=C2=A0 =C2=A0 =C2=A0int i, j, fd, add_idx =3D 0, rm_idx =3D 0, fd_num =3D 0=
;<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t offset;<br>
@@ -777,9 +795,9 @@ static int vhost_user_add_remove_regions(struct vhost_d=
ev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ool track_ramblocks)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_user *u =3D dev-&gt;opaque;<br>
-=C2=A0 =C2=A0 struct scrub_regions add_reg[VHOST_MEMORY_MAX_NREGIONS];<br>
-=C2=A0 =C2=A0 struct scrub_regions rem_reg[VHOST_MEMORY_MAX_NREGIONS];<br>
-=C2=A0 =C2=A0 uint64_t shadow_pcb[VHOST_MEMORY_MAX_NREGIONS] =3D {};<br>
+=C2=A0 =C2=A0 struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];<br>
+=C2=A0 =C2=A0 struct scrub_regions rem_reg[VHOST_USER_MAX_RAM_SLOTS];<br>
+=C2=A0 =C2=A0 uint64_t shadow_pcb[VHOST_USER_MAX_RAM_SLOTS] =3D {};<br>
=C2=A0 =C2=A0 =C2=A0int nr_add_reg, nr_rem_reg;<br>
<br>
=C2=A0 =C2=A0 =C2=A0msg-&gt;hdr.size =3D sizeof(msg-&gt;payload.mem_reg.pad=
ding) +<br>
@@ -803,7 +821,7 @@ static int vhost_user_add_remove_regions(struct vhost_d=
ev *dev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (track_ramblocks) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(u-&gt;postcopy_client_bases, shado=
w_pcb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_USER_MAX_RAM_SLOTS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Now we&#39;ve registered this with the=
 postcopy code, we ack to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * client, because now we&#39;re in the p=
osition to be able to deal with<br>
@@ -823,7 +841,7 @@ static int vhost_user_add_remove_regions(struct vhost_d=
ev *dev,<br>
=C2=A0err:<br>
=C2=A0 =C2=A0 =C2=A0if (track_ramblocks) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(u-&gt;postcopy_client_bases, shado=
w_pcb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_USER_MAX_RAM_SLOTS);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -835,7 +853,7 @@ static int vhost_user_set_mem_table_postcopy(struct vho=
st_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bool config_mem_slots)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_user *u =3D dev-&gt;opaque;<br>
-=C2=A0 =C2=A0 int fds[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 int fds[VHOST_MEMORY_BASELINE_NREGIONS];<br>
=C2=A0 =C2=A0 =C2=A0size_t fd_num =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMsg msg_reply;<br>
=C2=A0 =C2=A0 =C2=A0int region_i, msg_i;<br>
@@ -893,7 +911,7 @@ static int vhost_user_set_mem_table_postcopy(struct vho=
st_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(u-&gt;postcopy_client_bases, 0,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_USER_MAX_RAM_SLOTS);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * They&#39;re in the same order as the r=
egions that were sent<br>
@@ -942,7 +960,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *d=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_mem=
ory *mem)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_user *u =3D dev-&gt;opaque;<br>
-=C2=A0 =C2=A0 int fds[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 int fds[VHOST_MEMORY_BASELINE_NREGIONS];<br>
=C2=A0 =C2=A0 =C2=A0size_t fd_num =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bool do_postcopy =3D u-&gt;postcopy_listen &amp;&amp; u=
-&gt;postcopy_fd.handler;<br>
=C2=A0 =C2=A0 =C2=A0bool reply_supported =3D virtio_has_feature(dev-&gt;pro=
tocol_features,<br>
@@ -1149,7 +1167,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserRequest request,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vring_file *file)=
<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int fds[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 int fds[VHOST_USER_MAX_RAM_SLOTS];<br>
=C2=A0 =C2=A0 =C2=A0size_t fd_num =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMsg msg =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.hdr.request =3D request,<br>
@@ -1845,7 +1863,7 @@ static int vhost_user_backend_init(struct vhost_dev *=
dev, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* get max memory regions if backend supp=
orts configurable RAM slots */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!virtio_has_feature(dev-&gt;protocol_=
features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_CONFIGUR=
E_MEM_SLOTS)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;user-&gt;memory_slots =3D =
VHOST_MEMORY_MAX_NREGIONS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;user-&gt;memory_slots =3D =
VHOST_MEMORY_BASELINE_NREGIONS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D vhost_user_get_max_=
memslots(dev, &amp;ram_slots);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0) {<br>
@@ -1860,7 +1878,7 @@ static int vhost_user_backend_init(struct vhost_dev *=
dev, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;user-&gt;memory_slots =3D =
MIN(ram_slots, VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;user-&gt;memory_slots =3D =
MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000016620705a74334ce--

