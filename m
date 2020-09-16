Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAFAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0042220E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywyngdxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0042220E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZWC-0001tk-3X
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIZUe-0000sR-Or; Wed, 16 Sep 2020 11:37:12 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIZUd-0008Pm-2k; Wed, 16 Sep 2020 11:37:12 -0400
Received: by mail-ot1-x343.google.com with SMTP id m12so7134628otr.0;
 Wed, 16 Sep 2020 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FpOhr+4FNtFDsc7nD39WYzCA6HMOSzQ8gQeKUOz/6cY=;
 b=YwyngdxkNm0/aYH9aICPmQulem3dLh2fKSrmoPfG3RGNhBTwthU9bocPzd/1qibNbY
 aS9NnexYe7umWH1c0AN3ds2zEzI5Z/VlDy0+4WIuEDb2WGqSxu2OAgf7S8IGqV50phtX
 PHl97MFkCVcEByH0KJMUac6bsspDzM9/LYjh6G7/6RZV7d/e6q6z8XjXx7puIOiJMyZv
 yKzRb8ZoCsrwfRn/w/Nnr7qf3xYelh2NQM0L+Gd1Z2Uz2znOrTAw5lt/HhUKyeIO88rI
 qiO0cY7dIfzyyamRXFIT5Dggu7nZuu9KjXUzN9zM8Ob2kFjDpFfPzQ22y0ERdUkAV08w
 7jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FpOhr+4FNtFDsc7nD39WYzCA6HMOSzQ8gQeKUOz/6cY=;
 b=uZ38+J6wiX/uRxvVmuNpVAWCY3KyMBg+z+K0HQA9AdkNnxFiR8NQSg9mhZ0suVLGp0
 72+/P05qhm2V8/x0SAY9ctXgumoZua2Hlyp9L0qcrWCI6S+UynW119uKHheaf4Xelu8W
 bk0Qj9RXmfSjk6uXxXQdgKWXQ8MYuqkEofd8zQ4qiiRWV8FcYZ9txAIsYsDbJf0wWP5b
 vIb+PVm+B/qB0htqV2J7mswTnkGdAq86aEi0ilsM9e/kXzOYHl/YnhKaVAq/2Q95i0gU
 7I72MooS5zWIgLo2f6hIbzOPigXfLO2N74USO4oUvxuF+MBOW1fvBSc51m8+3sw5EE+8
 0pOA==
X-Gm-Message-State: AOAM533BPiaIPyi/XOe7fhh+MxKMGRhZLwlBEDG/QlhCBLkM+yCnWl2U
 EynjHdAZ/nqlOBYT8OdQBwcXEyiq14XSrduhrdM=
X-Google-Smtp-Source: ABdhPJzEpWMQuezFrRjx+GVyuDpluQ3ipuehjzTRDnnnDjEFBHi9+8vZUnrb86iVzww0S7t1268x9oVk70ZxyHOBLH0=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr16102530ote.181.1600270629566; 
 Wed, 16 Sep 2020 08:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-2-stefanha@redhat.com>
 <CAKXe6S+nUWQGFDKRu8mBBOTKc1kWc7YfO=p+F7+ObnmW017atg@mail.gmail.com>
 <20200916100905.GA756046@stefanha-x1.localdomain>
In-Reply-To: <20200916100905.GA756046@stefanha-x1.localdomain>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 23:36:33 +0800
Message-ID: <CAKXe6SKVNH2a3qvoBNmk1DD_yQj4ZEqtA3H6qO_-B59sJV6GRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] util/iov: add iov_discard_undo()
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SHORT_URL=1.209, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Aug 16, 2020 at 04:26:45PM +0800, Li Qiang wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:52=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Thanks for your review!
>
> > > +    /* Discard more bytes than vector size */
> > > +    iov_random(&iov, &iov_cnt);
> > > +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> > > +    iov_tmp =3D iov;
> > > +    iov_cnt_tmp =3D iov_cnt;
> > > +    size =3D iov_size(iov, iov_cnt);
> > > +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, size + 1, &un=
do);
> > > +    iov_discard_undo(&undo);
> > > +    assert(iov_equals(iov, iov_orig, iov_cnt));
> > >
> >
> > The 'iov_discard_front_undoable' will change the 'iov_tmp' it will not
> > touch 'iov_orig'.
> > So the test will be always passed. The actually function will not be te=
sted.
>
> The test verifies that the iovec elements are restored to their previous
> state by iov_discard_undo().
>
> I think you are saying you'd like iov_discard_undo() to reset the
> iov_tmp pointer? Currently that is not how the API works. The caller is
> assumed to have the original pointer (e.g. virtio-blk has
> req->elem.in/out_sg) and therefore it is not necessary to reset iov_tmp.
>

Hi Stefan,

You're right, I just have the idea in my mind the the 'discard'
function change the *iov, but the caller have the origin pointer.
So

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> > Also, maybe we could abstract a function to do these discard test?
>
> The structure of the test cases is similar but they vary in different
> places. I'm not sure if this can be abstracted nicely.
>
> > > diff --git a/util/iov.c b/util/iov.c
> > > index 45ef3043ee..efcf04b445 100644
> > > --- a/util/iov.c
> > > +++ b/util/iov.c
> > > @@ -636,14 +636,33 @@ void qemu_iovec_clone(QEMUIOVector *dest, const
> > > QEMUIOVector *src, void *buf)
> > >      }
> > >  }
> > >
> > > -size_t iov_discard_front(struct iovec **iov, unsigned int *iov_cnt,
> > > -                         size_t bytes)
> > > +void iov_discard_undo(IOVDiscardUndo *undo)
> > > +{
> > > +    /* Restore original iovec if it was modified */
> > > +    if (undo->modified_iov) {
> > > +        *undo->modified_iov =3D undo->orig;
> > > +    }
> > > +}
> > > +
> > > +size_t iov_discard_front_undoable(struct iovec **iov,
> > > +                                  unsigned int *iov_cnt,
> > > +                                  size_t bytes,
> > > +                                  IOVDiscardUndo *undo)
> > >  {
> > >      size_t total =3D 0;
> > >      struct iovec *cur;
> > >
> > > +    if (undo) {
> > > +        undo->modified_iov =3D NULL;
> > > +    }
> > > +
> > >      for (cur =3D *iov; *iov_cnt > 0; cur++) {
> > >          if (cur->iov_len > bytes) {
> > > +            if (undo) {
> > > +                undo->modified_iov =3D cur;
> > > +                undo->orig =3D *cur;
> > > +            }
> > > +
> > >
> >
> > Why here we remember the 'cur'? 'cur' is the some of the 'iov'.
> > Maybe we remember the 'iov'. I think we need the undo structure like th=
is:
> >
> > struct IOVUndo {
> >     iov **modified_iov;
> >     iov *orig;
> > };
> >
> > Then we can remeber the origin 'iov'.
>
> Yes, this could be done but it's not needed (yet?). VirtQueueElement has
> the original struct iovec pointers so adding this would be redundant.

