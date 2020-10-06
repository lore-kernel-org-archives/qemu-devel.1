Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929AEC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18543206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCn+Yuc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18543206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpYj-0002pR-4y
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUS-0005hT-7w
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUP-0003zX-TD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:06:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id o5so14107169wrn.13
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zgBdg/ROZ8w7930GlXQuz1GBCyNH1nekEw4y82IwPns=;
 b=bCn+Yuc7g0jPzHmtDLzBf+0u8sovtlvvdfPWjoV1tQOtdDAzhtk/fVZZhQ9GwHnSi1
 iv7VdOcVAk2DNbGK27MhoeUS8pk1qa5BjaaL4C6cKL3elbVhrfbhmN0p5/UI+zRE6zDo
 hB+mGOzxu52al2OIGGpjC+HMZFMBS75IWoYq/fv7NOeB2iCwrsIa49raakgED2ZASmoX
 OWJvMgzDDBwOe29si35jhH+iWHvLXfaJIw6m2qj7MTVXw6OQ7776V3GTkESdANRWi0UT
 ogAW0Wr7oS8/lvmkGck84PzTw4JeNIw6TP5KtvSwyMKc/no/dyLlAy51NhCqTfaDf0pu
 kwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zgBdg/ROZ8w7930GlXQuz1GBCyNH1nekEw4y82IwPns=;
 b=Wae1nz6Pv4qQc6jxyEcd+ggVh2jUWmz9raxq+R/v3WKCg+ud/PP1KdWiiYCc4auGsP
 5IHFXF6ONEjacM4aiX9QoPSMYW+1GGc4EuHD5tHO9unB77/B6qIic2QYehlYvyEIRDhp
 ZhgH2S5KkRJT5CjSimrtYnHRH9glzwwDtpC0nalR0wYfrxRaWbIUg8cdg5KzJ0qsUuh4
 vU0XzbSY9AyVflsxTTkEdGplN9QM6KJ626BWNneIybja4Ev8hTBOsu94dgQSwY+SqhXd
 vZdKG6GO8+zh8wFYY7v7AbiQZXylP92zlOza9kHaCSbo8hG6uiRmL0iUEDl5teE61GMZ
 2JQw==
X-Gm-Message-State: AOAM533TL7zJVd3bQ7YMEllYUQzQ6EMD+s5N7uKLcqqsGkgRoutOI/Pt
 5SHhnjMR3H6HJEXjeuUYEGs=
X-Google-Smtp-Source: ABdhPJy7N1eV3PTYU5/6F10QznJ5TfpX1LSAPQBr/5OPR6eaMxWLSKpt/9V49ey6INkU9v5tUHiSEg==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr3333082wrn.52.1602000416373; 
 Tue, 06 Oct 2020 09:06:56 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:06:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 01/12] contrib/gitdm: Add more academic domains
Date: Tue,  6 Oct 2020 18:06:42 +0200
Message-Id: <20201006160653.2391972-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Dayeol Lee <dayeol@berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Xinyu Li <precinct@mail.ustc.edu.cn>, Alexander Bulekov <alxndr@bu.edu>,
 Fan Yang <Fan_Yang@sjtu.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from these academic domains.
Add the entries to the gitdm 'academic' domain map.

Acked-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Acked-by: Xinyu Li <precinct@mail.ustc.edu.cn>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Dayeol Lee <dayeol@berkeley.edu>
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/group-map-academics | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 08f9d81d13..bf3c894821 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -12,3 +12,7 @@ ispras.ru
 # Columbia University
 cs.columbia.edu
 cota@braap.org
+
+uni-paderborn.de
+edu
+edu.cn
-- 
2.26.2


