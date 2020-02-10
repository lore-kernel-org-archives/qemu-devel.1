Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF2C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CD020714
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7vOZboY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CD020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19re-0000QZ-Qg
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 09:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stenavin@gmail.com>) id 1j19qt-0007zE-6G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stenavin@gmail.com>) id 1j19qr-0006Eh-IW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:15:55 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:45710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stenavin@gmail.com>)
 id 1j19qr-0006EF-CT; Mon, 10 Feb 2020 09:15:53 -0500
Received: by mail-ot1-x334.google.com with SMTP id 59so6408724otp.12;
 Mon, 10 Feb 2020 06:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oPgNC3OJCuFq5YuQ1njM+htwOmotKHGPSANsq2ZmEnA=;
 b=F7vOZboYY5LLet+SUTIFWyTfb3dPVNvXHiWPDjJnsCzyl7Ee0j1CGhhyFUg7NIryS4
 AxvGwqBHamhzztcxE4lCOYXVtG5P3It8vldRzFKYA/xt7N3V2rnNfe5oI67JRYjSTagR
 VVy6rCOO8Vmp898kfUYouCh11FwHRJQFfkdyGyLwCyb48PeS8LMqlVr80Ks06w6/yHO0
 nmSpAIP+0rXuVbft1Q8VgFezeC+dcf09zOm+vAp0tg81WqNxVD6qTZw0/Aaqqi/omUwZ
 VImBddZsmx5BH2ZJTIvdqFm7wVixXy3eYb9a+aPi/PugHPjID92vl12/tHfTiMpz4AEi
 F+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oPgNC3OJCuFq5YuQ1njM+htwOmotKHGPSANsq2ZmEnA=;
 b=qv8ILIPH77PpYdVJ/voUhC2xE0rC1fVv+ov42ai4rbm2ipxxmTKz8IZrf7PyBPsOS5
 gwmCw2Py4hrSGbBgYnc2S7d4wPKYQyjOtyhNq5eWprJI6iHMA8B3yZ1pSQ7q0OYW+oAi
 qfzq4v4kSZpbGCjg6JDrvaJTAi2L8WzAxy7I7N9X7gLqx2vgF8D+PCQhiG1EOYUdTIaA
 2OTQ0RSBDv4XnPnUiQozdbaTnOh/kR0VbEAyTjbFoqAlOpF1hk0mhJI4srrmxGYPPGeM
 ku9LUMF0Edd8+xOYh1D2V1cVrpIafa2c3SzQdoxPFn2vDgV371lf0UhS892hE0ppPYzX
 EaUA==
X-Gm-Message-State: APjAAAXG1WINKHoD8ClM40L2Uvz4cThCZp9xRRlh2CWce7oSwiXB1OzA
 ArQY38NJ8jahLQWHCIs/mzAyBCK3xbzln7LuWt++XGURMBU=
X-Google-Smtp-Source: APXvYqyrCMGTTNYCI/p10KQ92aTozKpff4+5hDPur+gMfuvAv3hAaV9sRq2675vIzWDAN8zDNCyyftUMMiy6S8uyO+c=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr1146922otb.121.1581344152294; 
 Mon, 10 Feb 2020 06:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20200207232528.13461-1-stenavin@gmail.com>
 <20200210114316.GW3888@redhat.com>
 <20200210134846.GD5955@linux.fritz.box>
In-Reply-To: <20200210134846.GD5955@linux.fritz.box>
From: Nikolay Ivanets <stenavin@gmail.com>
Date: Mon, 10 Feb 2020 16:15:40 +0200
Message-ID: <CAHwdxNdNQjXNr+rndka0vztMThgkrpifKJqVq5p1SO0nn7U2Kw@mail.gmail.com>
Subject: Re: [Libguestfs] [RFC] lib: allow to specify physical/logical block
 size for disks
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: pbonzini@redhat.com, libguestfs@redhat.com,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BD, 10 =D0=BB=D1=8E=D1=82. 2020 =D0=BE 15:48 Kevin Wolf <kwolf@re=
dhat.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Am 10.02.2020 um 12:43 hat Richard W.M. Jones geschrieben:
> > On Sat, Feb 08, 2020 at 01:25:28AM +0200, Mykola Ivanets wrote:
> > > From: Nikolay Ivanets <stenavin@gmail.com>
> > >
> > > I faced with situation where libguestfs cannot recognize partitions o=
n a
> > > disk image which was partitioned on a system with "4K native" sector
> > > size support.
> >
> > Do you have a small test case for this?
> >
> > > In order to fix the issue we need to allow users to specify desired
> > > physical and/or logical block size per drive basis.
> >
> > It seems like physical_block_size / logical_block_size in qemu are
> > completely undocumented.  However I did some experiments with patching
> > libguestfs and examining the qemu and parted code.  Here are my
> > observations:
> >
> > (1) Setting only physical_block_size =3D 4096 seems to do nothing.
>
> The guest sees the physical_block_size and can try to keep its requests
> aligned as an optimisation. But it doesn't actually make a semantic
> difference as to how the content of the disk is accessed.
>
> > (2) Setting only logical_block_size =3D 4096 is explicitly rejected by
> > virtio-scsi:
> >
> > https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/scsi/scsi-disk.c;h=
=3D10d0794d60f196f177563aae00bed2181f5c1bb1;hb=3DHEAD#l2352
> >
> > (A similar test exists for virtio-blk)
> >
> > (3) Setting both physical_block_size =3D logical_block_size =3D 4096
> > changes how parted partitions GPT disks.  The partition table is
> > clearly using 4K sectors as you can see by examining the disk
> > afterwards with hexdump.
>
> This is what you want for emulating a 4k native disk.
>
> > (4) Neither setting changes MBR partitioning by parted, although my
> > interpretation of Wikipedia indicates that it should be possible to
> > create a MBR disk with 4K sector size.  Maybe I'm doing something
> > wrong, or parted just doesn't support this case.
>
> I seem to remember that 4k native disks require GPT, but if you say you
> read otherwise, I'm not 100% sure about this any more.
>
> > So it appears that we should just have one blocksize control (maybe
> > called "sectorsize"?) which sets both physical_block_size and
> > logical_block_size to the same value.  It may also be worth enforcing
> > that blocksize/sectorsize must be set to 512 or 4096 (which we can
> > relax later if necessary).
>
> A single option (to control logical_block_size) makes sense for
> libguestfs. physical_block_size is only relevant for the appliance and
> not for the resulting image, so it can be treated as an implementation
> detail.
>
> Kevin
>

So, can we summarize?

- in libguestfs we will expose the only parameter called 'blocksize'
- 512 and 4096 are the only allowed values for 'blocksize' for now
- we will reject libvirt XML with values for physical_* and
logical_block_size other then 512 or 4096
- importing disks configuration from libvirt XML we will use logical_block_=
size

Richard, are we fine with that?

--
  Mykola Ivanets

