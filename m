Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C6CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD222CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD222CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04ia-0004s2-8l
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1i04hQ-00043g-Rb
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1i04hP-0004Ow-0p
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:01:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:16412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1i04hO-0004Nx-Mm
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:01:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C24907456D5;
 Tue, 20 Aug 2019 16:01:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9AB597456B4; Tue, 20 Aug 2019 16:01:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8DEED7456E3;
 Tue, 20 Aug 2019 16:01:20 +0200 (CEST)
Date: Tue, 20 Aug 2019 16:01:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190820122825.ok2jfngulypcyvah@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1908201530160.56910@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1908190208150.57965@zero.eik.bme.hu>
 <20190819061545.7qeiyonvvqe3s6up@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908200126020.56805@zero.eik.bme.hu>
 <20190820062552.ivu7o4rcroppkjje@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908201235270.15352@zero.eik.bme.hu>
 <20190820122825.ok2jfngulypcyvah@sirius.home.kraxel.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: Re: [Qemu-devel] Machine specific option ROMs
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019, Gerd Hoffmann wrote:
> Yes, how the guest treats those roms is another issue.  bios/efi combo
> roms on x86 are not that uncommon.  But I'm not sure how widespread
> bios/openfirmare combo roms are used (have been used) in practice.  If

I haven't heard about such BIOS/OF ROMs (which does not mean much as I 
don't know much about this) but I think it's probably not widespread if 
used at all. I think ROM size on cards were limited for cost reasons so 
instead of trying to fit more images in one limited space vendors usually 
produced separate versions for x86 and Macs with different ROM image. At 
least there's a lot of info on how to convert PC cards to Mac by 
reflashing ROM which would not be needed if these had support in ROM.

> guests can't deal with it (and try to run a x86 emulator on the bios
> image instead) it might not be the best plan to go that route.

Some clients do have BIOS emulation while also can use OF ROM like 
pegasos2's SmartFirmware but I don't know how that would handle 
multiplatform ROMs so it's better go the simpler way which seems to have 
less problems and just set the ROM the clients are most likely to support 
by machine emulation. Multiplatform ROMs are an interesting possibility 
but looks like more trouble in practice than it could bring.

>> just not the QEMU
>> vgabios due to not emulating i386 specific opcodes that gcc puts in real
>> mode code
>
> What does sam460ex use?  Some x86emu fork?  If so upgrading might help.
> Xorg uses x86emu too and older versions have problems with the
> gcc-generated real mode code too.

It has x86emu in roms/u-boot-sam460ex/board/ACube/bios_emulator and is 
likely old version because this is from 2010/2011. (I think I've also 
tried enabling the option in vgabios for x86emu fixups before but that did 
not help or maybe that was with pegasos2 which does not even have firmware 
sources to update, yet it's useful to test with original firmware so I'd 
like to get that working eventually.) For sam460ex there's a newer, 
updated firmware version from 2015 the sources of which are available from 
the vendor here:

http://acube-systems.biz/index.php?page=hardware&pid=5

but I don't know if that has newer x86emu and haven't tested if it works 
with QEMU. I also had to fix bugs in the previous version to compile and 
work so unless there's a good reason I don't want to spend time trying to 
update sam460ex firmware. The current version works enough to boot OSes 
and I don't want to start maintaining and fixing a commercial vendor's 
firmware. They can support it if they want.

Regards,
BALATON Zoltan

