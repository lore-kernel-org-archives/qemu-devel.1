Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC13C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF51D2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsKSHjHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF51D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT5C-0001x8-Di
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4f-0008QX-UA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4e-0008JT-UU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4e-0008J5-PC; Fri, 19 Jul 2019 09:37:24 -0400
Received: by mail-pl1-x643.google.com with SMTP id b3so15658540plr.4;
 Fri, 19 Jul 2019 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q8EyZO9gyjUrvwScd/MsjvWo1FHMNN/dKk0uX4kabR0=;
 b=jsKSHjHYUJToEkxrNNS9GKFdQmW6SPJcCxn0QHuPWhfHMX5+bvcyQwf89TpXJKyM8i
 V15/L4cLXYpSGvgZ2RxRINHvWJnxfZfRtTsZDREJu2/cxh68sjUu5KbMSuDyfow9m3TU
 78HvI7Vga/dHLPEDguXMd9+IvTt/VOiTdIk6leE68FSdVAZU11/IZagBgfYKgpa6jrlr
 AaUh5NNCs0kAk5p3NWfvIrZSlhdAhkzhzh88EW2qWUDRkglbd+WDFBabAOCZWiRAVDSi
 Wff0jqQpwre44NTYvnXefSSE2etJXaC+P7EsYEP9ECWcMeYU4dF3MACLknQDXbdFV8JY
 pg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q8EyZO9gyjUrvwScd/MsjvWo1FHMNN/dKk0uX4kabR0=;
 b=RAobQ4VKXXRnRGMpssa+uHTCqURgFT9DSSuQ2YQvvUsbY4/NByyykxnOIqMyQEyrsI
 8tl4uqRZYSeBkm+/ZiuSpAuf1MZWUBQiZhtXVzoRnXu83jsWnjiYZhv22AkJDQcVV03t
 GF/ot7shdJFkdyNbOI9YxkM2ktAz0sYO1WoRECzZuNPPZ7Kl4HUJGyBeRLNw6rPgtmNU
 7OAWE1kcanRb3fHIJi97e80bOEBxSC6KYGGqykmXZK4Xoxyv3Q6lrwl/TASz7LSV6/LK
 YTTf0Z6LeuRr5etpGDzCGiuzpjSIwaHSgeGLJY5h/X+vnHpW+fAMaOe7Zv7lsZ6CpwDv
 tuzA==
X-Gm-Message-State: APjAAAULtRW2rMD2RECf22UFa6QmGydZKv8Hb/DgFF29qUUSbTmiQOgj
 KqzfAURK5z94NwEXCl4RngnBuHRqDdo=
X-Google-Smtp-Source: APXvYqx3eOBYOiwgOCXt6p02ufwJtiLpoogdAPHeU9/pfi2NFZPirEdoWYHZbDT+acrIM5dWiUePbQ==
X-Received: by 2002:a17:902:fe93:: with SMTP id
 x19mr53009004plm.77.1563543443603; 
 Fri, 19 Jul 2019 06:37:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.37.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:37:23 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:28 +0530
Message-Id: <20190719133530.28688-13-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v6 12/14] qemu-img: adds option to use aio
 engine
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use -i AIOMODE instead of -n.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qemu-img.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..b7a962afff 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4192,7 +4192,7 @@ static int img_bench(int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_options, NULL);
+        c = getopt_long(argc, argv, ":hc:d:f:io:qs:S:t:wU", long_options, NULL);
         if (c == -1) {
             break;
         }
@@ -4232,8 +4232,13 @@ static int img_bench(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
-        case 'n':
-            flags |= BDRV_O_NATIVE_AIO;
+        case 'i':
+            ret = bdrv_parse_aio(optarg, &flags);
+            if (ret < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                ret = -1;
+                goto out;
+            }
             break;
         case 'o':
         {
-- 
2.21.0


