Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F825C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28E82070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEYBYf6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28E82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJC9-0000UG-38
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanbrankovic96@gmail.com>)
 id 1jrJB4-0007p7-2K
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:44:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanbrankovic96@gmail.com>)
 id 1jrJB1-0005qd-Dg
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:44:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id f18so24079481wrs.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Walft/krmIb88CcdozYYOZSH5JBOSdkbk+iW4cKzGzM=;
 b=OEYBYf6J3nvxDQ+nZ2muYdYx+SgY5REdp9vSuuR72wR8kH8HAwWoZ6sCwBW8lgIRg+
 us/hSSr6rko1Oi/uBcixauBGbYlppFVfnjOEki0JUKGOq0j5fgQgRD4+oP5fq5q93KRz
 Pa9DlFu+XuR1HiNNOld9u5OrujlGWLkaszP/TGGtjSnD9WO44cJndkouVXs7EHo4CPMy
 jrF40eiY+orfwZuVZjAysYot15vlGT+uat33DxF1X62epqCOLN1hiAfYOw0n8Ju43dNI
 bV8kQvmi8xBsM7XH2yPRpjqsBecTce+fPRKWieOJDdfruEvkWbJGew/eNAfktdkTLoo1
 4Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Walft/krmIb88CcdozYYOZSH5JBOSdkbk+iW4cKzGzM=;
 b=Draw13lpaI8+f0VYKkfaC8/y8LD7CYyMmpEQydyLJovmvbkuvtij3PBudGX1Gj35gZ
 +lti1bkxIQbpDyjSOVpMEUAvTfIfFYzzHWNdIXi8zb64nFjpZ3cekiaoXtDhUm0fhnmV
 MZCdl8HyERR3pF65Df3DGSJc72gLMBKkVGP9NSts0hPbqLW/5mqY2See9ioMy0Od6d+L
 JBQhwMOH5AFgWWhNT0LlMt8XwAMdyIK4QjiKvqLlrbdQEcW7/wvl5+rufD1rH94yy5xO
 uZYw9eGU62N98uLbRX+kAGy6gOwKyXU3RHEbgesX9fXyFGnhqlkH7Me9/NN6/23DAcNd
 gfFg==
X-Gm-Message-State: AOAM5339ZHsNoUzBuxdLSwmVsjiF7jrqERpHOoeyzm76RBA2xH8aQmK1
 tr9mi7ZFX6W4aLA+2AcBsUREE/5DGix5eg==
X-Google-Smtp-Source: ABdhPJxvxPjzvClv6w+7EFLWyKdGp3YBhqjLfkeAAg/TThE8R5O/GhbFQ3/o1RJimcelAe6mzHqgfA==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr36130609wro.151.1593773053425; 
 Fri, 03 Jul 2020 03:44:13 -0700 (PDT)
Received: from localhost.localdomain (109-93-62-240.dynamic.isp.telekom.rs.
 [109.93.62.240])
 by smtp.gmail.com with ESMTPSA id d13sm13628288wrq.89.2020.07.03.03.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 03:44:12 -0700 (PDT)
From: Stefan Brankovic <stefanbrankovic96@gmail.com>
X-Google-Original-From: Stefan Brankovic <stefan.brankovic@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] Add Loongson 2F disassembler
Date: Fri,  3 Jul 2020 12:44:08 +0200
Message-Id: <20200703104409.6986-1-stefan.brankovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanbrankovic96@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: thuth@redhat.com, aleksandar.rikalo@syrmia.com,
 aleksandar.qemu.devel@gmail.com, stefan.brankovic@syrmia.com,
 chenhc@lemote.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds disassembler for Loongson 2F architecture.

v2:
Fixed coding style problems.
Added comments related to licence and author.

Stefan Brankovic (1):
  disas: mips: Add Loongson 2F disassembler

 MAINTAINERS             |    1 +
 configure               |    1 +
 disas/Makefile.objs     |    1 +
 disas/loongson2f.cpp    | 8154 +++++++++++++++++++++++++++++++++++++++
 disas/loongson2f.h      | 2562 ++++++++++++
 include/disas/dis-asm.h |    1 +
 include/exec/poison.h   |    1 +
 target/mips/cpu.c       |    4 +
 8 files changed, 10725 insertions(+)
 create mode 100644 disas/loongson2f.cpp
 create mode 100644 disas/loongson2f.h

-- 
2.17.1


