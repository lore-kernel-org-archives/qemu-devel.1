Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCCC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E5D2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXpAuO7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E5D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaefA-000685-77
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeQV-0004yB-NN; Thu, 05 Nov 2020 07:31:40 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:55266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeQT-0005VJ-Jr; Thu, 05 Nov 2020 07:31:39 -0500
Received: by mail-pj1-x1033.google.com with SMTP id f12so2541pjp.4;
 Thu, 05 Nov 2020 04:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kzubQXn7VmEZvadVDrN2B8ATm1bBIX2uOarIfOPEuCQ=;
 b=LXpAuO7fJ5Yz0KDiykfhUXZG1Zop0akIO6qmm75iG+aB6rq66j2W1heCLG8Zfg505U
 8ty3WADlTHm/Orh7fsqBBtK70VOnAyXqVQbqfKzo7EVhFHAVXjjndaaRr7ZoCG7XU6z/
 lQPsLo72dGb5oOwtUG4zuRzWKEaRRDTs50ZY3KIZ3Drtkc34BQXWhNDgr3SzdUcVi8ri
 Y49bXXXmdeEAk37aMIRQju+Q1o4HiLhclY7NMG450Tf1fb2FNvBNwpy7bWYcVya3Bssd
 vL3duH95B+WLDwVEY/alzrtxd0Y1SvUjPcogQgeMBCw+cuELLm5E6K9c9U+XjBhBIz6w
 LRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kzubQXn7VmEZvadVDrN2B8ATm1bBIX2uOarIfOPEuCQ=;
 b=L5GHqHEWYSF/z/3UGYFNLJYb8O3mvtoE1KBRJVQahD+Wv0rO62LaS3J+d8zIu7DkFy
 pBpWeGkyIzr422q5PCUl23a21Xj/Wh1XT6Rx+cpznyKkUjPEX1jP4V0arej8pryL6tSo
 7lcZL6mHtQ9wjXoTept7mwX0fIumXwvYMXq0GmwR5MFiQW9sqOAJRYEOwS52KRYD6uL1
 sj+uoeVNkb0qJdIbrxLwK6VdB/oJypOsz4surUIV2mj7cWj0OjWobwQ0pG3Ti0iWITb2
 W8T1YqEsxdNFr30/fmb8wlmmZKz+vDhjjVhC7Ce9uhLGRk6p3SNLQ8KkOSIUZPCl7H2i
 viVg==
X-Gm-Message-State: AOAM533recHYqRbxUXmJ7jCpbFVwXTFtT/h9dAwVzIe3rrLjiEQa/gJ7
 vUgcRxXG40C17EvqeOh0vsmljw9ekodjtnfE
X-Google-Smtp-Source: ABdhPJwgw5R2rexkFtzwLCLAc44vpGLH97HPrkq4axiMlAKP0eRSzbqRFGqxjI5jxnX+UfmmJDKT6Q==
X-Received: by 2002:a17:90a:7784:: with SMTP id
 v4mr2262718pjk.60.1604579494305; 
 Thu, 05 Nov 2020 04:31:34 -0800 (PST)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id hi10sm2987008pjb.0.2020.11.05.04.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:31:33 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] Fixes building nfs on msys2/mingw
Date: Thu,  5 Nov 2020 20:31:14 +0800
Message-Id: <20201105123116.674-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1033.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V3-V4=0D
Use uint64_t instead of blkcnt_t=0D
V2-V3=0D
Revise the commit message of=0D
* block: enable libnfs on msys2/mingw in cirrus.yml=0D
=0D
V1-V2=0D
Apply suggestion from  Peter Lieven=0D
=0D
Yonggang Luo (2):=0D
  block: Fixes nfs compiling error on msys2/mingw=0D
  block: enable libnfs on msys2/mingw in cirrus.yml=0D
=0D
 .cirrus.yml |  1 +=0D
 block/nfs.c | 13 ++++++++++++-=0D
 2 files changed, 13 insertions(+), 1 deletion(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

