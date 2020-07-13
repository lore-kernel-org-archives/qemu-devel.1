Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998FEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E14205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFLbk5F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E14205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzMN-0001I9-Ie
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB0-0005T7-V7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAx-0006e2-Db
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id z15so16714408wrl.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2mJpCpL7EiAJWz9OGCJeMqrPYbEJZKGb3cEkeqQTV+A=;
 b=kFLbk5F3qKSufwcfNsh6oW+aSyB8MWoREaYH0gkX/hDIf/l9iBA7F+jrGVjMgYqDJO
 DmtY4eycpXOeJAg0Gvy4iXZFjhoWzxl63DoS6ydA4DzDJ3wU2slVodRbvzztSj9i77aM
 TfHpNxeNTq7iIcKG7Ix5nIB2zVeQEB4ZY0Y+us5zqmJZmNjF4LIkclayRZg/2cDirrkH
 Gw3Ll7O3urwnVvUSxLHQFWeG3GGB0Obb5oF7RaGF6yVf6Yi7uzPMU6Pz2tPw44rCHySx
 n3Bh5ALvrqh5T5fdfBggnvWW4ocfPLtu9aymPNSh7QO9dTALd9G9P6ouSnq/mhCfB8mP
 mF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2mJpCpL7EiAJWz9OGCJeMqrPYbEJZKGb3cEkeqQTV+A=;
 b=oARn/1hQpBl2TY3QPo2rYcVlt08l0/rUI4wK14H3LjxGXveSSNXxuJ7PGeWKuo/Njt
 Y+8flOsD9nO3uvJ10gW5nrwpZgSDxJXnjNig2gq/yEV6g3kUfCgwIVqgqxQA6ChXZ7h8
 IVH7BKLP8QlREMjsD2+P6oU8/km0o7B3KaFkhpPsmxnTcCV2Hp4mnMI2zfutloBfck/g
 tw3ovvK5UEnPI4L/OxTCDJuwm2IvMKVB2IonR30vO8lmYiWcusocsqQilEXgUFY0PGKE
 Zi7g3PyBoLvQB/kLdSC/om1/rAVofr/kxvJXZg4rg5oHXpi8UP9vzVK3N8MIQDRwdYKx
 RFdA==
X-Gm-Message-State: AOAM531XY9VcFziqgRIVZw2g4knXNCBsltbQfXeBVh+7ESqYbRCSAaEC
 /TUjvkNTu6sfkeXzfP2g5AZCEUsshWMClg==
X-Google-Smtp-Source: ABdhPJzcX8332YDxDyFCP3TZF3SY68vF2JgrcMM6+hCpnFet54W0+RE+qBgjGP1RIML/yzQUuGvzHQ==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr78535882wro.30.1594649481724; 
 Mon, 13 Jul 2020 07:11:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/25] bswap.h: Include <endian.h> on Haiku for bswap operations
Date: Mon, 13 Jul 2020 15:10:52 +0100
Message-Id: <20200713141104.5139-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Haiku puts the bswap* functions in <endian.h>; pull in that
include file on that platform.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-7-peter.maydell@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783e..1d3e4c24e41 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,6 +8,8 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
+#elif defined(__HAIKU__)
+# include <endian.h>
 #elif defined(CONFIG_BYTESWAP_H)
 # include <byteswap.h>
 
-- 
2.20.1


