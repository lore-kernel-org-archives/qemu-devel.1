Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F192075E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcVdttk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F192075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFaL-00067b-57
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jlFZB-0005ZE-33
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:40:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jlFZ9-0004Un-BR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592329206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+3VbB9RzhN8EOoprJvBH2mgGx2SmPQjXYqxfqqPhXGQ=;
 b=WcVdttk9tZiPRaMf0rM1upjxEqZZrruV8B356iyodw5E5P+bqe5kwlStqz9xAufcw2lhLc
 uHv9U6PBoniWuIIXCXlNMezD0BcV24WeGm+tAYqgoLev99U7Izy82A8RhBMG1tO2+zPfDP
 ta2hNneUDTDFFQBKtCKBNjxidmvj5hA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-BkR9YrQ8O_mmDvUJpu1AMw-1; Tue, 16 Jun 2020 13:39:56 -0400
X-MC-Unique: BkR9YrQ8O_mmDvUJpu1AMw-1
Received: by mail-oo1-f70.google.com with SMTP id t140so10029007oot.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+3VbB9RzhN8EOoprJvBH2mgGx2SmPQjXYqxfqqPhXGQ=;
 b=tqm9HartzzTacFS8ZI2pAtopP5BqhV6uf8H4xRqEz2OaeuYfBDBMR4xW87mLEU8uZZ
 Qx8BguG/SUa1BAVNMRuKozddkfnKMTz5aIAFc5qgrD52/4pnRm8uehI8GRGJc8krhrcO
 XOg64EG55hJIhs8l6JOfTKViD2x7eyhVAztJZuMUaK6fbsJlAfu/6X70n//ixiRPglIv
 10/+ESZUMtfXINory8fAl3luOfFFvO+PVWdfxmDywK7TT6nLSZlPSlRZs3AHB7Ta0Xf8
 jzggAjdkGnLBerIZNUfhruDbux4QwH2Hcc0PuWxSWgRxBSmu6qD718jrW+38TWaXHfwI
 xvnQ==
X-Gm-Message-State: AOAM530I6hKONRfo/7fKKGem11Opcg8aWeMjqV/pfnOgRSfftUrYJa4f
 46chfD1AarJ4BL+1M7e9cQTKK7ZEkTIbz76Ujj3gmqBrzpVEp5yGVgdIR3SEYus5IvIcOJFvxXG
 dELbSxUYWzMqNChBlCBNYSjajQ/ZcNpk=
X-Received: by 2002:a4a:e80c:: with SMTP id b12mr3346041oob.33.1592329196148; 
 Tue, 16 Jun 2020 10:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrqG8X+Yk92siANu9RganQye/nTGq28eB4XdPA/f1XFYQ0eZnb21W8XQpjgrYFmGGbUrbgC1zQxptwZb7jtGo=
X-Received: by 2002:a4a:e80c:: with SMTP id b12mr3346026oob.33.1592329195866; 
 Tue, 16 Jun 2020 10:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200613170826.354270-1-nsoffer@redhat.com>
 <CAMRbyyswkaedF0dN2nPb3H8fj5+pmhLWh9GHGor4wUk_Su=b8A@mail.gmail.com>
 <20200616153241.GF4305@linux.fritz.box>
In-Reply-To: <20200616153241.GF4305@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 16 Jun 2020 20:39:39 +0300
Message-ID: <CAMRbyys3fL_vqswb72-F_vE8pBQ1SkZZmmMeUA_TuTwsew6iSw@mail.gmail.com>
Subject: Re: [PATCH] block: file-posix: Fail unmap with NO_FALLBACK on block
 device
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: nirsof <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>, pl@kamp.de,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 6:32 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 15.06.2020 um 21:32 hat Nir Soffer geschrieben:
> > We can zero 2.3 g/s:
> >
> > # time blkdiscard -z test-lv
> >
> > real 0m43.902s
> > user 0m0.002s
> > sys 0m0.130s
>
> > We can write 445m/s:
> >
> > # dd if=/dev/zero bs=2M count=51200 of=test-lv oflag=direct conv=fsync
> > 107374182400 bytes (107 GB, 100 GiB) copied, 241.257 s, 445 MB/s
>
> So using FALLOC_FL_PUNCH_HOLE _is_ faster after all. What might not be
> faster is zeroing out the whole device and then overwriting a
> considerable part of it again.
>
> I think this means that we shouldn't fail write_zeroes at the file-posix
> level even if BDRV_REQ_NO_FALLBACK is given. Instead, qemu-img convert
> is where I see a fix.
>
> Certainly qemu-img could be cleverer and zero out more selectively. The
> idea of doing a blk_make_zero() first seems to have caused some
> problems, though of course its introduction was also justified with
> performance, so improving one case might hurt another if we're not
> careful.
>
> However, when Peter Lieven introduced this (commit 5a37b60a61c), we
> didn't use write_zeroes yet during the regular copy loop (we do since
> commit 690c7301600). So chances are that blk_make_zero() doesn't
> actually help any more now.
>
> Can you run another test with the patch below?

Sure, I can try this.

> I think it should perform
> the same as yours. Eric, Peter, do you think this would have a negative
> effect for NBD and/or iscsi?
>
> The other option would be providing an option and making it Someone
> Else's Problem.
>
> Kevin
>
>
> diff --git a/qemu-img.c b/qemu-img.c
> index d7e846e607..bdb9f6aa46 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2084,15 +2084,6 @@ static int convert_do_copy(ImgConvertState *s)
>          s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
>      }
>
> -    if (!s->has_zero_init && !s->target_has_backing &&
> -        bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
> -    {
> -        ret = blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
> -        if (ret == 0) {
> -            s->has_zero_init = true;
> -        }
> -    }

This will work of course, but now we will not do bulk zero for any target

I think we never do this for regular files anyway since we truncate
files, and there
is nothing to zero, but maybe there is some case when this is useful?

BTW, do we use BDRV_REQ_NO_FALLBACK elsewhere? maybe we can remove it.

>      /* Allocate buffer for copied data. For compressed images, only one cluster
>       * can be copied at a time. */
>      if (s->compressed) {
>


