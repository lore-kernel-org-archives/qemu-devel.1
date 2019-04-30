Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C3C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217DE21670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOP8JPe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217DE21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLScv-0002Xc-Am
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 09:16:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSat-00011F-22
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSas-0002Ci-4n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSar-0002C6-Uz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id k16so20992206wrn.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=I770HJlrpYyPcn2fSD+8YRmqIqI0uc6EiRRpIG177mg=;
	b=tOP8JPe0OmsP842zlxFqCldEBPL0wNOborCn+ovfk/7S+Xd1RatiuCilvKb4cpCr8D
	I8xMDb4DgZNAzBj4dgTceIqmmu/20I5CiKx4mG99HrL6K3f0ewrogSAdidxAs4kad27X
	jP46n2MjKk2doK6Vx7viTlfe4ZvsPri/R7nwKujiz86JBMGyTh9EXcEJfG8VIAH3XHic
	0Vgg89Aj1Mo4sVARzd+w4bEzFLSVwYfmhLZeTWyWjjyo2tKC/drwpeK+BJi3xoWrSqRb
	Y91jnfi6DoL4jm+D636KoZg+x7J0CZexxMOANrXu71IDF3Pq+umgW7hofG+DXcIo3kdn
	19/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=I770HJlrpYyPcn2fSD+8YRmqIqI0uc6EiRRpIG177mg=;
	b=QvsYRGxLHQqX9M52V7YjfhQGxyA1+dsYiO0xwLzvO44rNdZpqsIlvYMih2KnLzl6h/
	KvjHqXOLP02eW/LP/sfTZnDNIzRw2EXCqAYYkpQ+/XacmshuNaXwuluydPMev9zQz9sa
	lKL+25hh2vVb2XRRTxS/PlSDE6C423MGSxOiQJZRGsGUZe67mKKY0VWFhUYF3yKIOWTs
	AR7ZTlzavb/WwjYcqirYEaKhTlsVDfAQ0yL3O5ovYfa8VD2qbbJY1xT5y/y50+j4Vgab
	LxM07FsGp5hIqEieXVOkFGSAlVutf7vX8H0u2SXc5pGbeQ7Ccq2h3a/iU7fhP38Bo3kr
	bwpA==
X-Gm-Message-State: APjAAAUby5jh3ciqlVe9h3vN9yBwhOg4uhdjAvS0rb4I+KFzqJzIvPyB
	PmXcIAFlWncxpUgZGjZjhanVZN4hlSg=
X-Google-Smtp-Source: APXvYqyW8N/Da+/Voy2JopI4Qkkam6svOhkb12FH94m1vWGIbj8Pi5pRDghseF+qVavOoDWU7I9uLQ==
X-Received: by 2002:adf:b611:: with SMTP id f17mr21213990wre.162.1556630085112;
	Tue, 30 Apr 2019 06:14:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	a12sm16557460wrh.46.2019.04.30.06.14.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 06:14:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 14:14:38 +0100
Message-Id: <20190430131439.25251-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 3/4] hw/intc/armv7m_nvic: Don't enable
 ARMV7M_EXCP_DEBUG from reset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430131438.PTmHcGyKfBIiL7gzY75aAc3f9aklDNviaikGEnIkPuk@z>

The M-profile architecture specifies that the DebugMonitor exception
should be initially disabled, not enabled. It should be controlled
by the DEMCR register's MON_EN bit, but we don't implement that
register yet (like most of the debug architecture for M-profile).

Note that BKPT instructions will still work, because they
will be escalated to HardFault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 15cba63c964..3a346a682a3 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2491,10 +2491,12 @@ static void armv7m_nvic_reset(DeviceState *dev)
      * the System Handler Control register
      */
     s->vectors[ARMV7M_EXCP_SVC].enabled = 1;
-    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 1;
     s->vectors[ARMV7M_EXCP_PENDSV].enabled = 1;
     s->vectors[ARMV7M_EXCP_SYSTICK].enabled = 1;
 
+    /* DebugMonitor is enabled via DEMCR.MON_EN */
+    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 0;
+
     resetprio = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? -4 : -3;
     s->vectors[ARMV7M_EXCP_RESET].prio = resetprio;
     s->vectors[ARMV7M_EXCP_NMI].prio = -2;
-- 
2.20.1


