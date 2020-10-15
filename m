Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C6C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA742074A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ9wA3ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA742074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9hQ-0005IV-W0
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9dL-0002PY-Ow; Thu, 15 Oct 2020 16:13:55 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9dK-0001tH-7z; Thu, 15 Oct 2020 16:13:55 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a17so60050pju.1;
 Thu, 15 Oct 2020 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lzkmOsgdiyDfkLzbjc8ow0qh97P5IHNxbPWiTbiz7Dg=;
 b=LQ9wA3ewA1vAVpRuL09SXwn44rsFDGRzbyoGyc9mzjqG4hDN7g9Pjpl0Twcqu817pQ
 vgb7jd2T8xuHkJb68cmS6vypDoCJJMi7ElIGl40ZrDabWR1b5PN9Q6m60kyVkVq9Sc82
 uCYU3t0zFs+5WGHI3pzY6KE3wS55wefKJGxGvOOGV+PbFE0qYFtjDfb4OyfdzM13I+/n
 AhxDZE8cZymwXtz4bscBce5yn4nLM7+h6e/T9qPyCfjZy/e8yHY46rsVH7puCRr5xBur
 w7SYQBUmdf8EmK7XghuVVo5SMfnvfFAQfGXprva8qunJ97ThRB9ZNBoDRffXt3JDb6RK
 9xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lzkmOsgdiyDfkLzbjc8ow0qh97P5IHNxbPWiTbiz7Dg=;
 b=fZWJdtAfZvhFj+cqEKJlE/OWBqsmN5OEsPhHvJUMio57tJlXDWBUHTSp13cUf/PTdW
 c6kOFIGBJGmE5FAd5wHZ3wjUr8gT3YZ6hYKCqc6eYmVjCUw0TB2TXABwvwOelzrFrFv/
 oWvmccB9bnqLLbu3h8GZpEGkpZtndqDba5T2Pq8HAlpjlfw2U225oCRHWuCBL+FPg4Qa
 3vP6umP4qVzoUs6qR+ISu5btISpRPrtWYqFGFSqqWbjHUEDOukHvod9uGIeQlWuOL406
 i6Eb8JJyCP7ynITGCN6xdibxsEVY1Y83Xj4zTEaPy2HCPSMt8nX7C7yM41y5xFYEkbpc
 ttDg==
X-Gm-Message-State: AOAM533YIhh4Avfr6LkpbFydhl4wTYrpRStpWd6pfPVTLUfY+jDp1FPy
 kipAd7e1tnvp5XILtHONRhJezvWF9W8B4o42
X-Google-Smtp-Source: ABdhPJzYY7csfQ9NUlcCyPzsR4nEtEF/ns398ecooW3OjZcLkPE85ygmttvMEFWLoKVDI/61dPGlOQ==
X-Received: by 2002:a17:902:7042:b029:d5:c0e6:8e35 with SMTP id
 h2-20020a1709027042b02900d5c0e68e35mr247654plt.9.1602792831463; 
 Thu, 15 Oct 2020 13:13:51 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s20sm89922pfc.201.2020.10.15.13.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:13:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Fixes building nfs on msys2/mingw
Date: Fri, 16 Oct 2020 04:13:33 +0800
Message-Id: <20201015201335.357-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
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
 block/nfs.c | 15 +++++++++++++++=0D
 2 files changed, 16 insertions(+)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

