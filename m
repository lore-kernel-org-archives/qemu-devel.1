Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8241C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A1B20760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLW+vSnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A1B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1JS-0006cB-MY
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jw1Il-00065t-GY
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:39:43 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:38704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jw1Ij-0003BL-U5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:39:43 -0400
Received: by mail-ej1-x62e.google.com with SMTP id br7so6044230ejb.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=egynDzXmECLFmeOEmQM5VGLnIzAzZo7kO48x+S/z72M=;
 b=kLW+vSnttad+Lb/qa0l9Bapo5SMliuowLHVCvWokoatzbuKl/w/sfarBtJdWxWgidm
 qK6FMdNeSTRlTDM0JElik4Cko94ee5h8k5fetntYT8aZp6NRSHzb0xuQ4a/3mWaisltH
 cUK+/wH7yn51KL+1ZiY7rixZbt2igXDELJ2hE5FvBOt3gRibNzCYuokNyOA/a+qWkRCK
 ChyWz/E+fxEss8OOgI84SHOwpO50HucNrGUvkcL2QOhxM6VUcXeSWAdg8XI9VXpmIdC3
 qC1cqIaICb4Dti5NKKuxq9X/COyxXZWlgKcuUdmGk74DZL7U9o2iUq9UIMnPyy8iYatU
 5HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=egynDzXmECLFmeOEmQM5VGLnIzAzZo7kO48x+S/z72M=;
 b=elc2zeWUp9No2I/bxALtQxT5lDZfBXgTkUiYcT49q0/sprsD3vMUXxseNFKKeGyYvA
 XwOS0YO4aH2DLGcyySc3/uM/a+ph0agL6qHWUks/4TxLyLC8Pd5qyEUQFU8PfD5iViRT
 DgYvLc2qYLm7rHfrUNQTgQ0VGPQlxLcc58aHZ80TE8x748aQrfHxqtqqX/bYxUM1lYPE
 IqZSMd8xhZxXk4BO3Tdpyy48H4JFtH4KzXIYE8JmLoOdB74dLz0luekKmT3EvxVEBhax
 ZB0WdVcA9rpzWavxRDcF5iFBCNtGZtAz1lArGaoFF7Bp6ESPA+DkaL7EiELp3zkfi+Fy
 gsqg==
X-Gm-Message-State: AOAM532wVvHHjrlW/tQjJinDeg0BMeJ6eL9dZ2mp7RZut7E+3Tkk30d8
 HNEWC6K5Z1deNpX37oMfvGWh4amb
X-Google-Smtp-Source: ABdhPJwIpQXhIhoutRTIwrfl99+ndJvRsNGMv2ns0xedG9ODKNFs7lX8SWsQL4KWceGDinJo0uOa+w==
X-Received: by 2002:a17:906:5246:: with SMTP id
 y6mr3037458ejm.316.1594895979623; 
 Thu, 16 Jul 2020 03:39:39 -0700 (PDT)
Received: from localhost.localdomain ([197.58.201.14])
 by smtp.gmail.com with ESMTPSA id w8sm4707892ejb.10.2020.07.16.03.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 03:39:38 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 0/2] Add list_fn_callees.py and list_helpers.py scripts
Date: Thu, 16 Jul 2020 12:39:19 +0200
Message-Id: <20200716103921.6605-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-ej1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series adds the two new scripts introduced in report 4 of the
"TCG Continuous Benchmarking" GSoC project.

"list_fn_callees.py" is used for printing the callees of a given list
of QEMU functions.

"list_helpers.py" is used for printing the executed helpers of a QEMU
invocation.

To learn more about how the scripts work and how they can be used for
analyzing the performance of different targets, please check the
"Listing QEMU Helpers and Function Callees" report.

Report link:
https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg04227.html

Best regards,
Ahmed Karaman

v1->v2:
- Indent script example output in commit message to pass the "Test checkpatch"
  on patchew.

Ahmed Karaman (2):
  scripts/performance: Add list_fn_callees.py script
  scripts/performance: Add list_helpers.py script

 scripts/performance/list_fn_callees.py | 228 +++++++++++++++++++++++++
 scripts/performance/list_helpers.py    | 207 ++++++++++++++++++++++
 2 files changed, 435 insertions(+)
 create mode 100755 scripts/performance/list_fn_callees.py
 create mode 100755 scripts/performance/list_helpers.py

-- 
2.17.1


