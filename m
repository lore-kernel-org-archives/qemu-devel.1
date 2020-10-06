Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F29C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30764206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmWCWqiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30764206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpeW-0002vD-64
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUY-0005kM-D9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUW-00040L-G3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id m6so14142193wrn.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tMmMB+1b97oUYovximvYjUvW3SGMJjtaxcXoxHbshwY=;
 b=CmWCWqiBJcEFbmkN+Do8FhMFwcfgsp0XV3Ssev9+dSEPo7OAtqoUN4bihUBRAv5Se1
 MFHuXAsRjpJ2wfxmtz58Y0zwPaK5SN7UKxWsnVphBoAVmKXQGPhv8SqDfYr3Umpt1QWh
 qMz/fh+5qY5OmGPLSbIQFovA+kaTUZwt6QeAJ3hMn2TRfIfSqKgzIi8J9Q0WkPHIo4VF
 33jwK2X9IIOKqh4QJT/bXX7jn4eNpjEceEjSU2+F+fGJcVQ890yJ8uiU0aIMIbbymJJT
 ULupBuuj8J5M5wvz6PDO27fEhvXOEJAj73KLkkb+ApFfL5n9uK7rQkFFe4BVefXuTeVP
 iL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tMmMB+1b97oUYovximvYjUvW3SGMJjtaxcXoxHbshwY=;
 b=pe1Dj6mKupB3Ff+iw9cukNX7gT/2CzaFgSXnj5MCwYVemkhuxeI8kwloSHl4NH+TUC
 vbNo1nZmetk5VkqKzP5PzuS3yduNdgQoUNzCSs+tYf85E8TDUHCxHJyRfMFDZr9t/iM5
 Kk7vW310sM7dz1LNs0KPlh7PBPYBgv2CxReqBy0uTi7GxDaQhHgbXg4PCeRHBfaOWpwR
 i46foXRFZwsGhXb8Ko9DshB/QuG3jlXcDigyWWeLC3w5F7u3N+K9NRkoWPskirVG9wqM
 vF6S1E9Fu8mwFWreOnqrFXwmMwmuanbthD4glAgwQFbNoNx5jZ5D1jGeDF1fdNUho+/K
 Q5lQ==
X-Gm-Message-State: AOAM531s3BBjU6UjsT22Um0DhZ7t4AKOr8J9K+UeBB1AgQ0i/U2HlmO2
 OIZNQyoRXNVd+ALe9JxstDM=
X-Google-Smtp-Source: ABdhPJzcmZoR7woxMMW09JP1+R+ceVYnEPOP2z6MPsd+JpB77Ii6HUkI/r5JRs6z6UFjfrm6qt6vdQ==
X-Received: by 2002:adf:a306:: with SMTP id c6mr5756003wrb.160.1602000423234; 
 Tue, 06 Oct 2020 09:07:03 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 06/12] contrib/gitdm: Add Nuvia to the domain map
Date: Tue,  6 Oct 2020 18:06:47 +0200
Message-Id: <20201006160653.2391972-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Reviewed-by: Graeme Gregory <graeme@nuviainc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 72dc65f2b5..14c0582060 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -19,6 +19,7 @@ intel.com       Intel
 linaro.org      Linaro
 microsoft.com   Microsoft
 nokia.com       Nokia
+nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
 redhat.com      Red Hat
-- 
2.26.2


