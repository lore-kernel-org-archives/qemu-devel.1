Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DF4207C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgShtMYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DF4207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJib-0003G1-UM
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJha-0002Jg-BQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:40:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44450)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJhZ-0006uP-AU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:40:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id y17so5411343wrn.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/hPw/R+ORdBBhBH7uWOFuRzpIe3mNQxChSkCK6xsjQI=;
 b=LgShtMYev1eWxx6NbwRSnaAAsUMzreiWp6NUWLefFnaBKy07A6X0xHwGsKPmIj6Zir
 wzOoicNJNR4DYvGa1MpRpL+G0nDzII5/TYXKvbq4LgO/rcTaaCa3/kW7d5vUYxIFgJz0
 Gq1111Tgu7LYNyBU1IMwlfkdllDIDo+fOKtve2Gq74tg5qkumE/O0ocTBmsvD6cEeu2M
 /84XJKhSkQTF41/JzhjBUksdavMOrzA7wfTE8Hy0jwkH0BT9XQ6ynr13+9mJxxJd6yUl
 WJJxsv2g0QdDnt0mtHxCotkkyueDA273SSw8Dk+Hc5t5Ebq3LdUfoAPQ4qimkwiQPpJV
 kfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/hPw/R+ORdBBhBH7uWOFuRzpIe3mNQxChSkCK6xsjQI=;
 b=Kg6djraIUrMgEmZ4bRlCaAYV6QkUVA8mdHgLo72x4Roy/BAN7X+4SUEh1u+YyUomMd
 dm2i0imgTT4BLzgawm35LoIyTenILsk4bLzS0VJUsOpEJuEhONlQazsw5+16BhnrIg3u
 s/kyLcMAQOqGy56lD3ZSqL61eS2W8GB3/qzWmkHUrr9Lwco+MDlnJrtNALK0hE4/BJVh
 Kz/5oRqO+Y+i0epOZG/84uyBSRYXMU01OGrXnnNFHOjmWWb52AJztztY9tuQWsHv05Da
 Sft/22syAI2iCB2up7zyzmfZMFal/c+eCZ22HNyz2xlgjuPDfFMVYS7Xs5yH4lm0fNRp
 hW2A==
X-Gm-Message-State: AOAM533TmvwzPKCcn7Ks2jjetKoLkWRBPNiR6WVCIvkNeQ8WpqlJoQzW
 ATXJv62fc688dFApPbSUE/kwsA7ZQug=
X-Google-Smtp-Source: ABdhPJxgcHtgaHzsWFAKuooSi+OJXF3Lm1r1rv82rG8atmxmhIiIV96TKnnM9SaFKhEJAO630TbaWg==
X-Received: by 2002:adf:b34e:: with SMTP id k14mr8636811wrd.109.1591868442368; 
 Thu, 11 Jun 2020 02:40:42 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id e5sm4124975wrw.19.2020.06.11.02.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:40:41 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] Resolution of sh4 maintainership
Date: Thu, 11 Jun 2020 11:40:28 +0200
Message-Id: <20200611094029.9528-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series consists of a single patch that introduces a new
maintainer for sh4 target.

He may or may not adjust further the details of sh4 sections,
with recent discussions in mind.

The central idea of this series is that noone imposes his/hers
particular vision on the new maintainer person, but that we
let him organize himself the way it suites his style, and his
code situation, and his target position.

Three "Acked-by"s were deduced from the content of recent
discussions on the mailing list.

v1->v2:

  - improve commit message
  - keep Magnus as a reviewer for sh4 machines

Aleksandar Markovic (1):
  MAINTAINERS: Adjust sh4 maintainership

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1


