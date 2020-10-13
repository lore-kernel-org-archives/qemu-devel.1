Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9429C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BEB214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BEB214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIGO-0001tM-7O
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSI2P-0002iM-FW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:00:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51442
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSI2M-0006ZI-Uv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:00:13 -0400
Received: from host86-158-109-18.range86-158.btcentralplus.com
 ([86.158.109.18] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSI2A-0004NA-Fk; Tue, 13 Oct 2020 12:00:05 +0100
To: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 alxndr@bu.edu
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4f9846b5-4112-9598-fb9a-be26e28f2759@ilande.co.uk>
Date: Tue, 13 Oct 2020 11:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.18
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: ide: Linux reports drive diagnostic failures on boot
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During my latest OpenBIOS boot tests I've noticed the following IDE diagnostics 
failure message appearing in dmesg at Linux boot time when booting from CDROM on both 
SPARC64 and PPC:

[    9.347342] scsi host0: pata_cmd64x
[    9.369055] scsi host1: pata_cmd64x
[    9.371622] ata1: PATA max UDMA/33 cmd 0x1fe02008000 ctl 0x1fe02008080 bmdma 
0x1fe02008200 irq 8
[    9.372805] ata2: PATA max UDMA/33 cmd 0x1fe02008100 ctl 0x1fe02008180 bmdma 
0x1fe02008208 irq 8
[    9.711740] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    9.712591] ata2.00: Drive reports diagnostics failure. This may indicate a drive
[    9.713256] ata2.00: fault or invalid emulation. Contact drive vendor for information.
[    9.737677] ata2.00: configured for UDMA/33
[    9.790179] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 
ANSI: 5
[   10.381172] hme 0000:01:01.1 enp1s1f1: renamed from eth0
[   10.508819] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   10.509805] cdrom: Uniform CD-ROM driver Revision: 3.20


A session with git bisect points to the following commit:

55adb3c45620c31f29978f209e2a44a08d34e2da is the first bad commit
commit 55adb3c45620c31f29978f209e2a44a08d34e2da
Author: John Snow <jsnow@redhat.com>
Date:   Fri Jul 24 01:23:00 2020 -0400

     ide: cancel pending callbacks on SRST

     The SRST implementation did not keep up with the rest of IDE; it is
     possible to perform a weak reset on an IDE device to remove the BSY/DRQ
     bits, and then issue writes to the control/device registers which can
     cause chaos with the state machine.

     Fix that by actually performing a real reset.

     Reported-by: Alexander Bulekov <alxndr@bu.edu>
     Fixes: https://bugs.launchpad.net/qemu/+bug/1878253
     Fixes: https://bugs.launchpad.net/qemu/+bug/1887303
     Fixes: https://bugs.launchpad.net/qemu/+bug/1887309
     Signed-off-by: John Snow <jsnow@redhat.com>

:040000 040000 70a7c1cfbafb22fa815d3ae4d7ed075ac3918188 
3f37762f20e9ca9d2874eaf819d7175a1dca1dd9 M      hw


John/Alexander: any chance you could take a look at this? The message above is really 
simple to reproduce under qemu-system-sparc64 using 
http://cdimage.debian.org/cdimage/ports/9.0/sparc64/iso-cd/debian-9.0-sparc64-NETINST-1.iso 
and the following command line:

./qemu-system-sparc64 \
     -cdrom debian-9.0-sparc64-NETINST-1.iso \
     -m 256 \
     -nographic \
     -boot d


ATB,

Mark.

