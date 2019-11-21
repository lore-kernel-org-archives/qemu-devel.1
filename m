Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8085C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 00:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B183120878
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 00:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXeWgK+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B183120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXa3i-0001KR-P8
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 19:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iXa23-0007yb-EM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iXa22-0005cd-15
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:11 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iXa21-0005cD-SU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:09 -0500
Received: by mail-ot1-x342.google.com with SMTP id 94so1306529oty.8
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 16:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LnuosNvWWxN4M0Ub7V6G20xasHaJLUMucWeL+3NMq3Q=;
 b=NXeWgK+Ssbx4Zts3a+GEznZ7rnyKg5GgvO6gtlIUPffykMA3WnQY2k8/61lkAfQ74N
 dW3hBjl8UyM+rsE0x6iI5slwFnNxjrcoPwC9p++1r8orqUW+LbyC86/Cal8Xby96uhDP
 yEHTtduXdNxLxLIBqZwPFds+DTcUtI5Y+MV09vtWykaTjhbnMrohllCzpgjYxihw6f/W
 VPQUaJw2GHqMpGYm5+GkSAQ4tDb64WDCtQYsjkpxCft0JjuhsbKRs4qB/rFW5JV0x/q2
 tCrFdSRVzwj5D550Z6Oiw6SBdGQ7o7bShXzExFoF15RS3loTEqBtOyX7Ivi2wQMUZIqa
 ikBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LnuosNvWWxN4M0Ub7V6G20xasHaJLUMucWeL+3NMq3Q=;
 b=fcliHvS9Fd8s3r3E7jC4Hu/+UwZuY6W+ja27RMkDlop+AyTTIiTsHKjiKg973RBgbh
 DUScSzX0e1isTNClTtu7sSG1UCrJBdwsWkWgay6662TMOpO8U+sBYEgeDGbGIUmyDSL2
 ev8RqdAnzdnJ0XUv5RueWlNizPRqA0bLFgjdqjSzRldCu25t4Wwb9Nf5PgWuVuKV/XY3
 Wn9Iaqg2rTWiBFkoTUzAAUYdpqn03TeBpWC/vv3b8Iw6fUvwK3gCHF/8K63g8JCH9xI4
 UiIgqyHvtccFdl5kwcF5o5KJYLllsx6eSzElu8MEwkQQjBGrnQBieuazxqGMSZniXnPX
 QMCw==
X-Gm-Message-State: APjAAAUBez8MwLNACzHTBrpAl9CiNUAcM8fU/YtV4LmIGpWpbFY/rIyV
 TECT9cabDbIapEv9TfgVOKOJF1S4tkvy3Q==
X-Google-Smtp-Source: APXvYqxhhNg1c0F375yrETy33UdkuPy+nXreVkCoPTCe3o/6ihOrVdFsT072/uad2gigwfcWyhsXew==
X-Received: by 2002:a9d:3b26:: with SMTP id z35mr4298201otb.355.1574294948579; 
 Wed, 20 Nov 2019 16:09:08 -0800 (PST)
Received: from moi-limbo-9350.arm.com
 (host86-181-127-240.range86-181.btcentralplus.com. [86.181.127.240])
 by smtp.gmail.com with ESMTPSA id z17sm351439otk.40.2019.11.20.16.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 16:09:07 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] target/arm: Support for Data Cache Clean up to PoP
Date: Thu, 21 Nov 2019 00:08:39 +0000
Message-Id: <20191121000843.24844-1-beata.michalska@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ARMv8.2 introduced support for Data Cache Clean instructions to PoP
(point-of-persistence) and PoDP (point-of-deep-persistence):
ARMv8.2-DCCVAP &  ARMv8.2-DCCVADP respectively.
This patch set adds support for emulating both, though there is no
distinction between the two points: the PoDP is assumed to represent
the same point of persistence as PoP. Case there is no such point specified
for the considered memory system both will fall back to the DV CVAC inst
(clean up to the point of coherency).
The changes introduced include adding probe_read for validating read memory
access to allow verification for mandatory read access for both cache
clean instructions, along with support for writeback for requested memory
regions through msync, if one is available, based otherwise on fsyncdata.

As currently the virt platform is missing support for NVDIMM,
the changes have been tested  with [1] & [2]


[1] https://patchwork.kernel.org/cover/10830237/
[2] https://patchwork.kernel.org/project/qemu-devel/list/?series=159441

v3:
    - Assert on invalid sync range for ram block
    - Drop alignment handling from qemu_msync

v2:
    - Moved the msync into a qemu wrapper with
      CONFIG_POSIX switch + additional comments
    - Fixed length alignment
    - Dropped treating the DC CVAP/CVADP as special case
      and moved those to conditional registration
    - Dropped needless locking for grabbing mem region


Beata Michalska (4):
  tcg: cputlb: Add probe_read
  Memory: Enable writeback for given memory region
  migration: ram: Switch to ram block writeback
  target/arm: Add support for DC CVAP & DC CVADP ins

 exec.c                  | 36 +++++++++++++++++++++++++++++++
 include/exec/exec-all.h |  6 ++++++
 include/exec/memory.h   |  6 ++++++
 include/exec/ram_addr.h |  8 +++++++
 include/qemu/cutils.h   |  1 +
 linux-user/elfload.c    |  2 ++
 memory.c                | 12 +++++++++++
 migration/ram.c         |  5 +----
 target/arm/cpu.h        | 10 +++++++++
 target/arm/cpu64.c      |  1 +
 target/arm/helper.c     | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/cutils.c           | 38 +++++++++++++++++++++++++++++++++
 12 files changed, 177 insertions(+), 4 deletions(-)

-- 
2.7.4


