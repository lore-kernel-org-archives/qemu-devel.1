Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29195C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D7920848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aq0Po0Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D7920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cOI-0005Ld-3B
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLl-0000kb-FN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLk-00071D-AN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLk-00070T-6V
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mevovTh2z//uQB1rbtMSkrPY9g+6HbLB05a8lK8425E=;
 b=aq0Po0Pi2Q9TbLqSXjLH2AQDBqZ0LW9YX9oyRbIeW4mpkpSE9P7OMhxjo0An3V+QvLO1r/
 OyBuwOvOjEWJ3/hJodjEMyEbGdPk3e5qZQWRCORCAJwQWa5E4GlL1oqaFF3hNGnWwO071S
 lCovBW94Z1XxoQkYmK0xBokNnzaZj94=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-8MwfRC07OEOm2xuBhPdBHA-1; Wed, 04 Mar 2020 17:18:42 -0500
X-MC-Unique: 8MwfRC07OEOm2xuBhPdBHA-1
Received: by mail-wr1-f72.google.com with SMTP id n12so1429410wrp.19
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8itZXg/N7J74J4OimKI2kWdVe8JS+hsrlg+d+Edd6OU=;
 b=bRf5ju1VupSz11sTvl1MlHbTFzGY44KxI8OUXZD5Lmi/o0FflXZLEJH+Ua7lWfN3pM
 IiuLfC91jxhbvXp3Ln+rFu94mdBE9F14NBKFtOmUAIB8nsSvQ3sOW+ntO+yf1G0JJfmD
 MXAVqgqRvigbq6yzM98jAlq0V2KJRjIX8EVn5fYuG3ZB6CQcifxvXAV9RKpZW+lLpY2Y
 Ley5sg8EKHzNJjKDD5dzetAP63wLRACZzcOGRqyuKucuZZ2hYYXJBtKSv2WUg/xWSTZB
 +xRSv/0LglovmhiLYbe7zDgiIfmRGbHp+aRS+mHjxAvNi4jAPLz6pv9KOapOZ7bIE0aq
 FPbQ==
X-Gm-Message-State: ANhLgQ2ErUiSgOIeOtMt9p5H24eLyIxFgMwPZcIPPEBzduvOWO/VJJJR
 Fvrypg4ZeT1zBmxcV0m+3TjAoFuk9Ed0EaYperBXjEbcsrIuRdESkN2nfHwE1AV4jrzQhKLLids
 DbbIF9nJ0Bjccqbs=
X-Received: by 2002:a1c:750e:: with SMTP id o14mr5387712wmc.156.1583360289775; 
 Wed, 04 Mar 2020 14:18:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtP5/X7qMtItTdqvRAmfbBql51yio/qOOkkyd+VUuklGjXJhnZrxG3K/ROiIpzyuILKkg/otQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr5387697wmc.156.1583360289469; 
 Wed, 04 Mar 2020 14:18:09 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z12sm4506428wrl.48.2020.03.04.14.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] hw,ui: Reduce QEMU .rodata/.bss footprint
Date: Wed,  4 Mar 2020 23:18:01 +0100
Message-Id: <20200304221807.25212-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series reduce the footprint of the QEMU binary:
.bss: 106KiB (moved to .heap)
.rodata: 4.34MiB
(sizes on x86_64 building with -Os)

The elf-dissector tool [1] [2] helped to notice the big array.

[1] https://phabricator.kde.org/source/elf-dissector/
[2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support.ht=
ml

Philippe Mathieu-Daud=C3=A9 (6):
  hw/audio/fmopl: Fix a typo twice
  hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB of .bss
  hw/usb/quirks: Use smaller types to reduce .rodata by 10KiB
  hw/audio/intel-hda: Use memory region alias to reduce .rodata by
    4.34MB
  ui/curses: Make control_characters[] array const
  ui/curses: Move arrays to .heap to save 74KiB of .bss

 hw/usb/quirks.h      | 10 +++++-----
 hw/audio/fmopl.c     |  8 +++++---
 hw/audio/intel-hda.c | 24 ++++++++++--------------
 ui/curses.c          | 10 +++++++---
 4 files changed, 27 insertions(+), 25 deletions(-)

--=20
2.21.1


