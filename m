Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E5CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7008820835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5LCyTN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7008820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjn2b-0002su-KO
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjn1m-0001h2-7Y
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:59:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36454)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjn1k-0002f4-Ls
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:59:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id q11so10452805wrp.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=puTi/7vq4TT1JtKetAWdWS2wv74I0+t22zdHuQTlX2A=;
 b=b5LCyTN9JcEJgGGt0LkFeUIi7CxlSENFlSCb6EU/OVHxg4FgFMH0iPo1ekTTsip6S3
 3/Bf7895hVUlfEP0zwTE/iDs9liHrWPbcJKnCLpYP+9R1+1R3a0oxzTztPH5nWIQjki0
 VhX465evEtVeLR9W5rUtfwi+x3r6NnDzcajTjGJagbb/RPTb1akK6Vt9ohoQ5sjFBTHq
 hMbbGI0tEm+xpH6XIR3qqaUs3alt3Z9SEFHe4ylaKSY4KDZR/lng8vUSDSnMgG6Y1qZN
 SHrJWvVUaVi2P9zdNlodloDKhyxJ+fZUzUCSl769SgrM20HEDyeMVBdzfphnMASumzNg
 I5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=puTi/7vq4TT1JtKetAWdWS2wv74I0+t22zdHuQTlX2A=;
 b=F+ojKwB4IkFHzQBFkkBTW11zhN9RLkxNKkkrjq/Vw4CsGawRxxukSqMWT6XK1NLPzA
 kP2EqZBj1SxnNH6ViVTnUIix4ABaORvu4bFW78D6fXN/ktCnOpSsVbQ7fmvuJ28dlAja
 9nCMYwmElNW6cFFf+DEoAuuFe75Qsc7SQI8r7Q8pYtN2/79TktBWLmK1TuPcU6UwzQpL
 5f+9/XrwZbM+sldTtrDd0McYrP9CFxESp9TSVqGm4ivffhM37Sz9YtywZFIVvW3kxcHI
 RsN7IP45WRPt1E5piQ1sZ68Debm0e2FeiKqwbfpACg/D+MS7T7+mauk6W7M4xu/YADqW
 us4Q==
X-Gm-Message-State: AOAM5326l6SDb38d5tb3jT5KugE3M1M2TjHhFcWDKretOvn3A9uaIlZr
 2gvvPnKWmaFyHmnAIXEcPOKiFZV20YE=
X-Google-Smtp-Source: ABdhPJzuNG1QH6eQJ2KRDYftqBffNVShtwlzFLdNZnulh9GUfhOjm9q6MCnlKPH2xXgXJmRjp8BNHA==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr15685625wrr.405.1591981168487; 
 Fri, 12 Jun 2020 09:59:28 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id f185sm9923653wmf.43.2020.06.12.09.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 09:59:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/8] target/mips: MSA,
 FPU and other cleanups and improvements
Date: Fri, 12 Jun 2020 18:58:59 +0200
Message-Id: <20200612165907.1272-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains some patches that split heprers in msa_helper.c.
It will make easier for debugging tools to display involved source
code, and also introduces some modest performance improvements gains
for all involved MSA instructions.

v6->v7:

  - excluded patches that have been already upstreamed
  - added six new demacroing patches

v5->v6:

  - excluded a patch that was included by mistake

v4->v5:

  - corrected some spelling and style mistakes in commit messages
  - added changing MAINTAINERS too while renaming files
  - added two patches on splitting helpers in msa_helper.c

v3->v4:

  - corrected some spelling and style mistakes in commit messages
  - added a patch on renaming some files in hw/mips

v2->v3:

  - changed Malta patch to perform logging
  - added change of Aleksandar Rikalo's email

v1->v2:

  - added more demacroing

Aleksandar Markovic (8):
  target/mips: msa: Split helpers for MADDV.<B|H|W|D>
  target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
  target/mips: msa: Split helpers for DPADD_S.<H|W|D>
  target/mips: msa: Split helpers for DPADD_U.<H|W|D>
  target/mips: msa: Split helpers for DPSUB_S.<H|W|D>
  target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
  target/mips: msa: Split helpers for DOTP_S.<H|W|D>
  target/mips: msa: Split helpers for DOTP_U.<H|W|D>

 target/mips/helper.h     |  37 ++-
 target/mips/msa_helper.c | 580 ++++++++++++++++++++++++++++++++-------
 target/mips/translate.c  | 110 +++++++-
 3 files changed, 603 insertions(+), 124 deletions(-)

-- 
2.20.1


