Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB100CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 12:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B764821925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 12:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="nGhG3qVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B764821925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLnqp-0005Oa-M6
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 08:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iLnq4-0004kt-Bx
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 08:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iLnq3-0002Dx-2y
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 08:28:08 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:45478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iLnq2-0002DT-SW; Sat, 19 Oct 2019 08:28:07 -0400
Date: Sat, 19 Oct 2019 07:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571488085;
 bh=acvzxAoRFxn0+hEbhF3XzF6Vj8uOKj9kiowHmZvb27o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nGhG3qVFzYQ6kiGCGtG+eS7ItVWb4+ALTYvD0I4n6NjgK4atteRhXE0QeYXnV/yL4
 NfQYIMHXIE+2C3bH/vyQ4MaC4fUodIQmkKbcS1UqOnSToVnj6nRNsBpjDL/tBOZiuh
 SkD17fLCRspLerh14K3aVVLlQIArJ7zUUOnu/trATFSk4KrknrfgjIXgYrB2AuFbn8
 MMkbiqFQ6JIZv+CMIvCHXumfW//BkeHSew0+P5EhlBzZCcJqWoFHTHC5MpNIlX37OD
 95AjsYmkf7egHBzxGNtZ+wIs4Apmx0QaBPRyZ0lF1SfSPupXNYi8H9uuJwXO3rjkqz
 wNbcdgs4dP9Gw==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191019122800.m6cmdj7ywazqc7ei@proprietary-killer>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <20191019111519.GE1960@umbus.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019111519.GE1960@umbus.fritz.box>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.139
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
Cc: qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 10:15:19PM +1100, David Gibson wrote:
> On Fri, Oct 18, 2019 at 12:28:29PM -0500, Marty E. Plummer wrote:
> > Hello,
> > 
> > First off, thank you for the work you've done on the ppc64 support, it
> > has been very useful. I'm currently working on a coreboot port for the
> > talos ii line of systems (which means more ppc64 support, support
> > specifically for the power9 sforza chip, and specific mainboard support.
> > My plate is very full lol) and have been using qemu to debug the
> > bootblock.
> 
> Ok.  I'm assuming that's with the powernv machine type?
> 
Assuming you mean the hardware, yes, the kernel for it is configured
with the powernv_defconfig.

Assuming that you mean how I call qemu, yes, also powernv: my full
command is:

qemu-system-ppc64 -cpu power9 -M powernv -m 4G -s -S \
-chardev socket,id=qemu-monitor,host=localhost,port=7777,server,nowait,telnet \
-mon qemu-monitor,mode=readline -nographic -bios build/cbfs/fallback/bootblock.bin
> > It has been very useful for that, but I'm now at the point where I need
> > to jump to romstage, and that's where it gets tricky. qemu parses the rom
> > image and looks for a ffs header, locates skiboot on it, and jumps straight
> > to that. Not exactly ideal for debugging something not produced from
> > op-build.
> 
> Um.. I'm not sure what code you're talking about.  AFAICT the pnv code
> just starts the cpus at address 0x10.
> 
If I pass it the full coreboot.rom file via
`-drive file=./build/coreboot.rom,format=raw,if=mtd` it returns this error:
'qemu-system-ppc64: Initialization of device pnv-pnor failed: bad header'
which arises in hw/ppc/pnv_pnor.c:136-140 using legoater's powernv-4.2
branch.

Ah, so I wasn't going crazy and it was skipping the first four instructions,
how odd. Any particular reason the first four instruction are skipped?
On hostboot that's setting up the msr; on skiboot that seems to be the
fdt_entry branch to boot_entry.
> > Do you think it would be within your wheelhouse to provide a generic, non-ffs
> > pnor interface for loading arbitary rom images? It would be of great help if
> > you could. (This would still hopefully have the bmc support code as
> > well, as I'm still needing to support a system using one).
> 
> Uh.. and I'm not really sure what you're asking for here.
> 
Basically not have to have a pnor-style image for mtd devices, and not
immidiatly jump to skiboot.
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



