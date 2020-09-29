Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A11E21734
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QrZD2QpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A11E21734
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN3i0-0003XH-Kz
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 20:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SIJyXwsKChk6H97CC3BD3C5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--hskinnemoen.bounces.google.com>)
 id 1kN3gC-0002G9-NA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 20:39:40 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:34706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SIJyXwsKChk6H97CC3BD3C5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--hskinnemoen.bounces.google.com>)
 id 1kN3gB-0000PK-1h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 20:39:40 -0400
Received: by mail-qt1-x84a.google.com with SMTP id g10so1865570qto.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=cK79FpM6Y4GoQRIVgHZKxRPYems1DgVkhmUNuMjucR0=;
 b=QrZD2QpW7OeRB6TIFoeo3+KHDuVkJNYZBhGNIlt0i0hvUVfSSgolKEnjsPVOjd7yZm
 bvO8D+BPGAryu8j3aOckCnYZ/GaAqZREMqxxwvDB+quSX0aPEW2UWQduro9B2mZexRIr
 rxLIJ4api/wr/LUiZMmsC4doamA7V2SFGTGTp17TQob3veI0EsiBMlPKizBmJ/KCP+83
 WTC55E6EJ8H5/+YxtS+B+whZpKmGJNtlytriUM8OdQn3PpLOSAYGUTLh1w+ZwP/3T4DT
 vc4hSdAZ5pRfrgV/KsLMHJ8+vqUObopqd1lb8T/fg6jGS9b9vyyWY9vuJSmJ9yxo0/zP
 li3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=cK79FpM6Y4GoQRIVgHZKxRPYems1DgVkhmUNuMjucR0=;
 b=N41aiqitlBoEcpjQnV031/qSzWe7QjlVk1cyuie/GFFHyy6Aa4k2aXQ2JjqedV6Kdd
 jGvSE/tCYNcQYWmtTeKtZlEqCMEQdWNUXIZW6it4BBW2+pG90QkEUyeirZc05Q7FrBZJ
 eU+BxK216gdFluNG62tg5s6sPYClvcC//g6t1gMXWKuzYvp4SEoOwEP9LyHymd5bt/Cd
 +ol9WyyDnE5lWNPkDUT0KaeRZ9M8qkW8xsEM5cxSDM7nMWonlx0dipaDVJYkPihG8ww/
 IJaIlqnU7sxeG4zIgxJWyPEpjmSdN1Ss7zjVGniuFAoDKtrtO9Nro8JguuYIe7E5unED
 70Cg==
X-Gm-Message-State: AOAM531RKhaJ6wxpPs53l8zWhizTt+NFr/Fpcq1LacaBngW0A7e8B5ql
 boLDRTgnLKh04yesvET0GAXlmi5T6rg5gozM2a+g3T1iE0+jfFjPUdjfToLjzousUkvAKLDvnZo
 Hc9t4uaIpuWog3/ujznrNEUH/87lY58UyysZVsmSuQd3Tc90O4AJlArDfv9KfArFT2Do1XKVI8Q
 ==
X-Google-Smtp-Source: ABdhPJy8vUqDhLvNdaqkloRqT/KTfT5gUnxKtb4P23ilJ0/T6dL52/bvIn2jDQ44TSsTKf6Oit5lc3GUCtrHlrLHaQ==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a0c:e447:: with SMTP id
 d7mr2152783qvm.44.1601339976225; Mon, 28 Sep 2020 17:39:36 -0700 (PDT)
Date: Mon, 28 Sep 2020 17:39:13 -0700
Message-Id: <20200929003916.4183696-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [RFC 0/3] QEMU as IPMI BMC emulator
To: qemu-devel@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, joel@jms.id.au, clg@kaod.org, 
 venture@google.com, wuhaotsh@google.com, minyard@acm.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3SIJyXwsKChk6H97CC3BD3C5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x84a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This series briefly documents the existing IPMI device support for main
processor emulation, and goes on to propose a similar device structure to
emulate IPMI responder devices in BMC machines. This would allow a qemu
instance running BMC firmware to serve as an external BMC for a qemu instance
running server software.

RFC only at this point because the series does not include actual code to
implement this. I'd appreciate some initial feedback on

1. Whether anyone else is interested in something like this.
2. Completeness (i.e. anything that could be explained in more detail in the
   docs).
3. Naming, and whether 'specs' is the right place to put this.
4. Whether it's OK to enable the blockdiag sphinx extension (if not, I'll just
   toss the block diagrams and turn the docs into walls of text).

If this seems reasonable, I'll start working with one of my team mates on
implementing the common part, as well as the Nuvoton-specific responder device.
Possibly also an Aspeed device.

Havard Skinnemoen (3):
  docs: enable sphinx blockdiag extension
  docs/specs: IPMI device emulation: main processor
  docs/specs: IPMI device emulation: BMC

 docs/conf.py         |   5 +-
 docs/specs/index.rst |   1 +
 docs/specs/ipmi.rst  | 183 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/ipmi.rst

-- 
2.28.0.709.gb0816b6eb0-goog


