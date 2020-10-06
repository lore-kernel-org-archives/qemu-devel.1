Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546E2C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE48F206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDyrogcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE48F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpft-0004ml-JP
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUf-0005mq-BJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUc-00041H-1F
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id d4so3470064wmd.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q2LHzlhge5Rgv4oI7mjbR3wKTeQvCce3FDTPgBxJTKM=;
 b=pDyrogcCwyrxbjq7tT2CuLBT1vcISKXy+g12lkQY0prpCySp84N6EoKOWVxCZdFIg5
 SOqLRN/YlNz8Vtolx0GV3s1dz44BMnsPxUlUUsjpakReLwCXn5BGYwu/HgdGHH/qvidY
 DqS1O0ISWQGLUCsyQKInlQs01d+n1pIJREEVCC4wJI+5XwsB4bpKSmpflQz7DyWBNROK
 REHzk2PFiPCBx/Q1hNLeoAfjCVvoRU28t4M39mJAhOnUrfgTw5SSXTlfzFW9Waa6lpFl
 yOwegagZ0NUUP4CtZA/IbJZvcLAH0OcITJsdbs089VEDnRYtU05Aap/QKygBwnmWoXip
 1ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Q2LHzlhge5Rgv4oI7mjbR3wKTeQvCce3FDTPgBxJTKM=;
 b=WAdMXOva6IWnyoApFPXBpdnXxfqozCMVamKDn28kKReR6zvIGWFtT+rTuaLIh0y7KL
 ghA8EBzebracBZXyutQp8ZPDHS9IwiwUbm9cGoq4YREZMyr2OH9/+z82t6xHuGL6TL4o
 cI+fSWiIFFYXpMtiayv84HbeUINzLO/5hXb6xVl3QgpJkp+li0evpXKIsGaS4yT95mvr
 qD0AraTt7NI5OBZ3lwMcDK1R0cVYpnCTf0gmLTFaP3CDegoIlqJxF0yBTVKzdeKf2T19
 tkJOhYUPaBW5HFsENFgVK95+4sAUVVXqpBY+0MvGFpJKfDUBVGsguMZvT2hQYzWKJQOg
 h5PA==
X-Gm-Message-State: AOAM530iDfopjiwbj6cLDZaQqusAS0vFy6k3DKr7GsSNCO0LUMZxT1M+
 eA/2LB7XQvZjmSpTCoVxIzGoX1UceBA=
X-Google-Smtp-Source: ABdhPJyJL0ek28GCEg8Emg0mz36XmqaCozSYK/NVlAnpwzqcuL0m1QFoYUrv2kzshy2jDfwzmyf5vQ==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr5457241wmz.29.1602000428742; 
 Tue, 06 Oct 2020 09:07:08 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 11/12] contrib/gitdm: Add Yandex to the domain map
Date: Tue,  6 Oct 2020 18:06:52 +0200
Message-Id: <20201006160653.2391972-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Roman Kagan <rvkagan@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Reviewed-by: Roman Kagan <rvkagan@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 1572070cf4..0074da618f 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -33,3 +33,4 @@ virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
 xilinx.com      Xilinx
 yadro.com       YADRO
+yandex-team.ru  Yandex
-- 
2.26.2


