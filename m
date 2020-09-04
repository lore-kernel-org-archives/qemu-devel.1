Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB392C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1B420716
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLZiBHtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1B420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzBT-0002OL-Fd
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kDzAj-0001xS-Li
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:01:41 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kDzAh-000495-Sw
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:01:41 -0400
Received: by mail-ej1-x642.google.com with SMTP id q13so6195052ejo.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=xJFtwhn0thd/oBMr9T6W4mv9yooiQSle35CCdPGIoRo=;
 b=mLZiBHtbF19KhYlfjxaDbkjYqxQ98OvWyx16mL0L0AvFvLdxTD0yvqAp79NZ0i5JYh
 j20PCwb6nP5k+P059a5c5SpmA1lk48ym99Nw1Qx2lU9bD98hyzLekt6aD2BiSbsxaBzS
 SsHauF5S0PG/vVGI2PCrVjgnBY6u2Bn24mxEA33GEU2G7dK1LFFuil4AT5V8nRX5fqdi
 gwXqdtzQt5g4AsRzqspg5J7/utSrGKPpydjzWmC6dlUYw+rx+dt4RW/buBJMavxVHpt+
 gBRNGrlPF/wQeoNczw8u5cPjWuSSzMl1D7cEOdohMHg/KZU5I34COoKq38N4QWrW81ln
 iG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=xJFtwhn0thd/oBMr9T6W4mv9yooiQSle35CCdPGIoRo=;
 b=KfpgBOgELPV8tPShtk/kAnKpejGf9XEXGRJylHF3u0xKZFkBPqJmSxt+vGNkgG5dZZ
 9oy6kzvu7TP7nTf9TG7y9IMt8b5wTu/ZsEe1BzXncRehm2FuuQLWXa2Qk6tHFjojLRiE
 v65f83+ePeBSjCYyfAOcmSSAX2p37stb/axfYSkieH/HQJrRQ9pzPEBEyXiO09+VTzd5
 Mx3ANTRXV6/QtDbMh85neoBaSE3z/e/FWDeaW5+M786CHY8f+TZbFcYq3g0WWUGFjUS9
 xf1Sjut+Txfk/lXP+UBQK6Qiuto1ZZRjZLuTi0DUMfZf6c1dKf05QscqvZXvGASBHRYL
 Jv5Q==
X-Gm-Message-State: AOAM533qr/pQ0zEbW+fHVBq2GIFEpVIvSQykeevvmYAqNdx9kpuvWh0c
 +/42vmyjiUGozy/mGIK60WtmTMEecDl/4s3VgVodNa2c
X-Google-Smtp-Source: ABdhPJzPCn3d5d7MvBUmoesNj4UBecnICHMEZMLtY8c2b9ZWr1dRKXQa/zqKlASqatEYrAUpfli6aC4omiafRYD9da8=
X-Received: by 2002:a17:906:72d2:: with SMTP id
 m18mr4617152ejl.220.1599177697648; 
 Thu, 03 Sep 2020 17:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200903223721.84459-1-tom.ty89@gmail.com>
In-Reply-To: <20200903223721.84459-1-tom.ty89@gmail.com>
From: Tom Yan <tom.ty89@gmail.com>
Date: Fri, 4 Sep 2020 08:01:26 +0800
Message-ID: <CAGnHSEnK_xPv_=kUBcLcPDw-UMh9XST_c=TLAo=NV2cMk9sHJw@mail.gmail.com>
Subject: Re: [PATCH] file-posix: split hdev_refresh_limits from
 raw_refresh_limits
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=tom.ty89@gmail.com; helo=mail-ej1-x642.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops I forgot max_transfer needs to be in bytes (and BLKSECTGET in sg
has always been implemented wrongly). Will send a new version.

On Fri, 4 Sep 2020 at 06:37, Tom Yan <tom.ty89@gmail.com> wrote:
>
> sg_get_max_transfer_length() and sg_get_max_segments() have nothing
> to do with the sg driver or SG_IO at all. They can be and should be
> used on all host devices / cdroms (on Linux).
>
> Also use MIN_NON_ZERO instead when we clamp max_sectors against
> max_segments.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> ---
>  block/file-posix.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 9a00d4190a..a38f43af4f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1163,7 +1163,7 @@ static void raw_reopen_abort(BDRVReopenState *state)
>      s->reopen_state = NULL;
>  }
>
> -static int sg_get_max_transfer_length(int fd)
> +static int get_max_transfer_length(int fd)
>  {
>  #ifdef BLKSECTGET
>      int max_bytes = 0;
> @@ -1178,7 +1178,7 @@ static int sg_get_max_transfer_length(int fd)
>  #endif
>  }
>
> -static int sg_get_max_segments(int fd)
> +static int get_max_segments(int fd)
>  {
>  #ifdef CONFIG_LINUX
>      char buf[32];
> @@ -1233,23 +1233,28 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
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
> +    int ret = get_max_transfer_length(s->fd);
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
> @@ -3604,7 +3609,7 @@ static BlockDriver bdrv_host_device = {
>      .bdrv_co_pdiscard       = hdev_co_pdiscard,
>      .bdrv_co_copy_range_from = raw_co_copy_range_from,
>      .bdrv_co_copy_range_to  = raw_co_copy_range_to,
> -    .bdrv_refresh_limits = raw_refresh_limits,
> +    .bdrv_refresh_limits = hdev_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
>      .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> @@ -3728,7 +3733,7 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_co_preadv         = raw_co_preadv,
>      .bdrv_co_pwritev        = raw_co_pwritev,
>      .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
> -    .bdrv_refresh_limits = raw_refresh_limits,
> +    .bdrv_refresh_limits = hdev_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
>      .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> --
> 2.28.0
>

