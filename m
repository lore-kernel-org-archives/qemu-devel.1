Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38052C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86E421532
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFQsIA91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86E421532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNBH-0000UG-Sz
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA3-0006vB-SC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:41501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA2-0006YS-AP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id z19so6935345pfn.8
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G9YS8t1Tuykng4vH2Fb9AIF8whwQm2QB8lV8hhPV0yI=;
 b=FFQsIA91+crQ1comm63Rzb1CHH6O/cnnizuskhdX1W2dwOx2eS5faH/+9Oa2ODF3xd
 DL6Zu6aNNXRbzabWuY9gfbnnJC75B+iWgwVD2dV1TXYyd6uny9+nnTLzPbNRP4UNwZLm
 Zl/QgqEkLES6VyJoa20gcx3gY6ldO+5LLvra8tv1CqfV376Is3MyGP7detPypcO6ZAL+
 VyEPdqqBR84IQPb+vJmHh7xt3wMzHhP9udQsCuGAO6ZAY0jL6j8YxWUZnohwbQobAA9d
 aTlnA55pv34bXVb6V7PzHzkNXESxsIXoFA8cLh/LRQBN0DzBz/GCOXEsodUXwtFnPx1B
 QpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G9YS8t1Tuykng4vH2Fb9AIF8whwQm2QB8lV8hhPV0yI=;
 b=dY3bQAnSrhSpKZ2i9W7oTHmz2Wyy1OofMvm6nwBvoahwPDn3D1VkdLLLtgNn62l7+U
 pXt2SWpLs9oOQ/u7LFz2mW8D1/7Y0IiKL8cDCBrMOxyQIMG4pip03hbqxvizA/ECk06L
 7IEqASW1O7/PeDcvb6uLtkv4EkWpYvbpCrhUz9zIDQrCNSDPfsBnxhSqAXSfQRbUGRVd
 0Ao8pM32BNYn7JVhzx7LXuzDkXrGTHBEJCNHvkcoBAx0vco6w2E43Pv2Oop+70QPzDjk
 FhZ+r+lNQHMreYq/nraubhnXzL5SkKLMtyN+wXeBZGD4PRGZhZMpYQnHVGcu+BIxXWnf
 tkIA==
X-Gm-Message-State: AOAM531wPx7L4YdS7SpddO+Y5aiwxhBlM0PQumtqwh+4WoAS8DFF7VRc
 UdqX7G2vKrQ0Tz62bIDATzGyanz6zv52HCVr
X-Google-Smtp-Source: ABdhPJwar0dAaHZT1TnvHavEJAcWFDlK3/HXR+OUGwXhKEtQCN3ueqk+8LdOYkmOSitvwRNhbaRIpw==
X-Received: by 2002:a63:e20:: with SMTP id d32mr17192736pgl.53.1599508240381; 
 Mon, 07 Sep 2020 12:50:40 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id ev19sm4818990pjb.42.2020.09.07.12.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 12:50:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] Misc meson fixes along test-vmstate fixes
Date: Tue,  8 Sep 2020 03:50:21 +0800
Message-Id: <20200907195025.2308-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x429.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test-vmstate can be passed under win32 too=0D
so enable it on win32,=0D
This is based on Bonzini's upstream tag along=0D
=0D
Yonggang Luo (4):=0D
  vmstate: Trying fixes test-vmstate.c=0D
  meson: Fixes jemalloc and tcmalloc can not building.=0D
  meson: remove empty else and duplicated gio deps=0D
  vmstate: Enable test-vmstate on all platform:=0D
=0D
 configure            |  9 +++++++++=0D
 meson.build          | 11 ++++-------=0D
 tests/meson.build    |  4 +---=0D
 tests/test-vmstate.c |  2 +-=0D
 4 files changed, 15 insertions(+), 11 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

