Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B0C2D0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 00:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25435206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 00:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25435206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijXpA-00075v-Fz
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 19:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ijXoM-0006Wr-OT
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ijXoL-00066t-Je
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:12:30 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57356)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ijXoL-00064g-7e; Mon, 23 Dec 2019 19:12:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id D51B022CA5;
 Mon, 23 Dec 2019 19:12:21 -0500 (EST)
Date: Tue, 24 Dec 2019 11:12:26 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: NetBSD/arc on MIPS Magnum, was Re: [PATCH 00/10] Fixes for DP8393X
 SONIC device emulation
In-Reply-To: <636043f1-bd84-f00d-55a5-7d58aab6cd57@redhat.com>
Message-ID: <alpine.LNX.2.21.1.1912241016420.42@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
 <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
 <CAL1e-=hRs0EMz7ZTt+GXMfyHW8arq-h-m1Dzd3jz+vqP82+zjA@mail.gmail.com>
 <CAL1e-=iTBxqCsNCbGpONdewE4uTDG=OAV36fF_Cq9=i6KQhMaA@mail.gmail.com>
 <alpine.LNX.2.21.1.1912200912360.8@nippy.intranet>
 <636043f1-bd84-f00d-55a5-7d58aab6cd57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Dec 2019, Philippe Mathieu-Daud? wrote:

> Hi Finn,
> 
> On 12/20/19 5:24 AM, Finn Thain wrote:
> > On Sun, 15 Dec 2019, Aleksandar Markovic wrote:
> > 
> > > 
> > > Herve,
> > > 
> > > Is there any way for us to come up with an equivalent or at least
> > > approximate scenario for Jazz machines?
> > > 
> > > Regards,
> > > Aleksandar
> > > 
> > 
> > That would be useful in general, but in this case I think it might be
> > better to test NetBSD, since I have already tested Linux. (I had to fix
> > some bugs in the Linux sonic driver.)
> > 
> > I tried to boot NetBSD/arc but failed. I got a blue screen when I typed
> > "cd:boot" at the "Run A Program" prompt in the ARC menu.
> > 
> > $ ln -s NTPROM.RAW mipsel_bios.bin
> > $ mips64el-softmmu/qemu-system-mips64el -M magnum -L .
> > -drive if=scsi,unit=2,media=cdrom,format=raw,file=NetBSD-8.1-arc.iso
> > -global ds1225y.filename=nvram -global ds1225y.size=8200
> > qemu-system-mips64el: g364: invalid read at [0000000000102000]
> > $
> > 
> > Any help would be appreciated.
> 
> Please open a new bug entry with this information at
> https://bugs.launchpad.net/qemu/+filebug
> 

I know precious little about NetBSD installation and MIPS Magnum. What I 
wrote above was guesswork. Hence this could be a NetBSD bug or user error.

Does there exist a known-good combination of NetBSD/arc and 
qemu-system-mips64el releases?

If so, I could use that to check for user error or possible NetBSD issue.

> Thanks,
> 
> Phil.
> 
> 

