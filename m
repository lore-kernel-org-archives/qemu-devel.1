Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B45C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F98120657
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+WyAEdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F98120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaMTa-000645-6t
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaMSc-0004pV-Hq
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:48:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaMSb-0005HB-Sq
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:48:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so9102685wru.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PyD08TQGfE5nM9mCAZQwcChCFwFXw60cA5TwuhMr6U8=;
 b=u+WyAEdgnNcWH8xkNA7QvRyfN915taLRume4OYzWWgL2ynE35wbt+qbWI27QZg8ayU
 xsPpZj0UZn7JofkZldI8ftBq3D40Da1Li4dZoIwnfpg+Y/LeJDI+IHm9ZWHSS/y8Gy4o
 HeYfkbb90z6xWTEHKfeTanyQSNVZ4hJm0xxgH6CvoMUJBtcILi6Aro9i2T2IhikQeH8F
 aS6Gwgy4QkUSFsVWHhQ/lQ6obChYPL5PLUtmoLOrqAWtNfOpluzbFROUPlwVt2wOGSXJ
 2vhS8Lm01TPeZjvOcfi8tDb1TBQ2JVe67/QLebBZUp7VcYTzitaCjR8Urs3WdSOSQL4M
 C0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PyD08TQGfE5nM9mCAZQwcChCFwFXw60cA5TwuhMr6U8=;
 b=ry9kpztHBZovAw/kw5o0ErEU/Vh19s2/5ce9ITiJQgxA0WVmIPvX/i1kt1DwW1Vulw
 HOKmdMlGDD+FN5Yi6SsRx8UJfTSCiZiTDuC8p+mCcfwr+Xze2Fdk6S397+inCjmffwxU
 1INohsHobAdcmnk23nIrF/P/EUVovW7nxOAGp9VnRU5cJe23hRJ6QHGjC77aHMaQATIP
 At3TdT0JkQpLrSUD0kknpg8gY/OuWUtNYi+NNyQGvQOLFGMCpOCZx8tqrvlxIreaIjD0
 eTOJwNuB/BlXp7sRxcRrtFkEAdV9HT0B9W3f1emRKG0YqBX7v5jTSrsYT16CcGPkL3AK
 h2bg==
X-Gm-Message-State: AOAM530keaAzDu4NXyh7gRucCatzlBIwmUyXAV6btkIbfPzNvhKc9x/f
 olgfqzUIRPobBaV2d3IMnmsNUrJmzPk=
X-Google-Smtp-Source: ABdhPJwppSOgTPdimrd0/nnhZCgWrV/K4RilHMKCcqdtv029Tsjt8jkIDXTA9TqSoCbB5nVthB+Ygw==
X-Received: by 2002:adf:806e:: with SMTP id 101mr15315356wrk.225.1589734100123; 
 Sun, 17 May 2020 09:48:20 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o15sm10430850wrw.65.2020.05.17.09.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 09:48:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
Date: Sun, 17 May 2020 18:48:15 +0200
Message-Id: <20200517164817.5371-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Xu <peterx@redhat.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various places ignore the MemTxResult indicator of
transaction failed. Some cases might be justified
(DMA?) while other are probably bugs. To avoid
ignoring transaction errors, suggestion is to mark
functions returning MemTxResult with
warn_unused_result attribute.

Philippe Mathieu-Daudé (2):
  exec/memory: Let address_space_read/write_cached() propagate
    MemTxResult
  exec/memory: Emit warning when MemTxResult is ignored

 include/exec/memory.h | 50 +++++++++++++++++++++++++++----------------
 exec.c                | 16 +++++++-------
 2 files changed, 40 insertions(+), 26 deletions(-)

-- 
2.21.3


