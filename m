Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9418C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FBB2063F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FBB2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvkS-00036V-K9
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hgvPj-0007wU-2f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hgvPe-0008P4-CC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:15:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hgvPb-0008I4-MN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:15:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so7180328wrw.13
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 11:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UIZsZjOHEHJT0qd/b4R52X7k8SPjjogTdSD6Xl/25Ts=;
 b=JSrwzX+d7hO9s990zkT6Ke7M3DTUVQFImoF7xAaXOVpQ6NsQYXX80g9GRSxG5jnmMd
 MloakIyFR6NSQxQynqemu8cK4DWkkTywpWTqdw0Mm73CZC87lvsABFb84G6XMeONSKVo
 PR8itiTd2+fNUSEJRmngcpTIKq3tJAuqokgrGJCN/i958/SQMVt0kwi3ujGl3sQfH3dP
 XxZ0rLu5of2LpxcSOd5RpgT3Qhej+IftGsPAH0UK3rkF8lPr4ID0RJhkMdRyQ8zBG4Sr
 DIOFJwbuAVbYX4QhqmppkXqOYoyulLuLN2HDxWtb3PH6OlYkK7tQrMAvX/yOPZO7fVOg
 L7CQ==
X-Gm-Message-State: APjAAAWPsyE6w/tyRu7KBHfXEDDzTqstp/+cTZ+/lCvwq9//QKpQcOO1
 Pb99Sem9IRANEqj/cckIHpK/xok2
X-Google-Smtp-Source: APXvYqziQCqf+9tW93LYz1NLVWoSfzb2qusaVMguGm5OHHrq9+1MD/9dRLPSJy2RsE9zivMvenE7vA==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr8794684wrj.298.1561745744245; 
 Fri, 28 Jun 2019 11:15:44 -0700 (PDT)
Received: from thl530.multi.box (p5791D57D.dip0.t-ipconnect.de.
 [87.145.213.125])
 by smtp.gmail.com with ESMTPSA id s10sm3331447wmf.8.2019.06.28.11.15.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 11:15:43 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 20:15:32 +0200
Message-Id: <20190628181536.13729-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PATCH v2 0/4] m68k: Add basic support for the
 NeXTcube machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bryce apparently never got around to work on this again, so I'll have
another try now ...

During Google Summer of Code 2011, Bryce Lanham added the possibility to
emulate the NeXTcube machine in QEMU, e.g. see this URL for some details:

https://wiki.qemu.org/Google_Summer_of_Code_2011#NeXT_machines_system_emulation

But since the machine requires a 68040 CPU and this was not included in
upstream QEMU in 2011 yet, the patches have never been merged to upstream.

Then, during the last years, Laurent completed the full 680x0 support in
upstream QEMU, so we could finally merge the NeXTcube support, too.

The QEMU interfaces changed a lot since 2011, so I had to modify the
sources quite a bit, but with the attached patches, it is now possible
to boot up to the firmware monitor again.

Note that boot device emulation is either still missing (network and SCSI),
so you can not boot any operating systems with this machine yet. I have
the patches for these devices in my brach here:

 https://gitlab.com/huth/qemu/commits/next-cube

... but they are not quite working yet, so I'll submit them later once
they have been fixed and the basic support patches of this series have
been merged.

v2:
 - Don't use memory_region_allocate_system_memory() for the framebuffer
   device anymore
 - Turn the keyboard device into a proper QOM device
 - Put the global variables in the third patch into the machine state
   structure
 - Got rid of the "//" C++ comments

Thomas Huth (4):
  m68k: Add NeXTcube framebuffer device emulation
  m68k: Add NeXTcube keyboard device
  m68k: Add NeXTcube machine
  m68k: Add an entry for the NeXTcube machine to the MAINTAINERS file

 MAINTAINERS                      |   7 +
 default-configs/m68k-softmmu.mak |   1 +
 hw/display/Makefile.objs         |   1 +
 hw/display/next-fb.c             | 157 +++++
 hw/m68k/Kconfig                  |   4 +
 hw/m68k/Makefile.objs            |   1 +
 hw/m68k/next-cube.c              | 988 +++++++++++++++++++++++++++++++
 hw/m68k/next-kbd.c               | 320 ++++++++++
 include/hw/m68k/next-cube.h      |  49 ++
 9 files changed, 1528 insertions(+)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 hw/m68k/next-cube.c
 create mode 100644 hw/m68k/next-kbd.c
 create mode 100644 include/hw/m68k/next-cube.h

-- 
2.21.0


