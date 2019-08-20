Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECBC3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7992332A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7992332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ane-0007qB-21
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0Akk-0007Bz-8b
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0Akh-0001zq-Ph
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0Akh-0001zT-GE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:29:11 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73265693F5
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 20:29:09 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id c1so4557676otb.22
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8jpE604A0ndZmHbEPl7ik+Z7004aqxVzH55untYZetE=;
 b=UXYfDAqZ7MCSN+Dn9KaV1V6R6wUJHOZ7kRmryfHvfcrBpPp/1LwMtXrTYJA8+sFMdB
 oukWNuwA9RLWLfChk+J0/Mstalcp6vDOE3SSTclx7xTBChFIHpUOTzd4kl6jTZBxH+aj
 EvI+Ced9c3pieMXON3EB+Z44goZ6Ps4tRCR6DO64AniEglx8JjvgPxFvtgFw9ibi/eOk
 lJk/uEMUueJj9DNFrTnr66gmciZsqBBx/c+9ZFUTq5Shye9gRQqNjTVXli6Vh9vTIceg
 ianOv75AaESapu0zDonN45MmydPn2ROsU0NUNb/tT8xnw9k1GU64Ulf8kogJLbP6EqX7
 Zqtg==
X-Gm-Message-State: APjAAAUMTkexuCNAi63FfDWU5T6lnZRWrrEeUjhw9XORycedV4RELXqA
 lyQmCPSxwOuSRTgG7SwENGqDQ7qJUXJwvcL9eLLALLLwagd07uYZZICP9sUn+Myyyg5zfpGDokb
 CAcws/tAjpt6pU5Lbz6FFvPsgBMrwNew=
X-Received: by 2002:a54:4610:: with SMTP id p16mr1413994oip.56.1566332948790; 
 Tue, 20 Aug 2019 13:29:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0kU7NsefGbbUrjuqP08IKBAXWxha2RSxUx+cJQe7I04IXqnk19Cxl2r/pWb1I0UeeCwJh2trBRdqnU2EplyE=
X-Received: by 2002:a54:4610:: with SMTP id p16mr1413975oip.56.1566332948465; 
 Tue, 20 Aug 2019 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190817175346.12518-1-nsoffer@redhat.com>
 <1624c705-aa27-b840-ea6a-26886ba52b8e@redhat.com>
In-Reply-To: <1624c705-aa27-b840-ea6a-26886ba52b8e@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 20 Aug 2019 23:28:57 +0300
Message-ID: <CAMRbyytAq0YY_X8rKQZtnJcGysk=UJT+=nAeRKzsQcnj7NhVcQ@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Use QEMU_IS_ALIGNED
 instead of reinventing it
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 10:30 PM John Snow <jsnow@redhat.com> wrote:

>
>
> On 8/17/19 1:53 PM, Nir Soffer wrote:
> > Replace instances of:
> >
> >     (n & (BDRV_SECTOR_SIZE - 1)) == 0)
> >
> > With:
> >
> >     QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE)
> >
>
> Do you have a magical incantation you used to find these?
>

I found the first by accident, then I used:

    git grep 'BDRV_SECTOR_SIZE - 1'

> Which reveals the intent of the code better, and makes it easier to
> > locate the code checking alignment.
> >
> > QEMU_IS_ALIGNED is implemented using %, which may be less efficient but
> > it is used only in assert() except one instance, so it should not
> > matter.
> >
>
> There is virtually no way these aren't optimized by the compiler.
>

Makes sense, but I did not check.


>
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
>
> Therefore:
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>
> > ---
> >  block/bochs.c | 4 ++--
> >  block/cloop.c | 4 ++--
> >  block/dmg.c   | 4 ++--
> >  block/io.c    | 8 ++++----
> >  block/qcow2.c | 4 ++--
> >  block/vvfat.c | 8 ++++----
> >  qemu-img.c    | 2 +-
> >  7 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/block/bochs.c b/block/bochs.c
> > index 962f18592d..32bb83b268 100644
> > --- a/block/bochs.c
> > +++ b/block/bochs.c
> > @@ -248,8 +248,8 @@ bochs_co_preadv(BlockDriverState *bs, uint64_t
> offset, uint64_t bytes,
> >      QEMUIOVector local_qiov;
> >      int ret;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >
> >      qemu_iovec_init(&local_qiov, qiov->niov);
> >      qemu_co_mutex_lock(&s->lock);
> > diff --git a/block/cloop.c b/block/cloop.c
> > index 384c9735bb..4de94876d4 100644
> > --- a/block/cloop.c
> > +++ b/block/cloop.c
> > @@ -253,8 +253,8 @@ cloop_co_preadv(BlockDriverState *bs, uint64_t
> offset, uint64_t bytes,
> >      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
> >      int ret, i;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >
> >      qemu_co_mutex_lock(&s->lock);
> >
> > diff --git a/block/dmg.c b/block/dmg.c
> > index 45f6b28f17..4a045f2b3e 100644
> > --- a/block/dmg.c
> > +++ b/block/dmg.c
> > @@ -697,8 +697,8 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset,
> uint64_t bytes,
> >      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
> >      int ret, i;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >
> >      qemu_co_mutex_lock(&s->lock);
> >
> > diff --git a/block/io.c b/block/io.c
> > index 56bbf195bb..7508703ecd 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -1080,8 +1080,8 @@ static int coroutine_fn
> bdrv_driver_preadv(BlockDriverState *bs,
> >      sector_num = offset >> BDRV_SECTOR_BITS;
> >      nb_sectors = bytes >> BDRV_SECTOR_BITS;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >      assert(bytes <= BDRV_REQUEST_MAX_BYTES);
> >      assert(drv->bdrv_co_readv);
> >
> > @@ -1133,8 +1133,8 @@ static int coroutine_fn
> bdrv_driver_pwritev(BlockDriverState *bs,
> >      sector_num = offset >> BDRV_SECTOR_BITS;
> >      nb_sectors = bytes >> BDRV_SECTOR_BITS;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >      assert(bytes <= BDRV_REQUEST_MAX_BYTES);
> >
> >      assert(drv->bdrv_co_writev);
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 59cff1d4cb..41cab70e1d 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2072,8 +2072,8 @@ static coroutine_fn int
> qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
> >              }
> >              if (bs->encrypted) {
> >                  assert(s->crypto);
> > -                assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -                assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +                assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +                assert(QEMU_IS_ALIGNED(cur_bytes, BDRV_SECTOR_SIZE));
> >                  if (qcow2_co_decrypt(bs, cluster_offset, offset,
> >                                       cluster_data, cur_bytes) < 0) {
> >                      ret = -EIO;
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index f6c28805dd..019b8f1341 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -1547,8 +1547,8 @@ vvfat_co_preadv(BlockDriverState *bs, uint64_t
> offset, uint64_t bytes,
> >      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
> >      void *buf;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >
> >      buf = g_try_malloc(bytes);
> >      if (bytes && buf == NULL) {
> > @@ -3082,8 +3082,8 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t
> offset, uint64_t bytes,
> >      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
> >      void *buf;
> >
> > -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> >
> >      buf = g_try_malloc(bytes);
> >      if (bytes && buf == NULL) {
> > diff --git a/qemu-img.c b/qemu-img.c
> > index c920e3564c..ca3af0c549 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -2138,7 +2138,7 @@ static int img_convert(int argc, char **argv)
> >              int64_t sval;
> >
> >              sval = cvtnum(optarg);
> > -            if (sval < 0 || sval & (BDRV_SECTOR_SIZE - 1) ||
> > +            if (sval < 0 || !QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
> >                  sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
> >                  error_report("Invalid buffer size for sparse output
> specified. "
> >                      "Valid sizes are multiples of %llu up to %llu.
> Select "
> >
>
>
>
