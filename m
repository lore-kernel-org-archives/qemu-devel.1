Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82388C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E8822B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC+B0VRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E8822B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUkK-0000qQ-LK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxUjB-00009T-Gi; Mon, 20 Jul 2020 08:17:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxUjA-000236-2h; Mon, 20 Jul 2020 08:17:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id w3so24933213wmi.4;
 Mon, 20 Jul 2020 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hAik68VM6B//VrwGp6oJpnrHK7/B0jquEylvyU9zG58=;
 b=IC+B0VRHNNnWAGkJ76RSkqojQL2J+6yNg136gTyUuuAq6Zs+9//IxA690VP/0tWz9P
 9On+AqDg0YYxNzWRDItDMkh31flCnDXnovnFbADtyID730uYS02KWJ9FYnZ+Z7O+ag7C
 b5RLNxSIBa8l9pBjg6C0zLkTsj3SG4IjiChPFrN11E71XIRL2FOcEQ3n0j1nKFt6dUND
 dldOqGLG++lhG0P0OK4ghqTWAUwKAaw9v98+JcpEW3Ei4bRzpRzBPrZheETfheMbLrKm
 40fHlkv1DYuewvsOXpiq1r0QJc7dFFLQ9SJ23eJ2RJ6OuLO31yz/fB+IrIajT5Q888e4
 S9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hAik68VM6B//VrwGp6oJpnrHK7/B0jquEylvyU9zG58=;
 b=B59yW6s9jNX0ZxtnaeQC5HXnq/MYmeoinyU7yDf1pRyw7jc1l6dEqC+Z1MHmYRZr8P
 juKM3f6cUWJIbzAkvWl9Q+qh329u798Ij6FEFU7XxqnOhsPbzhCXKukie/KTvdaj5ndI
 YzIU+dyu09JHozDhqZGXU6GEwk8yD89KMoORvxulE5glD872ddclmudIsgJtMW8wqjSc
 qjpl+uQKjx4BAj+wdR3O2f3V7fAqDF39kteAAaAZjcUjfEMjNutFAlskkSh7rcuzvDPw
 PqH7XcZGF/qqOaoPFaIc0UfnZ8jb6OhHvxDquqym9bGu10+8A/kwT+wjPBK9OjR/Ri0t
 Hi9g==
X-Gm-Message-State: AOAM530q4Y+Y1G0TeUwDJjj+Q7rRBp7rHxppd2idt6J7Gjllw9qaO01f
 gSagk7D6Cu+LClnDIM88d7NrrmGgHmI=
X-Google-Smtp-Source: ABdhPJwIrOcJEcWxlBoWCCsIa62sqPJz65qWYg8EWADpEwuklVdff0cORj2ML6o3himXMxUlaOgjsw==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr22471981wma.66.1595247422056; 
 Mon, 20 Jul 2020 05:17:02 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w7sm30764365wmc.32.2020.07.20.05.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:17:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qdev: Document qdev_prop_set_drive_err() return value
Date: Mon, 20 Jul 2020 14:16:59 +0200
Message-Id: <20200720121659.31886-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 73ac1aac39 qdev_prop_set_drive_err() returns
a boolean value. Document it.

Fixes: 73ac1aac39 "Make functions taking Error ** return bool, not void"
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-properties.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 587e5b7d31..3a64d5ab9a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -238,6 +238,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 
 /*
  * Set properties between creation and realization.
+ *
+ * Returns: %true on success, %false on error.
  */
 bool qdev_prop_set_drive_err(DeviceState *dev, const char *name,
                              BlockBackend *value, Error **errp);
-- 
2.21.3


