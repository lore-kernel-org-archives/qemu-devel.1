Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167DBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45F422475
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7x4fwlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45F422475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO1Q-0000uh-0n
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jvO0g-0008Rc-0B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:42:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jvO0e-0006jT-A6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:42:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id f139so7228964wmf.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=G8/yZHS5L0Xe3/rN2i0supR5GoCdnNY5TJ1wMmIKFX8=;
 b=l7x4fwlMu87J2uFXnpD2bBLLBixMCn3WaIQF/LzykLSzGaR4jGg+Bu268y3lhJX09m
 tcXBaAGAZnBmTIP9rGdDVOPa+NlEjfQ+gDGdt6XSWMbxeKfwvle+QBYKxtx/opXX5Dh/
 IN74wqDqHv/9dejEbWEI5wNEzkwp/2UGScNUvrp6dd9UDf6BjtHjQWTCFlNxXGfwHalc
 Yat3mPfLSOI3Tjz+8w413cd4mfo+X7UHMEA5TjWV2KjpIGxUv0feOGLFOgQXhXt97WQN
 Uxe/rwDvFHvMi//pkPzFDTt71xk7R8BcA6MTClD/zQWmHj0gj8zcNqKEPhELQJS07s8u
 eOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=G8/yZHS5L0Xe3/rN2i0supR5GoCdnNY5TJ1wMmIKFX8=;
 b=kKmRJle0b9RVlWfV1GT5bsnVirldshlzzki5WXdGu3TDIDQ8h06VYcppYbU2D542tJ
 L+dMxMPrflYSrsxqCSblNjBbOhryYwmActSifjP/tj66fzIX16wSCB8afPOJVUWhY+P2
 8tfplOmbjTpVFZhEWnbcwa3Twgmkz2N/yMhFw9WdUlaco3FzHVtyBMckf9KDn9dcQSdW
 K907RKVNAAWYSDKtVpYwtWt7VtA7SagR44Fkd5OflVIIL84NjQIh/FhvPcrMc4aziwV3
 AORpa8z5AGTt3h64cQk1oQsMD6sM30cAjTYGJkwW2HB/jDvjBQwUPKeri6K01H3Q91Zo
 U4nA==
X-Gm-Message-State: AOAM530p3MSmfeAg8BqgIZi4y5023OHID2+moZmPyQ5zS+KP8z5QMvaT
 iaTon/V6fjplOBUUWt2t13pxj6Mu
X-Google-Smtp-Source: ABdhPJy7Fwy2wZq/xkSHhFfR1G5YsLZuAA7HJjygc+0LGe/3BnXywU0cUPOpxouGVstlNWzDOpz+TQ==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr4704948wmt.3.1594744941791; 
 Tue, 14 Jul 2020 09:42:21 -0700 (PDT)
Received: from AK-L.domain.name ([41.40.245.220])
 by smtp.gmail.com with ESMTPSA id l1sm30779380wrb.12.2020.07.14.09.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 09:42:21 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 0/2] Add list_fn_callees.py and list_helpers.py scripts
Date: Tue, 14 Jul 2020 18:41:54 +0200
Message-Id: <20200714164156.9353-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x344.google.com
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


