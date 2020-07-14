Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74904C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFFB2193E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljBDDzBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFFB2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCvn-0005Yb-HG
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvCue-000438-8a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:51:28 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e]:39062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvCuc-0004tR-CW
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:51:27 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id a14so6917036qvq.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 21:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s9KURi/roXAr810pR97pCEsAXdszO2apTpj9XTd+sCI=;
 b=ljBDDzBQqL0bRa1P4DvK/wZob3gKiSJxjXYFaLw+WwvEbtf9tvU2BlQv897TnnhTkf
 6GUajz+Nken3Dkagvqb7r1hjjYO/UNDkqwKe8WwUk+/3J8QOf6uOB38U2yE5HpoibhhP
 SRSCfMmdVlyK0GqxnvBS+he50R4eR7GLq81J5IWuHXAQzURF4v7urVJnqQh59xNPKOiu
 vk6wp4pMPPKNblKyKrQ3rmHQ8L+kg+i0rEmDAZrFZHrweiDEPvvnIDdnpZ8wFcO7GJDP
 URuxN4Ol7d6gQ6yFGih4XGH/NpxxsVhnj0vg0Qe5SekfHUY2dlZO27FoNC9naKovZ0h3
 kIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=s9KURi/roXAr810pR97pCEsAXdszO2apTpj9XTd+sCI=;
 b=H277jCv/8/c2GRg4t1HyBab/W/40RfhALti1U1x5mSZXJ9XZmyc88y/lmCb/cwMDlS
 d+vp0Lwuls0NC2ssh294w1RFk502Wg0wjGj+vEeDUKPsp1tM4gwSthnC3w6HTuaBGNl6
 uVuEtWATpG6Lr49bpYYE2q+hKSQ2L57ewL9tgJbhWUpiRIalbLSorQP/uBiPbi6l3sis
 0CzFsikxDmkwFsjMq7z+Nnxblgt9pefJKEVI/YSvKjy1weaeezJzkapQRg4mQMDkEX5M
 MtXYw49hMe4HLxvJN+Jw/Wza1lQCmfuofLVAxWwOOTjHWWZ7/2LacXkOPP1wxXrTd8HI
 PIvg==
X-Gm-Message-State: AOAM531KL78w/kL3fubw++mZSbr6qiuLcvlLchg+esvdFazRQeFxJM8x
 D3oEfX7rfzEAblSXw9NAADqe/Pd7
X-Google-Smtp-Source: ABdhPJxSsbtVUOx21QnWKSAY+f2BZ21ewbblccSQFLdQ9y8zQL2HzXFZ1VOIb5F/ykw1lH+lfuH1ng==
X-Received: by 2002:a05:6214:a6c:: with SMTP id
 ef12mr2791266qvb.74.1594702284566; 
 Mon, 13 Jul 2020 21:51:24 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 1sm21767298qki.122.2020.07.13.21.51.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Jul 2020 21:51:23 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] qemu-ga patch queue for hard-freeze
Date: Mon, 13 Jul 2020 23:51:10 -0500
Message-Id: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=flukshun@gmail.com; helo=mail-qv1-xf2e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-07-13-tag

for you to fetch changes up to 0d3a8f32b1e0eca279da1b0cc793efc7250c3daf:

  qga: Use qemu_get_host_name() instead of g_get_host_name() (2020-07-13 17:44:58 -0500)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* fix erroneously reporting stale hostname in guest-get-host-name
* fix regression where guest-shutdown asserts when called
* fix race condition with guest-fs-freeze/thaw on w32

----------------------------------------------------------------
Basil Salman (1):
      qga-win: Fix QGA VSS Provider service stop failure

Marc-André Lureau (1):
      qga: fix assert regression on guest-shutdown

Michal Privoznik (2):
      util: Introduce qemu_get_host_name()
      qga: Use qemu_get_host_name() instead of g_get_host_name()

 include/qemu/osdep.h      | 10 ++++++++++
 qga/commands.c            | 17 +++++++++++++----
 qga/main.c                |  6 +++++-
 qga/vss-win32/install.cpp | 33 ++++++++++++++++++++-------------
 util/oslib-posix.c        | 35 +++++++++++++++++++++++++++++++++++
 util/oslib-win32.c        | 13 +++++++++++++
 6 files changed, 96 insertions(+), 18 deletions(-)



