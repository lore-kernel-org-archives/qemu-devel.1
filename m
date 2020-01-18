Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61EFC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03E24683
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0DBqm5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03E24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istsH-0005jm-6q
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1istfF-0006Eo-OR
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1istfE-0007eB-Oz
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:45 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1istfD-0007cQ-Lo
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:44 -0500
Received: by mail-wr1-x433.google.com with SMTP id c14so25719812wrn.7
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eSJ5RiGA8vwSibEvx3Rd4fHMW4NWqPux5e84DlCysSk=;
 b=W0DBqm5aNDmJIK5mu20lZ8JlSoEzsZQsZpQER1dYnw/ys+TULDdxPiu9m7xlL79oyX
 k1yajYgT0+WSb2Me8WWg7dIwtHt+mPNw3kmkmF5EXWGV4Sp0TtnwQPF7cPv5xEvA3imF
 Ze0WgNTjg9JePXndgX+OtMSLrSWP46BdY4fyYC9icOG82slb5l9dxqRqTxzYm1en6UEs
 8tVYOGRzgPtt5gnqejq5OvYROplC0D1JTQ+apvxrDofde5QVwavx8jsG3xxoVBwfFQNo
 /kmKbSn/QSfSVwRlfgVy/UsioWc+mNupksarGiZJSTeSpGVUtmYh1wT2Nne9fri3ZLnH
 bJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eSJ5RiGA8vwSibEvx3Rd4fHMW4NWqPux5e84DlCysSk=;
 b=VHR1kKKXskx+hQgDoe83F9quvgLWhH0+YxCWVU0bl0i1re7XUQ3C2KqRyjvMjDbFYu
 bTWlql6Yf/BOa5m7t9aZeVXqM8r0Q7kPnNAtYH9Baf0z6jtI9xrUNyZSmwBxqf39jpCM
 4/3Tn+vd2FjOJxVhEprIVogtB7GQi9/pSsdUGsG+VWwh7rciZYXuWYDszF6LwDAnarzU
 GGcxyc1aYvUJPVz47BekdoYtyO6tN045kAymAUg9fiaXONnCQ+/snTHIzLQTn66j9y4j
 6Jjb/MbXFuQ+MLcEmSPH/S50wNUo2/3K+Ijd+dCJrv5oPHUlxnOCLn/B9La+UBAFmfyo
 rliA==
X-Gm-Message-State: APjAAAWUFGgzNfGhN7BrYnpEnAlbGILZdeCV19VIJOgw3jwUwLJq5ePf
 BCuFIY7lCXXktAyiA6vNIQT9WZfpotTA5CyR
X-Google-Smtp-Source: APXvYqxO5dG8HE06ekjtP7x6HLVPJ9GeCpbre2x2yQj20TiMBHhdxz8g/3haKQEUfZERCuFs6w0WhQ==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr9481341wru.382.1579375302226; 
 Sat, 18 Jan 2020 11:21:42 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-108-13.red.bezeqint.net. [109.65.108.13])
 by smtp.gmail.com with ESMTPSA id o16sm2875468wmc.18.2020.01.18.11.21.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 18 Jan 2020 11:21:41 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v41 17/21] target/avr: Add machine none test
Date: Sat, 18 Jan 2020 21:14:12 +0200
Message-Id: <20200118191416.19934-18-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200118191416.19934-1-mrolnik@gmail.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/qtest/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
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
2.17.2 (Apple Git-113)


