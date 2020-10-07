Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1433C4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324932173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E094pBIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324932173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCNN-00057W-RV
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsI-0005KI-JL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsE-00012c-34
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so2796161wru.12
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wShbQweM0QLxaD503QKQ0af5y+9OSC+PsKcb/w2fncE=;
 b=E094pBIkGIt1sox6YYa0IhP7m1MCWbp2mXmtvLRokfjY8H8vnsfRB7Iy9U2x9qLBKh
 21HgNzGUfZ2wkmaJct6ZG4vRJMKJSJ1YqY33HwESBn6yf8NdocwSGzn4NPQyW+CHu3uL
 2RDhS2Bwi42a5EqKgLnRBJ9LtL/jAbLEromDJeqNxEGDQqmb0R2WoPat9uWmt286ovb5
 R24o+kM6AzgJF3cWLBCZoLuwwEv3f7z/6hvuvIgur4Ki6eojyKGe4CB56FV0aBEkuXt0
 GnC0QClfk3bJueZGR59VIWcGo4euvoKKVTeLQh4qx5HqMIPnaEDR8TC8TPVOGBexzNjY
 PEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wShbQweM0QLxaD503QKQ0af5y+9OSC+PsKcb/w2fncE=;
 b=b6OYQAUi6SHlX05/hiEiWjE38+N76TkFSNj6YzgnJRK2xZp/TjW4P4WicKoUguGpCB
 i1kn5ktTF5/okrNmKnnZP3cFdbxnouXNp5zpE3/bDdpEn8vgAzbKDv173DFfBqnrDaO4
 ypTdvC9wjOfaus5CAQuGdA4cNcUAJOyiZwQlm5r+7RAZtDyglIc9deew5GJ9iaqFqAUc
 SYI7FqWH8T7ZPxWbdWvV6IrtTikTo3mBrWyli6oxZftOqEg9cxKeAQ1WcRStCVW3xOxQ
 QJb9GtfDLeB7xSJdqBsdGQg7801ENh+hB4G/NwHFmELSsuaZ2FSMNeHePb9y84sW+mqQ
 8fHw==
X-Gm-Message-State: AOAM530uB75o8bWIrynwQRHDoKzC1FHlQohbeKiT789ti5QvpgzK9U0Z
 IaHpeoezXRkVe4jCbYrnvETk4g==
X-Google-Smtp-Source: ABdhPJyJWbsmOeHRCeQ86YWwUjbNw4fr/+jrwq9fxk1B29nj9Vas3bqs2QBvQNQLMb+Rj5FHxfcxqw==
X-Received: by 2002:adf:82e5:: with SMTP id 92mr4156569wrc.192.1602086455739; 
 Wed, 07 Oct 2020 09:00:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b189sm3107063wmb.37.2020.10.07.09.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C567E1FF93;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/22] contrib/gitdm: Add more academic domains
Date: Wed,  7 Oct 2020 17:00:23 +0100
Message-Id: <20201007160038.26953-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Dayeol Lee <dayeol@berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Xinyu Li <precinct@mail.ustc.edu.cn>, Alexander Bulekov <alxndr@bu.edu>,
 Fan Yang <Fan_Yang@sjtu.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from these academic domains.
Add the entries to the gitdm 'academic' domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Dayeol Lee <dayeol@berkeley.edu>
Acked-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Acked-by: Xinyu Li <precinct@mail.ustc.edu.cn>
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20201006160653.2391972-2-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.20.1


