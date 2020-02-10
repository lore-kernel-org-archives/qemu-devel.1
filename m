Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1706C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A99214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfkprqNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A99214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j18BP-0004Cp-1e
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stenavin@gmail.com>) id 1j18Ao-0003cZ-5v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stenavin@gmail.com>) id 1j18Am-0005tG-Ty
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:28:22 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:40454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stenavin@gmail.com>)
 id 1j18Am-0005so-PM; Mon, 10 Feb 2020 07:28:20 -0500
Received: by mail-oi1-x233.google.com with SMTP id a142so8996924oii.7;
 Mon, 10 Feb 2020 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KCPoT2lJcBEaaSXkgsBUWuCOqh678TzTT+/anZXpPn8=;
 b=jfkprqNHyhRxFri92X63BVgzNzc6n9ys4lglNkGTtVojbPtsgmSV8zKHDkunxQLLsV
 rCQzpQFNi62JwonZhfUA5BqtX6I2QL6X2642YFPQYJXv27krEwdORTrfuZO+oyKkLZFk
 G4xPnH+b+QpBpuVq/J8/oUJ4fDIJcKntaq/Dma2LFGfUSRE/yPUajFBQw7ho02IvssZS
 4WHzZoZHbfuIJjjoyfo/JwqC0Uvfz6AHTIcFllE3Ru8PQo4HqyNlI5h3P6ch3l6P/TT6
 Sg6JfH3ci1dSRsybmE81XzsoEKzp087DCEXS9avYZiD2o6aBIm8rjzne1KqLZQI0bRGF
 dZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KCPoT2lJcBEaaSXkgsBUWuCOqh678TzTT+/anZXpPn8=;
 b=WQu2ZiCT2suagoOKvRQWpgw+JtzeWlmc8mfnBqGpu42hnJKElEbQVpuhM3enjb840G
 Q3qoAldX3LoNiIkJfF+BGRyTtq2tE0ncZZERK4vuq9bH7/oWmbbCj0SKQECRqW9LCgHH
 nGWKWtUmCVS72SmVW2B7zGSJcApKJKUIRWiG1CdlYOFZD5KmrCt2m9VN1bIPmOCnwBLk
 ogeqb6ZyGr8AJrrxSPiZrr1Em5iydvBYQRLyPfiD5zitAOovqQXTvFcvvsfR+ANtxRu9
 tBUqM0UG+gcokdbX07yCMZQAShS3Z7Du84AuDptFZY0vObms/FRue/cfVTrUWWZe19Kb
 IJxA==
X-Gm-Message-State: APjAAAWyZnirBLemJErh+EguzTQvDLdtV8o35tnDpOndzGqQJE8aXS7v
 DXnq+xz+/WJdfpLPh+llN3fuvhThYty724/IIOE=
X-Google-Smtp-Source: APXvYqxVlrlEv8FYi3YczQxtCbSXB6g49lTv+7f6gmYmWFWfL0yPwNcXdaulBP3k8t1IqvS6aoc/TwRwwxRzWCzhMi8=
X-Received: by 2002:a05:6808:8fc:: with SMTP id
 d28mr683268oic.152.1581337699688; 
 Mon, 10 Feb 2020 04:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20200207232528.13461-1-stenavin@gmail.com>
 <20200210114316.GW3888@redhat.com>
In-Reply-To: <20200210114316.GW3888@redhat.com>
From: Nikolay Ivanets <stenavin@gmail.com>
Date: Mon, 10 Feb 2020 14:28:08 +0200
Message-ID: <CAHwdxNdvLd9THPZz=xHd7m8Aw3myC1xM73WN_Fh-Xf5tor9Wig@mail.gmail.com>
Subject: Re: [Libguestfs] [RFC] lib: allow to specify physical/logical block
 size for disks
To: "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BD, 10 =D0=BB=D1=8E=D1=82. 2020 =D0=BE 13:43 Richard W.M. Jones <=
rjones@redhat.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Feb 08, 2020 at 01:25:28AM +0200, Mykola Ivanets wrote:
> > From: Nikolay Ivanets <stenavin@gmail.com>
> >
> > I faced with situation where libguestfs cannot recognize partitions on =
a
> > disk image which was partitioned on a system with "4K native" sector
> > size support.
>
> Do you have a small test case for this?

We can easily create one with patched libguestfs and attach disk to
unpatched libguestfs.

> > In order to fix the issue we need to allow users to specify desired
> > physical and/or logical block size per drive basis.
>
> It seems like physical_block_size / logical_block_size in qemu are
> completely undocumented.  However I did some experiments with patching
> libguestfs and examining the qemu and parted code.  Here are my
> observations:
>
> (1) Setting only physical_block_size =3D 4096 seems to do nothing.

See my thoughts on this in previous email.

> (2) Setting only logical_block_size =3D 4096 is explicitly rejected by
> virtio-scsi:
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/scsi/scsi-disk.c;h=3D1=
0d0794d60f196f177563aae00bed2181f5c1bb1;hb=3DHEAD#l2352
>
> (A similar test exists for virtio-blk)
>
> (3) Setting both physical_block_size =3D logical_block_size =3D 4096
> changes how parted partitions GPT disks.  The partition table is
> clearly using 4K sectors as you can see by examining the disk
> afterwards with hexdump.
>
> (4) Neither setting changes MBR partitioning by parted, although my
> interpretation of Wikipedia indicates that it should be possible to
> create a MBR disk with 4K sector size.  Maybe I'm doing something
> wrong, or parted just doesn't support this case.
>
> So it appears that we should just have one blocksize control (maybe
> called "sectorsize"?) which sets both physical_block_size and
> logical_block_size to the same value.  It may also be worth enforcing
> that blocksize/sectorsize must be set to 512 or 4096 (which we can
> relax later if necessary).

If we stick with the only parameter, I think blocksize might be better name=
,
especially if we want to split this parameter somewhere latter.

Here are more precise restrictions:

Both values must be a power of 2 between 512 and 32768.
logical_block_size must be
less or equals to physical_block_size.

--
  Mykola Ivanets

