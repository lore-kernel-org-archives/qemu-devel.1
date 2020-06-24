Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC264C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C96720706
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkxTovAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C96720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7Or-00060b-T9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jo7Nb-0004nr-W6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:32:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jo7NZ-0000GH-FM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:32:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so2731545wrm.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CTrjlf7HtCvSAVY02rxL/+iOMOzkJKkBsKe2VyXjDiU=;
 b=JkxTovAWNrHERYGX89MwoTM9LTKqTK2OwXIbd/RaoK2BU+/vHy++5B0Osc6RBvhSDH
 ydAHs1HDn2JWrpzKaGmtgARenYtXM48LpGS2e1ROlThd+hDRlQeiMqDd+7gboCmIkhFE
 JdzgcupZwTYlKvQZqjdAuM+4hpVD1rupHUnlLVjGWP+ysQ+z+lkevItYtDEF7itNt4s9
 g1EdZJOY4LqZC8fsmo32s7/PVJVkoAFZ1ep+VCmgGkKA5MhjbDNxAXIclefZkZdZoW3e
 ih2aHD76l5loZYrlvKbQrjpROehjaKeskLaE//oTgEEue8Zrl/8FioHG4iJ5YMe9fV3L
 w9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CTrjlf7HtCvSAVY02rxL/+iOMOzkJKkBsKe2VyXjDiU=;
 b=kRtnxMvXfsh6S6pdDfgJI0w4ymt/A1mz8YedMWK9InO1uKQn8oLaMkPDctpFVAdwx7
 wROpSac1CEOGefR5APr9bifwHtyu3TckHnHNCA8mkmeGCRKzMkYyhYdqnFDR6yaCMHCl
 u+uh1E2iTeNb4Wl/aAhooFpthN4GsANwzBlWOfD2RdrEMjKnv/l37wwZtm/KbN0b8QWC
 ez6iXZ/YwyZk0ue88D3IhP9NsZJ2fFPIGUPY+sgNRhCfYjj5QeY7zjjGCBEwwnEhh7gu
 gZzX6K9Aq5yUnkr4YKff4nhVAaYJgC3T+5Qy7ykaJpj/m68gEFuZCw2DATmsIg4N1k1F
 /79A==
X-Gm-Message-State: AOAM531LgW97UqEaMEQ2SAy1SIRmKyoC5VJdYysyDTG8WMzxiKSOccC6
 ESyJEl0lXtdWBCk8qIBPDnO0nHuB
X-Google-Smtp-Source: ABdhPJxHCVDn8Gmu57HgLNoio6jdOlmf6nyJp7o8WMYhliWxNhjYY+ICuB84+PYy7QtEfvC80SPJ1Q==
X-Received: by 2002:adf:e648:: with SMTP id b8mr32496737wrn.386.1593012719042; 
 Wed, 24 Jun 2020 08:31:59 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.65.131])
 by smtp.gmail.com with ESMTPSA id b184sm2011299wmc.20.2020.06.24.08.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 08:31:58 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, rth@twiddle.net,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v3 0/3] Add Scripts for Finding Top 25 Executed Functions
Date: Wed, 24 Jun 2020 17:31:39 +0200
Message-Id: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x444.google.com
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

As a part of the TCG Continous Benchmarking project for GSoC this
year, detailed reports discussing different performance measurement
methodologies and analysis results will be sent here on the mailing
list.

The project's first report is currently being revised and will be
posted on the mailing list in the next few days.*
A section in this report will deal with measuring the top 25 executed
functions when running QEMU. It includes two Python scripts that
automatically perform this task.

This series adds these two scripts to a new performance directory
created under the scripts directory. It also adds a new
"Miscellaneous" section to the end of the MAINTAINERS file with a
"Performance Tools and Tests" subsection.

Previous version of the series:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg06147.html

*UPDATE: Report 1 was published on the mailing list on Monday the 22nd
of June.

Best regards,
Ahmed Karaman

v2->v3:
- Use a clearer "Syntax" and "Example of usage" in the script comment
  and commit message.
- Manually specify the instructions required to run Perf instead of
  relying on the stderr produced by Perf.
- Use more descriptive variable names.

Ahmed Karaman (3):
  scripts/performance: Add topN_perf.py script
  scripts/performance: Add topN_callgrind.py script
  MAINTAINERS: Add 'Performance Tools and Tests' subsection

 MAINTAINERS                           |   7 ++
 scripts/performance/topN_callgrind.py | 139 +++++++++++++++++++++++++
 scripts/performance/topN_perf.py      | 142 ++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100755 scripts/performance/topN_callgrind.py
 create mode 100755 scripts/performance/topN_perf.py

-- 
2.17.1


