Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C9C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 05:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D7A20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 05:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftKrnU+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D7A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDKvO-0005i8-Pl
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 01:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kDKul-0004xR-Np
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 01:02:31 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:36314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kDKuk-0003kk-1I
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 01:02:31 -0400
Received: by mail-oo1-xc44.google.com with SMTP id y30so863541ooj.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 22:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HJKcaT8Ol0RRjGOHBAsmEu+ZB4g8RBw6+l8aHUOUMaY=;
 b=ftKrnU+CE3QOxiQsUKlsf1fD8853zmENaj3BtpEVcy62n0YPuFbldXqN5A4QVQVaEm
 VmpNwvUnxvlcD4DShzsx3ZtPustnxeco/V0jGAhtPowpiIM8txw3UAN48Q5R9tAGvnhM
 2pF4lgkCamTent+tL1vTrso3KzZIkX7GTgx0VPT7gZIE6cIsJkJX6seQy4yoCmttweml
 8W208kJY7uJREtHmK3ep4ys7Xf2Ck/t7pkoJbO3NUS7uWjT2tsJxooPeCmlVkG3briOJ
 JTnKUA5ob8GnB3w1M2BdoHTELVwjBSBkyKxKQmIbYj3kjYeoYrT3QgVQ8go4dZdQ8kzi
 uOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HJKcaT8Ol0RRjGOHBAsmEu+ZB4g8RBw6+l8aHUOUMaY=;
 b=nOjQ05tNsFQrVUvZ1OsIoK6aalzTgqCsdrV1/krjNLVANL+kweT4th77pLjR3OpoGW
 fqdt9wr1ZcX2m7ZtiHd2OtfJob/AK315BNQ8XngIDAg7GLR8vStBYE5HqF0MYs4EFacp
 t3iKYfajB4jWdS9vEN8TB97ivbACvhknX034Km7bxWzr+RmIHiCCmzziQpMZqRqAibQT
 sBYGK5zWnnjrFkFwRMKT1XtxfrfiPDeK24hMfJaQA5TgjTH1kCyHkTQ7eSjsdKkSCQ4h
 Gf6lv9rvnTR/pZ1o7cDxzuFjeXsCsmONmPhthP8C6YiTOyH9QLGHN3g+liV0n7rz1UiW
 xoCQ==
X-Gm-Message-State: AOAM531+Vlt3BaUseHxR0NzrxSDa0B+sUe5O6JqDbzQsN3/HsZEyMF7J
 LZd8oeXirULFITmaRLlQinzU3j/Ff/aJeZOICjI=
X-Google-Smtp-Source: ABdhPJxB1w+bKDXeyG2va2T7jxRonBVy1J/n0GEeEZwMdeIs7d2GMZk64X3kFt04k2TDRZNx5B+9wfKreRvJP/QaPaI=
X-Received: by 2002:a4a:d8ce:: with SMTP id c14mr4048249oov.90.1599022948064; 
 Tue, 01 Sep 2020 22:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200811014343.17140-1-chenjiajun8@huawei.com>
In-Reply-To: <20200811014343.17140-1-chenjiajun8@huawei.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 2 Sep 2020 01:02:17 -0400
Message-ID: <CAFubqFtdB5xL_+xz9O74FdDLU8ZMo=RTDmbskofEbxbFbk3TGg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: Jiajun Chen <chenjiajun8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc44.google.com
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
Cc: zhang.zhanghailiang@huawei.com, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I see how this fixes vhost_has_free_slot() to correctly determine
whether or not regions can be added, but why are the
used_memslots_exceeded variable and the used_memslots_is_exceeded()
API needed?

On Mon, Aug 10, 2020 at 9:44 PM Jiajun Chen <chenjiajun8@huawei.com> wrote:
>
> Used_memslots is equal to dev->mem->nregions now, it is true for
> vhost kernel, but not for vhost user, which uses the memory regions
> that have file descriptor. In fact, not all of the memory regions
> have file descriptor.
> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> 5 memory slots can be used by vhost user, it is failed to hot plug
> a new memory RAM because vhost_has_free_slot just returned false,
> but we can hot plug it safely in fact.
>
> Signed-off-by: Jiajun Chen <chenjiajun8@huawei.com>
> Signed-off-by: Jianjay Zhou <jianjay.zhou@huawei.com>
> ---
>  hw/virtio/vhost-backend.c         | 14 ++++++++
>  hw/virtio/vhost-user.c            | 28 ++++++++++++++++
>  hw/virtio/vhost.c                 | 54 +++++++++++++++++++++++++------
>  include/hw/virtio/vhost-backend.h |  5 +++
>  include/hw/virtio/vhost.h         |  1 +
>  net/vhost-user.c                  |  7 ++++
>  6 files changed, 100 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 31231218dc..04d20fc3ee 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2354,6 +2355,31 @@ void vhost_user_cleanup(VhostUserState *user)
>      user->chr = NULL;
>  }
>
> +static void vhost_user_set_used_memslots(struct vhost_dev *dev)
> +{
> +    unsigned int counter = 0;
> +    int i;
> +
> +    for (i = 0; i < dev->mem->nregions; ++i) {
> +        struct vhost_memory_region *reg = dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> +        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> +                                    &offset);

Why not use the  vhost_user_get_mr_data helper? It would simplify the
code a bit.

> +        if (mr && memory_region_get_fd(mr) > 0) {
> +            counter++;
> +        }
> +    }
> +    vhost_user_used_memslots = counter;
> +}
> +
> +static unsigned int vhost_user_get_used_memslots(void)
> +{
> +    return vhost_user_used_memslots;
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_backend_init,
> @@ -2387,4 +2413,6 @@ const VhostOps user_ops = {
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e7a6..7f36d7af25 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1346,9 +1373,13 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memory);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>
> -    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> -        error_report("vhost backend memory slots limit is less"
> -                " than current number of present memory slots");
> +    /*
> +     * If we started a VM without any vhost device,
> +     * vhost_dev_used_memslots_is_exceeded will always return false for the
> +     * first time vhost device hot-plug(vhost_get_used_memslots is always 0),
> +     * so it needs to double check here
> +     */
> +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {

Why can't we just check if hdev->vhost_ops->vhost_get_used_memslots()
> hdev->vhost_ops->vhost_backend_memslots_limit(hdev)?

>          r = -1;
>          if (busyloop_timeout) {
>              goto fail_busyloop;
> @@ -1773,3 +1804,8 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
>
>      return -1;
>  }
> +
> +bool used_memslots_is_exceeded(void)
> +{
> +    return used_memslots_exceeded;
> +}
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 17532daaf3..2f0216b518 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -347,6 +348,12 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>                                   net_vhost_user_event, NULL, nc0->name, NULL,
>                                   true);
> +
> +        if (used_memslots_is_exceeded()) {

Why can't you use vhost_has_free_slot() instead here?

> +            error_report("used memslots exceeded the backend limit, quit "
> +                            "loop");
> +            goto err;
> +        }
>      } while (!s->started);
>
>      assert(s->vhost_net);
> --
> 2.27.0.dirty
>
>

