Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F5C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D13206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9PMn/a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D13206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Ti-0002Ie-57
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Na-0002G6-AP
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NX-0008JF-CM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id o5so7077566wrn.13
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PHEeiWuUeVWAHmIsOglvv8etYI6WQHs493AQVpi0XqM=;
 b=P9PMn/a6ucMt5Lfo5OEFK49MO8+zGAZwLilN+WlhwCb2uAiJR+5mYUEPiXn/ktEMhi
 p6p6tI9tKiNKp2tf/2uauhrtnH+jNxIRVqzBybWuUhyHK3aar3DwsIMnuNv2bPs0dS/B
 tg64RKvKAZRZDKC2ZmG89DsTpTFZvxAkuABi2bJIN1YrLfwOZE52xfLG6YBQSzt3rvle
 c322HLCyBOmQwwF5AVVo1L+Yw3C5yVj6hGZ8E4W/RwQRmYl+n/3eIsdpsiFsz7Elk4s1
 Dc1be5mYd4BPszSxQOxjDwCdpGZgSYY3Jrel341VvHwrfUJrvDvHYgTg1LxgVY42p15e
 Nj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PHEeiWuUeVWAHmIsOglvv8etYI6WQHs493AQVpi0XqM=;
 b=dYK0ZNl1pF0JmRN0xiHrYlF7kSTMVxliLt5pyedBPpcyofefhTgbBub829Jo0Q8eIc
 +NmHQixivo3paf7iA5QWYJtcSTwgXavBzJy5JrOK0IVHUqBQxMEX0PyNIsDNOCHl3OJM
 YvgFYcyNxV1pghLSo5R+NYSZhZ4K9AxxQwVniwfkf020iVE4vCeuK8m7WbajL2kVIqF0
 f9NzXJI/xabjXPI4bXBtPamSkKr14tX6fQUExl+1dxpAYYzP+5w7wbbmLZuYx5p6cJPN
 D7/xv9RZo3oTF1oDH5GrhjcCtvDSqDwGcOYR4cwDvMFy4YKDnNOaQFzraHM0AwuLBmeX
 k9eA==
X-Gm-Message-State: AOAM530C9oNUgsVJk2lQbb39h51bK0BGHF5RgpQX8ybJxng1J5g97kZO
 3C5K4tqI6v13WICJFsZVHq7h5mLL4N0=
X-Google-Smtp-Source: ABdhPJwF9OXY8s4/Daf4YiMWQKlTHr+3eGr+ao0UtAH4IW729nh7Bay5dP7K/Vey9c4RLHu7x7Wwwg==
X-Received: by 2002:adf:f24f:: with SMTP id b15mr14442266wrp.301.1601834697951; 
 Sun, 04 Oct 2020 11:04:57 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the domain map
Date: Sun,  4 Oct 2020 20:04:30 +0200
Message-Id: <20201004180443.2035359-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>,
 Nathan Froyd <froydnj@codesourcery.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Julian Brown <julian@codesourcery.com>,
 Daniel Gutson <dgutson@codesourcery.com>,
 "Maciej W . Rozycki" <macro@codesourcery.com>,
 Paul Brook <paul@codesourcery.com>, Kazu Hirata <kazu@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Meador Inge <meadori@codesourcery.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Schwinge <thomas@codesourcery.com>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Andrew Jenner <andrew@codesourcery.com>
Cc: Daniel Gutson <dgutson@codesourcery.com>
Cc: Joseph Myers <joseph@codesourcery.com>
Cc: Julian Brown <julian@codesourcery.com>
Cc: Kazu Hirata <kazu@codesourcery.com>
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>
Cc: Maciej W. Rozycki <macro@codesourcery.com>
Cc: Meador Inge <meadori@codesourcery.com>
Cc: Nathan Froyd <froydnj@codesourcery.com>
Cc: Paul Brook <paul@codesourcery.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Taimoor Mirza <tmirza@codesourcery.com>
Cc: Thomas Schwinge <thomas@codesourcery.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 3e9602287a..4850eab4c4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -21,6 +21,7 @@ ibm.com         IBM
 igalia.com      Igalia
 intel.com       Intel
 linaro.org      Linaro
+codesourcery.com Mentor Graphics
 microsoft.com   Microsoft
 nokia.com       Nokia
 oracle.com      Oracle
-- 
2.26.2


