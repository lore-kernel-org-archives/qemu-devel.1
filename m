Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA6CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9714620658
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkuox/9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9714620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtP0U-00087B-To
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtOzv-0007gU-89
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:21:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtOzt-0001ED-Ju
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:21:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so870120wrj.13
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7ky8uy4CemIW7t+jRiCrHzA4m4j2zeS91X2qOBL7iww=;
 b=lkuox/9NA+xlCw93JIRt6+QB8y8GZVgzh/9BfgZEJzu48Kv/0DbAIgZR4uj4xwx0cV
 yAnneTvGRJQ4bnbSwVagsTV4eR+VTCaP0xqh3rYO4OglJHOzpzeQ9Qbv0rdv1MFQ6gAc
 7O4fBY3t/DVZ0r0zO4hxf5nZiEopyVHEbScycBfTO9TWMGOoLAeiXWqYPCF7aekMft8J
 ktQb2Sf1ZUT+P0Hv6k16VFbKYwRkO18kOb/lcd6vNINDeeX4clNIEpzQmrMNK4qa29/8
 nGklonSV23mHTwkZDBJik0/bi5RtCQ4Cz51HZ7vVZG0Eouil+wda2attXr88lIgtSXtD
 P8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7ky8uy4CemIW7t+jRiCrHzA4m4j2zeS91X2qOBL7iww=;
 b=U2IUS7+lG1YZFwB72lxrhIDwD6UvhbgW2jBp/2D/MP06vcD4XoWOASzC/hdfrrahL9
 acZihHP4jvS2G4FyUmbCAEjY9lxJOZiW+/hPml1sgmEpEI9bKWY1mm5RweNfVuW8Pf3X
 rVQ/zvVxemtcUMQPJa1NrY+3ox0g1MwoywSlMl2+LSl1O7KWDVXJ0vk1axKMGjU5EYoF
 4g8cb0Trn2kSYv0eLGm+pqvF7BIIfq8J9UAztkLwMKrMnyMeaqrjCq5sdlq1I9djF2Fa
 Y6lYA1ExYO4sqFKkR46g4WjKSznK0cfXDBrv/cd+P+5WR1yMjLCLIA1OvjjgoCqca018
 Mncg==
X-Gm-Message-State: AOAM533uYzRKmT+U2/DgSs46CyNohsYLBUgTDuwMJydjpJbnADlv24vN
 hdi/cmJg8ZFr06c7P7jD+Fk7aFVh
X-Google-Smtp-Source: ABdhPJyG54aaB3CLi1XXFzQmUF3lhmngcnORlO89csK0NSHMZgJYMeoCMjcWn9cFMbk6Qb33y300jQ==
X-Received: by 2002:adf:f452:: with SMTP id f18mr60876063wrp.78.1594272083882; 
 Wed, 08 Jul 2020 22:21:23 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.193.80])
 by smtp.gmail.com with ESMTPSA id j6sm3717551wro.25.2020.07.08.22.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:21:23 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v3 0/1] Add Script for Dissecting QEMU Execution
Date: Thu,  9 Jul 2020 07:20:54 +0200
Message-Id: <20200709052055.2650-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

v2->v3:
- Fix a misalignment in a comment line.
- Use tempfile.TemporaryDirectory() for handling intermediate files.

Ahmed Karaman (1):
  scripts/performance: Add dissect.py script

 scripts/performance/dissect.py | 166 +++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100755 scripts/performance/dissect.py

-- 
2.17.1


