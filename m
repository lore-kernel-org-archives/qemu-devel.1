Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7EBC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 22:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E236020671
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFyS69Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E236020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaRlg-00034N-OF
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 18:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jaRIi-0001wd-Mj
 for qemu-devel@nongnu.org; Sun, 17 May 2020 17:58:33 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jaRIh-0005hb-WD
 for qemu-devel@nongnu.org; Sun, 17 May 2020 17:58:28 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ci21so707962pjb.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8lGupcyVEI2tEhLkMg5o8wW4qEBwuroiKNS3ExpoDL4=;
 b=ZFyS69XdKIodGXIJBS7ulJ6XqYB8J2aINJRzxD0D7vtBdKphNZktFS8r91ImHB2Vvf
 OPsxlR+FM5DZKPXCs3y1qcZcb0VvjIDxaa60kL6OrsHZaYjGSrKUZK8Dyn1g2DeXVx9Z
 Mm0jfdd4fb/IEmIelorR8Mj8IfUHNGbbWqLHGVmc8ffhT/Uvhl1HqFy8XfJH2LQAQRCd
 NFArdDrMIAL3Nbi0Q8G3JyIVb7FsCc9u/VcFdXlyT4OBycSpouRUCK/HzxW08fzCZsep
 6znBrAuWhtnyMfkIODL1ID6l792ZVipGpHJ+oFCN2edvGpWYIlpUb3A+o6ZrBJQuNFzR
 TB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8lGupcyVEI2tEhLkMg5o8wW4qEBwuroiKNS3ExpoDL4=;
 b=CqkC/l46Vrodle7tAQpwa3xef39BKSUrv/1I+Id5pAW54LseKITu5BZ/44Oj35EtuW
 1bYuvjdKNqxmv1pk4A6b5zePl/J4iPd+G7IAAk/N9z0W/+G8g9oA1FQxER5o5ufU2tV9
 rwqe7x7AiCbN6SM/M6dYcPtjMnC4cu+irKQZVuDq8dHZdjRa0h4m0Mq/VHjOUPdm3oKW
 TXfEJDxNkXoen6axkV5yh6UI9SCZt5NM5vpY3V2Y33dvzVmnGDNd0N+g23VtuhAvXgXd
 35hZPktvl0h+udWAfCI6Mu+HSzUytLy4iFfjZ6eQOXky7ICyYyk1Pg4iFtWNyS+1C3To
 Yb3g==
X-Gm-Message-State: AOAM531Gy6KkYHc0xnj1jB/cd87JfXHYbSvJtofKDIl/59NHcFIwqQ8i
 vJqQLPtxwSUGAnKiqBeoiAGebmLm
X-Google-Smtp-Source: ABdhPJwEy9PJ9PRdywtNTRR3zkWeylwlozWa7z8Q00cO+1xrkCXATsGtXfj8yncAdm4V8Boir/sPnQ==
X-Received: by 2002:a17:90b:4398:: with SMTP id
 in24mr6244621pjb.152.1589752705121; 
 Sun, 17 May 2020 14:58:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:ed54:ef93:7dc5:e673])
 by smtp.gmail.com with ESMTPSA id h14sm6670139pjc.46.2020.05.17.14.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 14:58:24 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/xtensa: fix simcall for newer hardware
Date: Sun, 17 May 2020 14:58:12 -0700
Message-Id: <20200517215814.19623-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this series fixes simcall opcode behavior on the recent xtensa cores
making it nop rather than illegal instruction when semihosting is
disabled.

Max Filippov (2):
  target/xtensa: fetch HW version from configuration overlay
  target/xtensa: fix simcall for newer hardware

 target/xtensa/cpu.h          | 1 +
 target/xtensa/overlay_tool.h | 8 +++++---
 target/xtensa/translate.c    | 9 ++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.20.1


