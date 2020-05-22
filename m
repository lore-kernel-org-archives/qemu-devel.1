Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71BB2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPJ3mNqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71BB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxXB-00047z-Ux
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWI-00023f-SR
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:46 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:42276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWG-00055h-QD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:46 -0400
Received: by mail-pl1-x630.google.com with SMTP id x11so2823348plv.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XDhdcN+j5iDcQZfB4w0j46QmOfMVA3mEc/DoJHzCG4s=;
 b=MPJ3mNqqgkDSmGZ0WhDR9fTosnzsUdO6QSbJ3PBaKOZJU0fXX7dhFJSm0m0GcjCsd1
 gYCjE3uDy4IrfLFY6Yrvt7aroRSQF3ERTENqG5DNZGwMuG/hlByOgIKLcZLkEkYwndab
 DORA1Xu28rFpoo7Ge452MhtFv5OfDGWNHZnwvL04WPCNAqn8OZ1pqRga5KkKPuitKl2W
 Ll5ltdTfi4bVy6SPyN5RlWJTUDbrg3K2SJXk5kUK3sK8HIrKj3jGtcWYTZ1NrYisfYPs
 OwqLV5NZ/TbWO/k6JSXtpP1VLm05676LfKLQbFW4ry0XNDUirLJCW2HQGCtgFCkzkEF1
 QYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XDhdcN+j5iDcQZfB4w0j46QmOfMVA3mEc/DoJHzCG4s=;
 b=GtGbgALxfy/ChF/HzZeSY6uYRA4aDl1b8BBnlP9lEKFHD/i8Y7SctVGa5ylxvMRYVk
 rGEA02bNY8zgiL5OXqzc/n2sclyOQr1PMrIAJkvasbpY8q5YgQxQc/H5VE756uONb8ul
 hptLj7YrXUOLkdx37q7EXfLN62sK7T2ukdbC9gZle1sOqxUSxhGqwZRlsBNxL19cBwJd
 hDKVk0bxFhzE6laJtx3HCNiEaxWu/lYWgG8yt9RlXjeSPpUuYQ9puT+SsJJy685jKgUU
 8MWuCIXICyAeI4opp5NZJF2Qj/+g+aZxNH/VXqFpgIwu3O35ZhIftAU4Lq8wgDS+FVgd
 GbIw==
X-Gm-Message-State: AOAM531MhoxOheilS+dx3XXBqSr3ETc4OvYNxrwrhvjBwgmWessZuC0X
 /yOAnCfERVlcVhoMPWisQ1HJ9CwJjp4=
X-Google-Smtp-Source: ABdhPJwpEgWTPp4beg3DW8pLp6JVEYEDTENEpB71WJ77YuCvyEKgF5qhzvL84B3RLkqkMMLZo8HhCA==
X-Received: by 2002:a17:902:7:: with SMTP id 7mr12723016pla.45.1590114882192; 
 Thu, 21 May 2020 19:34:42 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/25] risu cleanups and improvements
Date: Thu, 21 May 2020 19:34:15 -0700
Message-Id: <20200522023440.26261-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 3 changes the --dump option to --fulldump and --diffdump,
after an off-hand suggestion by Alex.

These are now mode options, similar to --master.  Which means that
dumping is an orthogonal apprentice type, which means that we can
dump from a socket.  I'm not sure that will be useful as such, but
I think it makes main be a bit cleaner.

If using old trace files with the new risu, you get

  Unexpected magic number: 0x000078

If for somehow you use different risu for master and apprentice on
sockets, the apprentice will hang waiting for data that the master
will never write.  This is less than helpful, but should be trivial
to avoid.

While cleaning up the interface for reginfo_dump_mismatch(), I
noticed some bugs on the ppc64 side.

The patches without reviews are:

0014-Merge-reginfo.c-into-risu.c.patch
0015-Rearrange-reginfo-and-memblock-buffers.patch
0016-Split-out-recv_register_info.patch
0017-Add-magic-and-size-to-the-trace-header.patch
0018-Compute-reginfo_size-based-on-the-reginfo.patch
0019-aarch64-Reorg-sve-reginfo-to-save-space.patch
0020-aarch64-Use-arch_init-to-configure-sve.patch
0021-ppc64-Use-uint64_t-to-represent-double.patch
0022-Standardize-reginfo_dump_mismatch-printing.patch
0023-Add-fulldump-and-diffdup-options.patch
0024-Remove-return-value-from-reginfo_dump.patch
0025-ppc64-Clean-up-reginfo-handling.patch

most of which are new, and those that aren't new have had
significant modifications.


r~


Richard Henderson (25):
  Use bool for tracing variables
  Unify master_fd and apprentice_fd to comm_fd
  Hoist trace file and socket opening
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
  Merge reginfo.c into risu.c
  Rearrange reginfo and memblock buffers
  Split out recv_register_info
  Add magic and size to the trace header
  Compute reginfo_size based on the reginfo
  aarch64: Reorg sve reginfo to save space
  aarch64: Use arch_init to configure sve
  ppc64: Use uint64_t to represent double
  Standardize reginfo_dump_mismatch printing
  Add --fulldump and --diffdup options
  Remove return value from reginfo_dump
  ppc64: Clean up reginfo handling

 Makefile               |   2 +-
 risu.h                 | 103 +++----
 risu_reginfo_aarch64.h |  16 +-
 risu_reginfo_ppc64.h   |   3 +-
 comms.c                |  34 +--
 reginfo.c              | 183 -----------
 risu.c                 | 676 ++++++++++++++++++++++++++++++-----------
 risu_aarch64.c         |   6 +-
 risu_arm.c             |   6 +-
 risu_i386.c            |   4 +-
 risu_m68k.c            |   4 +-
 risu_ppc64.c           |   4 +-
 risu_reginfo_aarch64.c | 212 +++++++------
 risu_reginfo_arm.c     |  32 +-
 risu_reginfo_i386.c    |  22 +-
 risu_reginfo_m68k.c    |  37 +--
 risu_reginfo_ppc64.c   | 183 +++++------
 17 files changed, 803 insertions(+), 724 deletions(-)
 delete mode 100644 reginfo.c

-- 
2.20.1


