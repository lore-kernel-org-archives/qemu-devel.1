Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D7C83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7770214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BK2R5Xpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7770214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3b8-0002zN-Sh
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Xg-0004ry-OK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Wz-0006uf-A1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3Wy-0006pB-U2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588231367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uDiqxiBQKtXEe1JkBjxHXYRGF/sSEvKxFT2mFNvznJs=;
 b=BK2R5XpdYw6CNlTy9ysXVR2NuzALwJ/apNtNXZWcGHGrfhR8gkw8dBRgW+IlrXwseElV2i
 my36hCtkpadHaOPCe4S4jHe1M+jbChCmP6WNwBrcH0PA9xmBru/4GdP1tcnko1PSd6Dc3g
 cBIkpy8hoqlN2uSN0rzMs2sJRbYeGFc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-oOYSFmrlPYeur2glObjQCg-1; Thu, 30 Apr 2020 03:22:44 -0400
X-MC-Unique: oOYSFmrlPYeur2glObjQCg-1
Received: by mail-wm1-f71.google.com with SMTP id q5so418774wmc.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SUypC+mYeFaC5dWzw2aAaa8wAXxEdn5K+LOUYWt/mtg=;
 b=If8irgEJESPTE7Vmz2/aJql5NUKAZS/cBQ1HG5iGHLv/K2LJDhxJgJ0w7BwY/1Zp0N
 gdHvR1RaE50SqRN4lNET7pK8cY2DhMdP+0rCqh2tbeIas873ImBOaetnOx8h+g9guqNI
 HPH3dApMXpxXGxIRdAaiSNLW+zsCwBSsDPub4FBSWY2AMNhZQg4TVua4CoC3tLtcHkBh
 rHMcsKoN09u3YZzBIbpMAsfHbRjbazQwzhDr5Sd3VMHZnXoygq78xOQNN60+e9soO3Jj
 kDgI3slGTO+v8GcEctu8vmXM+9T4tIz+apapMgvbonVaXk5nfsihpN/yAd57+tQuB4TW
 D7Rw==
X-Gm-Message-State: AGi0PuamUgf2v4nGD0mQtby6qGi81if3UInhGfhu6ryyeP57US0rtqrk
 zKnEsRYyvbjNArvIXdpqBAKwigRHHt0lELkJvLijI2gQZFXSfeGAJfcOiOn3/brnB1V6DQ9zCad
 UPApGA+yQgd0c5EA=
X-Received: by 2002:adf:df04:: with SMTP id y4mr2212851wrl.413.1588231363091; 
 Thu, 30 Apr 2020 00:22:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypJeFfaEhSKlBAybKiGut+hS6hDR/an9dqU/U9FoEZCczDVdiF+ooCKUw8NsZCWFABwe2UOK4g==
X-Received: by 2002:adf:df04:: with SMTP id y4mr2212824wrl.413.1588231362854; 
 Thu, 30 Apr 2020 00:22:42 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id s8sm2608177wru.38.2020.04.30.00.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 00:22:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/3] hw/audio: Make 'soundhw' command line option a QOM
 interface
Date: Thu, 30 Apr 2020 09:22:37 +0200
Message-Id: <20200430072240.18142-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After looking at Gerd's "audio: deprecate -soundhw":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg698818.html
I updated a patch I started some time ago.
It is unfinished due to problem with hda-intel and pcspk. I have
some idea how to fix pcspk, but it invasive. I haven't looked at
hda-intel yet.
Looking at Gerd series, fixing these issue might be trivial for
him, so I send this patch as it, in case it helps.

Since v1:
- Include Gerd ISA/PCI stub patches to avoid link failure when
  target does no kselect the bus.

Regards,

Phil.

Gerd Hoffmann (2):
  stubs: add isa_create_simple
  stubs: add pci_create_simple

Philippe Mathieu-Daud=C3=A9 (1):
  hw/audio: Make 'soundhw' command line option a QOM interface

 include/hw/audio/soundhw.h |  20 +++-
 hw/audio/ac97.c            |  10 +-
 hw/audio/adlib.c           |  13 ++-
 hw/audio/cs4231a.c         |  13 ++-
 hw/audio/es1370.c          |  10 +-
 hw/audio/gus.c             |  13 ++-
 hw/audio/intel-hda.c       |  13 ++-
 hw/audio/pcspk.c           |  14 ++-
 hw/audio/sb16.c            |  13 ++-
 hw/audio/soundhw.c         | 203 ++++++++++++++++++++-----------------
 stubs/isa-bus.c            |   7 ++
 stubs/pci-bus.c            |   7 ++
 stubs/Makefile.objs        |   2 +
 13 files changed, 194 insertions(+), 144 deletions(-)
 create mode 100644 stubs/isa-bus.c
 create mode 100644 stubs/pci-bus.c

--=20
2.21.1


