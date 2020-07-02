Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DC7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA3720890
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg/B88gX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA3720890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0FZ-0001Tf-EV
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jr0Dx-00087I-7T
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:30:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jr0Dv-0003N1-D4
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:30:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id j18so27023248wmi.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Y0aMuriLqF+pdFM3digNYwkDgzJFCdadsPH4uXtiqPk=;
 b=Wg/B88gXblroy16b9RSkTSJX/vDE8vjFXb7L8MElWhUMD8NDyBoZe7sW4eGTIw31nv
 N0uGO5EpfjWMjXkV3yvqgI56V+iRT03RB+eEqeoG/QmAAIukiQKf1iZqA7+u14hppIo+
 kCAsPkRz9M/wLcJd2cfx4pkSMsx9BHG3Zds6cZOSWrcfH6OfqEdbwl8zBIDzUNQIzvhE
 Caf8e8+twy8uiufPN/mvGP3XFK4BqLzszVFv0RSIsbhNMD2XrhM7nPoM7TSGlz1f6oVQ
 kftKw926MowA6ni+MJ/8JJZdhlzazrDui1TZYTXQs99zBzLB2aTdrE2s9JUuZ16bb+lj
 Be/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Y0aMuriLqF+pdFM3digNYwkDgzJFCdadsPH4uXtiqPk=;
 b=HrjyF2iC/AUd6y0IFVRdLovO9ypLJN8rWwsgAUWRVfpY7Asg/hlIeHg4jpsn2sLKbi
 003ev8RPiaiai1us+JdTRJ+BSuQRUKetyjgVLgR7rwqD3oKm7o6FhDUzYVNW1+/h3oxS
 x2eVUd6Apbqdbcgizz0+oEhqCSnweztlQ8/7RrTPpCsz1H6R5HcUzXreTfA08uo/GVI5
 u3I5X5/BHuUvIeO7L7E2wCw7ddQ1y9N7kiXE0l+bnBHwqJ9hUBp7q32QY2xE1CTPf27Q
 IllbLSd0A/fRzngdrDdwd/mULW/VYb2QgpcxpCtqUrUG01L6AfmGwCICOCnzhgRbwG6S
 Hbbw==
X-Gm-Message-State: AOAM531CJ6KqwOeTeWnWqbXH1riIy5nZLdlCQL18PfdncsPJT0i9hRo4
 78ejIrYNUMIbNkdFjS9NO0oTyCko
X-Google-Smtp-Source: ABdhPJw0II7QlzPG1vZueWV/Q9f8h3CsKkCcgXS08Hdzny+JCI7f+gg5XFwzc39Xrtyw0XwSeDxCDQ==
X-Received: by 2002:a05:600c:2907:: with SMTP id
 i7mr28115654wmd.40.1593700194856; 
 Thu, 02 Jul 2020 07:29:54 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.210.158])
 by smtp.gmail.com with ESMTPSA id j14sm10818406wrs.75.2020.07.02.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 07:29:54 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, rth@twiddle.net, eblake@redhat.com,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 0/1] Add Script for Dissecting QEMU Execution
Date: Thu,  2 Jul 2020 16:29:41 +0200
Message-Id: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This series adds the dissect.py script which breaks down the execution
of QEMU into three main phases:
code generation, JIT execution, and helpers execution.

It prints the number of instructions executed by QEMU in each of these
three phases, plus the total number of executed instructions.

To learn more about how the script works and for further usage
instructions, please check the "Dissecting QEMU Into Three Main Parts"
report posted as part of the "TCG Continuous Benchmarking" GSoC project.

Report link:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09441.html

Best regards,
Ahmed Karaman

v1->v2:
- Set the executable bit for the script.
- Remove exclamation marks from error output.
- Fix a misspelling in a comment line.

Ahmed Karaman (1):
  scripts/performance: Add dissect.py script

 scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100755 scripts/performance/dissect.py

-- 
2.17.1


