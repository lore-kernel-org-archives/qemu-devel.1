Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A9BC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221F320874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph+pAKjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221F320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2H92-0005Wb-9D
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2H8M-000512-2P
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2H8L-0007f1-3M
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:42:17 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2H8K-0007ei-TM; Mon, 26 Aug 2019 11:42:17 -0400
Received: by mail-io1-xd41.google.com with SMTP id b10so29324960ioj.2;
 Mon, 26 Aug 2019 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VwxrGyveeTtFCGfeull61D5+PSUN3DjnIp2KIzI3lMQ=;
 b=Ph+pAKjKd/hke8IaB3djjlCLUPg4rpUn5W0f6UPvJZdUJ8hHihJmfKtvJqfAg9ViH7
 5fEbIKyMC0Gz7XSbTrDto3K/vDlkaKOAZIXZURSnhd2+7foF/5YpgYTY2+kiZXBVIUGE
 sF/Zzxp6d3WoDQYOodci1BdvlXNVCnq0zhiIByMXFmNv6OP8JG63ZIw6RucvIQbMOYZz
 Qp2o+HpxUGu3QAfv3knWQ6/P9KlilzaNKp2wItFSR63W1q8MjrVdjltSHJxmWDYdXII2
 ZzhMpdD057518B8XPQ7vhYdf7mexLb3QFP4U8PnjDlhBW6P+n6UkVQyOOHCq+xGq+0s9
 w0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VwxrGyveeTtFCGfeull61D5+PSUN3DjnIp2KIzI3lMQ=;
 b=uiYcPBJuZ0W27BaLTG9whUzRMemXPoo9Rk20plX6gY2sMjvhg66CaBPnx9jwhdyKZb
 vhTyZTPClU8yYiTe1tZaPMP+GEoyvoQ4M+ooNiXCpgQHwiEGo7W9Z0OoWD3FTDzJZHYp
 RdNpTKih7RStx7qpqQlVs4p4Gmg8BGKLzm1qmTeRI0qr4/K+6BB4fVvT3Z9by0dxsT8l
 Ok1PwVXE2Jf0sm8yDQA/W97QMJKcjBKBhoWs864efeeJHijPXV4G/wyYi+9sXjwRfzcX
 R76V66RTmkEGrJ2/m/B003YR3aJ3sGD3b1Rqb5IN4wTXIsxAwHe0lBOzrSY97isCCn4F
 Y9sA==
X-Gm-Message-State: APjAAAUuo3DEQ1VMvrlCyA29M7Je0IH6PJm/6DMn/6IjdnI4Etp5Wgb+
 u5O8pqjl+GN+PYCEUqraNHrG3ZK+VVfSclXrDis=
X-Google-Smtp-Source: APXvYqwkyACBsmfsEZdCQ9kceG7WxgVKMiEAu9E8L3Bj+Bv5TGYd+kBWfZgi3H3H19mmOXHXr3+OMYqeI8ayJTJEWfc=
X-Received: by 2002:a02:4005:: with SMTP id n5mr18379042jaa.73.1566834136310; 
 Mon, 26 Aug 2019 08:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
In-Reply-To: <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 26 Aug 2019 18:41:59 +0300
Message-ID: <CAMr-obvF9d=ed0hxa0FRCqFU93U8Mi21nZ6zoraYm2EfpgpQag@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: posix: Always allocate the
 first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 3:31 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 26.08.19 00:03, Nir Soffer wrote:
...
> > +/*
> > + * Help alignment probing by allocating the first block.
> > + *
> > + * When reading with direct I/O from unallocated area on Gluster backe=
d by XFS,
> > + * reading succeeds regardless of request length. In this case we fall=
back to
> > + * safe alignment which is not optimal. Allocating the first block avo=
ids this
> > + * fallback.
> > + *
> > + * fd may be opened with O_DIRECT, but we don't know the buffer alignm=
ent or
> > + * request alignment, so we use safe values.
> > + *
> > + * Returns: 0 on success, -errno on failure. Since this is an optimiza=
tion,
> > + * caller may ignore failures.
> > + */
> > +static int allocate_first_block(int fd, size_t max_size)
> > +{
> > +    size_t write_size =3D MIN(MAX_BLOCKSIZE, max_size);
>
> Hm, well, there was a reason why I proposed rounding this down to the
> next power of two.  If max_size is not a power of two but below
> MAX_BLOCKSIZE, write_size will not be a power of two, and thus the write
> below may fail even if write_size exceeds the physical block size.
>
> You can see that in the test case you add by using e.g. 768 as the
> destination size (provided your test filesystem has a block size of 512).
>
> Now I would like to say that it=E2=80=99s stupid to resize an O_DIRECT fi=
le to a
> size that is not a multiple of the block size; but I=E2=80=99ve had a bug
> assigned to me before because that didn=E2=80=99t work.
>
> But maybe it=E2=80=99s actually better if it doesn=E2=80=99t work.  I don=
=E2=80=99t know.

I tried to avoid complexity that is unlikely to help anyone, but we
can make the (typical)
case of 512 bytes sector size work with this:

    size_t write_size =3D (max_size < MAX_BLOCKSIZE)
        ? BDRV_SECTOR_SIZE
        : MAX_BLOCKSIZE;

Unfortunately testing max_size < 4096 will not be reliable since we don't k=
now
that underlying storage sector size.

...

