Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E316C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F036F22AB0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccJJjZIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F036F22AB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFfI9-0002xY-0L
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFfH6-0001pG-S2; Tue, 08 Sep 2020 11:11:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFfH5-0005jE-By; Tue, 08 Sep 2020 11:11:12 -0400
Received: by mail-pf1-x442.google.com with SMTP id w7so11202854pfi.4;
 Tue, 08 Sep 2020 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pi4fdZkK98uzzZ0ksfj6pMVZi4LQv4h+3M/IR0O7QLM=;
 b=ccJJjZIRgwenw12uFiihAAcJqiPjrAunSSna1eUn9WZayHi8FgiUC0uKxx9+IbhXDO
 idSuq/iHV2vMSG9ihy1d6cAzGUqHP5Q/i4zq1dzfwj79yeKuMdOgAm7ds1wQe29xhCFR
 QwoM01J1un4zosD8Qaxu///ZIlZsFKlGJdYOzgAVwyEMa2Kl6kNN9l5gSyGgPDiL0rLL
 Zr3lAagTy/uTS5gX2U0zf22XEQnj3woXlNjBU02oPkSpFv2m6MXwE72ybMW5U1a/wYBS
 NQPIe4HSCrLRLXdunaL408nkRxZW6iaRLMKS00OwIJHpwN9Rsq9zX1MVEkl2L+3Wc5Ze
 flGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pi4fdZkK98uzzZ0ksfj6pMVZi4LQv4h+3M/IR0O7QLM=;
 b=t35UZC9bVroMGpqQBE7jxm/1mlQEZZwBt5u29HfKfL95S5Xs0jzJJ5EuYYMt3vQbL+
 rKF+y/7kHauYUkyrqKcnTmVIKmkjCL1O1ti/NB8Te9hrLeBN5SqIVTyBIEn3AFpmTs/I
 1uACCl9pbEUMGzvTObO6kdRV179W+pbWR9jYNByYA2nZnC+25tGY2zCQx8O8Y3gEsqoh
 zNN6GLvZpSyeb6EAGiq6kT2L3O/X/90zNUMmRX2iioplqQDl+FVZwZa3D7/ibSiVWBAQ
 6NWMYyNYaC+9ZIPH4ZFa7zE1JI/4fZ13I9qQ9//6Qdcvv5KjRxx7EbAMnNwsh/5DDYZU
 /uXg==
X-Gm-Message-State: AOAM532vdwFjMlOLsXlRzxcb0N5KFsqRFL/5Vbe0M1yPG82ND+2gVev8
 HRu8Oht01PVdLmQJUUD5+I9ajMfp6cEFdMid
X-Google-Smtp-Source: ABdhPJxIIJGzA+eHF0YY0HPC+O+OXtVcMePaq8YS/MOgUPynMdg2OBFNbVXVEY9a9A9CtsPExR6i5g==
X-Received: by 2002:a62:ce8c:: with SMTP id
 y134mr13029270pfg.125.1599577869118; 
 Tue, 08 Sep 2020 08:11:09 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k5sm29436469pjl.3.2020.09.08.08.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:11:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] rcu: fixes rcu and test-logging.c
Date: Tue,  8 Sep 2020 23:10:50 +0800
Message-Id: <20200908151052.713-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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

This is necessary if the pending rcu calls are closing and removing=0D
temp files. This also provide a function=0D
void rcu_wait_finished(void);=0D
to fixes test-logging.c test failures on msys2/mingw.=0D
On windows if the file doesn't closed, you can not remove it.=0D
=0D
Yonggang Luo (2):=0D
  logging: Fixes memory leak in test-logging.c=0D
  rcu: add uninit destructor for rcu=0D
=0D
 include/qemu/rcu.h   |  5 +++++=0D
 tests/test-logging.c |  4 +++-=0D
 util/rcu.c           | 37 ++++++++++++++++++++++++++++++++++++-=0D
 3 files changed, 44 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

