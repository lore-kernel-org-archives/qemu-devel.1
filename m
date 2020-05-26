Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59510204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="viNXlKAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59510204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddKo-0000v9-A9
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJZ-0006Fj-VD; Tue, 26 May 2020 13:24:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJY-0004Lw-SS; Tue, 26 May 2020 13:24:33 -0400
Received: by mail-ed1-x543.google.com with SMTP id i16so18324145edv.1;
 Tue, 26 May 2020 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7u2GsvG5Iw2uNFovUm1HuPYi2RRhX++rHV4M2lgO7tI=;
 b=viNXlKAWJi8ByizwGtOFQuQCVyAWiVvnvKVc819FEMyVrPKE4pxPBdUUE4zNgCJHUd
 2qYmiP95J71S71AqB0w6SjmPFFwBK4gnJwPMC8yblzKknAs+XZyieLYbzMvl9WAIayzH
 O/Pl9HRaHuR5lw5tv3gQtKxdP+3LrJqH5TklxqiLSU9DYYMcfRYy2q5MOwK4WwG5+8QH
 soIxhwwi3c/1vtThGOqlDAY9Qco+fY2B6yqHvzzdoFfIug016qyZX4aL6MpA60oS23lu
 XdZ7EEXooV9TkH3bCndwb7QUMCi4Vq7yyEYtBF9mfE59g7TgEDGkLCRL7V6BlXTxA9mC
 d4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=7u2GsvG5Iw2uNFovUm1HuPYi2RRhX++rHV4M2lgO7tI=;
 b=foYQxzwBtdDqg1ByjBv6sj1Y5nnv20ZGcv/03WOjsJ/d0vzA9v6hceyPar6ub57ce0
 jccmRH39/Upjb2eFH1l1mRLG/9jQq+L+tcSsHtbsblv/HeP/y2sT2rmU5wL9y6YqMQRk
 O6kaY+eiO035yEuLc5pSo4tDz7fyhILmQi94sFipIJndVNdn07PLO1UtiJsWU/DFImcF
 vucVAAshrNWoxZNw+mCSo8J12+LM4U0nRYP1FNWZwO+ZNx2882d1SjWSHrvr9eDPVgcg
 AqFYr/oPvmUsEK3aW8TWuBFUJ2vEmIoEodKWwc721bBfrwsYze0mezXbtZ9sd3/mkh/6
 RAjQ==
X-Gm-Message-State: AOAM533Ra9syUYGd38dCSvTWhTidvlnP+wgOPilQa+gyGj06tC+kUDqU
 TCYBCrnRZ/sPivCa4Srk/52k2sWMO3Y=
X-Google-Smtp-Source: ABdhPJz8b94qY2qLk7y87C9U+5BfmSluRzutt6nds3uNw3hVPTQWskrOctcaVbHACz4JAD4ycJHc9Q==
X-Received: by 2002:a05:6402:c0e:: with SMTP id
 co14mr20675794edb.177.1590513870019; 
 Tue, 26 May 2020 10:24:30 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] exec/cpu: Cleanups around "exec/hwaddr.h" (reserved to
 system-mode)
Date: Tue, 26 May 2020 19:24:20 +0200
Message-Id: <20200526172427.17460-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'hwaddr' type declared in "exec/hwaddr.h" is meant for
system-mode emulation only.
This series is a preparatory cleanup to allow later poisoning
it in user-mode code.

Missing review: patche 7
- target/s390x: Restrict system-mode declarations

Maybe PPC/S390X maintainers can take their patches and let
the rest to Paolo, or he can take all the series. They are
not dependents.

Since v1:
- Do not poison hwaddr type
- Addressed Cornelia & David review comments
- Added R-b/A-b

$ git backport-diff -u v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[----] [--] 'sysemu/accel: Restrict machine methods to system-mode'
002/7:[----] [--] 'sysemu/tcg: Only declare tcg_allowed when TCG is available'
003/7:[----] [--] 'sysemu/hvf: Only declare hvf_allowed when HVF is available'
004/7:[----] [--] 'target/ppc: Restrict PPCVirtualHypervisorClass to system-mode'
005/7:[----] [--] 'target/s390x: Only compile decode_basedisp() on system-mode'
006/7:[0002] [FC] 'target/s390x/helper: Clean ifdef'ry'
007/7:[0005] [FC] 'target/s390x: Restrict system-mode declarations'

Supersedes: <20200509130910.26335-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (7):
  sysemu/accel: Restrict machine methods to system-mode
  sysemu/tcg: Only declare tcg_allowed when TCG is available
  sysemu/hvf: Only declare hvf_allowed when HVF is available
  target/ppc: Restrict PPCVirtualHypervisorClass to system-mode
  target/s390x: Only compile decode_basedisp() on system-mode
  target/s390x/helper: Clean ifdef'ry
  target/s390x: Restrict system-mode declarations

 include/sysemu/accel.h          |  2 ++
 include/sysemu/hvf.h            |  6 +++---
 include/sysemu/tcg.h            |  2 +-
 target/ppc/cpu.h                |  4 ++--
 target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
 target/s390x/internal.h         | 16 +++++++++++-----
 target/ppc/translate_init.inc.c |  4 ++++
 target/s390x/helper.c           |  5 -----
 8 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.21.3


