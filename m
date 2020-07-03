Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C740220782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+1h7xye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C740220782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSE6-0000BK-QF
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9j-0008Ih-DK; Fri, 03 Jul 2020 16:19:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9h-0001W7-UE; Fri, 03 Jul 2020 16:19:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f139so35273024wmf.5;
 Fri, 03 Jul 2020 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U933YCgKd1+A6Uolo/IGnLda28QZSre3deH9GRO1CU8=;
 b=j+1h7xyejxpJU0hNn9JVbL+9yC/bMh4791EnOIaNTAQTvOkmqyKKHoLeH221h2QSMf
 Vt302dYEZps5Ss+ckDR5dRmBiVG7/kQf+ziQN01VsLyB3ra7YzZFvyDxw8VQYMOLvdLV
 HKLtmHtpF5LrOBvo8xMAegSfzZtZtSmhRaNzThQ9pj9fe2/ZpPon+OxrNiHUqeA8FtES
 wMycIO+OozHdkazRqyhbOhgLg5QTrbdwC4p+TUhJGx1k2wDxBTi+FVAYIFL/iuwAxlfa
 Lc276BgNLHGdYkYquPAqIMyRljh8GfHJ0d5CY0DLyEIsmmzeoS9iArPMBMO7al/2KDjJ
 LWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U933YCgKd1+A6Uolo/IGnLda28QZSre3deH9GRO1CU8=;
 b=RvJRTDHGEAfATWNJDOVofI0xNskTexDkUWl8ah7fC7whECUeEMYDkI9KlcCaAEMEMD
 219bD8Eg4/Z/kPLMo2Cz6kizYSAqorPJJJTbv6J4U3q2t+vlPbtNVxiH+CGdK8TI3lVG
 iYKIOEMFtRIem5xSs+B51MYaSxKvR1jX20ftqdg3OmTbXCh4RC7OFiyZd6BvYhLxNflr
 XSeb+ic4+VRYvIiiq2zAMf9XNXhklVuByE/Uxz+R0KKzntAMI50KIzby/+u2Hf1FN0C6
 9E4TBeEGTftaumauuUfVrPEP17SeA4/1prQGLXS9FLLJZPnrD+4lnQvROKZrLIXfbq5y
 zOBA==
X-Gm-Message-State: AOAM533POKsIvwn2HuHfmEiThhGnlEGDV5IrlRvn4SvXszA8fD1E3JYX
 zTPa06Ee+NjojPmKNEn8kzPsKfl//bk=
X-Google-Smtp-Source: ABdhPJzLyFZsAQ8AHMwJhrYdAGE0q9akAYl8+x6ZnyQrgiD7jHqYEPwBeDlH4X5JM0XnTk5s19uVRg==
X-Received: by 2002:a1c:d5:: with SMTP id 204mr37214066wma.174.1593807568172; 
 Fri, 03 Jul 2020 13:19:28 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 10/18] hw/cpu/cluster: Mark the device with no migratable
 fields
Date: Fri,  3 Jul 2020 22:19:03 +0200
Message-Id: <20200703201911.26573-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device doesn't have fields to migrate. Be explicit
by using vmstate_qdev_no_state_to_migrate.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/cpu/cluster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index e444b7c29d..95653a643a 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -80,6 +80,7 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, cpu_cluster_properties);
     dc->realize = cpu_cluster_realize;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
 
     /* This is not directly for users, CPU children must be attached by code */
     dc->user_creatable = false;
-- 
2.21.3


