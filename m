Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE192084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFz0hzlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE192084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3E8-0001O1-QK
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AN-0003s5-U0; Thu, 02 Jul 2020 13:38:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:45586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AL-0007Db-SI; Thu, 02 Jul 2020 13:38:31 -0400
Received: by mail-ej1-x62c.google.com with SMTP id a1so30708789ejg.12;
 Thu, 02 Jul 2020 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OypgoG/QLuK2sFiqZjxGaVD1WtdhJ5ElhJHDw5WL8n0=;
 b=pFz0hzlKIoHAUDS71csbAb20ApCn1GIsGv+K9hANTvWPFue0P6CLAR72KH8xPfNonI
 nEwUOHrffXpbz8XFXPIzeZduu0HH4LS5gUn2ttDe5S7SNjT8WwMPju/RKhKpx6i0H310
 J2etMpdtnBWSv1zexXaPVgUBn+oRQe75DQ2VNFd8l1fUvJLS7dw3wnVVHSjgKd+Kqp/P
 g/W9BXwTlqVTQFJTbu+ycOPj/LLnAlimpTaimnFqKcKAAKP2qLYd7Vize02iavpuzi/g
 lcIbuzExTN+mXG9xM9MccXCeIZj+H+hSYhY//o9M06UHFc/Xm+pOBJRztkCVwMu/gkIr
 HFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OypgoG/QLuK2sFiqZjxGaVD1WtdhJ5ElhJHDw5WL8n0=;
 b=QLlHitxSeUe6KzLinfnC2Qnk5L0NljXuizCrDgRWsIF+W+UFZUCIqh6VclxBk9pdhf
 BTgNSwao7HGAK+DjvgEQCX2l45tFZ5BdKAkZgb/C/pGojqGu4+teC6Ijnyal6U2CAIPP
 585wTF2HJ433IwffXVbo0j35MKzFkPk06HVOcm8cghPE9ZzbB19W1k3+sGoMNqKaFxI0
 7UbrnQ0/jErzEG/9bDORuBNrXZhJaWgSUNxux0CZCjJnw98rnxqG1uAXXw2b8GiU5bsE
 IGBSwYU1DIy6WaWeoE336tZPsFy8UNXcxSVkCFP5TNFBjS/cjloEW1aeMrewE35YEDmd
 +r9g==
X-Gm-Message-State: AOAM532wQ/ta70uvTfZR/39SOcabwwKzrLesxuvyiXWcZM6eL5RVZ44G
 nsPzVlQszfFYcnumDaLBfi6ac9OrPBc=
X-Google-Smtp-Source: ABdhPJxvTw3ObMrutoMVNesL+6YKPbxyXZIj71ll9vdq9lNr+k8gFBxOll7UHxC4RMZtSkdZfsZQdA==
X-Received: by 2002:a17:906:fb99:: with SMTP id
 lr25mr28490130ejb.49.1593711507422; 
 Thu, 02 Jul 2020 10:38:27 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/19] .mailmap: Display correct email address for
 Christoph Hellwig
Date: Thu,  2 Jul 2020 19:38:05 +0200
Message-Id: <20200702173818.14651-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62c.google.com
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
 Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Christoph Hellwig email address in the following commit:

  $ git log --author='hch@lst.de <hch@lst.de>' --oneline
  37d5ddd6f4 virtio-blk: revert serial number support

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 1d444e4fce..8c8bbcf2e0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -85,6 +85,7 @@ Chen Gang <gang.chen.5i5j@gmail.com>
 Chen Gang <gang.chen@sunrus.com.cn>
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
 Christophe Lyon <christophe.lyon@st.com>
+Christoph Hellwig <hch@lst.de>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
 Eduardo Otubo <otubo@redhat.com>
-- 
2.21.3


