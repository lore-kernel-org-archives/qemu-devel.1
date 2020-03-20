Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58588C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2E620732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4d4Q/ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2E620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGQD-0001Du-8P
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGPI-0000Ck-17
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGPG-0008Hn-Ue
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jFGPG-0008HN-PF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:42 -0400
Received: by mail-pf1-x442.google.com with SMTP id i13so3137063pfe.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PMS/HT90PAKRMWfiQdAD+nmjuV+Lj/mKrnJ66GdRunI=;
 b=H4d4Q/ga9fiIG6t3JVM5cv6vl3BXAyaNJGZPrzLU5GA8Zl7F5FssXDVWqrPnFj84wp
 YbS6TrjHnQXLaUSV4KiwSFEOEoVWDDY7NMdqYqZwu1Mwt6jF6zv9XVhYJGW/Znw+Zhor
 7mhcXGtzNQwVdOGATb1S5cp1Ja6Sea0mkejTMuuWCnNwpad782Lch37ApdkCr3AfTKGq
 XMjSGNzHoEXZsJGsxhb//sRP69g1Yz0DFwFYwqsRk8spg+QLdWpux6StT9UKqFTVRITE
 /b4zdZRvHjVUSyyCl0/8ybjpdFdjsdL2N+RxSrhyyuR+kH+xqvFK3BaZ33Tbeda7PLtV
 1dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PMS/HT90PAKRMWfiQdAD+nmjuV+Lj/mKrnJ66GdRunI=;
 b=Jn62gmuxXZwmYsJ2xKNr8ZrfgnjCTbdueXVUGCTUJKsdhXpWaA32CVVCHfqZ2tHW6x
 Wiz5aLqF/mneHcMZOOiJC+/OV9BcBH6H1a5jYKypZomZ+JW6U7aaMY1u+lWgMx3reISp
 0loD7h/FsRFEAvW1SeKU91N9wj6JFlOsbwkunD9rRyyS9HN95ehDVjqD1XFH2eKQHNoc
 SHJZ1xJaB46miUhQBJFmbPBeLxrprkv6sWIzrmdgFOdaOZJrkTvFEcu4zghDa/Ob2jWi
 uiWSnijx7sxMU1hXfhOtFhXY1NkD+9PLK7wXikLk9kiOw3cVui9dJpOCQgqktjkwLoNb
 C/9Q==
X-Gm-Message-State: ANhLgQ2w8/zKeJa44EaE51jwR5GVZo42wWE+c4UZblxDzZhjpL+0sdih
 aylnr/eDfP+FO8gPFTfz8WY=
X-Google-Smtp-Source: ADFU+vvH5hVs4lIkTrUbSFps+pLLhg2vNRHyDaFlQBUV0Y2zQVdnp8ExlC/F5DCcdHFlnhjiNl/fHg==
X-Received: by 2002:a63:4e4e:: with SMTP id o14mr8220453pgl.228.1584705941632; 
 Fri, 20 Mar 2020 05:05:41 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id z125sm5617660pfz.92.2020.03.20.05.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 05:05:41 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v3 0/2] Replaced locks with lock guard macros
Date: Fri, 20 Mar 2020 05:04:54 -0700
Message-Id: <20200320120456.1931482-1-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Brodsky <dnbrdsky@gmail.com>

This patch set adds:
- a fix for lock guard macros so they can be used multiple times in
the same function
- replacement of locks with lock guards where appropriate

v2 -> v3:
- added __COUNTER__ fix for additional lock guard macro
- added missing include header in platform.c

v1 -> v2:
- fixed whitespace churn
- added cover letter so patch set referenced correctly

Daniel Brodsky (2):
  lockable: fix __COUNTER__ macro to be referenced properly
  lockable: replaced locks with lock guard macros where appropriate

 block/iscsi.c           | 11 +++------
 block/nfs.c             | 51 +++++++++++++++++++----------------------
 cpus-common.c           | 13 ++++-------
 hw/display/qxl.c        | 43 ++++++++++++++++------------------
 hw/vfio/platform.c      |  5 ++--
 include/qemu/lockable.h |  4 ++--
 include/qemu/rcu.h      |  2 +-
 migration/migration.c   |  3 +--
 migration/multifd.c     |  8 +++----
 migration/ram.c         |  3 +--
 monitor/misc.c          |  4 +---
 ui/spice-display.c      | 14 +++++------
 util/log.c              |  4 ++--
 util/qemu-timer.c       | 17 +++++++-------
 util/rcu.c              |  8 +++----
 util/thread-pool.c      |  3 +--
 util/vfio-helpers.c     |  4 ++--
 17 files changed, 87 insertions(+), 110 deletions(-)

-- 
2.25.1


