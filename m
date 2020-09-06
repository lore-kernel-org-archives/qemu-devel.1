Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AB0C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 11:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3639920760
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 11:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDuJyOE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3639920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEsUO-0002BI-AA
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 07:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kEsTq-0001bA-FW; Sun, 06 Sep 2020 07:05:06 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kEsTo-0005RV-EG; Sun, 06 Sep 2020 07:05:06 -0400
Received: by mail-ed1-x544.google.com with SMTP id a12so9887448eds.13;
 Sun, 06 Sep 2020 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=eNdHFRLdIzEeaRR2eJnvIW3tUh+p6PK+0B02/d8rd5M=;
 b=LDuJyOE5uNsR2by4e+EVvYSPtqsSf7hjeg0sbMctX1bKhnQnocq0WN+Iuatb789vid
 Nqs1Gzy1LOa84ad0QWJXtEQMrxZhtd76qa4UL1sJTh+IhCoBBoP2zR4+s0O6ly+JPX1D
 wGfZjG5AvFcarzakp+kikEzuvvKIppSfE+dtrzoOQgIXKwr6gSG2zsUQU4fU6iediTi1
 vDmDZBmaWwht9a4ltu6db5lc500WV5xM5y9PEzks+IZl1UIxLTySzzlwre0ySgjov10V
 91CcoEWIBSxJR27lbnqZRl+isddrHFeRn6/iGGNu5tniKCtIKI+x+AD9ewR+1LXbvDw9
 r9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=eNdHFRLdIzEeaRR2eJnvIW3tUh+p6PK+0B02/d8rd5M=;
 b=lUZ0DIzNx81q9dUK8aEQ50DhwLmrUzxSvrHrfMH0WCXpW9k2L/v7XarJQi42UI929l
 cenUwOh5U4z6mFVscJZ6KzCnrfuOIu8vr8ne3717wJopVEjL3cCFT1eXCPUWVZPd/z9T
 ykgphoZeaeEzv4GbfHx8PfQLoYQ+kydGmAr75eNKh/2EVHFHqMM9NPGWUvRXJz1vGrV1
 //XEv6ajDQvhT2Ka2JZ3WXhrZ6GYtJSntbOyW4fa6ArgqIUbUYQoe81dgl9yhr61DYhw
 xV+jGxYhJNYPRR/nsJ47XrweT8ufF1LV4fOuDBEOHsTUFuBH/SJUxWHe8/lV7de9CJZ4
 tqUA==
X-Gm-Message-State: AOAM53026S06hQORLoPRQYq/nUQx4cdUb+OWYIfmevAmX+jKbQeR0hrf
 sXzdNyW5moxtzeH/C05jL/NwvCm1riD7awCj0zb+oj9ESBg=
X-Google-Smtp-Source: ABdhPJwQIA+swN4xrkZX1N2OUdkeY7i+OkislKOCjh0FLWIlebdSqeBarihRzctNeUnvlQAmIiS7eF2pFGHN7sJk3QU=
X-Received: by 2002:a50:fb15:: with SMTP id d21mr17605814edq.150.1599390302305; 
 Sun, 06 Sep 2020 04:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200904020907.241550-1-tom.ty89@gmail.com>
 <20200904020907.241550-2-tom.ty89@gmail.com>
 <CAGnHSEnF--OJ9biTx_ZxgqizVtr+0rBL8o-b9wY9+XNsnLPV=A@mail.gmail.com>
In-Reply-To: <CAGnHSEnF--OJ9biTx_ZxgqizVtr+0rBL8o-b9wY9+XNsnLPV=A@mail.gmail.com>
From: Tom Yan <tom.ty89@gmail.com>
Date: Sun, 6 Sep 2020 19:04:51 +0800
Message-ID: <CAGnHSE=qnj8a8qaS6eiFdevp6ya0GjqXHuDgAV12B0tEAajddg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] file-posix: add sg_get_max_segments that actually
 works with sg
To: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, 
 qemu-devel@nongnu.org, mlevitsk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=tom.ty89@gmail.com; helo=mail-ed1-x544.google.com
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

Maybe you want to add some condition for this:
https://github.com/qemu/qemu/blob/v5.1.0/nbd/server.c#L659
Or not clamp it at all.

On Sun, 6 Sep 2020 at 18:58, Tom Yan <tom.ty89@gmail.com> wrote:
>
> In commit 867eccfed84f96b54f4a432c510a02c2ce03b430, Levitsky appears
> to have assumed that the only "SCSI Passthrough" is `-device
> scsi-generic`, while the fact is there's also `-device scsi-block`
> (passthrough without the sg driver). Unlike `-device scsi-hd`, getting
> max_sectors is necessary to it (more precisely, hw_max_sectors might
> what matters, but BLKSECTGET reports max_sectors, so).
>
> I'm unsure about how qemu-nbd works, but the commit clearly wasn't the
> right approach to fix the original issue it addresses. (It should for
> example ignore the max_transfer if it will never matter in to it, or
> overrides it in certain cases; when I glimpsed over
> https://bugzilla.redhat.com/show_bug.cgi?id=1647104, I don't see how
> it could be file-posix problem when it is reporting the right thing,
> regardless of whether "removing" the code helps.)
>
> I don't think we want to "mark" `-device scsi-block` as sg either. It
> will probably bring even more unexpected problems, because they are
> literally different sets of things behind the scene / in the kernel.
>
> On Fri, 4 Sep 2020 at 10:09, Tom Yan <tom.ty89@gmail.com> wrote:
> >
> > sg devices have different major/minor than their corresponding
> > block devices. Using sysfs to get max segments never really worked
> > for them.
> >
> > Fortunately the sg driver provides an ioctl to get sg_tablesize,
> > which is apparently equivalent to max segments.
> >
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > ---
> >  block/file-posix.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 411a23cf99..9e37594145 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1178,6 +1178,21 @@ static int sg_get_max_transfer_length(int fd)
> >  #endif
> >  }
> >
> > +static int sg_get_max_segments(int fd)
> > +{
> > +#ifdef SG_GET_SG_TABLESIZE
> > +    long max_segments = 0;
> > +
> > +    if (ioctl(fd, SG_GET_SG_TABLESIZE, &max_segments) == 0) {
> > +        return max_segments;
> > +    } else {
> > +        return -errno;
> > +    }
> > +#else
> > +    return -ENOSYS;
> > +#endif
> > +}
> > +
> >  static int get_max_transfer_length(int fd)
> >  {
> >  #if defined(BLKSECTGET) && defined(BLKSSZGET)
> > @@ -1268,7 +1283,7 @@ static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
> >          bs->bl.max_transfer = pow2floor(ret);
> >      }
> >
> > -    ret = get_max_segments(s->fd);
> > +    ret = bs->sg ? sg_get_max_segments(s->fd) : get_max_segments(s->fd);
> >      if (ret > 0) {
> >          bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
> >                                             ret * qemu_real_host_page_size);
> > --
> > 2.28.0
> >

