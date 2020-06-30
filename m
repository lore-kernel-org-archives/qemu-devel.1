Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2FFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B727A2078B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWz6y/qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDCN-0003bY-WC
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7F-0002IP-GV; Tue, 30 Jun 2020 06:03:49 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7D-0004bI-6z; Tue, 30 Jun 2020 06:03:49 -0400
Received: by mail-ed1-x542.google.com with SMTP id b15so15591609edy.7;
 Tue, 30 Jun 2020 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZtgcwLm+oPvDM0rBUBUhyO6syjgVWMHkfRFyMuMRFYE=;
 b=CWz6y/qM/FM1kLLwVrv7Rp58ep2HZ3jXLn6EycnQgAWdxTe9E28VKwZPXe9KBlHyPJ
 O+TWOXa2zRruy3KvWsrhCTGb+8m36VPEzc5P86SClF8IOTgIK6tYpQavEL9WbJBe/ubX
 G7P+ItNa6cCKDcCGHpKLMT2LPalLJn0Rl/5f1HPHvZvvzbGRec6FvV4uvLOhKkyEfebE
 gTT2xjlKvXm9YZVovXNCTthmi81mMQ6P3UG8bh6W+Z0bfzZ2TxaiwcvLIELGYkmAIcSy
 HeUOlASYHO1DFrFCGbkLZeaorJo0nuh5c7iJ40wqnIgi4gLE0ey/BFufgx7IbmMZrFBu
 NjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZtgcwLm+oPvDM0rBUBUhyO6syjgVWMHkfRFyMuMRFYE=;
 b=aQQDa+EBschkUtfYFjADIPLjTFS3cVw0MELTUhyLoC02Ce27GMZ7u1Auw6g8eRD6dG
 uFM56awIeeR+J9gH0IeIfBDj2dLYo8b7W3YO3qOsLvVPW05dWb9LlBzUGSi/74+rQLb+
 sRrRCI+3Vey6RwAEeBeln1qmhNPbJfjlQGpoJD8jmkeAiSQTOxHbRnzlQM8Skt3tYghr
 uCvDFCRI0bFgmxnq7OxW32ppmS1ftT6GJZQOKgg2a1owszt2Cto7IXtEfUIbqLmdpMIC
 DRaBbY5FxSdz6oWqDQu9Ml2+V87zXWw+pMQUWglVaH5PZRAVOOUDdxuQy9QN2D7wXY+F
 WMMQ==
X-Gm-Message-State: AOAM532NnVIn5AbqJa8xSAaBN83uFfUUY/YALXQt8FZOykZ3lEszoYoS
 pj6MpyKbADpMpp5nYpwq6VTgUT+yCo0=
X-Google-Smtp-Source: ABdhPJzXULjQs0VOJsgCNZhzvvi3XfavAABn1GcURP614TMxhXNCjSQsnX2VbYg2T9rehXAoIT0l8A==
X-Received: by 2002:aa7:c496:: with SMTP id m22mr8886070edq.336.1593511425216; 
 Tue, 30 Jun 2020 03:03:45 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/15] MAINTAINERS: Cc qemu-block mailing list
Date: Tue, 30 Jun 2020 12:03:28 +0200
Message-Id: <20200630100342.27625-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We forgot to include the qemu-block mailing list while adding
this section in commit 076a0fc32a7. Fix this.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..9ad876c4a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1628,6 +1628,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
-- 
2.21.3


