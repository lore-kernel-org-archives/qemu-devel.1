Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3A7207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShYhlJNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3A7207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooyr-00079k-Ch
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joowm-0004X1-EV; Fri, 26 Jun 2020 10:03:16 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:39106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joowk-0003xh-TL; Fri, 26 Jun 2020 10:03:16 -0400
Received: by mail-ed1-x52d.google.com with SMTP id d18so1375677edv.6;
 Fri, 26 Jun 2020 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=gkoQ7wKEqYIgyzpfrFvA5qo0YC+QngQ6l2mRgEwy8/M=;
 b=ShYhlJNxBUj5aFljVu9xwGiJ3hi3g0W8gHYqmQUBTwkCI5TW9MptYdd2I6QYqH+ukp
 zzisTUKZX118MIVP1VjPyOIqwKbJNlu2irkzbqm7jAk3kbo8EHpuWj9NHYEwa+wexvoY
 +nfYJnyOM2TJi+qAtSxWnc9c+BkmN0s2H8HKcmxokOg/TnpnCprJZO/8gkUG7zv+EGgk
 CUqTH2CktFeCHIEje1HqFoi8t94w6wJNfGNJaR0yafqiCOrTchdHs7+g/Pn8RN/vwiTt
 sq20xwH1j6boc6LFRYfV/OnsMP/bqAZblAy3SAHPIJhSQdJVb1CdoWgZBXkD26btix/D
 3Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=gkoQ7wKEqYIgyzpfrFvA5qo0YC+QngQ6l2mRgEwy8/M=;
 b=paE17ELw746aRqz0RJdmSWq94n3QStZF4idCV2aGydUJChN3ht/dmesvCH1HcnowOt
 S2z4hZqVxcEd6iTagbUD9YcsV1RfD2ybvFhovrc5TH0k5gNrP9vp1comoPeq38iDwXlE
 +xZmgK+7vRYItDtKLM/GjZAigqqdhJlMz48EReX2KDrQY2thLV1MOpL1XvMrDLGOaSX4
 VAPk5ekdK38AQL5Cizer1yh0R62B1hEFyb9x72avPnRJGfyLZCjJgcSt6blu0RXoMhQm
 silxNh/3ixqy9EBhpfJnutKWVIddSB3JVvTPQBjukPpX6ipFApi5wOvueMqpM+aa1PqO
 QcnQ==
X-Gm-Message-State: AOAM532mLi1scFx3JHKMFsKb33/DHJWOJelcGXRIPfVQLshnjpvfMEEa
 ba2JGjklwNgElTacTB9UpGKsNusq6JBllDu1d1n8JOAn6z1d8g==
X-Google-Smtp-Source: ABdhPJwGsdeLQDdnnzCB2xswnyc+30sR/haetUsD2Abfm+DrsHvj3kWvzjpfy5fSIlrji2ksuXa7XdGaKFsv6wgMgM8=
X-Received: by 2002:a50:9a82:: with SMTP id p2mr3456498edb.130.1593180193043; 
 Fri, 26 Jun 2020 07:03:13 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:03:02 +0100
Message-ID: <CA+XhMqzMSoD6Y6FVLk1MC6JgL-+GXWXBBe=gJiKAtLa8sW1LdA@mail.gmail.com>
Subject: [PATCH 2/3] define SIGIO for haiku
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x52d.google.com
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

From d36aba6190152c626f668fef3704ee6b61bfc323 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:45:04 +0000
Subject: [PATCH 2/3] define SIGIO for haiku

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/osdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f88fe23936..860bb3c16c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -388,6 +388,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define HAVE_CHARDEV_PARPORT 1
 #endif

+#if defined(__HAIKU__)
+#define SIGIO SIGPOLL
+#endif
+
 #if defined(CONFIG_LINUX)
 #ifndef BUS_MCEERR_AR
 #define BUS_MCEERR_AR 4
-- 
2.26.0

