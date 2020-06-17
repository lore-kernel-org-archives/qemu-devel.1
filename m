Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EF121532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIaDU0oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EF121532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYpe-0005H8-W7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilikernel@gmail.com>)
 id 1jlYp3-0004WO-Af; Wed, 17 Jun 2020 10:13:49 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:35182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yilikernel@gmail.com>)
 id 1jlYp1-0003w1-BG; Wed, 17 Jun 2020 10:13:49 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 187so1353971ybq.2;
 Wed, 17 Jun 2020 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AJQ6VEUGf1MQ++ss43RRmLAIinslj07stOFzOoMnW28=;
 b=bIaDU0oofQiEgNkfCfPiXwuwyJXaX4B7bb90cV4+cVqkagRNDY6ZwrvQomEVIY9UP+
 ofgd7BcMi7BdF/zndGyT/oGkU/uKj3b5DVkXFIyCiFkfjOl9gdpI6YZAB6S6Hqb1TXG5
 Zx4oOnGpMgLAriF+D4fiii7rwG9vauVelyxCRr08z53C/rN5UnmWkkW+HXBuWNguaUpV
 dWRIP6ROfFLVZdy6e+0+N9bcpDKfTF61zgntjyIw0Yt+HhUwKcccwxbFhNerOcRCKbiu
 XxRW9aexZm91dwch/MC1JjgOo2Hc03/zHXfLXmVgZqwflG6XTR+inFvHJxhc3PeP+ySe
 /f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AJQ6VEUGf1MQ++ss43RRmLAIinslj07stOFzOoMnW28=;
 b=XgteIemmneoJW+YiTLEsBFc+MgsgHCsNS8J8J2ZK4lgllZxbRwFWSwQh2ynrX7uP39
 0fxnCZPDcnhWh1F1ypTmFC4NgzZoOjU2z46ZZA1kIGM2Hy7owXJGGwZbYxuGqGyfNmE3
 Xu5YuE9a7Q7PMaYBdNjW+GzbW7g+k8frUuOIYhBpz54Jt++WLCegsPX3+31oQsy36108
 BqW8VvQbuBM4Yg5d6ERaT5I0DZWIi4sBESm3XULi6tET3KZaVw4xzbuq5BKVEJl98qqx
 q6ThZfKY8qtO47qYJOL/DlMhAk35LaLCPalilB45wB4yZv7LWVUtgsp/kr5yrYa7Ib+/
 qSEg==
X-Gm-Message-State: AOAM530wv5/feDmtbhlXVt2th6NH8nbAV2cqmQc514kpC00/wI80Imfn
 73KIgWggNHGdKyyUC0ggS+xPPLZD8AYzgGr6H/A=
X-Google-Smtp-Source: ABdhPJxmvMfmKBQOUDWT9e0P65KpjYU972aw+lxNkyZ5i7oH4Mz1Jh9Ec8qnAcvL99/inZv88IvsmB54UP8ceVohdzM=
X-Received: by 2002:a25:324f:: with SMTP id y76mr13621189yby.207.1592403225486; 
 Wed, 17 Jun 2020 07:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:3ca:0:0:0:0:0 with HTTP;
 Wed, 17 Jun 2020 07:13:43 -0700 (PDT)
In-Reply-To: <20200611153623.1415001-1-yili@winhong.com>
References: <CAJfdMYCS7SJ66K2F7a9qyKyP9f1Tmbe9N7qvshNe6jAZZtpWBg@mail.gmail.com>
 <20200611153623.1415001-1-yili@winhong.com>
From: Yi Li <yilikernel@gmail.com>
Date: Wed, 17 Jun 2020 22:13:43 +0800
Message-ID: <CAJfdMYDGr2O9JFKxvc9VYYYdoRhsc66sPXdVQ9KTo01a-6uQyA@mail.gmail.com>
Subject: Re: [PATCH v2] rbd: Use RBD fast-diff for querying actual allocation
To: jdillama@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=yilikernel@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping ?

On 6/11/20, Yi Li <yili@winhong.com> wrote:
> Since Ceph version Infernalis (9.2.0) the new fast-diff mechanism
> of RBD allows for querying actual rbd image usage.
>
> Prior to this version there was no easy and fast way to query how
> much allocation a RBD image had inside a Ceph cluster.
>
> To use the fast-diff feature it needs to be enabled per RBD image
> and is only supported by Ceph cluster running version Infernalis
> (9.2.0) or newer.
>
> The fast-diff feature disabled or fast-diff map is marked as invalid,
> qemu-img will report an allocation identical to the image capacity.
>
> 'qemu-img info rbd:cepharm/liyi-rbd' might output for example:
>
>   image: json:{"driver": "raw", "file": {"pool": "cepharm",
>   "image": "liyi-rbd", "driver": "rbd"}}
>   file format: raw
>   virtual size: 20 GiB (21474836480 bytes)
>   disk size: 0 B
>   cluster_size: 4194304
>
> Newly created rbds will have the fast-diff feature enabled.
>
> Signed-off-by: Yi Li <yili@winhong.com>
> ---
>  block/rbd.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 617553b022..c1e68ff7e9 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1107,6 +1107,108 @@ static int64_t qemu_rbd_getlength(BlockDriverState
> *bs)
>      return info.size;
>  }
>
> +#if LIBRBD_VERSION_CODE > 265
> +static int disk_usage_callback(uint64_t offset, size_t len, int exists,
> +                               void *arg)
> +{
> +  uint64_t *used_size = (uint64_t *)(arg);
> +  if (exists) {
> +    (*used_size) += len;
> +  }
> +  return 0;
> +}
> +
> +static int qemu_rbd_getflags(rbd_image_t image, uint64_t *flags)
> +{
> +    int r;
> +
> +    r = rbd_get_flags(image, flags);
> +    if (r < 0) {
> +        return r;
> +    }
> +    return 0;
> +}
> +
> +static bool qemu_rbd_use_fastdiff(uint64_t features, uint64_t flags)
> +{
> +    return (((features & RBD_FEATURE_FAST_DIFF) != 0ULL) &&
> +            ((flags & RBD_FLAG_FAST_DIFF_INVALID) == 0ULL));
> +}
> +
> +static int qemu_rbd_set_allocation(rbd_image_t image,
> +                                   rbd_image_info_t *info,
> +                                   uint64_t *used_size)
> +{
> +    int r;
> +    /*
> +     * RBD image fast-diff feature enabled
> +     * Querying for actual allocation.
> +     */
> +    r = rbd_diff_iterate2(image, NULL, 0, info->size, 0, 1,
> +                          &disk_usage_callback,
> +                          used_size);
> +    if (r < 0) {
> +        return r;
> +    }
> +    return 0;
> +}
> +
> +#else
> +static int qemu_rbd_getflags(rbd_image_t image G_GNUC_UNUSED, uint64_t
> *flags)
> +{
> +    *flags = 0;
> +    return 0;
> +}
> +
> +static bool qemu_rbd_use_fastdiff(uint64_t features G_GNUC_UNUSED,
> +                                  uint64_t feature_flags G_GNUC_UNUSED)
> +{
> +    return false;
> +}
> +
> +static int qemu_rbd_set_allocation(rbd_image_t image G_GNUC_UNUSED,
> +                                   rbd_image_info_t *info _GNUC_UNUSED,
> +                                   uint64_t *used_size _GNUC_UNUSED)
> +{
> +    return 0;
> +}
> +#endif
> +
> +static int64_t qemu_rbd_allocated_file_size(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    rbd_image_info_t info;
> +    int r;
> +    uint64_t used_size = 0;
> +    uint64_t features = 0;
> +    uint64_t flags = 0;
> +
> +    r = rbd_stat(s->image, &info, sizeof(info));
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r = rbd_get_features(s->image, &features);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r = qemu_rbd_getflags(s->image, &flags);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    if (qemu_rbd_use_fastdiff(features, flags)) {
> +        r = qemu_rbd_set_allocation(s->image, &info, &used_size);
> +        if (r < 0) {
> +            return r;
> +        }
> +    } else {
> +        used_size = info.size;
> +    }
> +    return used_size;
> +}
> +
>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
>                                               bool exact,
> @@ -1316,6 +1418,7 @@ static BlockDriver bdrv_rbd = {
>      .bdrv_get_info          = qemu_rbd_getinfo,
>      .create_opts            = &qemu_rbd_create_opts,
>      .bdrv_getlength         = qemu_rbd_getlength,
> +    .bdrv_get_allocated_file_size = qemu_rbd_allocated_file_size,
>      .bdrv_co_truncate       = qemu_rbd_co_truncate,
>      .protocol_name          = "rbd",
>
> --
> 2.25.3
>
>
>
>

