Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2FC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14628214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14628214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxbn-00009P-6Y
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1hzxaf-0007vn-1k
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hzxad-0000F7-Pm
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hzxad-0000Dv-Km
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:25:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D22B190C034;
 Tue, 20 Aug 2019 06:25:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A57E61001959;
 Tue, 20 Aug 2019 06:25:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9392416E2D; Tue, 20 Aug 2019 08:25:52 +0200 (CEST)
Date: Tue, 20 Aug 2019 08:25:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190820062552.ivu7o4rcroppkjje@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.9999.1908190208150.57965@zero.eik.bme.hu>
 <20190819061545.7qeiyonvvqe3s6up@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908200126020.56805@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1908200126020.56805@zero.eik.bme.hu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 20 Aug 2019 06:25:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

  Hi,

> > For example in qemu 1.5 the nic roms got EFI support and there is a
> > compat property which switches the pc-i440fx-1.4 (and older) machine
> > types to the non-efi versions.  Grep for pxe-e1000.rom to find the code.

Note that roms with a pci firmware standard header[1] can be chained
together, then placed in the pci rom bar.  This is how the efi-*.rom
files are created, they are three-in-one images (bios, efi ia32, efi
x64).

   # file pc-bios/qemu_vga.ndrv
   pc-bios/qemu_vga.ndrv: header for PowerPC PEF executable

Hmm, so that is probably not going to work.

> +static GlobalProperty compat[] = {
> +    { "VGA", "romfile", NDRV_VGA_FILENAME },
> +};

> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));

I wouldn't name the variable compat (in this specific case it's not for
backward compatibility), but yes, this is the idea.

> manually. (In the future this same way can also be used to pass proper 
> FCode ROMs to OpenBIOS.)

The image type (pci rom header) can be:

   Type      Description
   0         Intel x86, PC-AT compatible
   1         Open Firmware standard for PCI
   2         Hewlett-Packard PA RISC
   3         Extensible Firmware Interface (EFI) 
   4-FF      Reserved

So having a single pci rom image with both classic vgabios (type 0) and
open firmware fcode (type 1) should be possible.

cheers,
  Gerd

[1] http://read.pudn.com/downloads211/doc/comm/994029/pcifw_r3_0_updated.pdf, section 5.1

