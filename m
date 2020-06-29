Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4256B20760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBNQA05S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4256B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Mw-0008Tl-ED
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dZ-0007Bt-QP; Mon, 29 Jun 2020 17:48:25 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dX-00084B-An; Mon, 29 Jun 2020 17:48:25 -0400
Received: by mail-ed1-x541.google.com with SMTP id b15so14308386edy.7;
 Mon, 29 Jun 2020 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=VYDxu7agkxJI4PvbXPb7hzG3FFKhEiHrZUcRd/JBY8M=;
 b=lBNQA05S/zpAbA1PKviRFeS0idexucbJMHXiBGM+T+f7esMFuKAPqPemPKehxLAgtb
 Ayq3xhc+AnyxtU2yopX8ucFpSj5JgCj7ljx2nVsZXCBTqK+FhESSPSyz0dYF8t0mDAJy
 f07AsrT0JDtL2wYBcAvsbyMT7U1YyzQxVoWArxzf7ioL4UUKU8yKkVfF59tV5C0+7aTE
 nltEbxSFizdauJ/hcg12+wV3Chbu2ZQ91Eh+H6Wz+WV6/H1kh3Bv0aMSras0caHpFIi2
 ZYX1Euxxanoi2w7JbSxaoUS255hCgtsJR5/hm/109cEtQ8lTmrNNNTyTdj/p/wwYrP2y
 qdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=VYDxu7agkxJI4PvbXPb7hzG3FFKhEiHrZUcRd/JBY8M=;
 b=KzOL4Nw2CVfqQlVTNzR2kUn0C6gns8XYgq8zUSZGfrYo5TpJ/nB0Nh8oTrgt8KoJDN
 gJDMEd0DIzZQ9AC2s/Nx7JjwRQsDTtXEqEt1mmowvrTBv2M6PRwvkXjO07OOr0waWzUP
 F1ZUzfVI16syQjtU70lEjl+HC6fUGQgClFyH0K9d2mqxkG3HfKhNad6cXWAw6ZVIJ0rH
 kw7MWdVn/wYuZjFtry3znM1Li2oKaTV3Q9BFN7aZwetPrdEjhderhXYAj3mkHS4kfZ6H
 eqUT1mtvnAgeDBibS6QNCbRmh3orIHIVGbi3IPec6VE5dF7c+QxtcoaoJVZ4AGsfh0ua
 LucA==
X-Gm-Message-State: AOAM532A3VmOdUnAQha/MYxb/iVssNsbmjpUX4nJHgVQJOjSkXeMGKtO
 LZEVxMGoy/htelmj6JTtJ09V20DIOxHxBXSdIPq5hpCp2A4=
X-Google-Smtp-Source: ABdhPJw0U+Egq2x/lm0qDPCiJVyqXjVZL4oMUjKcdUsczbExHxSAA48qM7F6zV2vsfJtyN6oxvtYDn4pBbCtsXcdykc=
X-Received: by 2002:a05:6402:354:: with SMTP id
 r20mr19078970edw.32.1593467301638; 
 Mon, 29 Jun 2020 14:48:21 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:11 +0100
Message-ID: <CA+XhMqxuYwkJLbCRZpAM7pM14CbLzx3BZ=n6FW14cg344xsFJA@mail.gmail.com>
Subject: [PATCH 1/9] Enabling BSD symbols
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x541.google.com
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
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:17 -0400
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

From 5c6022f21289eb6e78e93d584c766db82165dced Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:13:35 +0000
Subject: [PATCH 1/9] Enabling BSD symbols.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4a22dcd563..d81931ba5e 100755
--- a/configure
+++ b/configure
@@ -903,8 +903,8 @@ SunOS)
 ;;
 Haiku)
   haiku="yes"
-  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
-  LIBS="-lposix_error_mapper -lnetwork $LIBS"
+  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
+  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
 ;;
 Linux)
   audio_drv_list="try-pa oss"
--
2.26.0

