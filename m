Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31723C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DF32076C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH9RCH2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DF32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF4lO-0007zj-4s
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 19:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jF4kR-0007Yx-70
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jF4kM-00036J-Ve
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:38:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jF4kM-00035t-Pf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:38:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id k191so970417pgc.13
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nrx0ScVU/x/zqX0fU/LXaERwZrsMGNyIqnIkFrVmaeU=;
 b=qH9RCH2qZC0v+kxXqihZRJAX5VJkHIBG9Z7de6G+YFlvBArBX5hw8bOn7WD7CKP8nu
 le7gGgyAchp8vPEhC0mqpbgVh7QKOryA3yZicDFtdlzV/uCmNVlIXqBoSRuY0DznQmA9
 ANa74ENnGSVeP3/f7lxIhv24odSiWXJ6Fs8OvP5ZHgUwqI74mkPjN+qmL/P4Ptv+x8g2
 +oxZqIE6s/PJhwpjP1lgDOP6PRO+6YzjJ7G6kVxRJ18R6krfztL9JZuC3bThCJMQ1LHv
 YAvHq66roM40A+YOi53FMGlUP+oww2WCGXKpZttqLPx06vIh/ad/+CJ6PQ715o+L/MJI
 hQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nrx0ScVU/x/zqX0fU/LXaERwZrsMGNyIqnIkFrVmaeU=;
 b=UULKLJAIk+qwd5+mnYpgXwM38HfOxplQMbuj+/gHBD/jeUajwULAjUeVqg3zn2qMEC
 8yNZoLOPILFvtEon9SC4QFSCjITMy61Sat3RiU4jOmu5UHA6Ej1e1tzZFE+h4fS6NCLj
 uuJhqD319N5C0czjSgQnHzns9dg9Eome4WnwebpkDnu3itTRBmyLnyV7yWepSYifgpZw
 fmxTmAuVnP6Q8h1G1uY1ICXvfyqRydyS6C7dm911hrzr6Kd8dhlm9INWnXusy5hlPwGs
 +w/KdmlfuoREeG5zgmJ3uxhv3DqiRLs+CQO7KKnRryKTpLGjPprNV9l6T09WLwg/LFv3
 4zSw==
X-Gm-Message-State: ANhLgQ0CWbx6Yc+WxdTVJQ0BYt+3Y8IcpJz2yLjoBzsVykqs4F6SKr9W
 3aAFjU7jHpSiDQiADk8qyRg=
X-Google-Smtp-Source: ADFU+vtKrA52RlRGSang/GBnECQQwwUodLwLvORDhp4detbcy5kk4qummMh+XOY3hMzlxmcc7AjJxg==
X-Received: by 2002:a63:6d4e:: with SMTP id i75mr5616155pgc.443.1584661121345; 
 Thu, 19 Mar 2020 16:38:41 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id d3sm3255587pfn.113.2020.03.19.16.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 16:38:41 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v2 0/2] Replaced locks with lock guard macros
Date: Thu, 19 Mar 2020 16:38:22 -0700
Message-Id: <20200319233822.1856994-1-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
 hw/vfio/platform.c      |  4 +---
 include/qemu/lockable.h |  2 +-
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
 17 files changed, 85 insertions(+), 109 deletions(-)

-- 
2.25.1


