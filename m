Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF152070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaMmd9b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF152070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYn5-0005mm-1C
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiV-0000EU-65
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiR-0008Kb-EB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itYiR-0008KK-67
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:47 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so14836428wmj.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WIU6E3hxHWLHvIPtvOTqa69pMSrB7Jk7+vICeNcppIU=;
 b=uaMmd9b7CHJPG8CR3QUFthSnzSHEbXZxNnXkGLEXAxJ7lOXkqmSbn9VJUop5IBynkh
 F4HI0vr0L+H8YQG2ozIP+M/6e6nkLLeSbiBTDKa3/BkHhUrgrvOmvMOUo4kuz0cnmwn7
 vdFs/4BCWbNuph2id9XOwcQSon94qggsO38KsyUXVK6z51bIhVibQokU7UZ/veEw/24V
 Yz6RW4/yeG4Q7OcM3ZCUZ8LwsQCuyIT+hmmy4xZH2vpLjJ6HOM/gvp0M6unh6U3sWk1L
 oB/iw97a7LiDs0nIP2KEcuFOqO557kUJ7+Y8ONMVJTgWkg8/rjqPNLdPt5yC7UZc+54d
 YHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WIU6E3hxHWLHvIPtvOTqa69pMSrB7Jk7+vICeNcppIU=;
 b=EJJUDH0kTBVoMBtW/tB3ip01wa1U7t4M26w6aMCJBUgSJWyrHEjjwo9NnHbIKvmSTQ
 DMzYA9Wc08oM2fFif3rTQau8tMw8+Ox/Lm5KPpqrUnPUIusKOISxUfv/n0pUop10bqRy
 GPPNbx42K1PCFPWim46a9C/7fxZ5/qIl/oNvTZrn9125KZ6uuHlkbfSKbstElIhRCxFI
 hVCYoOqGpd4ctIetuMpYgJChEW7PF55AYLVFTAuE9qHIhHtSuNI9F7Zc3fSMOZdPERaa
 aQRN+Z1Wz3fHLbFUkM/kTwAxpLrqpgjlsi0gnTXyESqk8S8VngbK279/QsUz5P3idefj
 Nydw==
X-Gm-Message-State: APjAAAUU16oINw665dnLJVxP+lbj0a5OWq6ZUHv4E+zhsesllhLMLQOO
 M1pZoGe9nK5+vkWs4NfMCfRtQ1bAdrdzgw==
X-Google-Smtp-Source: APXvYqzl3wb92hBS55kdr8+mjQPJ2jAwloPa6enRBljYr40QRAeCkHFj+GUDTZofwBkMr/ZdhETf8Q==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr18750051wmm.97.1579533105097; 
 Mon, 20 Jan 2020 07:11:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f17sm817919wmc.8.2020.01.20.07.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 07:11:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Use only trace_event_get_state_backends() to check trace
 enablement
Date: Mon, 20 Jan 2020 15:11:39 +0000
Message-Id: <20200120151142.18954-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently docs/devel/tracing.txt recommends checking the
TRACE_FOO_ENABLED macro to see if the FOO event is enabled,
for the purpose of skipping expensive computations that
are only used in trace output.

This is no longer the best way to do this; instead we
should prefer trace_event_get_state_backends(), which
checks both whether the event is compile-time disabled
and also whether it is run-time disabled.

Update the documentation, and also the 5 uses of the
old style in the tree.

thanks
-- PMM

Peter Maydell (3):
  docs/devel/tracing.txt: Recommend only
    trace_event_get_state_backends()
  memory.c: Use trace_event_get_state_backends()
  hw/display/qxl.c: Use trace_event_get_state_backends()

 docs/devel/tracing.txt | 12 +++++-------
 hw/display/qxl.c       |  2 +-
 memory.c               |  8 ++++----
 3 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.20.1


