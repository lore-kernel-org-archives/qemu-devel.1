Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F93C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0087C20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMQFU9pB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0087C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3MC-0000li-6R
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3Ac-00043D-HO; Thu, 02 Jul 2020 13:38:47 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:38226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AY-0007Q3-5J; Thu, 02 Jul 2020 13:38:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id n2so15810569edr.5;
 Thu, 02 Jul 2020 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6O1epUu6iAZ3kh0hRgn8zHID1usD/zp4yuJGkIMs5lQ=;
 b=lMQFU9pB7gc8lw8bRwTtN9ja+jQj4sYgL6EQ/k8iOXk6qHPYknZPhWgU83AHCGaaSH
 dl7TzhrHqFp8lFGxpnSbkYLcICLbBg1phYROvOMh4uFxwmI5tIVausRAx1Ki+JNSluIu
 epb1KuoEHEz45v0jO1ElqFRVbE6wNaXDjkZrlKzQ5Rj6g8YR6lAOjHRAuLNkN0ZXIcIm
 k/+9k4yLEdeMov3PhIKUT9jDlJfEYeyWKuBKZ07MG6fX5LAoDrfutyzLjJtesxib+VFs
 /SnjbkVGDssKDRnxsKr2+1LkQc4mpOVUpoyO3dNs4mtuH9+P81SnQeQvDsVX2zfeUn4J
 rIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6O1epUu6iAZ3kh0hRgn8zHID1usD/zp4yuJGkIMs5lQ=;
 b=RxzoEmitDVhk3o4R4MgYU8KltmMk2+XQ1AGVh8r2t2r+XY5OZNXs3S2jXnNC/A4XRB
 2evBvOIIoa1GAzl2cs2GbUlEuWSZ3Y8DUm8IvKlAAUTxNGDj1R7VnL6K+TgEtmHMyMB/
 VvAHLNYMT+/gKJMh9Tbgl2GdPit6ej1nOOyyxXAFdh3PwUHl3Dbk5O6Qvz2BqKoNCiKv
 3dOmvpcNUdiBPplmqrTOl3QgA5AqIsnVmqYrdzjyZEd5K2bxJ4EOPwcRlAZe5o7ms2Ry
 RFhYPe2bS2tcBsq0wp2Nng5OGgJVsRV1a49r6PRczJFdei1IN6CES9VvUq8pJSSnuLA4
 ytag==
X-Gm-Message-State: AOAM531/ZDxctTDPJtT5DiA7AGh88olKxZ2w2481BVxlZooG9oUA1I0v
 RLec/g89ma3RNJbmlrk+ve1VgQ9nsFw=
X-Google-Smtp-Source: ABdhPJxYdulDrDzFtHt+HC/GlwB9qBvYZdMZek1nauP12lORAicrQcsxY+PPF2xZK79Sto3WNzz9Dw==
X-Received: by 2002:aa7:d283:: with SMTP id w3mr17098563edq.76.1593711520223; 
 Thu, 02 Jul 2020 10:38:40 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/19] .mailmap: Display correct email address for Stefan
 Berger
Date: Thu,  2 Jul 2020 19:38:16 +0200
Message-Id: <20200702173818.14651-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Stefan Berger email address in the following commit:

  $ git log --author='Stefan Berger stefanb@linux.vnet.ibm.com' --oneline
  4a42fa0ee2 acpi: Update TPM2 ACPI table to more recent specs

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b06baa094e..67f7d5caf2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -155,6 +155,7 @@ Roger Pau Monné <roger.pau@citrix.com>
 Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
 Sochin Jiang <sochin.jiang@huawei.com>
+Stefan Berger <stefanb@linux.ibm.com> <Stefan Berger stefanb@linux.vnet.ibm.com>
 Takashi Yoshii <takasi-y@ops.dti.ne.jp>
 Thomas Huth <thuth@redhat.com>
 Thomas Knych <thomaswk@google.com>
-- 
2.21.3


