Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E594620774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhAaypYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E594620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnIR-0002g8-1V
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGmiM-0003Rg-LG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGmiL-0007p9-NZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:42 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jGmiL-0007oh-G5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:41 -0400
Received: by mail-oi1-x22f.google.com with SMTP id e9so10735586oii.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=8LSVFwuj6iqUFJMuSfXP5COlq9RJkhGVi7iETjgZ4KI=;
 b=WhAaypYgTmJdl5ROfrM5OrFAacfo+Ah3BRSn9QDv6M7R0CrSXmFUyVhBe/UseEaMur
 syp2L6wmPovWMumTad+Dt3ItJC6wPWK3AT77MRdyvNGv4xWE04hAelp6vWg2uk7sF8Qm
 TvD2mL5rVZMMlngO08rkGXnHvMzcLrglM7KMpStDT05Vw67pmCaFEDbXAZ8ThWUzeyC/
 vX2amT+QanPqNAEBPt6/AW6m2ikWSHdCVlIiGsax3NVGhconmhSDxwfaE8q4XuqpcwZR
 ggGtehwgpFP5EfiNkbImDPCDAt6bGYbP4RhwLYQFo/6KXMfOuZHDaNxN7MBpj3YyXbYf
 SmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=8LSVFwuj6iqUFJMuSfXP5COlq9RJkhGVi7iETjgZ4KI=;
 b=GTknM8RecPHNo69au+BkXviMWxMK8bhio1ngmhvV8gYQmEaVsO50y1QkpALSsh7wUq
 CDA6SmX83NyZR+JEGXG8bk/5TuL2X4LCqzo1ybE3Mm2t7IU9eHB5J1F89/Nfk+YnQAuF
 QGVrR30qkJr92R2pDcb+TDL/zP3EklnuXkPqf9W4eDKZZum4VyZEyQRGpgDZnQAQK2qT
 azbdtAqeN/suWwb0lw59v6nPh6vVEeMepSzQZd7OjMVs75n+DyHYpLxihtb4ongiWMTX
 OfWyYlTimy1ucmJXEn5uE1BNbhbPNql/4tYorEiPwt1q7goXEusUd7hJfwk2Rj/cZif+
 cp+g==
X-Gm-Message-State: ANhLgQ2Ymo7PlKC9Ji9Fa6W+C6j9Y6EVRWgtDs6skaAf3+s9yk/I/NsL
 t5nFI597UC/HE4KQcqejhM/UouWllBo=
X-Google-Smtp-Source: ADFU+vtBjgz+qAi2CO2Nx6ZQHrNq3gswCWp53wuk/tEPrrPERGak5vjh9m8e6UCS/bxrQyMlXG9yzg==
X-Received: by 2002:aca:c4d3:: with SMTP id u202mr4306630oif.20.1585068459479; 
 Tue, 24 Mar 2020 09:47:39 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e206sm6338406oia.24.2020.03.24.09.47.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 09:47:38 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/5] qemu-ga patch queue for hard-freeze
Date: Tue, 24 Mar 2020 11:46:48 -0500
Message-Id: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
X-Mailman-Approved-At: Tue, 24 Mar 2020 13:24:15 -0400
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 62a43e53faed67a5aa4bfededca24c9079de9720:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-03-24' into staging (2020-03-24 12:24:41 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-03-24-tag0

for you to fetch changes up to 7b46aadbbfb7b06cd45a3b113b1f7c003c68f603:

  qemu-ga: document vsock-listen in the man page (2020-03-24 11:32:19 -0500)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* fix undefined C behavior with guest-file-* interfaces
* fix w32 installer issues
* fix crash for large file reads via guest-file-read on windows
* add missing man page documentation for virtio-vsock

----------------------------------------------------------------
Basil Salman (2):
      qga: Installer: Wait for installation to finish
      qga-win: prevent crash when executing guest-file-read with large count

Eric Blake (1):
      qga: Fix undefined C behavior

Sameeh Jubran (1):
      qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error

Stefan Hajnoczi (1):
      qemu-ga: document vsock-listen in the man page

 docs/interop/qemu-ga.rst  |  5 +++--
 qga/commands-win32.c      |  8 +++++++-
 qga/commands.c            |  9 +++++++--
 qga/installer/qemu-ga.wxs |  2 +-
 qga/main.c                |  4 +++-
 qga/vss-win32/install.cpp | 11 +++++++++++
 6 files changed, 32 insertions(+), 7 deletions(-)



