Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4317AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C630E22206
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqg+osWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C630E22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFct8-0005I5-Ol
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFcnB-0001jQ-Pu; Tue, 08 Sep 2020 08:32:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFcn9-0008D7-Oh; Tue, 08 Sep 2020 08:32:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id z19so8669335pfn.8;
 Tue, 08 Sep 2020 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EKG1apOrW8tjor/2mLwmR3nr+4172Hc8gwfm/Y5sTeg=;
 b=Fqg+osWHj477oq2eTRSxx9C9i46/LHZsB3jIbup3heyaLgZT+NVXAtwwIy6q7V7L9r
 VZ9aVyfryuYV6v9I4ebukk0+Xf+XR1JzvY9HCJdTR09zAbG4LVDdm0Q6P39dxRUCDTyl
 OXLhlhot2wSnA0CIl6TYRj3/Tf5NzAtm0XCt2/njSosB0mi73yiYeChvMG/cywBNbkck
 8cZAshRc8fBcny1HN+GC8S+tGe10i5X88ukaj/lOL1Eyr8nIwocLyScL8sY5CLp/psGx
 8srINwSdSwXZCXtldmnhD9/Q3bMBBLkUDrOhaFs9Ig77nJa0ILqNhRg0Sdqz45kec6HO
 Lw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EKG1apOrW8tjor/2mLwmR3nr+4172Hc8gwfm/Y5sTeg=;
 b=MUP73xjjCpF2HzLZoFeB55/86TTC8U7d8OeHmwRMApDZdQDp6v8F4ioma/9aAnc1Yo
 Vkw8XC9i/MiWnNlS3skeRgT1E43Qv2YiSqJEGLdo7Cqumujiecbg6LNR2srYswos/8G3
 NwxxO0rixih43y7PRXhlHTt7z1v6Py7MIxKdjKBjigsxc7IBU5f8HvSx4zzsefLwh6zw
 CaRBJx95iH0zatRhnwCuPWh+f9qPspAXpNVaqmQ27B6VwaysaX0Mk5kivuf8xI7+hZGn
 Eq7eyKSKTo/ej41Es1yhxdHTRnQSiLkHPb1caWNdEE1I6g+3GakxuiOhaqMoped2NGzG
 wDAg==
X-Gm-Message-State: AOAM533i2zmNd2Do54wOvZVQ3WUfQvIu2P7bpmJI7nLMNfMG3N/1ylpG
 rlrSUsd2PghDqYZrx+w15MsuFBr+kG1sACC9
X-Google-Smtp-Source: ABdhPJxkSaI7X/gUk3TTp6E8PUjpVZixCVEGCnUxcmHBaX2ohx8ZYd5lIIgw/qY5c83Pv06W1LxAqg==
X-Received: by 2002:a17:902:c151:: with SMTP id
 17mr10207356plj.49.1599568325493; 
 Tue, 08 Sep 2020 05:32:05 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k5sm29172087pjl.3.2020.09.08.05.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:32:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] rcu: fixes rcu and test-logging.c
Date: Tue,  8 Sep 2020 20:31:47 +0800
Message-Id: <20200908123149.1475-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is necessary if the pending  rcu calls are closing and removing=0D
temp files. This also provide a function=0D
void rcu_wait_finished(void);=0D
to fixes test-logging.c test failure on msys2/mingw.=0D
On windows if the file doesn't closed, you can not remove it.=0D
=0D
Yonggang Luo (2):=0D
  logging: Fixes memory leak in test-logging.c=0D
  rcu: add uninit destructor for rcu=0D
=0D
 include/qemu/rcu.h   |  5 +++++=0D
 tests/test-logging.c |  4 +++-=0D
 util/rcu.c           | 28 ++++++++++++++++++++++++----=0D
 3 files changed, 32 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

