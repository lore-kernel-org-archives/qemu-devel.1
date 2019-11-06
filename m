Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DBC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A11217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5N0i/Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A11217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMfw-0008GK-2C
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1iSMej-00073j-99
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1iSMei-000401-3g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:51:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1iSMeh-0003z1-U6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:51:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id c22so3713118wmd.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=BHj7/NibcB3ZIJOBOIE9D7AlYxAWL/MTdFEzvenDykY=;
 b=B5N0i/ZsDqs0jPRQTfVzkLK7dutRs7F01vfuS6Clq6OnNVtjg+hBaVscjFPRpxUY6J
 fi1pZMgnh0Pk1OGwDaAY/gQkU0E/Ifum64RoiIfkZ5ch0o04y+eWaO5NHYlCSwGJcZNf
 1arHd6AuAyRUNk0kLM7PyDDdquKPHt46LSFZraeY0OUY+udXyTpw1qt2GTfrbmIBP4uH
 1sCVdvyyFC3r3jyBcLhVb51RMY02rTOewyqYg4Md9OiEdNQJ7MMhvccouhmfwdMUZYCa
 ADnHdBZ32B/3l6EVgWBU2o8hInjGvb846ZRg/vVKqwnuXCQd3LicQSmc2TD5JdIQgJYR
 6E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BHj7/NibcB3ZIJOBOIE9D7AlYxAWL/MTdFEzvenDykY=;
 b=stmOgs8lzcNCrMOUh/rvBtQ7ZrXorF17lBq4x3SPmz5HB1aWtMBF3hxJmfwy8AAh98
 atZNYSLNF6rwJcNMRWR3p86Hx5MVgxMW+K91sMDjQgm7g5uh7ChvqAv+YH8fBXcFKt/w
 FjnBui2za6xDgbJkG4KPxGbgi62HViRPqK8HdypYyNUpUdqQDLlG4YrdNr89TzLn9lAw
 ZRl+W0HcKRnDx8ssaAJzumex8OKl0EuCXWWvfpPHgPGKn3FVG09BuLnoIr5nCjGt+IFG
 OmanFWInWuTqOVU+LfVi0PiKd2Wfq3Fr37sc5NNUSoElnA4d90ZyjpkeTWQ8RX7CA6AL
 wIOw==
X-Gm-Message-State: APjAAAWHdMNGaRjR6kZXAex03lRhwy8kALxUpGqKKA8VV753BProiCLi
 OIYx+65IPWKZDgayPcyJ+CUI0SfO
X-Google-Smtp-Source: APXvYqxvjbcPP3xQkrLLGKFRUquCEPpOVyOj6b3rLYAA1Jl/j5+Nyv4vu82Q12HeSepVMsmSi3aqAg==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr3069511wme.92.1573051890475; 
 Wed, 06 Nov 2019 06:51:30 -0800 (PST)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id t133sm3116744wmb.1.2019.11.06.06.51.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Nov 2019 06:51:29 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 0/2] RDMA queue
Date: Wed,  6 Nov 2019 16:51:25 +0200
Message-Id: <20191106145127.23700-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: yuval.shaia@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull-request' into staging (2019-11-05 20:17:11 +0000)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to 68b89aee710ab48b3dcaaa721bbc5d8aa5ea24d1:

  hw/rdma: Utilize ibv_reg_mr_iova for memory registration (2019-11-06 12:49:04 +0200)

----------------------------------------------------------------
RDMA queue

* better memory registration performance

----------------------------------------------------------------

Yuval Shaia (2):
  configure: Check if we can use ibv_reg_mr_iova
  hw/rdma: Utilize ibv_reg_mr_iova for memory registration

 configure                 | 28 ++++++++++++++++++++++++++++
 hw/rdma/rdma_backend.c    | 13 +++++++++++++
 hw/rdma/rdma_backend.h    |  5 +++++
 hw/rdma/rdma_rm.c         |  5 +++++
 hw/rdma/vmw/pvrdma_main.c |  6 ++++++
 5 files changed, 57 insertions(+)

-- 
2.17.2


