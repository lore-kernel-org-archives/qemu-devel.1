Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E395CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0380D20650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fNPNtgSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0380D20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZeA-0004Fx-0C
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iQZcR-00031Z-C8
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iQZcQ-0005of-26
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:17:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:41857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iQZcP-0005m1-TQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:17:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id p26so7388448pfq.8
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=agZSirPRdMoHVC3gCYphFvJ6jy/o+BLQv3H5zsgQARE=;
 b=fNPNtgSU1pPgW5CT98KHMktgOzlrHf2UCNCgRkrlsm0Pw7MOvEnQI0jJjI8TXzmTVN
 AlLVvIvPN9saL8fYFI0Tb/GDFmqaGsCpFJVGtdQSvCuI0/cR7LRlDo/qXMtLGb1S+U4F
 frUDTjiw3KUsW/ugSkUlJlFJzntUsU7AP3g8v8zMdR1FLca9IO1UtJCLZIo/+BrFCpDx
 6SIwVbYyYRrqCbiNwsl+yypXoF70JoOcJy66isb1P0PLE1Ufqpu7ZHdiHGr2zYfwd4Ao
 oMnzIJzDZnQwHfIo4Kg8jEYHrYAOOpcN/HKq0F9SuxpZbf9arjO0/n7ykdI6s/cA5uEN
 2DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=agZSirPRdMoHVC3gCYphFvJ6jy/o+BLQv3H5zsgQARE=;
 b=SRu2FBd3d+MpI1N6xT0ZCkUCowqQ36edxFB4MIvvh17MXkgYT1bDqCzw9irr2FnROo
 wYNlsZA/6+eunZHiVlWPGZ14SyWWcwaisagkWW9HPURZ/Rcg/DrH6O9GmkPOWZZ7muyl
 /LNFsyrxJ2oB+D6Lu80kJClByzLpZ+o2f+wG3Zl3mNSYCwNpSaNM13FCHfNQVqgKA1TC
 YYL5gxPy2mMyDHXnr541jqUaWJVxv172KH5cMlIzVOrGq1g6Ndub3WyfFLxV1t55MB8P
 MaXchXoypTXgXgnCAVwE/G7wivSP+Nivmic84hwRrreUhCExh8+P8p/UXd9a1bJqtav6
 IE8Q==
X-Gm-Message-State: APjAAAVML/H/finkD8pAgvJ5TGi5pu3FCqo/Ufb6ZwjJnOscC4xL5HrS
 t/TzAeopE+L4P9n1y0j4ahq0HcVbfmGXPg==
X-Google-Smtp-Source: APXvYqydVJhG32ZGjWrO5icIbBzeaB7SEDOW8Orm4FOd8oB2sFmo4bAwS9PZ+67OQ0wpO9dh4Z/Pog==
X-Received: by 2002:a63:d651:: with SMTP id d17mr14969909pgj.106.1572625064062; 
 Fri, 01 Nov 2019 09:17:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id o1sm7404270pgm.1.2019.11.01.09.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 09:17:42 -0700 (PDT)
Subject: [PULL] Update my MAINTAINERS file entry
Date: Fri,  1 Nov 2019 09:16:53 -0700
Message-Id: <20191101161654.2871-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72784b:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-10-31 15:57:30 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/palmer-for-master-4.2-sf1

for you to fetch changes up to c1677bcc395eb977cc7279a1af0a1d23ad23fdd4:

  MAINTAINERS: Change to my personal email address (2019-11-01 09:13:30 -0700)

----------------------------------------------------------------
Update my MAINTAINERS file entry

This contains a single patch to change my email address.

----------------------------------------------------------------
Palmer Dabbelt (1):
      MAINTAINERS: Change to my personal email address

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


