Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB73C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C8A2078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atDeYKai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C8A2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeLn3-0002EO-Oz
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeLmG-0001Lz-Ga
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:53:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeLmF-000584-SD
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:53:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id c71so3970814wmd.5
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EK8X1ZnP5Ehvl+AAiSZNssm8DWCcaETPS0XfFLoDo1k=;
 b=atDeYKai+FKKeTqbbf0+4vZyWnrmZSTt+eCGPLQ6bWxx05ikipV5irCNE7A57Ntm6J
 u+sSoKv/pgmB0UCxiGNagjVohdJ9E7JkHrYHW0HvV6LsHv0pgKl7QGiYcfmAR42AL84k
 RGWlxUxOJSe0mKLFQTshHJrcLKVK+b+Vwz0fPRWK+3aM0pwo0QVtJleG3o4aErSXJXko
 /4nR/voxvTA2f+J0fsB45d+wFi2nKhuJK8Y4NNfwF/YcYbagz/dZt2tSADeLWa2L0s4G
 e1pDHWsjjeEoYHiQ5ZKVmYs9tIR3gKNIO3VrLfivqpASblx8XnjLgDApEsw53Zie3DBQ
 iD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=EK8X1ZnP5Ehvl+AAiSZNssm8DWCcaETPS0XfFLoDo1k=;
 b=U/0RkJxfurhNELfYfiqpQ6m3jFWjv2yXcXZxYfJfKGQ6shmMMvK2RdYWEa6r+775c4
 Ao8AAdwGW8ZcQA9rXNGMJaE+3RWceJGdgBd4azJfAUYV2UfFbbqrAax44dWy9fMOhuBO
 P8Ead9h5vhlrPwFp/h0bFvA0MqdosuVw3Y5moMxv+aIl9n3ohh1C0VyyagjFLuxuG8+A
 y96+d2sBqkg02n/TTROpBEqC7xCfsAftbDKX0YVWMaN9Ol4GedkssKdrQ3xsWLhLfgNW
 citRXTpY6gbFn8t7UYvICIJYZ47QJV37Xra/lF8r9/hYY0rj1KJWmFNexFrDJgDftCVb
 7KYw==
X-Gm-Message-State: AOAM533/i3zKSXDSYpY/KhJdosr0vBrq4wP8Ehc36eB3QMxuLulgn3Q8
 Xv+E9HzQ5uTDbWvxN8j7iotzMlXM
X-Google-Smtp-Source: ABdhPJy1iLA2efFlWmYdgxFDO3h7FS/23kkJ7cL6huoJTUfHfOoE3VhskZ28Rt5j4fzuAX2vMxbnEA==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr4085808wmf.24.1590684785862;
 Thu, 28 May 2020 09:53:05 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o15sm7445447wmm.31.2020.05.28.09.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 09:53:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] tests/qtest/fuzz: Avoid QTest serialization
Date: Thu, 28 May 2020 18:53:02 +0200
Message-Id: <20200528165303.1877-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
- update virtio tests after talking with Alex & Stefan.

Alex, from here you can test the getenv("QTEST_LOG") trick.

Regards,

Phil.

Philippe Mathieu-Daudé (1):
  tests/qtest/fuzz: Add faster virtio tests

 tests/qtest/fuzz/virtio_net_fuzz.c  | 42 ++++++++++++++++++++---
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 53 +++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.21.3


