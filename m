Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A59C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BCB22204
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKtC7qR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BCB22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcoN-00040h-PE
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFclC-0006Rv-K7; Tue, 08 Sep 2020 08:30:06 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFclA-0007rX-D5; Tue, 08 Sep 2020 08:30:06 -0400
Received: by mail-pj1-x1044.google.com with SMTP id s2so7950817pjr.4;
 Tue, 08 Sep 2020 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EKG1apOrW8tjor/2mLwmR3nr+4172Hc8gwfm/Y5sTeg=;
 b=BKtC7qR8e5qiLJNAaOyPC8svfaIgJHIiNFIwR0e20uLvahbgK0HYka1O7q0RcQtzqE
 yw6/SGbv7nSe+7G8oULZvuIgra1sZBvpJ3eS/u6w8BiFf9XptOOy86JwOeWbiHfAi5V9
 biPVB/bToLAyEDwnuxGt0/9IoS2XUUfbSBhzVDZJ0ac0VeOifraIiR6jpwcRYoTCO+HZ
 Dy0zIxIGuQHTymrw7hTT3TmUssL9hmBE679w6HHNmO3JVeJfM2BSfVhjm/kFkp6L+U0u
 kS0/a/KNXpiuyKjgo1sL7ORX30ZkQUfrgZddbIsNdGMBiEBgad64yTGmi240A0NMytw8
 4pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EKG1apOrW8tjor/2mLwmR3nr+4172Hc8gwfm/Y5sTeg=;
 b=DayriUVOEbODw0ljrtj/PxIn1zYpn8wDwBP6YwKNcYq9AxTSiFtnFDsWNtZhGw1M+9
 McSEquBmGoIZzT7CI65uHK41VuRM39ikDl0FswhDIH/FfcHJyvv9HpQ+PvusBCPEqrEY
 1dM/B8IkSWlE5wWR/tG4kMONd8Fp8jkK3JcPrQOCYG+iMgRN0KM4+H8UdnHQiIbDiZjt
 U+39ijqzYhNJSf+zeZHhEn2lk2VUiyrUDYXQPsQpCU0DBQktUyTRXPiUhLzaJoQkFdy+
 VjZuYfM1XWQm2ZxWXYumvafhe2QZJ6bGcHURCNCcBnCs/XNn2VdSOOgv59zD9T2bpacK
 yOiw==
X-Gm-Message-State: AOAM532995xFZeQRFdrlffejiYjkIYmSzukV6osjrZcHprUXISt3G/u3
 1H8DqIaC/ByhJDzm6be73H7YdyIyoYtHJl2Y
X-Google-Smtp-Source: ABdhPJwLPp1M+u8WQaI2/t40aV9+YTEc9hpovWgaENy+sgPK/vIjfzMi9fi97UinUQMUXneQW15LkQ==
X-Received: by 2002:a17:90b:510:: with SMTP id
 r16mr3748686pjz.75.1599568201356; 
 Tue, 08 Sep 2020 05:30:01 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id d8sm14833887pgt.19.2020.09.08.05.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:30:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] rcu: add uninit destructor for rcu
Date: Tue,  8 Sep 2020 20:29:42 +0800
Message-Id: <20200908122944.414-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

