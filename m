Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C2C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218CB206DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218CB206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i01gA-000522-7H
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1i01fP-0004Yd-CU
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1i01fN-0003jc-9H
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:47:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:35418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1i01fM-0003hJ-Uh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:47:05 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EF08A749FDB;
 Tue, 20 Aug 2019 12:46:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CEB0D7456E2; Tue, 20 Aug 2019 12:46:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9BD47456D5;
 Tue, 20 Aug 2019 12:46:56 +0200 (CEST)
Date: Tue, 20 Aug 2019 12:46:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190820062552.ivu7o4rcroppkjje@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1908201235270.15352@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1908190208150.57965@zero.eik.bme.hu>
 <20190819061545.7qeiyonvvqe3s6up@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908200126020.56805@zero.eik.bme.hu>
 <20190820062552.ivu7o4rcroppkjje@sirius.home.kraxel.org>
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
>>> For example in qemu 1.5 the nic roms got EFI support and there is a
>>> compat property which switches the pc-i440fx-1.4 (and older) machine
>>> types to the non-efi versions.  Grep for pxe-e1000.rom to find the code.
>
> Note that roms with a pci firmware standard header[1] can be chained
> together, then placed in the pci rom bar.  This is how the efi-*.rom
> files are created, they are three-in-one images (bios, efi ia32, efi
> x64).
>
>   # file pc-bios/qemu_vga.ndrv
>   pc-bios/qemu_vga.ndrv: header for PowerPC PEF executable
>
> Hmm, so that is probably not going to work.
>
>> +static GlobalProperty compat[] = {
>> +    { "VGA", "romfile", NDRV_VGA_FILENAME },
>> +};
>
>> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>
> I wouldn't name the variable compat (in this specific case it's not for
> backward compatibility), but yes, this is the idea.
>
>> manually. (In the future this same way can also be used to pass proper
>> FCode ROMs to OpenBIOS.)
>
> The image type (pci rom header) can be:
>
>   Type      Description
>   0         Intel x86, PC-AT compatible
>   1         Open Firmware standard for PCI
>   2         Hewlett-Packard PA RISC
>   3         Extensible Firmware Interface (EFI)
>   4-FF      Reserved
>
> So having a single pci rom image with both classic vgabios (type 0) and
> open firmware fcode (type 1) should be possible.
>
> cheers,
>  Gerd
>
> [1] http://read.pudn.com/downloads211/doc/comm/994029/pcifw_r3_0_updated.pdf, section 5.1

Thanks for investigating it. However there are at least two problems with 
that idea:

1. OpenBIOS does not yet understand standard PCI ROM headers, it can only 
handle NDRV and PEF ROMs yet so first support for that (and FCode ROMs) 
should be added to OpenBIOS.

2. Building rom images from different sources (in this case your vgabios 
and QemuMacDrivers for the NDRV) might not be straightforward (maybe some 
clever make rules would take care of these without too much hassle but I'm 
not sure, this would mean rebuilding binary if any of the two sources 
change).

Plus I don't know if other firmwares such as sam460ex U-Boot can handle 
such multiplatform ROMs, especially because it can use x86 ROM just not 
the QEMU vgabios due to not emulating i386 specific opcodes that gcc puts 
in real mode code so it needs something compiled with bcc such as 
Plex86/Bochs VGABios so then we can't put those in one binary because we 
had two x86 images in it. Therefore I think setting this based on machine 
like above is probably the easiest way for now.

I'll wait for Mark's comments before going further with this.

Regards,
BALATON Zoltan

