Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B34C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F28620869
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReEEF5om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F28620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3PJ-0001dG-Dw
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:08:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NU-0000PQ-2N
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NT-00054m-1E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hF3NS-00054K-RX; Fri, 12 Apr 2019 17:06:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id q16so12824339wmj.3;
	Fri, 12 Apr 2019 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=Q9sgQ2mZhuOx/zPkge6h+hJ+vpFFaCKEFz9uIHeTEDg=;
	b=ReEEF5om5+hB2K0JF+Xh7nPhwechgw6pmYYCJNhDS3zPEW9kVAPKTtjWxxtzPg+N9Z
	UtSt9Qj7taHmD1yCXPzvsbB6PBdnH41kP5B5ax/7R4glj6Zl8p1VxviWNnJMBkKEbXlK
	N9s7S0ryDGnVPs583p7uiJDHPGFphNLzmT8PzRjo46P7igjebKscV4bcTkN/DsLeUfpk
	NC0uJRVj2llhGLjByEkM6nn/IWbFPp42vFr/r76miUwC3rhmIiAsFqRQq1Vk5/Z1Ox95
	M2YIKHmYDO+AtfQMXxiZpzgu2xH0ot2/JgWfpayXAnVH/wsGj48EMeGpanwnZdpKdxvJ
	+Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Q9sgQ2mZhuOx/zPkge6h+hJ+vpFFaCKEFz9uIHeTEDg=;
	b=FAepCJsi9Q/RXq9KV5jwqj/k08r80UXSyxZC/uIUNBgKwdYbdkHOs0qD8KnPo7onas
	xMAnS/r++YWd6aHoJxGjuY7v+wDo4yslFTseuyNikRHdcjKm3btB2j0vyfMSnmHNa7YB
	JwG8wzfMUTIblR9UUbNAqddhUVsRSbUlEXXmNk9rUApbSgWdjT9eEQXOFr1kGlb1tmq/
	a9XUokwghyyy97Y8yZDkGa7dwGk/Jq968ZjszOW+fdPUVhudQYOOy3/b38xYXDw+ppCM
	E0BufTX0cR0fuh4Apu9OER3jTyyGG5Ce3pElBibrBD0RajMTBqr7P1lnRjjU8zLBr2oj
	am1A==
X-Gm-Message-State: APjAAAXu2WpgDyK0LiFnCs0l9/8Jn7veL3vNhDRq0Ads/SqfMCnP8Vko
	j1z3dOTqKJ+ajn6iUlI51tJFVTn3
X-Google-Smtp-Source: APXvYqxtK0WvfK/z0Ki3tB6jjd167XWR9EBpMA13jyh9U2l0H+YdU3YIZsU6iog0SonX0zekXPJyeQ==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr12389321wml.108.1555103184914; 
	Fri, 12 Apr 2019 14:06:24 -0700 (PDT)
Received: from localhost (x4d0c5397.dyn.telefonica.de. [77.12.83.151])
	by smtp.gmail.com with ESMTPSA id
	y127sm13128780wmg.29.2019.04.12.14.06.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:06:23 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Fri, 12 Apr 2019 23:06:14 +0200
Message-Id: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 0/4] Improve 40p, make AIX 5.1 boot
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412210614.DBmZlMRsJfsl8vto6qzPrCz0Xzblsoa6vu-PcKg6gLY@z>

This series makes various fixes for the -M 40p target.
Particularly now it's possible to boot AIX 5.1 (both from a cdrom
and a hard disk).

The OFW image: 
https://github.com/artyom-tarasenko/openfirmware/releases/download/20190406-AIX-boots/q40pofw-serial.rom

The command line:
qemu-system-ppc -M 40p -bios q40pofw-serial.rom -serial telnet::4441,server -hda aix-hdd.qcow2 -cdrom \
/path/to/aix-5.1-cd1.iso  -vga none -nographic

More info can be found here:
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Artyom Tarasenko (4):
  lsi53c895a: hide 53c895a registers in 53c810
  40p and prep: implement PCI bus mastering
  target/ppc: improve performance of large BAT invalidations
  hw/isa/i82378.c: use 1900 as a base year

 hw/isa/i82378.c         |  4 +++-
 hw/pci-host/prep.c      | 15 +++++++++++----
 hw/scsi/lsi53c895a.c    | 31 ++++++++++++++++++++++++++-----
 target/ppc/mmu_helper.c |  7 +++++++
 4 files changed, 47 insertions(+), 10 deletions(-)

-- 
2.7.2


