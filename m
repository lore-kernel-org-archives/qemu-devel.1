Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7C7206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upDrTAgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7C7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJ5J-0007J4-IB
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4Y-0005uy-Il
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:36:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4W-00051r-Rp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:36:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id f185so9515531wmf.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IpMZoLnZj96IJGtMtir9GSdpfeChtymSYOvGV3P30rM=;
 b=upDrTAgUmwBc4qMyAE/JXVnD0w7iCgf/eOeAXWavlC4DVEHUNNf2vubszwctAi2Glk
 ksJt3CspN/y5B5ZunRiHtQ0eOnd3+d5sx/Wnl7HejdcSkoMET4pGkFgH0X9YcwXjuL8M
 mwR61pVDJY+9gYul0FgJX2VdFC6s0ZtIJQgMoom3Ne0mmiz8jhGtDnT4FWTUXZZS5ppr
 zoYS0K9kR7rBx9R1Z0d6DQ4P0W48KRWCM9zHvKfaOudQ1+cvKbKwPpMSYEIicgmrsVR1
 9ev+SwcN9Nr9nov96CHZX3VMTTJ8AMF/gcBWLLKpvVQcYkE+xfcayEolPVWQu4d7vIp8
 t2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IpMZoLnZj96IJGtMtir9GSdpfeChtymSYOvGV3P30rM=;
 b=Y1ouNlsVJ0JBWZmqbL2mimLOB+mIGa1AWj6bJEFLSgg+QZXy9RDCqzXvwdDqEDWES4
 wYnjLDmXNBc86Fza/BGRTRPO/T9IeRfRbZeY7PaqQmm3xJ8MYv5DLJSHW6USCtRsowpa
 K1gLzBMxkPra9hb9mfmdQaDvNK1jpp2c52zfRH6rOtjOYPQzE07rrhA+JVUBFDh2jNrb
 y6VJLnn+wIZAHDXQ34184DH3r4Kl8M4D3u/nKigwSJb/mZoVEcoJpzn+BxubNrQaEvyd
 hLDAk9XqCItUb7kb22ViqsCSDa4P4kJKuKa75tD8Tiyv1AE6Tby3FJf3MoiOUUjzr9D1
 Qaig==
X-Gm-Message-State: AOAM5302I4SPL8JwHvbNO2up0w9C4EPQcWs+vEOi1yT2D0G8G6ij4eLv
 YYgbOLrFqMYV0lX+dSBFxia1zsB0
X-Google-Smtp-Source: ABdhPJzrWIf5ECgJcENi2m/UyhwzcTZOMtdkB4o8rUXG7L7cAjFemDo19L/DNP/bEuCklPbLyr66Cg==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr2222330wmk.138.1592581010304; 
 Fri, 19 Jun 2020 08:36:50 -0700 (PDT)
Received: from AK-L.domain.name ([41.232.120.95])
 by smtp.gmail.com with ESMTPSA id x186sm7341354wmg.8.2020.06.19.08.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:36:49 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, rth@twiddle.net,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 0/3] Add Scripts for Finding Top 25 Executed Functions
Date: Fri, 19 Jun 2020 17:36:29 +0200
Message-Id: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greetings,

This series implements the improvements and changes requested to be
added to the two scripts.

Thanks to Mr. Aleksandar Markovic, Mr. Alex Bennée, and Mr. Eric Blake
for their valuable feedback.

First version of the series:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg04868.html

Best regards,
Ahmed Karaman

v1->v2:
- Add an empty line at the end of the MAINTAINERS file.
- Move MAINTAINERS patch to be the last in the series.
- Allow custom number of top functions to be specified.
- Check for vallgrind and perf before executing the scripts.
- Ensure sufficient permissions when running the topN_perf script.
- Use subprocess instead of os.system
- Use os.unlink() for deleting intermediate files.
- Spread out the data extraction steps.
- Enable execution permission for the scripts.
- Add script example output in the commit message.

Ahmed Karaman (3):
  scripts/performance: Add topN_perf.py script
  scripts/performance: Add topN_callgrind.py script
  MAINTAINERS: Add 'Performance Tools and Tests' subsection

 MAINTAINERS                           |   7 ++
 scripts/performance/topN_callgrind.py | 131 ++++++++++++++++++++++++++
 scripts/performance/topN_perf.py      | 115 ++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100755 scripts/performance/topN_callgrind.py
 create mode 100755 scripts/performance/topN_perf.py

-- 
2.17.1


