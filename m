Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1BC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C684206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5/79D/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C684206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaHT-00048E-2u
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kIaGL-0003I2-Hz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:26:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kIaGJ-0000oZ-IS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:26:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e16so7598699wrm.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vP3u++uJfrc8GJFxE3xLc1xjNIuQqA5HZ4/OCoDRGig=;
 b=p5/79D/LYmUWlxVNyfb9KutQ1eyNMCgCPEtP9iNCPAqo/U52IhVp2zrc78rm+G5QTO
 nZrK5EC0tRvOk6rrgzKMfwaL+WhLV2UM3j9Hbvhp+gVwyaI4Lwqtg3LPyK4Ks5cMxvzp
 oM7dh9S0DSozbSLmsq+HlV5zmaLWX8VCi3MP17b4NkBWnwguuY/3WwQ1RSLSGcAa/MTY
 ZZi5nNa4IA6d+vHqakulvX8iOErP4xY70Khn9Hzu220r1udVxmlA+du0Ts0B9zCO8KyS
 WErOhQvJLPndW9aJ+0dwfJqt8pGEY0+UEVvD3tLcvWROZe9FJLqB3XVO6xBX2GvyqBZX
 yDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vP3u++uJfrc8GJFxE3xLc1xjNIuQqA5HZ4/OCoDRGig=;
 b=PH+EvsKHmuJ31xJGS8VL00DWITs0sPfPLrVfHPfclr+UFB9MeZathyW5V6zd8skkZS
 DK8Nb0cFp1ib76/dntOhwuqtE0y4CsxQ/aD/PoFE03g7IyhKHeJTiw5vfXCYDfGKPrln
 HXrfNxhwrwlyPg6UaQ0AHdtKQByqHUZcy1/6LApIJ92w36+5QY8YiRDS4Ykz+mv9+GPm
 bDRnZA7tD/SgLI1w/+ylG/Cd1pckP5rCykewAatmD8HHBqcCDu74MLRc63bPyibhccS2
 GPQDZLj83xqskSPcuoQoNwEKGBXpoIRsweOBt3aXLvXtO57YIeXZtzHLrQdMHeGoaIBt
 tg+w==
X-Gm-Message-State: AOAM533aT4g0KfIWZIr+Z8uXA2zTGIcV6s/WmSACuqI0v9F6IJoWQ2ve
 DqhliLulh+aY8/0g/lWkvt9ul7R7bWY=
X-Google-Smtp-Source: ABdhPJz8f6arSbCwfPNG5DaHHlXWv94I49q8Z/lzSOVSIlY486nVWmi2rdzi555chzR0LqK+jJNeMA==
X-Received: by 2002:adf:f846:: with SMTP id d6mr29781682wrq.56.1600273583776; 
 Wed, 16 Sep 2020 09:26:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:cf8e:a9a0:1aed:9a37])
 by smtp.gmail.com with ESMTPSA id v128sm6111933wme.2.2020.09.16.09.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 09:26:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] meson: move libmpathpersist test
Date: Wed, 16 Sep 2020 18:26:19 +0200
Message-Id: <20200916162621.100141-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the libmpathpersist test, as well as its dependency
libudev, to meson.  This should fix or help debugging
https://travis-ci.com/github/huth/qemu/jobs/385737549#L4528

Paolo Bonzini (2):
  meson: move libudev test
  meson: move libmpathpersist test

 configure         | 91 +++--------------------------------------------
 meson.build       | 83 +++++++++++++++++++++++++++++++++++++-----
 meson_options.txt |  2 ++
 3 files changed, 80 insertions(+), 96 deletions(-)

-- 
2.26.2


