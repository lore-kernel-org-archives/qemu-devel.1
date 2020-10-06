Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79722C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C12087E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiEgOnQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPu1X-00066k-Nh
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 16:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.turek@gmail.com>)
 id 1kPtWa-0005z2-OG
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:25:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brian.turek@gmail.com>)
 id 1kPtWZ-0002Ju-6h
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:25:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id o5so14908856wrn.13
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XQsOkmRYLuPhwzofzg/0dnEmyL/kcD6eH0BzATzy0r4=;
 b=NiEgOnQJxofw0Awb4EHGA1ynMYzuXJdu3PmD31gftN8t/2eui46P8S12QmOqTlns8A
 0BUA0WjPUk+iv5xh5IUACVkT0COwvAzImLoTpha9nBp1DwRoGDR31V7WirLlkZH/K29Q
 F+XN8Zmu85R/kd2AdMwIl0fq5WIAMVJzCMeXEDcTdLlExT/v/2JRnKRnAAsqEhTpG98r
 U/maGGgzQg3LPgGpOz5TD6V2xiA26JMnUKzVvNrZNawA+Uh7t5dZ+w1ib4taKf730MTI
 kUHE0nLOoZ0sW6FcKHJv2SM8t64XrjBJI6/VSImWRmTYRa0zM18L1hrDMKIRaK2tX5TZ
 bT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XQsOkmRYLuPhwzofzg/0dnEmyL/kcD6eH0BzATzy0r4=;
 b=IuEymrZDrV/aWSulGOesIiAAIkcx4SIO99C7q9rYwsAcMW5U0hENBn7fUKZk403XOS
 Os1aAIcmBgH5X5ONtQ+tqZ+Wis29nWtJnZ22T86jo8oWoEs+DOkL227DeDsM+DfuHwPk
 iGigNZUxRuxzg0zDe5tMPzJiaUlEAX1RvvUL7dMSUgDFe3OcoAuUubA7WNyGnKK09cZz
 /8xTFb52me5Ylg2+uqac7az6Pg+7coD9bCW6ROIHSFtRW5RaMkNd3xKS+Vw+jla2bBFl
 Z/2kJpS8ZhBUe9nsNmOoyyqyzuqyP1vMyAZ1apKa2KaxvDO/IBHjBkkNsN6O3juYQl3r
 lyNA==
X-Gm-Message-State: AOAM530eJstFFhe/FMnzWa5kH4IfpoXZrL3YqWwTMu4SJIxPL5Scz5g2
 SHUs7zLk2jdkZ/6UfcLvHv4svO6mGVPubRu6
X-Google-Smtp-Source: ABdhPJzmaYtgfUMqx+2NHt8uueSNCQZ52IWfNwjuWguA5Tatmh6YYhOktSYu74vluBgpKwMdvTTnRg==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr6956887wrk.263.1602015925077; 
 Tue, 06 Oct 2020 13:25:25 -0700 (PDT)
Received: from localhost.localdomain
 (cpc75556-harg6-2-0-cust35.7-1.cable.virginm.net. [86.3.36.36])
 by smtp.gmail.com with ESMTPSA id o15sm5402131wmh.29.2020.10.06.13.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 13:25:24 -0700 (PDT)
From: Brian Turek <brian.turek@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] docs: Clarify formatting for 'fmode' and 'dmode'
Date: Tue,  6 Oct 2020 21:25:00 +0100
Message-Id: <20201006202501.81537-1-brian.turek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=brian.turek@gmail.com; helo=mail-wr1-x436.google.com
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
X-Mailman-Approved-At: Tue, 06 Oct 2020 16:56:11 -0400
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
Cc: Brian Turek <brian.turek@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current documentation for the 'fmode' and 'dmode' options for
fsdev/virtfs is ambiguous for the expected format of the values.  The
code itself parses the value using a call to strtoull with base=0 which
causes values like "644" and "755" to be parsed as base-10 rather than
base-8. This can cause unexpected behavior.

This patch changes the docmentation to be explicit on the expected
format and mentions the fact that the setuid, setgid, and sticky bit are
dropped.

Brian Turek (1):
  docs: Clarify formatting for 'fmode' and 'dmode'

 qemu-options.hx | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


