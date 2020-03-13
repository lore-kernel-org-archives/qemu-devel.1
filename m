Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51952C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2696F206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2696F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnvE-0007Bt-71
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jCntx-0006In-Pf
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jCntv-0007Uv-QS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:15:13 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:51261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jCnts-0007JE-1i; Fri, 13 Mar 2020 13:15:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 659FB747E10;
 Fri, 13 Mar 2020 18:15:04 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1C898747E04; Fri, 13 Mar 2020 18:15:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1AE83747E0C;
 Fri, 13 Mar 2020 18:15:04 +0100 (CET)
Date: Fri, 13 Mar 2020 18:15:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Subject: Re: [EXTERNAL][PATCH 0/7] via-ide: fixes and improvements
In-Reply-To: <BN6PR2201MB1251E13D9FB745DDE73DC74BC6FA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.BSF.2.22.395.2003131806460.7598@zero.eik.bme.hu>
References: <20200313082444.2439-1-mark.cave-ayland@ilande.co.uk>
 <BN6PR2201MB1251E13D9FB745DDE73DC74BC6FA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Fri, 13 Mar 2020, Aleksandar Markovic wrote:
> Hi, Mark, could you just enumerate those test images, download
> locations, etc. and whatever else is needed to reproduce the boot
> processes in question - it would be useful not only for this patch
> set, but for possible future work, wouldn't it?
>
> Sorry in advance if that info in possibly in another message, and
> was missed by me.

I've sent it to Mark off-list but here it is:

On Tue, 10 Mar 2020, BALATON Zoltan wrote:
> I was testing fulong2e with this kernel:
> 
> http://distfiles.gentoo.org/experimental/mips/livecd/loongson-2007.1/
> 
> running it as
> 
> qemu-system-mips64el -M fulong2e -serial stdio -net none -vga none \
> -trace enable="pci*" -kernel gentoo-loongson-2.6.22.6-20070902 \
> -cdrom debian-8.11.0-mipsel-netinst.iso
> 
> adding the cdrom proabably does not really matter and I could not find 
> corresponding gentoo iso so using a debian one, it's just useful to have 
> something on the ide bus and also -cdrom adds it to second channel 
> because if you test with something on first channel only it might work 
> as that uses IRQ14 anyway.
> 
> On pegasos2 I've used:
> 
> qemu-system-ppc -M pegasos2 -net none -serial stdio \
> -vga none -device ati-vga,romfile=VGABIOS-lgpl-latest.bin \
> -cdrom morphos-3.13.iso
> 
> then enter "boot cd boot.img" at the firmware ok prompt.
> 
> And also the same pegasos2 command with
> 
> -cdrom debian-8.11.0-powerpc-netinst.iso
> 
> and enter "boot cd install/pegasos" then I usually select 3 for rescue 
> mode which can get to a command prompt.

For more info on VGABIOS-lgpl-latest.bin and pegrom.bin needed for 
pegasos2 see Pegasos2 emulation subproject on my http://qmiga.osdn.io/ 
page.

The fulong2e probably still has some problem correctly emulating pci 
devices becuase without -net none -vga none the kernel panics, I have no 
interest trying to debug and fix that, I only using fulong2e to 
cross-check changes needed for pegasos2. It could also be that the kernel 
being experimental have some problems, I can't test if it works on real 
hardware.

Regards,
BALATON Zoltan

