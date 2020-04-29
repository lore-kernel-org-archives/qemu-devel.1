Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9246C83001
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 03:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992A920731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 03:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVdWbkzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992A920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTd5d-0003N7-Pz
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 23:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTd4Q-0001yF-U5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTd1Z-0006aO-RH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:07:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jTd1Z-0006a1-Ed
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:04:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so689624wrt.5
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 20:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R6q50vp6hRSEnb/zKd1obSRsfWUOxnyEo7uYejY6auA=;
 b=oVdWbkzK4f0DHuYFQTk7fZkYoaZ/hc+B4N3+gC8aedHEAVltwiJ6rH3phiWtzS80ti
 VaQ19JiC6n8L8cOUt1EuX8o2sbTy+vg7tMlIX5v2vsXmoVmpkhfobBtPVipLCSPfnleN
 dvBKET91uwWTlU12jLpUv3i4wTWBXV2aHAefVCXL8ISwNumcL8RFnrRO0zFqkR2CzDif
 9kocUQWlGooEOaVzGdtzP3eLEHp9QHn0NX+kN61JfLc3DgfMi/yDpBuI1yfDk57wfG2E
 sreTZxKU/vJcPngvcim2Z/QeE3dAU33GKhSQbZ7wzlVfXHzBfJSm38T61sIkCunJ4Iqi
 J0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R6q50vp6hRSEnb/zKd1obSRsfWUOxnyEo7uYejY6auA=;
 b=WOQ14fg/WUmGH/QLEvAhvvbOt7YNdVuYUmOsoxfMskHQL+MMUS5PW0k8Ibw1XRdHOM
 i6xkuwMouf7Afi2kDIe22DJ/iYzBkTvsV9vfoeARSqOvHZfeDEWKGiZ3Ztn5kyW7dcEl
 H37wuQ7A66VhC+DaqMCi/bqiTwbWuZWlxAPlYBWXs9fNZunju7T3t/i9UBwzAElmaMUF
 AXyX1nkcsQhDKSom9+RtDkirE3UfooWupWS+RWaMmYS3kqRgedvZQ/K2aLF7aAzhyIUq
 SRzLvDVfL7/30crqfRsq6LHkR6mKKDgdkAlxpWtpiR+/nOys5lF+P2x1JT3Jo+ww9yNE
 jAkw==
X-Gm-Message-State: AGi0PuYKfWR11NTjY8Z5AUgJ0ikQb+lQe7y6dmlQlOp7pOyEw2c+r5Bg
 oRQJasnn/FIKC1T+utiXFcUB5sWnenbRug==
X-Google-Smtp-Source: APiQypKh84TmqBY76LL+9V6XYeNoWav0vxXwJ7Fz7g8GT3hJ3Fu0UZxeitOY36z79gZqFKFL1stxCQ==
X-Received: by 2002:adf:e681:: with SMTP id r1mr39637110wrm.213.1588129475663; 
 Tue, 28 Apr 2020 20:04:35 -0700 (PDT)
Received: from localhost.localdomain (public-gprs636909.centertel.pl.
 [5.184.31.46])
 by smtp.gmail.com with ESMTPSA id o6sm19713725wrw.63.2020.04.28.20.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 20:04:34 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix QEMU crashes when passing IGD to a guest VM under
 XEN
Date: Wed, 29 Apr 2020 03:04:07 +0000
Message-Id: <20200429030409.9406-1-gorbak25@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=gorbak25@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: artur@puzio.waw.pl, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Grzegorz Uriasz <gorbak25@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the v1 cover letter - the patches now include a detailed description of the changes.

Hi,

This patch series is a small subset of a bigger patch set spanning few projects aiming to isolate the GPU
in QUBES OS to a dedicated security domain. I'm doing this together with 3 colleagues as part of our Bachelors thesis.

When passing an Intel Graphic Device to a HVM guest under XEN, QEMU sometimes crashes
when starting the VM. It turns out that the code responsible for setting up
the legacy VBIOS for the IGD contains a bug which results in a memcpy of an undefined size
between the QEMU heap and the physical memory of the guest.

If the size of the memcpy is small enough qemu does not crash - this means that this
bug is actually a small security issue - a hostile guest kernel might determine the memory layout of
QEMU simply by looking at physical memory beyond 0xdffff - this defeats ASLR and might make exploitation
easier if other issues were to be found.

The problem is the current mechanism for obtaining a copy of the ROM of the IGD.
We first allocate a buffer which holds the vbios - the size of which is obtained from sysfs.
We then try to read the rom from sysfs, if we fail then we just return without setting the size of the buffer.
This would be ok if the size of the ROM reported by sysfs would be 0, but the size is always 32 pages as this corresponds
to legacy memory ranges. It turns out that reading the ROM fails on every single device I've tested(spanning few
generations of IGD), which means qemu never sets the size of the buffer and returns a valid pointer to code which
basically does a memcpy of an undefined size.

I'm including two patches.
The first one fixes the security issue by making failing to read the ROM from sysfs fatal.
The second patch introduces a better method for obtaining the VBIOS. I've haven't yet seen a single device on which
the old code was working, the new code basically creates a shadow copy directly by reading from /dev/mem - this
should be fine as a quick grep of the codebase shows that this approach is already being used to handle MSI.
I've tested the new code on few different laptops and it works fine and the guest VMS finally stopped complaining that
the VBIOS tables are missing.

Grzegorz Uriasz (2):
  Fix undefined behaviour
  Improve legacy vbios handling

 hw/xen/xen_pt.c          |  8 +++++--
 hw/xen/xen_pt_graphics.c | 48 +++++++++++++++++++++++++++++++++++++---
 hw/xen/xen_pt_load_rom.c | 13 +++++------
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.26.1


