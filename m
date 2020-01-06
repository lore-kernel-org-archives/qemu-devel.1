Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D885A2081E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4tyhqku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D885A2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXjk-0008Ru-IG
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4Z-0002jN-To
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4Y-0004cN-Pr
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:51 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:42550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4Y-0004bz-LQ; Mon, 06 Jan 2020 13:25:50 -0500
Received: by mail-qk1-x744.google.com with SMTP id z14so39015038qkg.9;
 Mon, 06 Jan 2020 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hHc8KM4wbyx7oApuYrLldPmbj5H4j8u/5LpfmbUVXc8=;
 b=T4tyhqkugSDw1fNHjAUkq2C8KOBU/8EGI4SIrpzht34zgrAhBGiAL0bL/pFJpErVl7
 h2cXmZyXig9uRZ8Sbnb/yGrWNsLTrph9Yc5XGuKlAJD2YQBmXTF6rSc1eaOxdjKoke37
 uhHunMIc06Nwk2lmSI1dCbTD8aQBIkVroN2MaFA3Hmx+10jmI8nxHgywNoHSGg0e9iEU
 feoY75Nn7cB6QDRKhD+S/7jKbVMb8vyX0w7r3tZT9abXigC4i2uvWfsLllzjApbg4iiU
 4G/gpomo4ZCM6y87qSYolYLop1AtUd1d2lqc9uJheElCSIJv+zIySGazJYEz5BQsKMan
 nyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hHc8KM4wbyx7oApuYrLldPmbj5H4j8u/5LpfmbUVXc8=;
 b=ZywST0Zw/9YTNhZe+EXx5ME55hbL9ln6O44LoPkhAAbDiv+Nr/nOK8PMel9ghSNlAp
 rPD+NZdQX08YDn+QEQcJQ36IT/brLa/Farq3qUhVLyZngdmWNMfjIVIJibwJ0r9eyKsa
 dZ27lS+ZMUCFZ+oOpSbNcfP1G7WxvbIOka8BmTW2YTTjZlJwpjGl4JTav1aUYK1hPElK
 FCpO+IZ0YH10s/SncnBm4bUenmD+YCI838flEQZ89v80/+RN6+OgeR4PBHWK4GPrJgIq
 3a8D5jvLO/SBf7/Qp9QoQwD+XeerPVW2JtfwFh6o5L705AWQXIn8VxZt+oi4Cfg3N0mP
 qD0g==
X-Gm-Message-State: APjAAAXSgMPspsGdk6z2s8Gsmk+zSmDBXzHp0YQHVa5DpTwxyWe8mUK0
 cyjEImsaA+bcsLvhBQZY4iURwa7/
X-Google-Smtp-Source: APXvYqziWR5ne9olzdjMctJpqGaccIPRjn1I2s35O8ZZA3yBuUdyRiz8JOcQsiLp1p1GmlxmHKMvlw==
X-Received: by 2002:a37:801:: with SMTP id 1mr86585967qki.326.1578335150132;
 Mon, 06 Jan 2020 10:25:50 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:49 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 32/59] qemu-img.c: remove 'out4' label in img_compare
Date: Mon,  6 Jan 2020 15:23:58 -0300
Message-Id: <20200106182425.20312-33-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out4' can be replaced by 'return 2'.

CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qemu-img.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6233b8ca56..fc7b08e7ee 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1346,8 +1346,7 @@ static int img_compare(int argc, char **argv)
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
             if (!opts) {
-                ret = 2;
-                goto out4;
+                return 2;
             }
         }   break;
         case OPTION_IMAGE_OPTS:
@@ -1371,8 +1370,7 @@ static int img_compare(int argc, char **argv)
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
                           qemu_img_object_print_help, &error_fatal)) {
-        ret = 2;
-        goto out4;
+        return 2;
     }
 
     /* Initialize before goto out */
@@ -1559,7 +1557,6 @@ out2:
     blk_unref(blk1);
 out3:
     qemu_progress_end();
-out4:
     return ret;
 }
 
-- 
2.24.1


