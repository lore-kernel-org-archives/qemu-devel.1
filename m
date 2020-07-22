Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9865C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957C720656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbhRwC7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957C720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8IM-0003cP-Pl
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fb-000713-DK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8FZ-0006uE-NO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so799447wmi.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VATDeEmHe81iWlkc3YdJcm4+JPfu8GfZbyW4AtdCEog=;
 b=YbhRwC7NfCDVUmdjnWcYy5uHKivpP9KWc0ust5RdVP2W8qHmMZbTfHW+7q30/cn0/1
 ojvB81uUmP0B4tV/PjO7egK42JMDzSDH4BE4wncZTGzIbBWsDxJpqOf9VGu6+TajC8vZ
 b/aLnuFRfySeujFCts9foVKhC9gCadElMzuz26nWejgoS5bmq+Aq63QvcyV3RJ4EOkfG
 4grbpXNDUvdkZuG+0hVk00FcTJXBQIhihCRkJ3IR35/IBopFX/7IIl4USFmnUzVKcyCg
 5MzgVgfz0pFaFG7QNCrMvyNHsVt6rfPXkXMvnc2DRUCNxtuO0IkXc3XwuhfzWnlYmc1v
 KWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VATDeEmHe81iWlkc3YdJcm4+JPfu8GfZbyW4AtdCEog=;
 b=FirsVgZIcgzjxfdDDi1NmAwiPbAlIewL4hCbcrBgJ9Fm3joOVfZlt0U0/kT29KDKfS
 Wfsw03SxCr2lyfTF13a3FcekZp3XYyuDFF8T6F8zRFgMsDHtg32caC5rF21wZgrLd1VB
 eHSRWQNw4+5Vv/xDiUykkfs1btvD30VZJZB2DoQ6XNtmTNEc7tgJO1/6x52OipeaN0cJ
 LQMHj2BOXHVw1YzrDnTnEvAeG/QZGRMB5Uj3i/43Ku/8ixrWAy/ez1nwlPV/Pt/wDLuG
 QVIhb6w50NOQmsWZU3Ioh+jfq1gpT/Kmm2FK6dVQ778UTaZiaPC06Oe5c+CXIyHrSalE
 apVg==
X-Gm-Message-State: AOAM530hCIHeAjXLSCUraQ2vbS3TYJLkGUhCfBoi8SppYnEFB8O5rfTU
 /k3czCtpXyDnjEaXkFGGwFHgcA==
X-Google-Smtp-Source: ABdhPJx1icjXYHeus9S5zNLsWayQncqes+KUrUYVVqTUV7BSoBGhY/hawVUhXM+DcPMTgbeqb8tn+g==
X-Received: by 2002:a1c:2d89:: with SMTP id t131mr7419311wmt.151.1595399348037; 
 Tue, 21 Jul 2020 23:29:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o21sm6122615wmh.18.2020.07.21.23.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28CE91FF8C;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] semihosting: defer connect_chardevs a little more to
 use serialx
Date: Wed, 22 Jul 2020 07:28:52 +0100
Message-Id: <20200722062902.24509-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

With that we can just use -semihosting-config chardev=serial0.

[AJB: tweak commit message]

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
Message-Id: <20200717105139.25293-3-alex.bennee@linaro.org>
---
 softmmu/vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index f476ef89edb..4fedbe60c39 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4131,8 +4131,6 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
-    /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
@@ -4281,6 +4279,9 @@ void qemu_init(int argc, char **argv, char **envp)
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
+
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
         vga_model = get_default_vga_model(machine_class);
-- 
2.20.1


