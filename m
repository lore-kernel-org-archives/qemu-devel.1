Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5DFC47095
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E434F206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGJNJaet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E434F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kORXZ-0001cU-Lb
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 16:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonatan.p@gmail.com>)
 id 1kORWy-0001C0-M2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 16:19:52 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonatan.p@gmail.com>)
 id 1kORWw-000565-LR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 16:19:52 -0400
Received: by mail-lj1-x243.google.com with SMTP id r24so2208647ljm.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=55dkHICSqwJIFRicE8GeKb5XDRhaWcYvPvXipz4ZI9A=;
 b=DGJNJaet0cWaDUgVwithlj2uAM8st0edlZFNgqLEhbMjW42wvOipOI8tmLPjyO5qs+
 ztYIqUVrys0URo0j5ZmS1YdcQYMtoi+hDF/x8xsgOgJxvFMiXV9Bk6XeXXJqjBFvYMVx
 XQ+M9E7fkmel1OspylTfhlk/Ogw/zy+EBvzBLBzbKBXJqe1gau+jhmfTgqZhH5Q7BPQk
 yyfn4LV4lpHK9jH5pXtcl6p6Ce2d6r7BLHHNOes+2Q5//70E8oBT5U+5jBi+B9EzMSRk
 oGjVIuX6btSlHu4bQvV+ZUG51Eh7IhlJPyb+U51M04nj+vHFYHa65BClDo4UCyGXYql+
 0Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=55dkHICSqwJIFRicE8GeKb5XDRhaWcYvPvXipz4ZI9A=;
 b=kaW/kjc+sHu0QR6+an2NTVWNqHRGj54ptdckHCnEb8PIIIUMKveb+/JJmAG906nJEH
 yA5mxDhRWhoBFQpYv1Ml7zNc/O+H4yqSVOmFqqvEgDy64ioYO+uR289PjiF8M72ltBfU
 SQqbGG17A1u2gTkwmXoI/xi9axZU/jpXwDcZegRZy/G36QLWe45GmXSBSPtx+7KM03pw
 rnZv5lH+7zzs+m3LI+Du8rAls/Q/YGk1dlkUa2OvALlougBQYbO3BBYJ09YI/86P+R0o
 IDe1Zz50bVZLlUX0klEkx1JIDXT8FTcO+MZ8mkyr/NE5i5qnzp0lI1PfFh9gt1AKTdgI
 M4dQ==
X-Gm-Message-State: AOAM532KHRfO9EEONMFbYpw6+IDvobLQrg+EyNOGsrSLLrEJgvmSst4x
 IJRH2lh02MoX7A6v4xQNOQvxRbO6f3+cXw==
X-Google-Smtp-Source: ABdhPJwhKSiXhDUfFfD/jlGlIymuOE6f6H5kuFqxuxGyvmSa8HAiEee6ZY2r/CUslFsvG0aQIahkLQ==
X-Received: by 2002:a05:651c:484:: with SMTP id
 s4mr1241024ljc.391.1601669987935; 
 Fri, 02 Oct 2020 13:19:47 -0700 (PDT)
Received: from X1.lan (h-170-217-237.A357.priv.bahnhof.se. [81.170.217.237])
 by smtp.gmail.com with ESMTPSA id m19sm502809lji.112.2020.10.02.13.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 13:19:47 -0700 (PDT)
From: =?UTF-8?q?Jonatan=20P=C3=A5lsson?= <jonatan.p@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/qmp/qom-set: Allow setting integer value
Date: Fri,  2 Oct 2020 22:19:33 +0200
Message-Id: <20201002201933.250878-1-jonatan.p@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=jonatan.p@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: =?UTF-8?q?Jonatan=20P=C3=A5lsson?= <jonatan.p@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the value appears to be an integer, parse it as such.

This allows the following:

    qmp/qom-set -s ~/qmp.sock sensor.temperature 20000

.. where sensor is a tmp105 device, and temperature is an integer
property.

Signed-off-by: Jonatan Pålsson <jonatan.p@gmail.com>
---
 scripts/qmp/qom-set | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 240a78187f..61920680eb 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -56,7 +56,10 @@ if len(args) > 1:
         path, prop = args[0].rsplit('.', 1)
     except:
         usage_error("invalid format for path/property/value")
-    value = args[1]
+    try:
+        value = int(args[1])
+    except:
+        value = args[1]
 else:
     usage_error("not enough arguments")
 
-- 
2.26.1


