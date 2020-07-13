Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC60C433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682482065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt87FNqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682482065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1Pi-0000BB-MF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jv1Ou-0007uO-DD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:33:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53528
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jv1Os-0004Vy-V4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594658034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUB5HcDhsDjaZiBMAQY0FtbMcWCQMIfpcdsXDtSf8AU=;
 b=Xt87FNqzh+p41YhayCw/AlA4XR+JXXg3Vk6YnMw5vlY4HGOvpI9gc1dhVYcDE/K5pNCl+M
 jnb1VtOwjf7+aiMoD7CWqWZkpYBmXFhV6x0yG7gaBO6SNY/ZxdZqpYFx8ALz5IKZGqKQnj
 gaiKuesUWZfTA0Jt6n/myQ4bU/dR4Ts=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217--yAmHFo9PjmUfBAXyqT5cA-1; Mon, 13 Jul 2020 12:33:51 -0400
X-MC-Unique: -yAmHFo9PjmUfBAXyqT5cA-1
Received: by mail-oo1-f72.google.com with SMTP id v13so9435723oor.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jUB5HcDhsDjaZiBMAQY0FtbMcWCQMIfpcdsXDtSf8AU=;
 b=W1dQzlpS3QL1VC5LINX2FBEO4PwEwLrRcu1/M4/61XDnAxVXch/gXHE4UvcStotBKg
 rb0IL8NPRbuEQx9gzHU10JzMd+4crZsdB1os73hlV0h+Ft4flBRyOcvKX2qAl7R0silx
 fehmAwC7/R3Dye4UmdNNIFP6aN39XrA30Ei7eYne3KRcNqaUl+wn9ZVaUJXS3iBD3Udk
 Gth4udfeCzwuw9ietWMRr9LmU5wxDetzupDMybI/Z0luAGoC8T7zPkxMzrGyKI/e8sS3
 cuy8G//FvdgI8mGKcxTd6xNH4wZ51SGm5Mpg/2ePhCZCd2AN4EQRP64Fhb8+5bOqvpFS
 6vpQ==
X-Gm-Message-State: AOAM53262If0cjZw91yr5INQJZJSD4mpi1UjjOXBnvJE3IdS6dJ7A3LQ
 3VDIQiscDuy8NAx/qEE2EC6jPfLCZqzXR3ZOUSNMvt5ii+KzNV/MOAJncCCrHcawcLMmTqXx6lu
 CCIvRE4fqIqOP392Zx5onXe/Es5uhYyY=
X-Received: by 2002:a05:6830:1313:: with SMTP id
 p19mr412499otq.132.1594658026380; 
 Mon, 13 Jul 2020 09:33:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNmK28lClj98WNF0gEthuMl8R0uOIFOYet1bWcQUtVWrImKj+HgcBfFcZdyHXtWSSV8/E5aGyeuoyFz5xT44A=
X-Received: by 2002:a05:6830:1313:: with SMTP id
 p19mr412479otq.132.1594658026131; 
 Mon, 13 Jul 2020 09:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
In-Reply-To: <20200710142149.40962-2-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 13 Jul 2020 19:33:30 +0300
Message-ID: <CAMRbyyux0eQo8vmz4JB8pT_1i4PJviQJPKiaJC6ehwjLhc649A@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 5:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Unaligned requests will automatically be aligned to bl.request_alignment
> and we don't want to extend requests to access space beyond the end of
> the image, so it's required that the image size is aligned.
>
> With write requests, this could cause assertion failures like this if
> RESIZE permissions weren't requested:
>
> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
>
> This was e.g. triggered by qemu-img converting to a target image with 4k
> request alignment when the image was only aligned to 512 bytes, but not
> to 4k.

Was it on NFS? Shouldn't this be fix by the next patch then?

>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/block.c b/block.c
> index cc377d7ef3..c635777911 100644
> --- a/block.c
> +++ b/block.c
> @@ -1489,6 +1489,16 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>          return -EINVAL;
>      }
>
> +    /*
> +     * Unaligned requests will automatically be aligned to bl.request_alignment
> +     * and we don't want to extend requests to access space beyond the end of
> +     * the image, so it's required that the image size is aligned.
> +     */
> +    if ((bs->total_sectors * BDRV_SECTOR_SIZE) % bs->bl.request_alignment) {
> +        error_setg(errp, "Image size is not a multiple of request alignment");
> +        return -EINVAL;
> +    }
> +
>      assert(bdrv_opt_mem_align(bs) != 0);
>      assert(bdrv_min_mem_align(bs) != 0);
>      assert(is_power_of_2(bs->bl.request_alignment));
> --
> 2.25.4
>


