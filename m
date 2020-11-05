Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F34C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF1B206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/htB1tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF1B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaY5T-0005oj-Jb
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 00:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kaY4j-0005JV-Ch; Thu, 05 Nov 2020 00:44:45 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kaY4h-0003L7-Gs; Thu, 05 Nov 2020 00:44:45 -0500
Received: by mail-ej1-x644.google.com with SMTP id oq3so823080ejb.7;
 Wed, 04 Nov 2020 21:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2O7esqFD4W8tdj6x6DS945tnXTOKlUWC4JwqFNdAhi0=;
 b=a/htB1tjeQ7chhr/SExXJkIBF4ZANNttESCql/XAkhoCvmWSyEtS3tP1eoO1YrJzsF
 bZ7Ty7cM54uuzWnVrYMcHfTgrLbAozm/Nis4xeTXWpyWDCwfu7WTtEskOt2Q18QfKV9r
 CGXDfclk1FbW7KKcql+u/q1MxVEhU+hIC2FBWNoCy5nYXBUACKpEOlDR7uCYifYTKmwj
 c7kVxCeVVytu/8fIhwfBBLLa9DYLYp89xnwSZG8quDY9dXR/TZgN5bAujjH0KBdKFKrq
 53ig1GThvRx62lI+6vTfxCZ5JTnzXtoLVEwXSX9cdaV9auJqDqao+nmX9kjvhihS0MVO
 YBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2O7esqFD4W8tdj6x6DS945tnXTOKlUWC4JwqFNdAhi0=;
 b=VJQrTXJp6zJ8K8zd4VqFsu1/YwXCQoarBu0TMZNuelmUPrIJbjplbe3nDe89CbUX0l
 lZktvEsh9OYp9KIMxV0LZ6gK+zTLmXkV1YGxC9j7sRfd0U03dueNlN+DcydW6mzawM3P
 lx+boImh7WH0DLS4uTKm0472k72u+qsPDCU42ZoOuW+67Uwc0LknNhKIZn9WOB50X/Gr
 PZ7nn1cKWlf+xXg9azOgGNwu4jbiiVPi2nE7IAQ9g8fa7IEeg9myOw5Un7ZyEegiCa+e
 uLaWEVJzO6TI0sOOT7SQS1klJEXBLmHgWQ0ezRoOc8chWOjl0r817Mzs1T6cEp1bzgfl
 Jczg==
X-Gm-Message-State: AOAM53209CRCo6hplI8bdv7VwD4vLsDFEKi/h3ihJ+IMRIX1RMHAb3Tb
 gJAXt3vYoXgnOsEEmHcLdnOzXCmF1W5dNCUunsg=
X-Google-Smtp-Source: ABdhPJzqwU84m6ishjrnAa4Pjb22Kb7JCERdv7Qt33fbK6kDTTUER74AbVLl0z7JwLEJdOJr50nPzQzAtmCUlPrX5Zw=
X-Received: by 2002:a17:906:a090:: with SMTP id
 q16mr694060ejy.220.1604555081191; 
 Wed, 04 Nov 2020 21:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20201104173217.417538-1-mlevitsk@redhat.com>
 <20201104173217.417538-2-mlevitsk@redhat.com>
In-Reply-To: <20201104173217.417538-2-mlevitsk@redhat.com>
From: Tom Yan <tom.ty89@gmail.com>
Date: Thu, 5 Nov 2020 13:44:28 +0800
Message-ID: <CAGnHSEmDa4Sbv0D+RB8zz=o2C77ZdA-M13=bfbSZ+TZucNZpGw@mail.gmail.com>
Subject: Re: [PATCH 1/5] file-posix: split hdev_refresh_limits from
 raw_refresh_limits
To: Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=tom.ty89@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Actually I made a mistake in this. BLKSECTGET (the one in the block
layer) returns the number of "sectors", which is "defined" as 512-byte
block. So we shouldn't use BLKSSZGET here, but simply 512 (1 << 9).
See logical_to_sectors() in sd.h of the kernel.

On Thu, 5 Nov 2020 at 01:32, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> From: Tom Yan <tom.ty89@gmail.com>
>
> We can and should get max transfer length and max segments for all host
> devices / cdroms (on Linux).
>
> Also use MIN_NON_ZERO instead when we clamp max transfer length against
> max segments.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index c63926d592..6581f41b2b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1162,6 +1162,12 @@ static void raw_reopen_abort(BDRVReopenState *state)
>
>  static int sg_get_max_transfer_length(int fd)
>  {
> +    /*
> +     * BLKSECTGET for /dev/sg* character devices incorrectly returns
> +     * the max transfer size in bytes (rather than in blocks).
> +     * Also note that /dev/sg* doesn't support BLKSSZGET ioctl.
> +     */
> +
>  #ifdef BLKSECTGET
>      int max_bytes = 0;
>
> @@ -1175,7 +1181,24 @@ static int sg_get_max_transfer_length(int fd)
>  #endif
>  }
>
> -static int sg_get_max_segments(int fd)
> +static int get_max_transfer_length(int fd)
> +{
> +#if defined(BLKSECTGET) && defined(BLKSSZGET)
> +    int sect = 0;
> +    int ssz = 0;
> +
> +    if (ioctl(fd, BLKSECTGET, &sect) == 0 &&
> +        ioctl(fd, BLKSSZGET, &ssz) == 0) {
> +        return sect * ssz;
> +    } else {
> +        return -errno;
> +    }
> +#else
> +    return -ENOSYS;
> +#endif
> +}
> +
> +static int get_max_segments(int fd)
>  {
>  #ifdef CONFIG_LINUX
>      char buf[32];
> @@ -1230,23 +1253,29 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
>
> -    if (bs->sg) {
> -        int ret = sg_get_max_transfer_length(s->fd);
> +    raw_probe_alignment(bs, s->fd, errp);
> +    bs->bl.min_mem_alignment = s->buf_align;
> +    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
> +}
>
> -        if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> -            bs->bl.max_transfer = pow2floor(ret);
> -        }
> +static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    BDRVRawState *s = bs->opaque;
>
> -        ret = sg_get_max_segments(s->fd);
> -        if (ret > 0) {
> -            bs->bl.max_transfer = MIN(bs->bl.max_transfer,
> -                                      ret * qemu_real_host_page_size);
> -        }
> +    int ret = bs->sg ? sg_get_max_transfer_length(s->fd) :
> +                       get_max_transfer_length(s->fd);
> +
> +    if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> +        bs->bl.max_transfer = pow2floor(ret);
>      }
>
> -    raw_probe_alignment(bs, s->fd, errp);
> -    bs->bl.min_mem_alignment = s->buf_align;
> -    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
> +    ret = get_max_segments(s->fd);
> +    if (ret > 0) {
> +        bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
> +                                           ret * qemu_real_host_page_size);
> +    }
> +
> +    raw_refresh_limits(bs, errp);
>  }
>
>  static int check_for_dasd(int fd)
> @@ -3600,7 +3629,7 @@ static BlockDriver bdrv_host_device = {
>      .bdrv_co_pdiscard       = hdev_co_pdiscard,
>      .bdrv_co_copy_range_from = raw_co_copy_range_from,
>      .bdrv_co_copy_range_to  = raw_co_copy_range_to,
> -    .bdrv_refresh_limits = raw_refresh_limits,
> +    .bdrv_refresh_limits = hdev_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
>      .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> @@ -3724,7 +3753,7 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_co_preadv         = raw_co_preadv,
>      .bdrv_co_pwritev        = raw_co_pwritev,
>      .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
> -    .bdrv_refresh_limits = raw_refresh_limits,
> +    .bdrv_refresh_limits = hdev_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
>      .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> --
> 2.26.2
>

