Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279EAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7908322226
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMOr4wRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7908322226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQcKF-0007pp-Td
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcIn-0006u5-TR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:14:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:45754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcIm-00044M-As
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:14:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id x22so4873387pfo.12
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MTsSprQCPRitXVrwDnKVRM64W56h3LUQ0a/EatJQxzc=;
 b=tMOr4wRgBTl4qt5rQeRH4uWBXqHCSvl9kTYObElWaEjfE29By0Ty1h9uEcxOlYgmgV
 Q96DJqAUcVTB3XeaTI2RtxA/vVujQ30dSyWnpYei1fqnuAARjKMbTEGtAsT2uOiVwBbt
 MyPW26jdOXFCQrwUm2l7oRx7UbM8J++NGRxQFICI6eCuCKZyloGJFLoMry48iCPm5Qhi
 y+K2bvgqvhVQErClNSgWdTQqVkqxNc6p4Pbx+8tpO4QyWoet/fxxx8lReEMX0EEf2COR
 oe+ZlRLoZi4Lu898yzDeGrrjcN7uO510zoglMkdqHkjfL9+FxhvDKN8pqgIGLSDHGUM7
 qTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MTsSprQCPRitXVrwDnKVRM64W56h3LUQ0a/EatJQxzc=;
 b=sifcookwwOc9HdjKyTTGg/Lu5ltYwbVs8XO8UrdI/0Ato1ANVkXbgjvna3HMMYxDSY
 VNoD+RYqi9+Db7OpeHdHvasTD0lBHAT5JKnQaHHXteyjhQE7I7CuELfhikExU68d/TRM
 nigvfgnBKLYGeA+TfZiC2pz0JiOw9qgBf6FwrnmnOKVXjpAypbSoUODgjYUan22IscNQ
 Xh7ahlFtsqOmNE3QyDPTIdrPZZ1UZZeTTt38YStOLIC/3l5JdWoSkIc+uc5zoZ+5X6fe
 lAi8BYkul5EZsv3FwNGSlKNvitDfB8i238prUrn9gqz+gcrnvlrtcYm2gPQYHqF8BdTR
 joCw==
X-Gm-Message-State: AOAM530YCXKu2++YmQFMj1ZpVO7Mz+x/hCw8TCm4IfM2m7kygAFmgM87
 aS48w6fFt55ZHkly/7CjXQGKAy23nM9q4g==
X-Google-Smtp-Source: ABdhPJy9UZKbxgI5SmmWqGdxo23E9PeBjMqn7Qp/p1Kk1iOoo7eB01/EXqIGjWr/QDp1AQnfOVUTxQ==
X-Received: by 2002:a17:90a:7787:: with SMTP id
 v7mr629759pjk.104.1602188050278; 
 Thu, 08 Oct 2020 13:14:10 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s24sm8008454pjp.53.2020.10.08.13.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:14:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fixes docs building on msys2/mingw
Date: Fri,  9 Oct 2020 04:13:51 +0800
Message-Id: <20201008201353.465-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42e.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cirrus are based on non-merged patches=0D
=0D
Yonggang Luo (2):=0D
  docs: Fixes build docs on msys2/mingw=0D
  cirrus: Enable doc build on msys2/mingw=0D
=0D
 .cirrus.yml                   |  8 ++++++++=0D
 docs/conf.py                  |  2 +-=0D
 docs/sphinx/kerneldoc.py      |  2 +-=0D
 scripts/rst-sanitize.py       | 21 +++++++++++++++++++++=0D
 tests/qapi-schema/meson.build |  5 +++--=0D
 5 files changed, 34 insertions(+), 4 deletions(-)=0D
 create mode 100644 scripts/rst-sanitize.py=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

