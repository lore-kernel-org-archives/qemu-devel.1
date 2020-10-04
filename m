Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A73C47095
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4061A206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X//18Wso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4061A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Tf-0002BP-AZ
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nh-0002Xu-Av
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nf-0008KP-GJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id v12so6559643wmh.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SbkTu/IhMJ/C6IJ2FiboW4MDdddpSWQsUo8c159m5ZQ=;
 b=X//18WsoxtrVC9prukqpDF4E4Vh0SI3FeLzxJV3/wWJVeLWaNZJ7CHAvjeqobUKp7Z
 VcR2ETFIR43Y5FQa0cV/6tpWQRcbC5ItTHCBPQgaW9zu1vGaC6nCB6hCrxmkMfjW1GPc
 Al20gDz9PPnpoWeRP2ZWCKkfN70bzPqzD8FvW5DOsiHSVQWXrgTgqp0D9i6J0doXRMU4
 swDaXZua2DGU1eVXhbiJp7EvRKxABmybrPqP5EddMI05fIiTw22v/jeyU4rSpaQdQ7C7
 Nz3+1msmLzq8swBG9dKHCQh/GQiXFbo1po2/Ud0Ennvvb/lOLmh+0QW997ojgtP4a6oN
 A+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SbkTu/IhMJ/C6IJ2FiboW4MDdddpSWQsUo8c159m5ZQ=;
 b=nxh4uI1toHrmP/xgk/CY4r3Kg8UljfbwmUpFAYSafiDzz8/o7fifZOAzB+gW87Hsrk
 sVAQqsG5wtL/oSKUqiPgswNj2wAPAS3UMNc5OXagrw+3G++SzVP9t8ief64vsJ18uq0r
 lTuelK254unqOqFJLnfc9q/NJviSggt0tQ8LLcRd51ciIpllB5Q95FxF/zqB4BU+EFq3
 kw8M0JjWSzmSt9fVAAtvi6VZ6qHnySaqnQJXpan9Gd9WubXD19j6gf4jL+KkgrxHjpF/
 R4cGZnCTjhgQOp6f1o4JE3WSCdtdHBu6pVTD8maAJN7MxaX4FQxpHLB9pKVBhJGOIGRl
 EsWg==
X-Gm-Message-State: AOAM531BAA6G9sdZvSal8Y/o+17lG5py0wTpUDoTk5HURERnYN7JqZoo
 jK/RZML1YGSTYKrCwifruaDoKmX5y4dG4Q==
X-Google-Smtp-Source: ABdhPJxAHf1iox4SWzTTrAZo2TGHlsLeCzh+c+Diu8t5zbIRb5QLBsw4zS4TW3k6gIThkQm+lPUJzA==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr8931201wmi.73.1601834706062; 
 Sun, 04 Oct 2020 11:05:06 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/21] contrib/gitdm: Add Samsung to the domain map
Date: Sun,  4 Oct 2020 20:04:36 +0200
Message-Id: <20201004180443.2035359-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Sergey Fedorov <s.fedorov@samsung.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Ilya Maximets <i.maximets@samsung.com>,
 Sangho Park <sangho1206.park@samsung.com>,
 Stanislav Vorobiov <s.vorobiov@samsung.com>,
 Mikhail Ilyin <m.ilin@samsung.com>, Igor Mitsyanko <i.mitsyanko@samsung.com>,
 Mike McCormack <mj.mccormack@samsung.com>,
 Yeongkyoon Lee <yeongkyoon.lee@samsung.com>, Pavel Fedin <p.fedin@samsung.com>,
 Maxim Ostapenko <m.ostapenko@partner.samsung.com>,
 Mario Smarduch <m.smarduch@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Munkyu Im <munkyu.im@samsung.com>, SeokYeon Hwang <syeon.hwang@samsung.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Skalkin <i.skalkin@samsung.com>, Maksim Kozlov <m.kozlov@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 YuYeon Oh <yuyeon.oh@samsung.com>, Oleg Ogurtsov <o.ogurtsov@samsung.com>,
 Jaroslaw Pelczar <j.pelczar@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Evgeny Voevodin <e.voevodin@samsung.com>
Cc: Igor Mitsyanko <i.mitsyanko@samsung.com>
Cc: Igor Skalkin <i.skalkin@samsung.com>
Cc: Ilya Maximets <i.maximets@samsung.com>
Cc: Jaroslaw Pelczar <j.pelczar@samsung.com>
Cc: Klaus Jensen <k.jensen@samsung.com>
Cc: Maksim Kozlov <m.kozlov@samsung.com>
Cc: Mario Smarduch <m.smarduch@samsung.com>
Cc: Maxim Ostapenko <m.ostapenko@partner.samsung.com>
Cc: Mike McCormack <mj.mccormack@samsung.com>
Cc: Mikhail Ilyin <m.ilin@samsung.com>
Cc: Munkyu Im <munkyu.im@samsung.com>
Cc: Oleg Ogurtsov <o.ogurtsov@samsung.com>
Cc: Pavel Fedin <p.fedin@samsung.com>
Cc: Sangho Park <sangho1206.park@samsung.com>
Cc: SeokYeon Hwang <syeon.hwang@samsung.com>
Cc: Sergey Fedorov <s.fedorov@samsung.com>
Cc: Stanislav Vorobiov <s.vorobiov@samsung.com>
Cc: Yeongkyoon Lee <yeongkyoon.lee@samsung.com>
Cc: YuYeon Oh <yuyeon.oh@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 47522dff02..77f2a140cd 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -31,6 +31,7 @@ proxmox.com     Proxmox
 quicinc.com     Qualcomm
 redhat.com      Red Hat
 rt-rk.com       RT-RK
+samsung.com     Samsung
 siemens.com     Siemens
 sifive.com      SiFive
 suse.de         SUSE
-- 
2.26.2


