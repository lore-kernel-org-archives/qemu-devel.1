Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699AC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2362320656
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh4hFnNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2362320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19V9-0001fZ-BZ
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stenavin@gmail.com>) id 1j19UW-000174-M5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stenavin@gmail.com>) id 1j19UV-0003bh-8v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:52:48 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:44112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stenavin@gmail.com>)
 id 1j19UV-0003bN-4X; Mon, 10 Feb 2020 08:52:47 -0500
Received: by mail-ot1-x32c.google.com with SMTP id h9so6331066otj.11;
 Mon, 10 Feb 2020 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U4pUy1U9NZw3G+SHreNZMgPR29ZPAb8t8aTLFJZkCYE=;
 b=nh4hFnNiaevOGBfO/GAZNA1a5GcdZjaKRZgL51CZ41PkHt8/PAxWZ+LkoPBQCaC77X
 Pgq3Ofje3aiOUgghWm3Wn+MdFBwH7yCaem7dCNtpMC4tNoSockWS53p9vLexCVErKgn1
 SBZaFD3IeCTliSSzxXjHbGWusa3Q/jaRmk7dPVrv61w3m7xpF5CW998lTtPtYNBbTQsB
 exfNlTrYr6cq6wi1immChx1yHdw1BBpV5yms/ldSfak/9P0pYmZzMa83d1VwgIG7QHUK
 N8G1MUYcvXcjtyYqQ7+/tcydTaxphlAvTkN1BoiCUzS7nwJTZ157AwvnY82YSEqBXp4o
 IW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U4pUy1U9NZw3G+SHreNZMgPR29ZPAb8t8aTLFJZkCYE=;
 b=r2qZObdWtzXuXXTahvgRe8YGm2N5blK6glCem5i0caYgXg2l8cD7gvwk7yHrPhvvG1
 NP+AlLM71x0WVxSHPPKHj/g4YMw9KyZT4v3TjriODZbNG8SlCdSFa68I8R+DP+15CNzn
 sjwyhiNKwjX6Y8lmtxp5/bhCZMeij0FVtRAED5XWMG5joPpW1eR/oEr0DgIRqU50piJl
 XIeLwS3uccjSWlGj6XqP3qJCsRD9rNwTI4OxqHN4dj/vYVGOufy7+cFEb5yLk1mnkGpO
 +zOVBY3E63EpC/fkgoynHB+q2nObBu/yQWQm/8HstdOzsw1zZEBRIwVCr8ikMP46lqJb
 Zz6A==
X-Gm-Message-State: APjAAAWW5y4R3PHXLnGF5Mhag3CNkG/H7ixmKSDDkA0sDvciqBAeOjvm
 f0MMkvaqgKHpBWE3v9wPwwdR6gwKhjYDBbSdMbo=
X-Google-Smtp-Source: APXvYqz+0lFVAaXo1NLHEfGpJZGy45p1UbDu1mYKO2JAikulyEhjeUFcBXuepNIpvcsiKus3EKWvgrcWfyg2q5vSKSw=
X-Received: by 2002:a05:6830:22cc:: with SMTP id
 q12mr1178273otc.110.1581342766223; 
 Mon, 10 Feb 2020 05:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20200207232528.13461-1-stenavin@gmail.com>
 <20200210114316.GW3888@redhat.com>
 <CAHwdxNdvLd9THPZz=xHd7m8Aw3myC1xM73WN_Fh-Xf5tor9Wig@mail.gmail.com>
 <20200210130208.GA3888@redhat.com>
In-Reply-To: <20200210130208.GA3888@redhat.com>
From: Nikolay Ivanets <stenavin@gmail.com>
Date: Mon, 10 Feb 2020 15:52:35 +0200
Message-ID: <CAHwdxNdoYTm6kn5Yxniy4=6ehcYBjSH6HK9y9i-XU5cBT+yaMA@mail.gmail.com>
Subject: Re: [Libguestfs] [RFC] lib: allow to specify physical/logical block
 size for disks
To: "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

=D0=BF=D0=BD, 10 =D0=BB=D1=8E=D1=82. 2020 =D0=BE 15:02 Richard W.M. Jones <=
rjones@redhat.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 10, 2020 at 02:28:08PM +0200, Nikolay Ivanets wrote:
> > =D0=BF=D0=BD, 10 =D0=BB=D1=8E=D1=82. 2020 =D0=BE 13:43 Richard W.M. Jon=
es <rjones@redhat.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sat, Feb 08, 2020 at 01:25:28AM +0200, Mykola Ivanets wrote:
> > > > From: Nikolay Ivanets <stenavin@gmail.com>
> > > >
> > > > I faced with situation where libguestfs cannot recognize partitions=
 on a
> > > > disk image which was partitioned on a system with "4K native" secto=
r
> > > > size support.
> > >
> > > Do you have a small test case for this?
> >
> > We can easily create one with patched libguestfs and attach disk to
> > unpatched libguestfs.
> >
> > > > In order to fix the issue we need to allow users to specify desired
> > > > physical and/or logical block size per drive basis.
> > >
> > > It seems like physical_block_size / logical_block_size in qemu are
> > > completely undocumented.  However I did some experiments with patchin=
g
> > > libguestfs and examining the qemu and parted code.  Here are my
> > > observations:
> > >
> > > (1) Setting only physical_block_size =3D 4096 seems to do nothing.
> >
> > See my thoughts on this in previous email.
> >
> > > (2) Setting only logical_block_size =3D 4096 is explicitly rejected b=
y
> > > virtio-scsi:
> > >
> > > https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/scsi/scsi-disk.c;h=
=3D10d0794d60f196f177563aae00bed2181f5c1bb1;hb=3DHEAD#l2352
> > >
> > > (A similar test exists for virtio-blk)
> > >
> > > (3) Setting both physical_block_size =3D logical_block_size =3D 4096
> > > changes how parted partitions GPT disks.  The partition table is
> > > clearly using 4K sectors as you can see by examining the disk
> > > afterwards with hexdump.
> > >
> > > (4) Neither setting changes MBR partitioning by parted, although my
> > > interpretation of Wikipedia indicates that it should be possible to
> > > create a MBR disk with 4K sector size.  Maybe I'm doing something
> > > wrong, or parted just doesn't support this case.
> > >
> > > So it appears that we should just have one blocksize control (maybe
> > > called "sectorsize"?) which sets both physical_block_size and
> > > logical_block_size to the same value.  It may also be worth enforcing
> > > that blocksize/sectorsize must be set to 512 or 4096 (which we can
> > > relax later if necessary).
> >
> > If we stick with the only parameter, I think blocksize might be better =
name,
> > especially if we want to split this parameter somewhere latter.
> >
> > Here are more precise restrictions:
> >
> > Both values must be a power of 2 between 512 and 32768.
> > logical_block_size must be
> > less or equals to physical_block_size.
>
> Agreed, but note that we can relax restrictions later if we want, but
> enforcing restrictions later is an ABI break.
>
> The only disk format I'm aware of which uses !512 and !4K sectors are
> CD ROMs (2K sector size), although libguestfs reads those without any
> problems today.  Even if you consider NASes where 64K sectors are
> normal, they still use 512 or 4K logical sectors (with lots of
> horrible read-modify-write cycles).

In this case we will reject libvirt XML with block size other then 512 and =
4096.
I'm fine with that because other values are artificial.

