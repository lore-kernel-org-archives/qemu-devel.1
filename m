Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A35CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B27207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE4AM2mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B27207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jak26-0003c5-IS
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jak1N-0003AQ-0R
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:57:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jak1M-00022e-0h
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:57:48 -0400
Received: by mail-il1-x143.google.com with SMTP id a14so5398901ilk.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EpvMD7y42tlaqqHQojBSKn8FteDhk6iDgUAc82fUk4g=;
 b=EE4AM2miv6kduwOMy31rB0gVhzifGzpUXdoDSr0+Ou2U8sJgD1IiQ7APDIRend6zkP
 /wmSax+AVk03Xm9Ebzqiss72ZgdbkysHGwEyF6jF538Fm+9SRhJEM9eqNfrebKvcOZ6M
 8G4LdStQBguAr/0qyRxWTLJvUsSO+hmdenQgivHPHlysNllyGbrvulld07KpyLeSe06g
 wcLsiaIEDUJab3gW9q/VAwfstqXwknTKDHQfsK2fPoXnvMjUEYeN5A9f39Jxi073Tqop
 sjAcnW5736Z11EpHxr/FF2kDwkcHey0gmwvhk2lvjuCP8ZPW3zqLa6Lu6y/9O2ONBgQR
 cySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EpvMD7y42tlaqqHQojBSKn8FteDhk6iDgUAc82fUk4g=;
 b=tcot6bYqKUx8FAGsoPZP7YxjSG0pp+ehFn38nGaTkxSXZUGppib2kuYGPDR1uSxtKw
 9fS2WOOKKl79jUb6WVQhz9yqkG5FufyCurTuskEBFcmRtvMnOhRV2B9PuhEIiRcuedZa
 BfrT6RKsWkZOBSlqDoSHc/vNZnJqDiqjq5zgvi2cL64uotElDExaX1qm7iBH9bDpZ6pQ
 ShiYs3raO+Fdmy1BsppxseIHKDhn1Z6Vfi9o1qCd/3j2S9pPWQCtrpb6dMByIRbzcAfT
 OK0DM8sSPkw5kBbmFwzXouQ6JLtxPaSunlYfsNbRLxxfyz7Pn23aWkZ2gPxURT1xaVKc
 iU3Q==
X-Gm-Message-State: AOAM531RTKnKte0xpNqLiNb7jK4ZyfFYWRxjM/zQIIgeEPEnlxmkVeF6
 thmHEwJF6g2tN4YUjNnxkPzqzsQCW0BFricnXDs0TONL9fA=
X-Google-Smtp-Source: ABdhPJwG1A+oV0qUnfWwuCstEW8DCTYtWZQKZiB6z3kGpBTkycUzktqbDHS09K2rJsUhXrosAsuFk9qhXIjSHMM3VJA=
X-Received: by 2002:a92:d40f:: with SMTP id q15mr15929095ilm.97.1589824666707; 
 Mon, 18 May 2020 10:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200508212719.26071.94248.stgit@localhost.localdomain>
 <20200508213010.26071.6318.stgit@localhost.localdomain>
In-Reply-To: <20200508213010.26071.6318.stgit@localhost.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 May 2020 10:57:35 -0700
Message-ID: <CAKgT0UcT5yhv-yvTZDvgX_uBjRz3oKAqBpc4y899b1xdAQZ6aw@mail.gmail.com>
Subject: Re: [PATCH v24 QEMU 3/3] virtio-balloon: Provide an interface for
 free page reporting
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 2:30 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Add support for free page reporting. The idea is to function very similar
> to how the balloon works in that we basically end up madvising the page as
> not being used. However we don't really need to bother with any deflate
> type logic since the page will be faulted back into the guest when it is
> read or written to.
>
> This provides a new way of letting the guest proactively report free
> pages to the hypervisor, so the hypervisor can reuse them. In contrast to
> inflate/deflate that is triggered via the hypervisor explicitly.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>


I just realized that the patch below added the code to add the
reporting_vq but I never cleaned it up. I will submit a v25 in the
next couple of days that contains a fix for that.

> ---
>  hw/virtio/virtio-balloon.c         |   69 ++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-balloon.h |    2 +
>  2 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 1666132a24c1..53abba290274 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -321,6 +321,67 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>
> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> +    VirtQueueElement *elem;
> +
> +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> +        unsigned int i;
> +
> +        /*
> +         * When we discard the page it has the effect of removing the page
> +         * from the hypervisor itself and causing it to be zeroed when it
> +         * is returned to us. So we must not discard the page if it is
> +         * accessible by another device or process, or if the guest is
> +         * expecting it to retain a non-zero value.
> +         */
> +        if (qemu_balloon_is_inhibited() || dev->poison_val) {
> +            goto skip_element;
> +        }
> +
> +        for (i = 0; i < elem->in_num; i++) {
> +            void *addr = elem->in_sg[i].iov_base;
> +            size_t size = elem->in_sg[i].iov_len;
> +            ram_addr_t ram_offset;
> +            RAMBlock *rb;
> +
> +            /*
> +             * There is no need to check the memory section to see if
> +             * it is ram/readonly/romd like there is for handle_output
> +             * below. If the region is not meant to be written to then
> +             * address_space_map will have allocated a bounce buffer
> +             * and it will be freed in address_space_unmap and trigger
> +             * and unassigned_mem_write before failing to copy over the
> +             * buffer. If more than one bad descriptor is provided it
> +             * will return NULL after the first bounce buffer and fail
> +             * to map any resources.
> +             */
> +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> +            if (!rb) {
> +                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
> +                continue;
> +            }
> +
> +            /*
> +             * For now we will simply ignore unaligned memory regions, or
> +             * regions that overrun the end of the RAMBlock.
> +             */
> +            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb)) ||
> +                (ram_offset + size) > qemu_ram_get_used_length(rb)) {
> +                continue;
> +            }
> +
> +            ram_block_discard_range(rb, ram_offset, size);
> +        }
> +
> +skip_element:
> +        virtqueue_push(vq, elem, 0);
> +        virtio_notify(vdev, vq);
> +        g_free(elem);
> +    }
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -841,6 +902,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>              virtio_error(vdev, "iothread is missing");
>          }
>      }
> +
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
> +        s->reporting_vq = virtio_add_queue(vdev, 32,
> +                                           virtio_balloon_handle_report);
> +    }
> +
>      reset_stats(s);
>  }
>
> @@ -945,6 +1012,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>      DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_PAGE_POISON, true),
> +    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_REPORTING, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 3ca2a78e1aca..28fd2b396087 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_hint_status {
>
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
>      uint32_t free_page_hint_status;
>      uint32_t num_pages;
>      uint32_t actual;
>

