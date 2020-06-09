Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76705C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402DC20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkUkvy/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402DC20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jie9y-0001tE-Fq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 09:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilikernel@gmail.com>)
 id 1jiZ5n-0001VY-WE; Tue, 09 Jun 2020 03:54:44 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yilikernel@gmail.com>)
 id 1jiZ5m-0002WX-NW; Tue, 09 Jun 2020 03:54:43 -0400
Received: by mail-yb1-xb44.google.com with SMTP id n123so10642256ybf.11;
 Tue, 09 Jun 2020 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=iHU/sJ5BGAr3m/MEqBDWJpJCGXIpf9YEa6LVNUn1BbY=;
 b=mkUkvy/42U5qAvLdwGHVQZ+CTE49HaudXSxj+oPQ23GupA5rbDxE3iAb9FbGMjJGCZ
 DnMYJeM7wCntM3LaqEP0SnKWXm4xwIXRLWrJCQnGs5lrZQ/fB/jaltJhpSWPmrpWMZaO
 b1J38aN8f9D6I4VAvT9UUS1/xKczd/t2NerQL6t50ylvRyAe8kzHmjj5sdmKnV9Nopnb
 NfYXMH9wLiEVUilL6n8l/O3uoLHHL8/JIRhKu0oydMAnRZZyYGhBi/mInOuGSkK6HH1n
 vMiQd9tBop2J01cZrPxw8/q3/YOMyVyuIUuLx2PkP2rAgKJZaZSedU1cRxdownPgBqJz
 wBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=iHU/sJ5BGAr3m/MEqBDWJpJCGXIpf9YEa6LVNUn1BbY=;
 b=tMJaaE6HaTzaM3hEpDiiHhH4g2IBinqUlfK1NpA0yjPloOTqHeqhFPZX91z8JT2zTz
 gXP42Xgkc8O5rmlGQ/uLh+GkcE3a3TOBrJrMh/OMIw5KnZDHdtPB1zulpMkAY9m+fRB3
 q+v0FlvUCRiu5kO62PEBLCe8FA1pFZ20vCV7bRFeUr/GFZaT01CsGinY2oPjESoDhlLo
 dKteCFrOIV/KJgjEuSbBR0RV23yfo4xCJHcGkkuiJGh4X8Netook54s6EKb6DWkFFrsG
 6StAhI0WHiVFWWNkLzsnvkHwQxs6rAvugIVswVeXrD9KLAmAb/HWZkmI4nkqwTlzfBiK
 7mFA==
X-Gm-Message-State: AOAM531aPKI0Zro7ZIVo4FB1WT9p8ekQgrL98YO0jcuiiW45Ue7fxHmP
 huYS33zMmQ4st20OI10lF0qfzLcdHg2kINktuRs=
X-Google-Smtp-Source: ABdhPJwJs8EHFpw2tZF22ElbFZxkIUP4wstC51OWPcQK4FG0wSuk3LKVKDyh/ttVAS0rPsH/3JJSqBlQO3u/2g11EK8=
X-Received: by 2002:a25:c1c5:: with SMTP id r188mr4310701ybf.240.1591689280602; 
 Tue, 09 Jun 2020 00:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:3ca:0:0:0:0:0 with HTTP;
 Tue, 9 Jun 2020 00:54:39 -0700 (PDT)
In-Reply-To: <20200609073001.3668811-1-yili@winhong.com>
References: <20200609073001.3668811-1-yili@winhong.com>
From: =?UTF-8?B?5p2O5LmJ?= <yilikernel@gmail.com>
Date: Tue, 9 Jun 2020 15:54:39 +0800
Message-ID: <CAJfdMYC54tyd3Q2au8MDBNOrcC08CxtZDbTweSxZD=hx-MLmSQ@mail.gmail.com>
Subject: Re: [PATCH] rbd: Use RBD fast-diff for querying actual allocation
To: Yi Li <yili@winhong.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=yilikernel@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2020 09:16:32 -0400
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
Cc: kwolf@redhat.com, dillaman@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CC qemu-block and rbd maintainers

On 6/9/20, Yi Li <yili@winhong.com> wrote:
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
> Without the fast-diff feature enabled qemu-img will report an allocation
> identical to the image capacity.
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
>  block/rbd.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 617553b022..f231653f7b 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1107,6 +1107,65 @@ static int64_t qemu_rbd_getlength(BlockDriverState
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
> +#endif
> +
> +static int64_t qemu_rbd_allocated_file_size(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    rbd_image_info_t info;
> +    int r;
> +    uint64_t used_size = 0;
> +    uint64_t features = 0;
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
> +   /*
> +    * rbd_diff_iterate2() is available in versions above Ceph 0.94
> (Hammer)
> +    * It uses a object map inside Ceph which is faster than
> rbd_diff_iterate()
> +    * which iterates all objects.
> +    * LIBRBD_VERSION_CODE for Ceph 0.94 is 265. In 266 and upwards
> diff_iterate2
> +    * is available
> +    */
> +#if LIBRBD_VERSION_CODE > 265
> +    if (features & RBD_FEATURE_FAST_DIFF) {
> +
> +        /*
> +         * RBD image fast-diff feature enabled
> +         * Querying for actual allocation.
> +         */
> +        r = rbd_diff_iterate2(s->image, NULL, 0, info.size, 0, 1,
> +                              &disk_usage_callback,
> +                              &used_size);
> +        if (r < 0) {
> +            return r;
> +        }
> +    } else {
> +        used_size = info.size;
> +    }
> +#else
> +    used_size = info.size;
> +#endif
> +    return used_size;
> +}
> +
>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
>                                               bool exact,
> @@ -1316,6 +1375,7 @@ static BlockDriver bdrv_rbd = {
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

