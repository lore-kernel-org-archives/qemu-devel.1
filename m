Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BCC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D366F2070C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1GP3fSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D366F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hutZT-0003sz-5d
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutZ0-00036r-Ui
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutZ0-0008Ta-3K
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutYz-0008TI-UM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id s15so53940058wmj.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=E2BWUDMogeaMnAzUGw7aqSKyoNamQEmEseoMEgY6Yho=;
 b=h1GP3fSy9DFsvyTMIN42PkMTzVSM79VpO7mt/x3CoCokalVm3tL3EyP8xDaKJZDc6t
 jB3aIdac8u40wSoIIFdGL30wLUFNyZDIfjBQv7xsCPGH9cLEKdBQFvfUMoFFMXzKxGLr
 XefI/VnABh14NUBuwg3tBeI0ezBnnqpOrBJyLcUQOUae9vfuXqh+FBxG1OXB9hEzMHni
 Ucej9VzlV3fMWLWaY5zGIZVwp7AOfNNfklJKdJ+KcMylH4DyfCJcFNCtr7DeNGjtNonb
 spfPeh5dWTUYPH86ur98pz4e63cQ2+yreyTekhu394QW0G/8wUHzSiN/NHmNv63f8w7J
 9dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=E2BWUDMogeaMnAzUGw7aqSKyoNamQEmEseoMEgY6Yho=;
 b=lXihgsC11TAFu7MynI8y+GLDIHBMEZ5t1XsZxpuI/egM58gu6koI0UbjTwCmEY4BnW
 9SCvweN364UImrCqYhFuPomXfpIUn06M3Z0QqwQ3ttE0ZWIbiNWXI0RMNbnvvNtIX4cP
 0wPuEFoAq9iDRMf+DV8HrihYwwzD2qevDvBpc5Tn6PGK22Hv7Uv47lwIWTJV5hXeibHi
 9xhNN0REJZ8ZPsi9x7w7wX5C06E4smu6xJjT37Aa4bJL9OAq81X6gG3WW1yZxwbPjVv0
 AU2IBkxgfXXkQbDkqgy6rd26DbUc7DqquQB4LtrtY59Hi4Z9sc0g0kPTGjkGmxJ8lNY5
 ER6g==
X-Gm-Message-State: APjAAAXhfmzIADhSd3KMkHXszIPGl1kUOAaf5M/OjC3324hU0cxmS4U5
 wDuyqe43Q1xDC46d4bBmtRA8fmU1
X-Google-Smtp-Source: APXvYqwjIm0YTpr8+QPqiX098BFxMi5Rct9prDJfvNdvRgREWNKB4bdOPtLjmekWlIxI/iKSyACfaQ==
X-Received: by 2002:a05:600c:20c1:: with SMTP id
 y1mr2907807wmm.10.1565075236169; 
 Tue, 06 Aug 2019 00:07:16 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id t13sm103637009wrr.0.2019.08.06.00.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:07:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:07:11 +0200
Message-Id: <1565075233-10882-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH 0/2] build: clean up TOOLS definition and usage
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

Some more nasty things discovered during the Meson conversion project.

Paolo Bonzini (2):
  qemu-ga: clean up TOOLS variable
  configure: define CONFIG_TOOLS here

 Makefile  | 9 ++++-----
 configure | 5 ++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
1.8.3.1


