Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E0BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565D220786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bj0PEdpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565D220786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCdR-0001hO-Cp
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kBCcf-0000OQ-T4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:47:01 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kBCcd-0008GX-ER
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:47:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id 67so2742409pgd.12
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=tCr3MMz6st5pg7fucz/AcR5Oj9EdPXcjCi4JOTZ6F2Q=;
 b=bj0PEdpxz/nWbCxiAeul7HQ1/lsUfuD8QpatFHPyBv6Zn2cpRFNJZ4XBJ0hKyNMdzN
 NjOmwsSqYaQgtvsmUPKzjAmUFDOelxaUJFqYMRXcIdGwC+tJO+DTVFIFV66nnDFCD35X
 yIGvgZU2BS0ENXv1OPlxq7JayQPXyXYFcRWfjZboIFoOiCTjERCpFQvrxoD1540tGPj6
 T8cDBNrIrXoTFzbsQlybNpGlEjSXMxAhoTnnz7gG2dZJp7coFuReS768FytrR7JKTpYo
 28JDaLAa3C6s2sdXoksqhUHFBIYeFk81PCn4OL4dCEl1gBsLFjQ/K/DJicvuO99LOfEz
 cbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tCr3MMz6st5pg7fucz/AcR5Oj9EdPXcjCi4JOTZ6F2Q=;
 b=rGgajqozYHnw0XaC+G3ByT4LJo20J9aTlSCE+UByFxDVcS8snfX4MBCdg0Y0ryX1kD
 B/qJDee8ncMK2nuAWND30y7tuttFNk4AEGW/ETd7D0nn1OKeA9cZhzHe4BA92AccSBf+
 6zsX/pSrcyqrPunN603ixwOhNdHsW0jU3tW+MSWSiAqnjChrusP75qSUxT6a09CIlIC+
 wcmvAW1hhjgKNnwaXY4hVSc9uR3l3QVh8F4UZ0eVkR+uB3dSp0p01qWajX/dMApZeRer
 jHLOVrZCaSjU5m5F3Pu/wHmYIF5cBIDHgyXemyRTSE6Z6ZQA483Wjv1dmJDxtFdgo6iY
 QiEQ==
X-Gm-Message-State: AOAM531MsPBs3EZOlrVVeSwt2dyOXaDtBnx3CAe7It+I9Y1S4BXG/wRE
 EkYiSFtijJUAfamOTa4N8/JoyQ==
X-Google-Smtp-Source: ABdhPJz5szXl7s00S2z+aa2/eIJyKmsaLkhDM4obxn1GIcxgyWIAxE7sfhIWOyZi7X/dYAhjYXvfWg==
X-Received: by 2002:a17:902:a50d:: with SMTP id
 s13mr15108246plq.135.1598514417375; 
 Thu, 27 Aug 2020 00:46:57 -0700 (PDT)
Received: from localhost.localdomain (111-241-121-209.dynamic-ip.hinet.net.
 [111.241.121.209])
 by smtp.gmail.com with ESMTPSA id k17sm431032pfg.99.2020.08.27.00.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 00:46:56 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v4 0/2] Add file-backed and write-once features to OTP
Date: Thu, 27 Aug 2020 15:46:36 +0800
Message-Id: <20200827074638.21451-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=green.wan@sifive.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based RFC v3 to fix:
 - Fix all nits-related
 - Use blk for blk_by_legacy_dinfo(dinfo) 
 - Move SET_WRITTEN_BIT out from else branch

Summary of Patches
 - First patch is to add file-backed implementation to allow users to use
   '-drive' to assign an OTP raw image file. OTP image file must be bigger
   than 16K.

       For example, '-drive if=none,format=raw,file=otp.img'

 - Second patch is to add 'write-once' feature to block second write to
   the OTP memory. Only keep the 'written' state for non-control register
   range from 0x38 to 16KB.

Testing
 - Tested on sifive_u for both qemu and u-boot.

Green Wan (2):
  hw/riscv: sifive_u: Add backend drive support
  hw/riscv: sifive_u: Add write-once protection

 hw/riscv/sifive_u_otp.c         | 71 +++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  3 ++
 2 files changed, 74 insertions(+)

-- 
2.17.1


