Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B06C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBA52075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtmaXZ9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBA52075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasPG-0006cn-0B
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOH-00056b-BP
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:01 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:43409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOF-0002OF-OQ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id f4so5725260pgi.10
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wKGbphf+Kes9iMm8h2LB5BORjWrEvB9cReHSSjeTBt0=;
 b=ZtmaXZ9HsAlL6finuK9klFppWpOoPTBYCPbJHL3cGL1KZ5A8KZHYDMYCyqUNzFSbH7
 hcDM/rPeviTxERi2eua4yr81pk4Geb5jNzRyqd7sIaJOSVpNmfeKi86QY+gaCQ/8qca4
 GfhE3mTq0XsMtg8Mfojh3BSSOchIQMuDf26fdDa0TXyU6LlfhsgAC2rrsRKI1FKJ8I1R
 Z3WplsYtYTULhxTqjl+sLziaQxdUvU8UqaABYAGTYiDQduNsMvGiqrFXP04HpD4Tc4Ns
 yTMhxaRsHC3jY4ImcDx5nS3tqrNrTilmjxQMQb6pUMzFDH2V833PmPuv/aIHpMH47TC2
 wriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wKGbphf+Kes9iMm8h2LB5BORjWrEvB9cReHSSjeTBt0=;
 b=Zms6m1xjPiF3dvSoe4cBB0eP0+3tXgxa4ydsXKtDIBcty/0UCdteVM4C5Wi/FPddvh
 wvvA5bzfjvYINFarcEgGrcqAhVwurp2vF+3R/NPgpt1K45ojmbab+TLelv890CvTFBpf
 eY4s3h+dLWFP10NRFtirTPnoXZNUYkFJQn87fGlla33Vst12EY8lLQ6Jtt8VDiokowQk
 9w3y4F35uknu/oSN84w2w93lV55Jv6FgEl89BW0naNbGN1ieEMb7XEbCp/ZbEdZZr1tI
 YmIG7DJsS4D3N5uLgoXk2dVCC2wB+SDrocVbKDoKfybaRsGlqtFYCXCvfX1K0dJk/oii
 kVOQ==
X-Gm-Message-State: AOAM533xmeXMr8QLrdI/LHZbBOY90qM7T6laW27LbwrRi1xacAYRzBIU
 VSawyPCNfbZXKOsKAwSvKHiAlPNF5Ss=
X-Google-Smtp-Source: ABdhPJyGroNnEMu5CLA/wWZMjUSA4qHG90hh/q2aj7gj4OwX0nFOQRziRqRPDkrBg0Mb6njtGo1adg==
X-Received: by 2002:a63:5fc8:: with SMTP id
 t191mr17592126pgb.185.1589856837536; 
 Mon, 18 May 2020 19:53:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:53:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 00/17] risu cleanups and improvements
Date: Mon, 18 May 2020 19:53:38 -0700
Message-Id: <20200519025355.4420-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set does alter the format of the trace files, and thus
means we'll have to re-generate these.  However, the space saved
for sve trace files is significant, so I consider it worthwhile.

In addition, the new --dump option allows one to inspect the
contents of the trace file.

Version 2 adds a number of patches that clean up the whole
reporting of errors thing.  This allows us to give sensible
output when things go awry.

If using old trace files with the new risu, you get

mismatch header after 1 checkpoints
header mismatch detail (master : apprentice):
  magic: 000000fc vs 52695375

If for somehow you use different risu for master and apprentice
on sockets, you get

i/o error after 1 checkpoints

Which is less helpful, but since the master has not written
enough data to the socket, the apprentice notices and reports
the i/o error before having a look at the header contents.


r~


Richard Henderson (17):
  Use bool for tracing variables
  Unify master_fd and apprentice_fd to comm_fd
  Hoist trace file opening
  Adjust tracefile open for write
  Use EXIT_FAILURE, EXIT_SUCCESS
  Make some risu.c symbols static
  Add enum RisuOp
  Add enum RisuResult
  Unify i/o functions and use RisuResult
  Pass non-OK result back through siglongjmp
  Always write for --master
  Simplify syncing with master
  Split RES_MISMATCH for registers and memory
  Add magic and size to the trace header
  Compute reginfo_size based on the reginfo
  aarch64: Reorg sve reginfo to save space
  Add --dump option to inspect trace files

 risu.h                 |  88 +++++----
 risu_reginfo_aarch64.h |  16 +-
 comms.c                |  34 ++--
 reginfo.c              | 274 ++++++++++++++++-----------
 risu.c                 | 409 +++++++++++++++++++++++++----------------
 risu_aarch64.c         |   6 +-
 risu_arm.c             |   6 +-
 risu_i386.c            |   4 +-
 risu_m68k.c            |   4 +-
 risu_ppc64.c           |   4 +-
 risu_reginfo_aarch64.c | 192 ++++++++++---------
 risu_reginfo_arm.c     |   6 +-
 risu_reginfo_i386.c    |   8 +-
 risu_reginfo_m68k.c    |   6 +-
 risu_reginfo_ppc64.c   |   6 +-
 15 files changed, 635 insertions(+), 428 deletions(-)

-- 
2.20.1


