Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33CC433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D932074B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN50xkfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D932074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwmkT-00047N-Ut
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmje-0003Zg-14; Sat, 18 Jul 2020 09:18:38 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:35975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmjc-0006lm-KP; Sat, 18 Jul 2020 09:18:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id dg28so9737455edb.3;
 Sat, 18 Jul 2020 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ZIGgbEWqMQEZSeGWdp/Sc6jD5b49KXoL2NjpXMOToKI=;
 b=IN50xkfpSxA/MF07WjA4in1cvdybXaMrfBQnUoWT1Y4PKSUB9j/HDstvdYvyXpFBSY
 y1lUOOT4zsFSCt5LNa3+liGoJ4qVqqnmas9Jt0QYeIgcKJPgR3mFsKwMfjTxdASohwfC
 tRCXeR4cMssPlFWz5ZodlbyHkJDIAQuhH525MbdMT6XGUGzijt53gyffAKqyvjSeYvVp
 poBogSlK+3VjGe/VGyBK6j3uyFeyCyd1BJZRubwtMZQ3rGJqEv2HDRKoKD9ZWxdC5WgX
 j/eKjgxXKV7kwF42ZExoGFbQTiGx+UYVsJqDwsPw4E2qqXW12Hvpnyv7J9NSULbOocRJ
 mSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ZIGgbEWqMQEZSeGWdp/Sc6jD5b49KXoL2NjpXMOToKI=;
 b=NaVTtgjKaDM1wUfQWFzPm/xTKBTlnyMczvXQnI1ry9/X7K0s6mkeIgoeX1P1JqzoxV
 3HJ4bzyv/9u72FefrGde3EdFbbR+NrY9Fqmzx1GO8Jo5g0+54xqzrL/W2qICAhqrIvvh
 QpsJaSSGQjj70865jaOlIutD2rQT02J4cvMorRAE5ogWrwIgmoa5MVS4w9FbhX6dsYB5
 9K7G/Pdn44y6Q1BniehauU5vxvD6jXEPi3ypIKEwT64bwZ9MjvdkPrWXv1FA74lcOVWd
 JNrw8Fu6jqF4+kz+8Lfbr7JZMkwvG3R4OTBAzSxsIleq/WM85C3VMrWa1ibY629NUi4t
 ifiw==
X-Gm-Message-State: AOAM530prM6jM9irmgJM9TL7O/++UvVOJn/VnxSiWeaf/ydK3JXduzgj
 5MeeWbXEmbeoeFOAueogStaXb3DZ7XGdC2wno9D3kMbfs+I=
X-Google-Smtp-Source: ABdhPJyuM9RdBION656vrYTi5rO/wAak75mps3CAOZ6rFjfuoZlV3Prcj7mjCwLoP396A8iWlUToRyTRASr54jCgfJ8=
X-Received: by 2002:a05:6402:354:: with SMTP id
 r20mr14386463edw.32.1595078313551; 
 Sat, 18 Jul 2020 06:18:33 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 14:18:22 +0100
Message-ID: <CA+XhMqwLWxe-+QmFy=fRQn_Gjm251ThuydLJGgtCcT-EzD2Jpg@mail.gmail.com>
Subject: [PATCH] build: fix for SunOS based systems.
To: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x536.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 1c5225132a01ad67c87d603659ef4e4bcd46a16d Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 13:33:47 +0100
Subject: [PATCH 0/3] build: fix for SunOS systems.

David Carlier (3):
  configure: fix for SunOS based systems.
  exec: posix_madvise usage on SunOS.
  contrib: ivshmem client and server build fix for SunOS.

 configure                               |  2 +-
 contrib/ivshmem-client/ivshmem-client.c | 12 ++++++------
 contrib/ivshmem-server/ivshmem-server.c | 12 ++++++------
 exec.c                                  |  8 ++++++++
 4 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.25.4

