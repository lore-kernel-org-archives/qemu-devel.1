Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99631C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB54E2225A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UODIvnGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB54E2225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT53O-00053x-R4
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT51X-0003fL-BM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:18:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT51V-0005ah-83
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:18:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id e23so3575287wme.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X9vM5kU6Ra6+9oN0rFJRbPpOaRk8QiTX4VZaKBm9IHI=;
 b=UODIvnGOvaYcaQ36G9J5pJglDTAUK0wjxvNFH5Shw55EJ2k+2gALvZwZMjpa6zv5cu
 qHxWuIpHylPcN8n0bMReoL1tLvp8cZLnKS3+urnbkdcVOxeflMOJ6+9tHC9jz4IggmOg
 JQ7BYuQz9ZM2o1uOa3sppETYriKVzDrzBUHQb/x1IvFEr6qgK8cYAIU8vIvjYo0c676b
 qUy4C7Bgk8lWrdsdIoxqf5cenqjDJNRa1D0GdcA6jZuizsqiRmlNmsi6a+b6v5yScVbU
 ajG/trJMriqLOR6YeRBtY3c4EfS+Fxblayv7IHNewlK1Gtqxuvchaw0OKNdGRBNSNLp/
 Fc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X9vM5kU6Ra6+9oN0rFJRbPpOaRk8QiTX4VZaKBm9IHI=;
 b=slP9P1dO3XgbCIDE1VpHwFbM97xp5ysiL5tWeXPzRxahdpA8IzkUFsnD+yycUtt0Ll
 8FCKwx0ibz3PBLjROyT67ZQXl7Z/gJP3MzJlV0HehjV2/q6nLNA2MGSMeumGcQaOBpdo
 /BzOdcpxNZxYbRf353ObvN3LVNn4i8EsxJuIres3hTo9/TOyRfsP7evF7zo+fTCjb5Mm
 pEBVOtLvEPdbpG2IUpAyAO4PRWce4BWbKcbmL8sfiMR3E+HVk7ktRDR/QUfYVL/OMim8
 StY0va592VRU3dDlKh6psj8BW+F4wBAsuIucxtAhWBeUDtlwIIWTCHyV9xuCXKtVsmL8
 CDvA==
X-Gm-Message-State: AOAM5310s7vrmStG0Z9mytPyqLOplngmXUp5mHfLfp3mYADQxpqBEOr+
 I2vAQwYEY4BE7+2gTG/NUQMQByi+brtgT9sE
X-Google-Smtp-Source: ABdhPJyXiVtNXAyFNaqHHAtNFMMaC9DNnUn9Wwav0pxQgnzx1nSayg2MTnL/VEec0yIxKVBm95Vjcg==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr4461153wmf.24.1602775111426;
 Thu, 15 Oct 2020 08:18:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j13sm5193286wru.86.2020.10.15.08.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 08:18:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] armv7m_systick: Rewrite to use ptimers
Date: Thu, 15 Oct 2020 16:18:27 +0100
Message-Id: <20201015151829.14656-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

This patch series rewrites our implementation of the armv7m systick
timer to use ptimers.

The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
clear-on-write counter.  Our current implementation has various bugs
and dubious workarounds in it (for instance see
https://bugs.launchpad.net/qemu/+bug/1872237).
    
We have an implementation of a simple decrementing counter and we put
a lot of effort into making sure it handles the interesting corner
cases (like "spend a cycle at 0 before reloading"), so rather than
trying to fix these all over again in systick's hand-rolled countdown
code it's much simpler to just rewrite it to use a ptimer.
    
Unfortunately this is a migration compatibility break, which will
affect all M-profile boards.
   
Among other bugs, this fixes
https://bugs.launchpad.net/qemu/+bug/1872237 : now writes to SYST_CVR
when the timer is enabled correctly do nothing; when the timer is
enabled via SYST_CSR.ENABLE, the ptimer code will (because of
POLICY_NO_IMMEDIATE_RELOAD) arrange that after one timer tick the
counter is reloaded from SYST_RVR and then counts down from there, as
the architecture requires.

Side note: the trace from the test program in LP1872237 won't look
quite like it does on the hardware: under QEMU the "waiting for 1000
ms" debug printing generally reports a SYST_CVR value of 0.  This is
because QEMU's emulated CPU is comparatively fast and our systick has a
hard-wired value of 1MHz for the frequency of the 'external reference
clock', which means that execution of the guest code reaches "read
SYST_CVR" before the first tick of the timer clock after enabling of
the timer (which is where the reload of SYST_CVR from SYST_RVR is
required).  The exception is the first iteration, where the time QEMU
takes to translate the guest code is enough that the timer tick
happens before the register read.  You can also get the timer tick to
win the race by fiddling around with the -icount option (which
effectively is slowing down the emulated CPU speed).

Some day we should model both the 'system_clock_scale' (ie the CPU
clock frequency) and the 'external reference clock' as QEMU clock
source/sinks so that board code can specify the correct reference
clock frequency.

Patch 1 is a minor tweak to the ptimer code to suppress a spurious
warning message for the "timer callback function disabled the ptimer"
case, which the systick timer uses.  Patch 2 is the actual
conversion.

thanks
-- PMM


Peter Maydell (2):
  hw/core/ptimer: Support ptimer being disabled by timer callback
  hw/timer/armv7m_systick: Rewrite to use ptimers

 include/hw/timer/armv7m_systick.h |   3 +-
 hw/core/ptimer.c                  |   4 +
 hw/timer/armv7m_systick.c         | 124 +++++++++++++-----------------
 3 files changed, 58 insertions(+), 73 deletions(-)

-- 
2.20.1


