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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE47C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7087206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0FqbAAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7087206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgr8m-0006m8-VB
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr7J-0005bY-D0
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:45:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr7G-0002xP-6e
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:45:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so5515814wmj.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x95LZRQ1s9OpIF7dCR6MjYJkU/+LD3apz1lRMU7uuf4=;
 b=l0FqbAAi/g30Lf1OIEY1ZC6RsedXaBkQ9C5eKqUE/i4wgmfovQdWkZVqpXSkLcZ114
 kUtylGI8F/NMs1/TtqwhoF4DEk0NfY94xOAZcG3ykzkJAcRobkHc+6Ju/YzuLacNLEFI
 QB4lcBYv3dNdIxeabNTMtkTnuNUQjpZog5N7KVChYvY5VkvAGpX/YY161QyZYdHr4uyY
 zCRbQa5GqRrzbfotUJK3LMTbPWuLMXmQvTIe6Au3XxHbwu+NB1/A4Yw6qAtueNB997BS
 dYPragB1CEfF70ZUhb4c+lheuUig7os/HtHZKRQLDZYXJzDTfn49YUbcLt0QLtbZNYH9
 t15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x95LZRQ1s9OpIF7dCR6MjYJkU/+LD3apz1lRMU7uuf4=;
 b=nb4T2iNSfCoIngv+UQb3dFynlY7JQAy2Z7EIw8C/newJyINRDnqVDylAFUmcAUP+93
 gnwwRGHaHvVLZj2fvZ+i8850AVGBdiZNm1wzund9ILXMGJKBX/3V++CViqFIVQNKOqNn
 Z///GOsSaMmVsZgmPibDSkdPzUPMFVCkcewnxwWmrbqTTscN5P90HUz7Pu6lkcRuobsv
 9uuATGoWcPcjOkIBKrOW62a+0abghZIdlE2liXviTMmUI1/dAB2MlkTNOLj+OxOsNu65
 355wO295BhobpQ+OVX1z+r9GcMaL7nZke4wPC0Ezqrmdl2920rhMOoOQlsLRCgf2GTd/
 K01Q==
X-Gm-Message-State: AOAM533C5koNobrmVyqq0yPhxYlwxTKjnmWO9T2FVQ8W9U0qh9ra51pV
 JUa3Uu8kfincO5/xpe6lzEvrZC5v0OqsUDjirj0=
X-Google-Smtp-Source: ABdhPJx9w/YSbK7i8U0uWo12GrrIhra7xmo0THvfMaplowEeZ29V5lL3rui81+9ZH03Eh/MVxRmhqykhpZuyqrka5Jc=
X-Received: by 2002:a1c:6606:: with SMTP id a6mr4160055wmc.37.1591281908555;
 Thu, 04 Jun 2020 07:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-5-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-5-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:44:56 +0200
Message-ID: <CAJ+F1C+mdTwe9xzTYpf_mS8bZRDQDJnE+CTFJD4=Ju4yJPKipA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] Transmit vhost-user memory regions individually
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="000000000000e5a1f505a74330fa"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x343.google.com
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e5a1f505a74330fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> With this change, when the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> protocol feature has been negotiated, Qemu no longer sends the backend
> all the memory regions in a single message. Rather, when the memory
> tables are set or updated, a series of VHOST_USER_ADD_MEM_REG and
> VHOST_USER_REM_MEM_REG messages are sent to transmit the regions to map
> and/or unmap instead of sending send all the regions in one fixed size
> VHOST_USER_SET_MEM_TABLE message.
>
> The vhost_user struct maintains a shadow state of the VM=E2=80=99s memory
> regions. When the memory tables are modified, the
> vhost_user_set_mem_table() function compares the new device memory state
> to the shadow state and only sends regions which need to be unmapped or
> mapped in. The regions which must be unmapped are sent first, followed
> by the new regions to be mapped in. After all the messages have been
> sent, the shadow state is set to the current virtual device state.
>
> Existing backends which do not support
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Swapnil Ingle <swapnil.ingle@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Suggested-by: Mike Cui <cui@nutanix.com>
>

The change is a bit tricky, why not add more pre-condition/post-condition
checks? This could really help in case we missed some OOB conditions.

I would also use longer names: rem->remove, reg->registry, etc.. I think
they improve readability.

Nonetheless, it looks ok and apparently 4 people already looked at it, so
for now:
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  docs/interop/vhost-user.rst |  33 ++-
>  hw/virtio/vhost-user.c      | 510
> +++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 469 insertions(+), 74 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index b3cf5c3..037eefa 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1276,8 +1276,37 @@ Master message types
>    QEMU to expose to the guest. At this point, the value returned
>    by the backend will be capped at the maximum number of ram slots
>    which can be supported by vhost-user. Currently that limit is set
> -  at VHOST_USER_MAX_RAM_SLOTS =3D 8 because of underlying protocol
> -  limitations.
> +  at VHOST_USER_MAX_RAM_SLOTS =3D 8.
> +
> +``VHOST_USER_ADD_MEM_REG``
> +  :id: 37
> +  :equivalent ioctl: N/A
> +  :slave payload: memory region
> +
> +  When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
> +  feature has been successfully negotiated, this message is submitted
> +  by the master to the slave. The message payload contains a memory
> +  region descriptor struct, describing a region of guest memory which
> +  the slave device must map in. When the
> +  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol feature has
> +  been successfully negotiated, along with the
> +  ``VHOST_USER_REM_MEM_REG`` message, this message is used to set and
> +  update the memory tables of the slave device.
> +
> +``VHOST_USER_REM_MEM_REG``
> +  :id: 38
> +  :equivalent ioctl: N/A
> +  :slave payload: memory region
> +
> +  When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
> +  feature has been successfully negotiated, this message is submitted
> +  by the master to the slave. The message payload contains a memory
> +  region descriptor struct, describing a region of guest memory which
> +  the slave device must unmap. When the
> +  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol feature has
> +  been successfully negotiated, along with the
> +  ``VHOST_USER_ADD_MEM_REG`` message, this message is used to set and
> +  update the memory tables of the slave device.
>
>  Slave message types
>  -------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 0af593f..9358406 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -104,6 +104,8 @@ typedef enum VhostUserRequest {
>      VHOST_USER_RESET_DEVICE =3D 34,
>      /* Message number 35 reserved for VHOST_USER_VRING_KICK. */
>      VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,
> +    VHOST_USER_ADD_MEM_REG =3D 37,
> +    VHOST_USER_REM_MEM_REG =3D 38,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> @@ -128,6 +130,11 @@ typedef struct VhostUserMemory {
>      VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>  } VhostUserMemory;
>
> +typedef struct VhostUserMemRegMsg {
> +    uint32_t padding;
> +    VhostUserMemoryRegion region;
> +} VhostUserMemRegMsg;
> +
>  typedef struct VhostUserLog {
>      uint64_t mmap_size;
>      uint64_t mmap_offset;
> @@ -186,6 +193,7 @@ typedef union {
>          struct vhost_vring_state state;
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
> +        VhostUserMemRegMsg mem_reg;
>          VhostUserLog log;
>          struct vhost_iotlb_msg iotlb;
>          VhostUserConfig config;
> @@ -226,6 +234,16 @@ struct vhost_user {
>
>      /* True once we've entered postcopy_listen */
>      bool               postcopy_listen;
> +
> +    /* Our current regions */
> +    int num_shadow_regions;
> +    struct vhost_memory_region shadow_regions[VHOST_MEMORY_MAX_NREGIONS]=
;
> +};
> +
> +struct scrub_regions {
> +    struct vhost_memory_region *region;
> +    int reg_idx;
> +    int fd_idx;
>  };
>
>  static bool ioeventfd_enabled(void)
> @@ -489,8 +507,332 @@ static int vhost_user_fill_set_mem_table_msg(struct
> vhost_user *u,
>      return 1;
>  }
>
> +static inline bool reg_equal(struct vhost_memory_region *shadow_reg,
> +                             struct vhost_memory_region *vdev_reg)
> +{
> +    return shadow_reg->guest_phys_addr =3D=3D vdev_reg->guest_phys_addr =
&&
> +        shadow_reg->userspace_addr =3D=3D vdev_reg->userspace_addr &&
> +        shadow_reg->memory_size =3D=3D vdev_reg->memory_size;
> +}
> +
> +static void scrub_shadow_regions(struct vhost_dev *dev,
> +                                 struct scrub_regions *add_reg,
> +                                 int *nr_add_reg,
> +                                 struct scrub_regions *rem_reg,
> +                                 int *nr_rem_reg, uint64_t *shadow_pcb,
> +                                 bool track_ramblocks)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    bool found[VHOST_MEMORY_MAX_NREGIONS] =3D {};
> +    struct vhost_memory_region *reg, *shadow_reg;
> +    int i, j, fd, add_idx =3D 0, rm_idx =3D 0, fd_num =3D 0;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +    bool matching;
> +
> +    /*
> +     * Find memory regions present in our shadow state which are not in
> +     * the device's current memory state.
> +     *
> +     * Mark regions in both the shadow and device state as "found".
> +     */
> +    for (i =3D 0; i < u->num_shadow_regions; i++) {
> +        shadow_reg =3D &u->shadow_regions[i];
> +        matching =3D false;
> +
> +        for (j =3D 0; j < dev->mem->nregions; j++) {
> +            reg =3D &dev->mem->regions[j];
> +
> +            mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset,
> &fd);
> +
> +            if (reg_equal(shadow_reg, reg)) {
> +                matching =3D true;
> +                found[j] =3D true;
> +                if (track_ramblocks) {
> +                    /*
> +                     * Reset postcopy client bases, region_rb, and
> +                     * region_rb_offset in case regions are removed.
> +                     */
> +                    if (fd > 0) {
> +                        u->region_rb_offset[j] =3D offset;
> +                        u->region_rb[j] =3D mr->ram_block;
> +                        shadow_pcb[j] =3D u->postcopy_client_bases[i];
> +                    } else {
> +                        u->region_rb_offset[j] =3D 0;
> +                        u->region_rb[j] =3D NULL;
> +                    }
> +                }
> +                break;
> +            }
> +        }
> +
> +        /*
> +         * If the region was not found in the current device memory stat=
e
> +         * create an entry for it in the removed list.
> +         */
> +        if (!matching) {
> +            rem_reg[rm_idx].region =3D shadow_reg;
> +            rem_reg[rm_idx++].reg_idx =3D i;
> +        }
> +    }
> +
> +    /*
> +     * For regions not marked "found", create entries in the added list.
> +     *
> +     * Note their indexes in the device memory state and the indexes of
> their
> +     * file descriptors.
> +     */
> +    for (i =3D 0; i < dev->mem->nregions; i++) {
> +        reg =3D &dev->mem->regions[i];
> +        mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd)=
;
> +        if (fd > 0) {
> +            ++fd_num;
> +        }
> +
> +        /*
> +         * If the region was in both the shadow and device state we don'=
t
> +         * need to send a VHOST_USER_ADD_MEM_REG message for it.
> +         */
> +        if (found[i]) {
> +            continue;
> +        }
> +
> +        add_reg[add_idx].region =3D reg;
> +        add_reg[add_idx].reg_idx =3D i;
> +        add_reg[add_idx++].fd_idx =3D fd_num;
> +    }
> +    *nr_rem_reg =3D rm_idx;
> +    *nr_add_reg =3D add_idx;
> +
> +    return;
> +}
> +
> +static int send_remove_regions(struct vhost_dev *dev,
> +                               struct scrub_regions *remove_reg,
> +                               int nr_rem_reg, VhostUserMsg *msg,
> +                               bool reply_supported)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    struct vhost_memory_region *shadow_reg;
> +    int i, fd, shadow_reg_idx, ret;
> +    ram_addr_t offset;
> +    VhostUserMemoryRegion region_buffer;
> +
> +    /*
> +     * The regions in remove_reg appear in the same order they do in the
> +     * shadow table. Therefore we can minimize memory copies by iteratin=
g
> +     * through remove_reg backwards.
> +     */
> +    for (i =3D nr_rem_reg - 1; i >=3D 0; i--) {
> +        shadow_reg =3D remove_reg[i].region;
> +        shadow_reg_idx =3D remove_reg[i].reg_idx;
> +
> +        vhost_user_get_mr_data(shadow_reg->userspace_addr, &offset, &fd)=
;
> +
> +        if (fd > 0) {
> +            msg->hdr.request =3D VHOST_USER_REM_MEM_REG;
> +            vhost_user_fill_msg_region(&region_buffer, shadow_reg);
> +            msg->payload.mem_reg.region =3D region_buffer;
> +
> +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> +                return -1;
> +            }
> +
> +            if (reply_supported) {
> +                ret =3D process_message_reply(dev, msg);
> +                if (ret) {
> +                    return ret;
> +                }
> +            }
> +        }
> +
> +        /*
> +         * At this point we know the backend has unmapped the region. It
> is now
> +         * safe to remove it from the shadow table.
> +         */
> +        memmove(&u->shadow_regions[shadow_reg_idx],
> +                &u->shadow_regions[shadow_reg_idx + 1],
> +                sizeof(struct vhost_memory_region) *
> +                (u->num_shadow_regions - shadow_reg_idx));
> +        u->num_shadow_regions--;
> +    }
> +
> +    return 0;
> +}
> +
> +static int send_add_regions(struct vhost_dev *dev,
> +                            struct scrub_regions *add_reg, int nr_add_re=
g,
> +                            VhostUserMsg *msg, uint64_t *shadow_pcb,
> +                            bool reply_supported, bool track_ramblocks)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    int i, fd, ret, reg_idx, reg_fd_idx;
> +    struct vhost_memory_region *reg;
> +    MemoryRegion *mr;
> +    ram_addr_t offset;
> +    VhostUserMsg msg_reply;
> +    VhostUserMemoryRegion region_buffer;
> +
> +    for (i =3D 0; i < nr_add_reg; i++) {
> +        reg =3D add_reg[i].region;
> +        reg_idx =3D add_reg[i].reg_idx;
> +        reg_fd_idx =3D add_reg[i].fd_idx;
> +
> +        mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd)=
;
> +
> +        if (fd > 0) {
> +            if (track_ramblocks) {
> +                trace_vhost_user_set_mem_table_withfd(reg_fd_idx,
> mr->name,
> +                                                      reg->memory_size,
> +
> reg->guest_phys_addr,
> +                                                      reg->userspace_add=
r,
> +                                                      offset);
> +                u->region_rb_offset[reg_idx] =3D offset;
> +                u->region_rb[reg_idx] =3D mr->ram_block;
> +            }
> +            msg->hdr.request =3D VHOST_USER_ADD_MEM_REG;
> +            vhost_user_fill_msg_region(&region_buffer, reg);
> +            msg->payload.mem_reg.region =3D region_buffer;
> +            msg->payload.mem_reg.region.mmap_offset =3D offset;
> +
> +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> +                return -1;
> +            }
> +
> +            if (track_ramblocks) {
> +                uint64_t reply_gpa;
> +
> +                if (vhost_user_read(dev, &msg_reply) < 0) {
> +                    return -1;
> +                }
> +
> +                reply_gpa =3D
> msg_reply.payload.mem_reg.region.guest_phys_addr;
> +
> +                if (msg_reply.hdr.request !=3D VHOST_USER_ADD_MEM_REG) {
> +                    error_report("%s: Received unexpected msg type."
> +                                 "Expected %d received %d", __func__,
> +                                 VHOST_USER_ADD_MEM_REG,
> +                                 msg_reply.hdr.request);
> +                    return -1;
> +                }
> +
> +                /*
> +                 * We're using the same structure, just reusing one of t=
he
> +                 * fields, so it should be the same size.
> +                 */
> +                if (msg_reply.hdr.size !=3D msg->hdr.size) {
> +                    error_report("%s: Unexpected size for postcopy reply=
 "
> +                                 "%d vs %d", __func__, msg_reply.hdr.siz=
e,
> +                                 msg->hdr.size);
> +                    return -1;
> +                }
> +
> +                /* Get the postcopy client base from the backend's reply=
.
> */
> +                if (reply_gpa =3D=3D
> dev->mem->regions[reg_idx].guest_phys_addr) {
> +                    shadow_pcb[reg_idx] =3D
> +                        msg_reply.payload.mem_reg.region.userspace_addr;
> +                    trace_vhost_user_set_mem_table_postcopy(
> +                        msg_reply.payload.mem_reg.region.userspace_addr,
> +                        msg->payload.mem_reg.region.userspace_addr,
> +                        reg_fd_idx, reg_idx);
> +                } else {
> +                    error_report("%s: invalid postcopy reply for region.=
 "
> +                                 "Got guest physical address %lX,
> expected "
> +                                 "%lX", __func__, reply_gpa,
> +
>  dev->mem->regions[reg_idx].guest_phys_addr);
> +                    return -1;
> +                }
> +            } else if (reply_supported) {
> +                ret =3D process_message_reply(dev, msg);
> +                if (ret) {
> +                    return ret;
> +                }
> +            }
> +        } else if (track_ramblocks) {
> +            u->region_rb_offset[reg_idx] =3D 0;
> +            u->region_rb[reg_idx] =3D NULL;
> +        }
> +
> +        /*
> +         * At this point, we know the backend has mapped in the new
> +         * region, if the region has a valid file descriptor.
> +         *
> +         * The region should now be added to the shadow table.
> +         */
> +        u->shadow_regions[u->num_shadow_regions].guest_phys_addr =3D
> +            reg->guest_phys_addr;
> +        u->shadow_regions[u->num_shadow_regions].userspace_addr =3D
> +            reg->userspace_addr;
> +        u->shadow_regions[u->num_shadow_regions].memory_size =3D
> +            reg->memory_size;
> +        u->num_shadow_regions++;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_user_add_remove_regions(struct vhost_dev *dev,
> +                                         VhostUserMsg *msg,
> +                                         bool reply_supported,
> +                                         bool track_ramblocks)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    struct scrub_regions add_reg[VHOST_MEMORY_MAX_NREGIONS];
> +    struct scrub_regions rem_reg[VHOST_MEMORY_MAX_NREGIONS];
> +    uint64_t shadow_pcb[VHOST_MEMORY_MAX_NREGIONS] =3D {};
> +    int nr_add_reg, nr_rem_reg;
> +
> +    msg->hdr.size =3D sizeof(msg->payload.mem_reg.padding) +
> +        sizeof(VhostUserMemoryRegion);
> +
> +    /* Find the regions which need to be removed or added. */
> +    scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg=
,
> +                         shadow_pcb, track_ramblocks);
> +
> +    if (nr_rem_reg && send_remove_regions(dev, rem_reg, nr_rem_reg, msg,
> +                reply_supported) < 0)
> +    {
> +        goto err;
> +    }
> +
> +    if (nr_add_reg && send_add_regions(dev, add_reg, nr_add_reg, msg,
> +                shadow_pcb, reply_supported, track_ramblocks) < 0)
> +    {
> +        goto err;
> +    }
> +
> +    if (track_ramblocks) {
> +        memcpy(u->postcopy_client_bases, shadow_pcb,
> +               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +        /*
> +         * Now we've registered this with the postcopy code, we ack to t=
he
> +         * client, because now we're in the position to be able to deal
> with
> +         * any faults it generates.
> +         */
> +        /* TODO: Use this for failure cases as well with a bad value. */
> +        msg->hdr.size =3D sizeof(msg->payload.u64);
> +        msg->payload.u64 =3D 0; /* OK */
> +
> +        if (vhost_user_write(dev, msg, NULL, 0) < 0) {
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    if (track_ramblocks) {
> +        memcpy(u->postcopy_client_bases, shadow_pcb,
> +               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +    }
> +
> +    return -1;
> +}
> +
>  static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
> -                                             struct vhost_memory *mem)
> +                                             struct vhost_memory *mem,
> +                                             bool reply_supported,
> +                                             bool config_mem_slots)
>  {
>      struct vhost_user *u =3D dev->opaque;
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> @@ -513,71 +855,84 @@ static int vhost_user_set_mem_table_postcopy(struct
> vhost_dev *dev,
>          u->region_rb_len =3D dev->mem->nregions;
>      }
>
> -    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
> +    if (config_mem_slots) {
> +        if (vhost_user_add_remove_regions(dev, &msg, reply_supported,
>                                            true) < 0) {
> -        return -1;
> -    }
> +            return -1;
> +        }
> +    } else {
> +        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num=
,
> +                                              true) < 0) {
> +            return -1;
> +        }
>
> -    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> -        return -1;
> -    }
> +        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> +            return -1;
> +        }
>
> -    if (vhost_user_read(dev, &msg_reply) < 0) {
> -        return -1;
> -    }
> +        if (vhost_user_read(dev, &msg_reply) < 0) {
> +            return -1;
> +        }
>
> -    if (msg_reply.hdr.request !=3D VHOST_USER_SET_MEM_TABLE) {
> -        error_report("%s: Received unexpected msg type."
> -                     "Expected %d received %d", __func__,
> -                     VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);
> -        return -1;
> -    }
> -    /* We're using the same structure, just reusing one of the
> -     * fields, so it should be the same size.
> -     */
> -    if (msg_reply.hdr.size !=3D msg.hdr.size) {
> -        error_report("%s: Unexpected size for postcopy reply "
> -                     "%d vs %d", __func__, msg_reply.hdr.size,
> msg.hdr.size);
> -        return -1;
> -    }
> -
> -    memset(u->postcopy_client_bases, 0,
> -           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> -
> -    /* They're in the same order as the regions that were sent
> -     * but some of the regions were skipped (above) if they
> -     * didn't have fd's
> -    */
> -    for (msg_i =3D 0, region_i =3D 0;
> -         region_i < dev->mem->nregions;
> -        region_i++) {
> -        if (msg_i < fd_num &&
> -            msg_reply.payload.memory.regions[msg_i].guest_phys_addr =3D=
=3D
> -            dev->mem->regions[region_i].guest_phys_addr) {
> -            u->postcopy_client_bases[region_i] =3D
> -                msg_reply.payload.memory.regions[msg_i].userspace_addr;
> -            trace_vhost_user_set_mem_table_postcopy(
> -                msg_reply.payload.memory.regions[msg_i].userspace_addr,
> -                msg.payload.memory.regions[msg_i].userspace_addr,
> -                msg_i, region_i);
> -            msg_i++;
> +        if (msg_reply.hdr.request !=3D VHOST_USER_SET_MEM_TABLE) {
> +            error_report("%s: Received unexpected msg type."
> +                         "Expected %d received %d", __func__,
> +                         VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request=
);
> +            return -1;
> +        }
> +
> +        /*
> +         * We're using the same structure, just reusing one of the
> +         * fields, so it should be the same size.
> +         */
> +        if (msg_reply.hdr.size !=3D msg.hdr.size) {
> +            error_report("%s: Unexpected size for postcopy reply "
> +                         "%d vs %d", __func__, msg_reply.hdr.size,
> +                         msg.hdr.size);
> +            return -1;
> +        }
> +
> +        memset(u->postcopy_client_bases, 0,
> +               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +
> +        /*
> +         * They're in the same order as the regions that were sent
> +         * but some of the regions were skipped (above) if they
> +         * didn't have fd's
> +         */
> +        for (msg_i =3D 0, region_i =3D 0;
> +             region_i < dev->mem->nregions;
> +             region_i++) {
> +            if (msg_i < fd_num &&
> +                msg_reply.payload.memory.regions[msg_i].guest_phys_addr =
=3D=3D
> +                dev->mem->regions[region_i].guest_phys_addr) {
> +                u->postcopy_client_bases[region_i] =3D
> +
> msg_reply.payload.memory.regions[msg_i].userspace_addr;
> +                trace_vhost_user_set_mem_table_postcopy(
> +
> msg_reply.payload.memory.regions[msg_i].userspace_addr,
> +                    msg.payload.memory.regions[msg_i].userspace_addr,
> +                    msg_i, region_i);
> +                msg_i++;
> +            }
> +        }
> +        if (msg_i !=3D fd_num) {
> +            error_report("%s: postcopy reply not fully consumed "
> +                         "%d vs %zd",
> +                         __func__, msg_i, fd_num);
> +            return -1;
> +        }
> +
> +        /*
> +         * Now we've registered this with the postcopy code, we ack to t=
he
> +         * client, because now we're in the position to be able to deal
> +         * with any faults it generates.
> +         */
> +        /* TODO: Use this for failure cases as well with a bad value. */
> +        msg.hdr.size =3D sizeof(msg.payload.u64);
> +        msg.payload.u64 =3D 0; /* OK */
> +        if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +            return -1;
>          }
> -    }
> -    if (msg_i !=3D fd_num) {
> -        error_report("%s: postcopy reply not fully consumed "
> -                     "%d vs %zd",
> -                     __func__, msg_i, fd_num);
> -        return -1;
> -    }
> -    /* Now we've registered this with the postcopy code, we ack to the
> client,
> -     * because now we're in the position to be able to deal with any
> faults
> -     * it generates.
> -     */
> -    /* TODO: Use this for failure cases as well with a bad value */
> -    msg.hdr.size =3D sizeof(msg.payload.u64);
> -    msg.payload.u64 =3D 0; /* OK */
> -    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> -        return -1;
>      }
>
>      return 0;
> @@ -592,12 +947,17 @@ static int vhost_user_set_mem_table(struct vhost_de=
v
> *dev,
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
>      bool reply_supported =3D virtio_has_feature(dev->protocol_features,
>
>  VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +    bool config_mem_slots =3D
> +        virtio_has_feature(dev->protocol_features,
> +                           VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
>
>      if (do_postcopy) {
> -        /* Postcopy has enough differences that it's best done in it's o=
wn
> +        /*
> +         * Postcopy has enough differences that it's best done in it's o=
wn
>           * version
>           */
> -        return vhost_user_set_mem_table_postcopy(dev, mem);
> +        return vhost_user_set_mem_table_postcopy(dev, mem,
> reply_supported,
> +                                                 config_mem_slots);
>      }
>
>      VhostUserMsg msg =3D {
> @@ -608,17 +968,23 @@ static int vhost_user_set_mem_table(struct vhost_de=
v
> *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
>
> -    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
> +    if (config_mem_slots) {
> +        if (vhost_user_add_remove_regions(dev, &msg, reply_supported,
>                                            false) < 0) {
> -        return -1;
> -    }
> -
> -    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> -        return -1;
> -    }
> +            return -1;
> +        }
> +    } else {
> +        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num=
,
> +                                              false) < 0) {
> +            return -1;
> +        }
> +        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> +            return -1;
> +        }
>
> -    if (reply_supported) {
> -        return process_message_reply(dev, &msg);
> +        if (reply_supported) {
> +            return process_message_reply(dev, &msg);
> +        }
>      }
>
>      return 0;
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e5a1f505a74330fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Rap=
hael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.nor=
witz@nutanix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">With this change, when the VHOST_USER_PROTOCOL_F_CONFIGURE_=
MEM_SLOTS<br>
protocol feature has been negotiated, Qemu no longer sends the backend<br>
all the memory regions in a single message. Rather, when the memory<br>
tables are set or updated, a series of VHOST_USER_ADD_MEM_REG and<br>
VHOST_USER_REM_MEM_REG messages are sent to transmit the regions to map<br>
and/or unmap instead of sending send all the regions in one fixed size<br>
VHOST_USER_SET_MEM_TABLE message.<br>
<br>
The vhost_user struct maintains a shadow state of the VM=E2=80=99s memory<b=
r>
regions. When the memory tables are modified, the<br>
vhost_user_set_mem_table() function compares the new device memory state<br=
>
to the shadow state and only sends regions which need to be unmapped or<br>
mapped in. The regions which must be unmapped are sent first, followed<br>
by the new regions to be mapped in. After all the messages have been<br>
sent, the shadow state is set to the current virtual device state.<br>
<br>
Existing backends which do not support<br>
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br>
Signed-off-by: Swapnil Ingle &lt;<a href=3D"mailto:swapnil.ingle@nutanix.co=
m" target=3D"_blank">swapnil.ingle@nutanix.com</a>&gt;<br>
Signed-off-by: Peter Turschmid &lt;<a href=3D"mailto:peter.turschm@nutanix.=
com" target=3D"_blank">peter.turschm@nutanix.com</a>&gt;<br>
Suggested-by: Mike Cui &lt;<a href=3D"mailto:cui@nutanix.com" target=3D"_bl=
ank">cui@nutanix.com</a>&gt;<br></blockquote><div><br></div><div>The change=
 is a bit tricky, why not add more pre-condition/post-condition checks? Thi=
s could really help in case we missed some OOB conditions.<br></div></div><=
div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">I would also=
 use longer names: rem-&gt;remove, reg-&gt;registry, etc.. I think they imp=
rove readability.<br></div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">Nonetheless, it looks ok and apparently 4 people already l=
ooked at it, so for now:<br></div><div class=3D"gmail_quote"><div>Acked-by:=
 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">=
marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
---<br>
=C2=A0docs/interop/vhost-user.rst |=C2=A0 33 ++-<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 510 ++++++++++++++++++++=
+++++++++++++++++-------<br>
=C2=A02 files changed, 469 insertions(+), 74 deletions(-)<br>
<br>
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst<br>
index b3cf5c3..037eefa 100644<br>
--- a/docs/interop/vhost-user.rst<br>
+++ b/docs/interop/vhost-user.rst<br>
@@ -1276,8 +1276,37 @@ Master message types<br>
=C2=A0 =C2=A0QEMU to expose to the guest. At this point, the value returned=
<br>
=C2=A0 =C2=A0by the backend will be capped at the maximum number of ram slo=
ts<br>
=C2=A0 =C2=A0which can be supported by vhost-user. Currently that limit is =
set<br>
-=C2=A0 at VHOST_USER_MAX_RAM_SLOTS =3D 8 because of underlying protocol<br=
>
-=C2=A0 limitations.<br>
+=C2=A0 at VHOST_USER_MAX_RAM_SLOTS =3D 8.<br>
+<br>
+``VHOST_USER_ADD_MEM_REG``<br>
+=C2=A0 :id: 37<br>
+=C2=A0 :equivalent ioctl: N/A<br>
+=C2=A0 :slave payload: memory region<br>
+<br>
+=C2=A0 When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol<br>
+=C2=A0 feature has been successfully negotiated, this message is submitted=
<br>
+=C2=A0 by the master to the slave. The message payload contains a memory<b=
r>
+=C2=A0 region descriptor struct, describing a region of guest memory which=
<br>
+=C2=A0 the slave device must map in. When the<br>
+=C2=A0 ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol feature has<=
br>
+=C2=A0 been successfully negotiated, along with the<br>
+=C2=A0 ``VHOST_USER_REM_MEM_REG`` message, this message is used to set and=
<br>
+=C2=A0 update the memory tables of the slave device.<br>
+<br>
+``VHOST_USER_REM_MEM_REG``<br>
+=C2=A0 :id: 38<br>
+=C2=A0 :equivalent ioctl: N/A<br>
+=C2=A0 :slave payload: memory region<br>
+<br>
+=C2=A0 When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol<br>
+=C2=A0 feature has been successfully negotiated, this message is submitted=
<br>
+=C2=A0 by the master to the slave. The message payload contains a memory<b=
r>
+=C2=A0 region descriptor struct, describing a region of guest memory which=
<br>
+=C2=A0 the slave device must unmap. When the<br>
+=C2=A0 ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol feature has<=
br>
+=C2=A0 been successfully negotiated, along with the<br>
+=C2=A0 ``VHOST_USER_ADD_MEM_REG`` message, this message is used to set and=
<br>
+=C2=A0 update the memory tables of the slave device.<br>
<br>
=C2=A0Slave message types<br>
=C2=A0-------------------<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 0af593f..9358406 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -104,6 +104,8 @@ typedef enum VhostUserRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_RESET_DEVICE =3D 34,<br>
=C2=A0 =C2=A0 =C2=A0/* Message number 35 reserved for VHOST_USER_VRING_KICK=
. */<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,<br>
+=C2=A0 =C2=A0 VHOST_USER_ADD_MEM_REG =3D 37,<br>
+=C2=A0 =C2=A0 VHOST_USER_REM_MEM_REG =3D 38,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_MAX<br>
=C2=A0} VhostUserRequest;<br>
<br>
@@ -128,6 +130,11 @@ typedef struct VhostUserMemory {<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS=
];<br>
=C2=A0} VhostUserMemory;<br>
<br>
+typedef struct VhostUserMemRegMsg {<br>
+=C2=A0 =C2=A0 uint32_t padding;<br>
+=C2=A0 =C2=A0 VhostUserMemoryRegion region;<br>
+} VhostUserMemRegMsg;<br>
+<br>
=C2=A0typedef struct VhostUserLog {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t mmap_size;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t mmap_offset;<br>
@@ -186,6 +193,7 @@ typedef union {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vring_state state;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vring_addr addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserMemory memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMemRegMsg mem_reg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserLog log;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_iotlb_msg iotlb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserConfig config;<br>
@@ -226,6 +234,16 @@ struct vhost_user {<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* True once we&#39;ve entered postcopy_listen */<br>
=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0postcopy_listen;<br>
+<br>
+=C2=A0 =C2=A0 /* Our current regions */<br>
+=C2=A0 =C2=A0 int num_shadow_regions;<br>
+=C2=A0 =C2=A0 struct vhost_memory_region shadow_regions[VHOST_MEMORY_MAX_N=
REGIONS];<br>
+};<br>
+<br>
+struct scrub_regions {<br>
+=C2=A0 =C2=A0 struct vhost_memory_region *region;<br>
+=C2=A0 =C2=A0 int reg_idx;<br>
+=C2=A0 =C2=A0 int fd_idx;<br>
=C2=A0};<br>
<br>
=C2=A0static bool ioeventfd_enabled(void)<br>
@@ -489,8 +507,332 @@ static int vhost_user_fill_set_mem_table_msg(struct v=
host_user *u,<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
+static inline bool reg_equal(struct vhost_memory_region *shadow_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_memory_region *vdev_reg)<br>
+{<br>
+=C2=A0 =C2=A0 return shadow_reg-&gt;guest_phys_addr =3D=3D vdev_reg-&gt;gu=
est_phys_addr &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_reg-&gt;userspace_addr =3D=3D vdev_reg-=
&gt;userspace_addr &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_reg-&gt;memory_size =3D=3D vdev_reg-&gt=
;memory_size;<br>
+}<br>
+<br>
+static void scrub_shadow_regions(struct vhost_dev *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scrub_regions *add_reg,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *nr_add_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scrub_regions *rem_reg,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *nr_rem_reg, uint64_t *sha=
dow_pcb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool track_ramblocks)<br>
+{<br>
+=C2=A0 =C2=A0 struct vhost_user *u =3D dev-&gt;opaque;<br>
+=C2=A0 =C2=A0 bool found[VHOST_MEMORY_MAX_NREGIONS] =3D {};<br>
+=C2=A0 =C2=A0 struct vhost_memory_region *reg, *shadow_reg;<br>
+=C2=A0 =C2=A0 int i, j, fd, add_idx =3D 0, rm_idx =3D 0, fd_num =3D 0;<br>
+=C2=A0 =C2=A0 ram_addr_t offset;<br>
+=C2=A0 =C2=A0 MemoryRegion *mr;<br>
+=C2=A0 =C2=A0 bool matching;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Find memory regions present in our shadow state whic=
h are not in<br>
+=C2=A0 =C2=A0 =C2=A0* the device&#39;s current memory state.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Mark regions in both the shadow and device state as =
&quot;found&quot;.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; u-&gt;num_shadow_regions; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_reg =3D &amp;u-&gt;shadow_regions[i];<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 matching =3D false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; dev-&gt;mem-&gt;nregions;=
 j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &amp;dev-&gt;mem-&gt;reg=
ions[j];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(re=
g-&gt;userspace_addr, &amp;offset, &amp;fd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_equal(shadow_reg, reg)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matching =3D true;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found[j] =3D true;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (track_ramblock=
s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* Reset postcopy client bases, region_rb, and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* region_rb_offset in case regions are removed.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
fd &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 u-&gt;region_rb_offset[j] =3D offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 u-&gt;region_rb[j] =3D mr-&gt;ram_block;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 shadow_pcb[j] =3D u-&gt;postcopy_client_bases[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } el=
se {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 u-&gt;region_rb_offset[j] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 u-&gt;region_rb[j] =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the region was not found in the cur=
rent device memory state<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* create an entry for it in the removed =
list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!matching) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rem_reg[rm_idx].region =3D shado=
w_reg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rem_reg[rm_idx++].reg_idx =3D i;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* For regions not marked &quot;found&quot;, create ent=
ries in the added list.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Note their indexes in the device memory state and th=
e indexes of their<br>
+=C2=A0 =C2=A0 =C2=A0* file descriptors.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;mem-&gt;nregions; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &amp;dev-&gt;mem-&gt;regions[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(reg-&gt;userspac=
e_addr, &amp;offset, &amp;fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++fd_num;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the region was in both the shadow a=
nd device state we don&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* need to send a VHOST_USER_ADD_MEM_REG =
message for it.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (found[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_reg[add_idx].region =3D reg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_reg[add_idx].reg_idx =3D i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_reg[add_idx++].fd_idx =3D fd_num;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *nr_rem_reg =3D rm_idx;<br>
+=C2=A0 =C2=A0 *nr_add_reg =3D add_idx;<br>
+<br>
+=C2=A0 =C2=A0 return;<br>
+}<br>
+<br>
+static int send_remove_regions(struct vhost_dev *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scrub_regions *remove_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nr_rem_reg, VhostUserMsg *msg,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool reply_supported)<br>
+{<br>
+=C2=A0 =C2=A0 struct vhost_user *u =3D dev-&gt;opaque;<br>
+=C2=A0 =C2=A0 struct vhost_memory_region *shadow_reg;<br>
+=C2=A0 =C2=A0 int i, fd, shadow_reg_idx, ret;<br>
+=C2=A0 =C2=A0 ram_addr_t offset;<br>
+=C2=A0 =C2=A0 VhostUserMemoryRegion region_buffer;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The regions in remove_reg appear in the same order t=
hey do in the<br>
+=C2=A0 =C2=A0 =C2=A0* shadow table. Therefore we can minimize memory copie=
s by iterating<br>
+=C2=A0 =C2=A0 =C2=A0* through remove_reg backwards.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 for (i =3D nr_rem_reg - 1; i &gt;=3D 0; i--) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_reg =3D remove_reg[i].region;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_reg_idx =3D remove_reg[i].reg_idx;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_get_mr_data(shadow_reg-&gt;userspac=
e_addr, &amp;offset, &amp;fd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;hdr.request =3D VHOST_US=
ER_REM_MEM_REG;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_fill_msg_region(&amp;=
region_buffer, shadow_reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.mem_reg.region =
=3D region_buffer;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_write(dev, msg, &=
amp;fd, 1) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reply_supported) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D process_me=
ssage_reply(dev, msg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* At this point we know the backend has =
unmapped the region. It is now<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* safe to remove it from the shadow tabl=
e.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(&amp;u-&gt;shadow_regions[shadow_reg_i=
dx],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;u-&gt;shadow_=
regions[shadow_reg_idx + 1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct vhos=
t_memory_region) *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u-&gt;num_shadow_=
regions - shadow_reg_idx));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;num_shadow_regions--;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int send_add_regions(struct vhost_dev *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct scrub_regions *add_reg, int nr_add_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMsg *msg, uint64_t *shadow_pcb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool reply_supported, bool track_ramblocks)<br>
+{<br>
+=C2=A0 =C2=A0 struct vhost_user *u =3D dev-&gt;opaque;<br>
+=C2=A0 =C2=A0 int i, fd, ret, reg_idx, reg_fd_idx;<br>
+=C2=A0 =C2=A0 struct vhost_memory_region *reg;<br>
+=C2=A0 =C2=A0 MemoryRegion *mr;<br>
+=C2=A0 =C2=A0 ram_addr_t offset;<br>
+=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
+=C2=A0 =C2=A0 VhostUserMemoryRegion region_buffer;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; nr_add_reg; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D add_reg[i].region;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_idx =3D add_reg[i].reg_idx;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_fd_idx =3D add_reg[i].fd_idx;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(reg-&gt;userspac=
e_addr, &amp;offset, &amp;fd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (track_ramblocks) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_vhost_user_s=
et_mem_table_withfd(reg_fd_idx, mr-&gt;name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;memory_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;guest_phys_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;userspace_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;region_rb_of=
fset[reg_idx] =3D offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;region_rb[re=
g_idx] =3D mr-&gt;ram_block;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;hdr.request =3D VHOST_US=
ER_ADD_MEM_REG;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_fill_msg_region(&amp;=
region_buffer, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.mem_reg.region =
=3D region_buffer;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.mem_reg.region.m=
map_offset =3D offset;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_write(dev, msg, &=
amp;fd, 1) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (track_ramblocks) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t reply_gpa=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_rea=
d(dev, &amp;msg_reply) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reply_gpa =3D msg_=
reply.payload.mem_reg.region.guest_phys_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_reply.hdr.=
request !=3D VHOST_USER_ADD_MEM_REG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;%s: Received unexpected msg type.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Expected %d received %d&=
quot;, __func__,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_ADD_MEM_REG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg_reply.hdr.request);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We&#39;re =
using the same structure, just reusing one of the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* fields, so=
 it should be the same size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_reply.hdr.=
size !=3D msg-&gt;hdr.size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;%s: Unexpected size for postcopy reply &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%d vs %d&quot;, __func__=
, msg_reply.hdr.size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg-&gt;hdr.size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get the postcop=
y client base from the backend&#39;s reply. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reply_gpa =3D=
=3D dev-&gt;mem-&gt;regions[reg_idx].guest_phys_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shad=
ow_pcb[reg_idx] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg_reply.payload.mem_reg.region.userspace_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trac=
e_vhost_user_set_mem_table_postcopy(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg_reply.payload.mem_reg.region.userspace_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg-&gt;payload.mem_reg.region.userspace_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reg_fd_idx, reg_idx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;%s: invalid postcopy reply for region. &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Got guest physical addre=
ss %lX, expected &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%lX&quot;, __func__, rep=
ly_gpa,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;mem-&gt;regions[reg_id=
x].guest_phys_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (reply_supported) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D process_me=
ssage_reply(dev, msg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (track_ramblocks) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;region_rb_offset[reg_idx] =
=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;region_rb[reg_idx] =3D NUL=
L;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* At this point, we know the backend has=
 mapped in the new<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* region, if the region has a valid file=
 descriptor.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The region should now be added to the =
shadow table.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;shadow_regions[u-&gt;num_shadow_regions]=
.guest_phys_addr =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;guest_phys_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;shadow_regions[u-&gt;num_shadow_regions]=
.userspace_addr =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;userspace_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;shadow_regions[u-&gt;num_shadow_regions]=
.memory_size =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;memory_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;num_shadow_regions++;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int vhost_user_add_remove_regions(struct vhost_dev *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Vh=
ostUserMsg *msg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol reply_supported,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol track_ramblocks)<br>
+{<br>
+=C2=A0 =C2=A0 struct vhost_user *u =3D dev-&gt;opaque;<br>
+=C2=A0 =C2=A0 struct scrub_regions add_reg[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 struct scrub_regions rem_reg[VHOST_MEMORY_MAX_NREGIONS];<br>
+=C2=A0 =C2=A0 uint64_t shadow_pcb[VHOST_MEMORY_MAX_NREGIONS] =3D {};<br>
+=C2=A0 =C2=A0 int nr_add_reg, nr_rem_reg;<br>
+<br>
+=C2=A0 =C2=A0 msg-&gt;hdr.size =3D sizeof(msg-&gt;payload.mem_reg.padding)=
 +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(VhostUserMemoryRegion);<br>
+<br>
+=C2=A0 =C2=A0 /* Find the regions which need to be removed or added. */<br=
>
+=C2=A0 =C2=A0 scrub_shadow_regions(dev, add_reg, &amp;nr_add_reg, rem_reg,=
 &amp;nr_rem_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0shadow_pcb, track_ramblocks);<br>
+<br>
+=C2=A0 =C2=A0 if (nr_rem_reg &amp;&amp; send_remove_regions(dev, rem_reg, =
nr_rem_reg, msg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reply_supported) &=
lt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (nr_add_reg &amp;&amp; send_add_regions(dev, add_reg, nr_=
add_reg, msg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_pcb, reply_=
supported, track_ramblocks) &lt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (track_ramblocks) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(u-&gt;postcopy_client_bases, shadow_pcb=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Now we&#39;ve registered this with the=
 postcopy code, we ack to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* client, because now we&#39;re in the p=
osition to be able to deal with<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any faults it generates.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Use this for failure cases as well wi=
th a bad value. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;hdr.size =3D sizeof(msg-&gt;payload.u6=
4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.u64 =3D 0; /* OK */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_write(dev, msg, NULL, 0) &lt; 0=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+<br>
+err:<br>
+=C2=A0 =C2=A0 if (track_ramblocks) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(u-&gt;postcopy_client_bases, shadow_pcb=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
=C2=A0static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct vhost_memory *mem)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct vhost_memory *mem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool reply_supported,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool config_mem_slots)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_user *u =3D dev-&gt;opaque;<br>
=C2=A0 =C2=A0 =C2=A0int fds[VHOST_MEMORY_MAX_NREGIONS];<br>
@@ -513,71 +855,84 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u-&gt;region_rb_len =3D dev-&gt;mem-&gt;n=
regions;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (vhost_user_fill_set_mem_table_msg(u, dev, &amp;msg, fds,=
 &amp;fd_num,<br>
+=C2=A0 =C2=A0 if (config_mem_slots) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_add_remove_regions(dev, &amp;ms=
g, reply_supported,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0true) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_fill_set_mem_table_msg(u, dev, =
&amp;msg, fds, &amp;fd_num,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 true) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 if (vhost_user_write(dev, &amp;msg, fds, fd_num) &lt; 0) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_write(dev, &amp;msg, fds, fd_nu=
m) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 if (vhost_user_read(dev, &amp;msg_reply) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_read(dev, &amp;msg_reply) &lt; =
0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 if (msg_reply.hdr.request !=3D VHOST_USER_SET_MEM_TABLE) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Received unexpected msg=
 type.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;Expected %d received %d&quot;, __func__,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 /* We&#39;re using the same structure, just reusing one of t=
he<br>
-=C2=A0 =C2=A0 =C2=A0* fields, so it should be the same size.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (msg_reply.hdr.size !=3D msg.hdr.size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Unexpected size for pos=
tcopy reply &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;%d vs %d&quot;, __func__, msg_reply.hdr.size, msg.hdr.size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 memset(u-&gt;postcopy_client_bases, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * VHOST_MEMORY_M=
AX_NREGIONS);<br>
-<br>
-=C2=A0 =C2=A0 /* They&#39;re in the same order as the regions that were se=
nt<br>
-=C2=A0 =C2=A0 =C2=A0* but some of the regions were skipped (above) if they=
<br>
-=C2=A0 =C2=A0 =C2=A0* didn&#39;t have fd&#39;s<br>
-=C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 for (msg_i =3D 0, region_i =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region_i &lt; dev-&gt;mem-&gt;nregions;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 region_i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_i &lt; fd_num &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_reply.payload.memory.regions=
[msg_i].guest_phys_addr =3D=3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;mem-&gt;regions[region_i=
].guest_phys_addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;postcopy_client_bases[regi=
on_i] =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_reply.payload.=
memory.regions[msg_i].userspace_addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_vhost_user_set_mem_table_p=
ostcopy(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_reply.payload.=
memory.regions[msg_i].userspace_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.payload.memory=
.regions[msg_i].userspace_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_i, region_i);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_i++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_reply.hdr.request !=3D VHOST_USER_SET_=
MEM_TABLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Received =
unexpected msg type.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Expected %d received %d&quot;, __func__,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We&#39;re using the same structure, ju=
st reusing one of the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* fields, so it should be the same size.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_reply.hdr.size !=3D msg.hdr.size) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Unexpecte=
d size for postcopy reply &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;%d vs %d&quot;, __func__, msg_reply.hdr.size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0msg.hdr.size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(u-&gt;postcopy_client_bases, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * =
VHOST_MEMORY_MAX_NREGIONS);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* They&#39;re in the same order as the r=
egions that were sent<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* but some of the regions were skipped (=
above) if they<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* didn&#39;t have fd&#39;s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (msg_i =3D 0, region_i =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region_i &lt; dev-&gt;mem-=
&gt;nregions;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region_i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_i &lt; fd_num &amp;&amp;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_reply.payload.=
memory.regions[msg_i].guest_phys_addr =3D=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;mem-&gt;re=
gions[region_i].guest_phys_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;postcopy_cli=
ent_bases[region_i] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_=
reply.payload.memory.regions[msg_i].userspace_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_vhost_user_s=
et_mem_table_postcopy(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_=
reply.payload.memory.regions[msg_i].userspace_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.=
payload.memory.regions[msg_i].userspace_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_=
i, region_i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_i++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_i !=3D fd_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: postcopy =
reply not fully consumed &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;%d vs %zd&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__func__, msg_i, fd_num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Now we&#39;ve registered this with the=
 postcopy code, we ack to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* client, because now we&#39;re in the p=
osition to be able to deal<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* with any faults it generates.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Use this for failure cases as well wi=
th a bad value. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.hdr.size =3D sizeof(msg.payload.u64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.payload.u64 =3D 0; /* OK */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_write(dev, &amp;msg, NULL, 0) &=
lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (msg_i !=3D fd_num) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: postcopy reply not full=
y consumed &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;%d vs %zd&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, msg_i, fd_num);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 /* Now we&#39;ve registered this with the postcopy code, we =
ack to the client,<br>
-=C2=A0 =C2=A0 =C2=A0* because now we&#39;re in the position to be able to =
deal with any faults<br>
-=C2=A0 =C2=A0 =C2=A0* it generates.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 /* TODO: Use this for failure cases as well with a bad value=
 */<br>
-=C2=A0 =C2=A0 msg.hdr.size =3D sizeof(msg.payload.u64);<br>
-=C2=A0 =C2=A0 msg.payload.u64 =3D 0; /* OK */<br>
-=C2=A0 =C2=A0 if (vhost_user_write(dev, &amp;msg, NULL, 0) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -592,12 +947,17 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,<br>
=C2=A0 =C2=A0 =C2=A0bool do_postcopy =3D u-&gt;postcopy_listen &amp;&amp; u=
-&gt;postcopy_fd.handler;<br>
=C2=A0 =C2=A0 =C2=A0bool reply_supported =3D virtio_has_feature(dev-&gt;pro=
tocol_features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_REPLY_ACK);<br>
+=C2=A0 =C2=A0 bool config_mem_slots =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_has_feature(dev-&gt;protocol_features,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (do_postcopy) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Postcopy has enough differences that it&#39=
;s best done in it&#39;s own<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Postcopy has enough differences that i=
t&#39;s best done in it&#39;s own<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * version<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vhost_user_set_mem_table_postcopy(dev, =
mem);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vhost_user_set_mem_table_postcopy(dev, =
mem, reply_supported,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0config_mem_slots);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMsg msg =3D {<br>
@@ -608,17 +968,23 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_=
MASK;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (vhost_user_fill_set_mem_table_msg(u, dev, &amp;msg, fds,=
 &amp;fd_num,<br>
+=C2=A0 =C2=A0 if (config_mem_slots) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_add_remove_regions(dev, &amp;ms=
g, reply_supported,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0false) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (vhost_user_write(dev, &amp;msg, fds, fd_num) &lt; 0) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_fill_set_mem_table_msg(u, dev, =
&amp;msg, fds, &amp;fd_num,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 false) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_user_write(dev, &amp;msg, fds, fd_nu=
m) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 if (reply_supported) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return process_message_reply(dev, &amp;msg);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reply_supported) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return process_message_reply(dev=
, &amp;msg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000e5a1f505a74330fa--

