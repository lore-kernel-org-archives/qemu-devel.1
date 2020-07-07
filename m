Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EDE20708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X04VdGBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EDE20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssHR-0002qL-Kb
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssA8-0008Qs-GQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssA6-0002uz-U3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id o11so46280131wrv.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FJkhGbusa0UakMrLvdJRQQgJLVFjiBsHuUfXktzAxYs=;
 b=X04VdGBRkay6t4yxDH0oLfDGVvQIrN0uZjYpRQIgox8cHKINGc7ryetx2dMzASIEa2
 pDUQ2Cfs5b5YvJRJqsBnx3aTDA5Eqt+hy3zreeTqjbX3n/8qyRzGUo/G7Ko8s2o58Z/y
 MFJkBkXQfD5vPZLSD+eNmx5MCMuktYzISpYlvusllI4WEA1b1lH7YIbMpNjAyTtmMNCK
 M3Lgq/RFz7rECTSwSMz+g1FTLrBpR0VVIr4miAzUpWCJ4rPrs/OEzajN7rhkAq1WXyE4
 jWTebrQ2DpktQ8pus3SAFtXvTdTUF75Q9QcFxJ4GAyx5Ibit/Z2u5v41R35xTpwyDaNA
 Jp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FJkhGbusa0UakMrLvdJRQQgJLVFjiBsHuUfXktzAxYs=;
 b=IzKEXbYw6sgWpGDjzm2Dyn45K4SAO21oJCo9dah7LjTcttAA+R18M3bGzALVw/w0i4
 TXGLXzIsetOIcswQZSTjayj/060y06fUZCAt+aBKdeWagl/KUetXJ6ZFiixHTSKKApkR
 pLFI7NUBT5O/6uQ/B+B9qsJ+E94Ud0Vm8i6hdWNtxPwMW7n3huBE145TfnwFFCpiZKLj
 j+qSRzvs5bKVdhGHXi81qBgFhSypXPKiU5Ox5dLJ1Barqm/WecVRypLjdFCBQ8wSbzyA
 QKC7ZirEhkiyHmsq3cFgdDVDxgfRCwD5FaJWqGF4+l0djO/7k2ag7LP1IelTVEM9WfBd
 qE2g==
X-Gm-Message-State: AOAM532u1luGjtIfo8V0opd/cGGH18/jnWNzb1Fv7hdbYvY0zTDDuSRH
 IpQlDpr6jcikq22hFC3rjky8TxzF
X-Google-Smtp-Source: ABdhPJzn5v6xj3V2KI9h1CCz/eYZS+u0UoBE1PU2WFQa7xYFAInrlvXxQ1Dpcaqro/T6rZ6gYzAbWA==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr55031389wrr.391.1594145865350; 
 Tue, 07 Jul 2020 11:17:45 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] tests/machine-none: Add AVR support
Date: Tue,  7 Jul 2020 20:16:58 +0200
Message-Id: <20200707181710.30950-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add a single code line that will automatically provide
'machine none' test.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-28-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 8b7abea8af..57107f1aec 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.21.3


