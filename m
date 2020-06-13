Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C1CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27D920789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27D920789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkAWW-0004M4-41
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 14:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkAVL-0003Rn-PH; Sat, 13 Jun 2020 14:03:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:18282)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkAVK-00076F-4z; Sat, 13 Jun 2020 14:03:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id F22A5746331;
 Sat, 13 Jun 2020 20:03:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CC783746307; Sat, 13 Jun 2020 20:03:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB0857456F8;
 Sat, 13 Jun 2020 20:03:34 +0200 (CEST)
Date: Sat, 13 Jun 2020 20:03:34 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 0/5] Mac Old World ROM experiment
In-Reply-To: <cover.1592055375.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006131957090.82630@zero.eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 14:03:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 13 Jun 2020, BALATON Zoltan wrote:
> Version 2 with some more tweaks this now starts but drops in a Serial
> Test Manager (see below) presumably because some POST step is failing,
> I let others who know more about this machine figure out what's
> missing from here.
>
> Regards,
> BALATON Zoltan
>
>
>      1 :pci_update_mappings_add d=0x55a1bb6254a0 00:01.0 0,0xf3000000+0x80000
>      1 pci_cfg_read grackle 00:0 @0x0 -> 0x21057
>      1 pci_cfg_read grackle 00:0 @0xa8 -> 0x0
>      1 pci_cfg_write grackle 00:0 @0xa8 <- 0x40e0c
>      1 pci_cfg_read grackle 00:0 @0xac -> 0x0
>      1 pci_cfg_write grackle 00:0 @0xac <- 0x12000000
>      1 pci_cfg_read grackle 00:0 @0xac -> 0x12000000
>      1 pci_cfg_write grackle 00:0 @0xac <- 0x2000000
>      1 pci_cfg_read grackle 00:0 @0x70 -> 0x0
>      1 pci_cfg_write grackle 00:0 @0x70 <- 0x11000000
>      1 machine_id_read(0, 2)
>      1 pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
>      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x0
>      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12900000
>      1 machine_id_read(0, 2)
>      1 portA_write unimplemented
>      1 CUDA: unknown command 0x22
>      1 CUDA: unknown command 0x26
>      3 CUDA: unknown command 0x25
>      1 pci_cfg_write grackle 00:0 @0x80 <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x88 <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x90 <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x98 <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x84 <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x8c <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x94 <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0x9c <- 0xffffffff
>      1 pci_cfg_write grackle 00:0 @0xa0 <- 0x0
>      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12900000
>      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12900000
>      1 machine_id_read(0, 2)
>      1 pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
>      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12900000
>      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12940000
>      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12940000
>      1 pci_cfg_write grackle 00:0 @0xf4 <- 0x40010fe4
>      1 pci_cfg_write grackle 00:0 @0xf8 <- 0x7302293
>      1 pci_cfg_write grackle 00:0 @0xfc <- 0x25302220
>      1 pci_cfg_read grackle 00:0 @0xa0 -> 0x0
>      1 pci_cfg_write grackle 00:0 @0xa0 <- 0x67000000
>      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12940000
>      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x129c0000
> 550755 Unassigned mem read 00000000f3014020

So this seems to be the missing sound device (maybe trying to play the 
startup chime). Adding some dummy implementation there gets me a little 
bit further:

       2 macio: screamer read 20  4
       1 macio: screamer write 10  4 = 600000
       1 macio: screamer read 10  4
       2 macio: screamer read 20  4
       1 macio: screamer write 10  4 = 8220000
       1 macio: screamer read 10  4
       1 macio: screamer write 10  4 = 0
       1 macio: screamer read 10  4
       7 CUDA: unknown command 0x22
       2 macio: screamer read 20  4
       1 macio: screamer write 10  4 = 180000
       1 macio: screamer read 10  4
       1 CUDA: unknown command 0x22
       1 macio: screamer read 0  4
       1 macio: screamer write 0  4 = 11050000
       1 dbdma_unassigned_flush: use of unassigned channel 16
       1 dbdma_unassigned_rw: use of unassigned channel 16
       1 Unassigned mem write 0000000000240020 = 0x10006238
       1 Unassigned mem write 0000000000240024 = 0xffe32c00
       1 Unassigned mem write 0000000000240028 = 0x0
       1 Unassigned mem write 000000000024002c = 0x84006238

then stops here, I guess it may be waiting for an interrupt so probably we 
need Mark's screamer implementation to move on. Mark, any chance you can 
look at this sometimes? Why is your email address stripped from emails 
coming from the list? Is that a list setting to exclude you from replies?

Regards,
BALATON Zoltan

