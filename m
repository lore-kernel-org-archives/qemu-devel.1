Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E13C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CD52051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1lj7T0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CD52051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAKX-00068F-Sz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jEAJv-0005Sx-AQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jEAJt-0000Ln-Tx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:23:39 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jEAJq-0008Fs-Rv; Tue, 17 Mar 2020 07:23:35 -0400
Received: by mail-qt1-x841.google.com with SMTP id v15so17026661qto.2;
 Tue, 17 Mar 2020 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1HipZxFaFaHTDiGh9r1mcN7AqtB3M0sbGoT73y/TO48=;
 b=X1lj7T0BOajC1XukD0WegCUw4yMx7dlttPIAd5ZbaOFeF3EDFftSZ/wMiPM665Wg7n
 RIpSyAPmf6mYgjGXcgfjGfZGRH/fcDTWOVF0LnDeajB8qMpV0RsKz/+zwMHgcUptpWGk
 UJ5Eevf3NWaK4h1KdYHgqp74MO/N3UAOiULZkx4tnodnL6tkJO2XWDUrmnyksbp3H8YQ
 yy0VMvNoK4ALzP8JTdtw0oZ1NoTglG5OtaJkuUtfG+bQpbI8SXvSzlRRwOpMFNzRPUZL
 XRbr6Rka732MbPYLV5jqgu821eG14Bu+waNhWIbmPnTUPjYDMV0xKupfsUtWIJ5DimtJ
 HWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1HipZxFaFaHTDiGh9r1mcN7AqtB3M0sbGoT73y/TO48=;
 b=Lq0NmImffAt6YZzx7Lo7GTfJ3ZFveeZn0KN1qb/sIvc/pmYKf0HsjwThA3xQ3rNsK8
 OLEbGtYlg8xNhZVr0L7gcYsmZZLp1BnyENjfGbsyhz+YG7gXQD2uIYJsIx6Nv4g5oZl6
 7JFYtphq989pgWadWVoHPK3wvyyo4ypZgnQfFNO88VB4ebGOxbF6C927aMFPVST+s3Ll
 V4OZHtnc6U4SGhEmmO6evSAwR+oJ+OptoG3yAdR4PBI/pGvF2idnWAIB1/rIpHom7ov0
 gzdYT+W5QcCvJBRdHHi5b0R5mQj2vLr8i6cDwCzj36fwEJcSbUlSjQX/ziQiRX7o1AEX
 B4Pg==
X-Gm-Message-State: ANhLgQ1hi4DX3NBraFbGQ2E9/ZUN67qbGdqNz+kpl6wTG/UG/y8UGE4W
 9TLUjsiGWOb31e9J8+/elSZ/r+1b7+M6z7fwTLI=
X-Google-Smtp-Source: ADFU+vsf00z6lf3S22OxujlrgtSAitZKSu+Vm3SRUEXCJkm8Kqgs911tg+16yGV7ogBf5Uiu5H6CZyoVbhzUec1Yh/s=
X-Received: by 2002:ac8:4b53:: with SMTP id e19mr4357005qts.213.1584444212543; 
 Tue, 17 Mar 2020 04:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
 <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
 <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
 <20200312060827.gjddwgmevyptsmpl@apples.localdomain>
 <20200316113216.GB449975@stefanha-x1.localdomain>
 <cf3833cc-fbd1-9930-fee1-ed9b26647f1c@linux.intel.com>
In-Reply-To: <cf3833cc-fbd1-9930-fee1-ed9b26647f1c@linux.intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Mar 2020 11:23:20 +0000
Message-ID: <CAJSP0QUmO2sbCscL=f+=Ps8Wud5vcxWmL0U64Jy7XJ7VPuQGFA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe 1.4
 spec
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Dave Gilbert <dgilbert@redhat.com>, kbusch@kernel.org,
 Zhang Yi <yi.z.zhang@linux.intel.com>, "He, Junyan" <junyan.he@intel.com>,
 Klaus Birkelund Jensen <its@irrelevant.dk>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 5:10 PM Andrzej Jakowski
<andrzej.jakowski@linux.intel.com> wrote:
> On 3/16/20 4:32 AM, Stefan Hajnoczi wrote:
> > On Wed, Mar 11, 2020 at 11:08:27PM -0700, Klaus Birkelund Jensen wrote:
> >> On Mar 11 15:54, Andrzej Jakowski wrote:
> >>> On 3/11/20 2:20 AM, Stefan Hajnoczi wrote:
> >>>> Please try:
> >>>>
> >>>>   $ git grep pmem
> >>>>
> >>>> backends/hostmem-file.c is the backend that can be used and the
> >>>> pmem_persist() API can be used to flush writes.
> >>> I've reworked this patch into hostmem-file type of backend.
> >>> From simple tests in virtual machine: writing to PMR region
> >>> and then reading from it after VM power cycle I have observed that
> >>> there is no persistency.
> > Sounds like an integration bug.  QEMU's NVDIMM emulation uses
> > HostMemoryBackend and file contents survive guest reboot.
> >
> > If you would like help debugging this, please post a link to the code
> > and the command-line that you are using.
> >
>
> Code is posted here
> https://github.com/AndrzejJakowski/qemu/commit/3a7762a1d13ff1543d1da430748eb24e38faab6f
>
> QEMU command line:
>
> # below are just relevant pieces of configuration, other stuff omitted
> # tried different setting (e.g. pmem=on and pmem=off)
>
> ./x86_64-softmmu/qemu-system-x86_64 ... \
> -object memory-backend-file,id=mem1,share=off,pmem=on,mem-path=../nvme_pmr.bin,size=$((1*1024*1024)) \

share=off is MAP_PRIVATE.  If persistence is desired then share=on
should be used.

However, this shouldn't affect "system_reset" behavior since the QEMU
process still has the same mapped file open.

> -drive file=../nvme.bin,format=raw,if=none,id=nvme_emulated \
> -device nvme,drive=nvme_emulated,serial="test serial",pmrdev=mem1
>
> In VM:
> My persisent memory region is exposed PCI BAR
> Region 2: Memory at fe000000 (64-bit, prefetchable) [size=1M]
>
> So I perform reads/writes from/to following adress 0xfe000000 (decimal 4261412864)
>
> dd if=test.bin of=/dev/mem bs=1 count=30 seek=4261412864
> dd if=/dev/mem of=test1.bin bs=1 count=30 skip=4261412864

Did you verify that the guest kernel is really accessing the BAR?  I
remember that distro kernels often ship with options that make
/dev/mem of limited use because it's considered insecure.

> On VMM I didn't observe that backing file has been updated and after power cycling VM
> I see old junk when reading PMR region.

Did you check that the pmrdev mmap region contains the data the guest
wrote before power cycling?

> Also from include/qemu/pmem.h it looks like pmem_persist() will cause qemu to exit
> if libpmem is not installed:

The libpmem support only needs to be used when the pmem=on option was
given.  If there isn't a physical pmem device then it doesn't need to
be used.

Stefan

