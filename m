Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFAEC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0927F2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lk7ZPi/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0927F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS8Tn-0006gG-Mw
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 18:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8Rz-0005Jx-Kk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8Ry-0004Ns-2l
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:27 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iS8Rx-0004Ll-R3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id b3so17795934wrs.13
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3G6n6Zl5Ml5xiNIOzQAAwJRvPoWHJs+oXuob89eeLPI=;
 b=Lk7ZPi/sETD/d31zTJ/vC793sX4S0YjuWhqcFhBTsdKrnYpqIC60AacfL5l1zNyasT
 hN53PQo6yI9MywpnPr9bZIeEkqceyNOn1bQHrdutmqok5u+92jKS6YI1SBXGdWWEXAPI
 fJSR9qpxiCGipXRPhPuhV9Wzpd+nG0reJJzDnbc/KpFHbRvMdE01xuTzSuZ6xlEcElUX
 Mia7r4OLP/nyUG8WygLry3Azl1k+semlQvQlNDtGCnBFWCW3tgOS8lW/yzus0X+cQqYP
 PnPsqxvFezn1xeVx7XBF7hDsORzCwmHHWqL3mNLXr/WhFTYZOIph9vMJqYCC52FwkzTX
 EUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3G6n6Zl5Ml5xiNIOzQAAwJRvPoWHJs+oXuob89eeLPI=;
 b=cKBjoLvANK0b6hzDqSLJSeGWnD3r5eFZB63MbJn8jilEZy/B1rL45DO/8ZAh+9k6EH
 9KT0RZ5RZgk6ImFbMSPODAX/aIgCTOo92Tl7ecZPrBNGPmIL78TNVlznnoWwq9MHep5C
 Iio3dunU88KgAdKMf+OFxKUhds0r7sg0VRv2b5VnXlqoY6VmvZ2hkp3OcBuV/izIQ5JN
 by6OEZhOfGdppmzmmlHcgNhHirWBvsBY2tuK8kURhNxdNBsuYm2CaBof945PjYOO5P98
 uneVdKF9vcv5JC+NJiA3JOrVrGSxYeLTcyqh9Lo3cvWIQXzgAkLjfEuYXdXtRosihSwd
 tp+w==
X-Gm-Message-State: APjAAAUAFTBDsDhXfzpBlWEnnONLEqg0MflkM/rlIRHNyGkQ5j0nXex0
 cBIXFmgl7T7XikEWVipn7KtU3JYgEjXI8g==
X-Google-Smtp-Source: APXvYqzR1CB7JCYrDPVqOliBqDOtwPa+A221ANbOtGPtaF6iLq7ksr2cTBp6yd6j/Rrn5JAlx0vOjg==
X-Received: by 2002:adf:e886:: with SMTP id d6mr9080066wrm.188.1572997284024; 
 Tue, 05 Nov 2019 15:41:24 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-144-13-94.range86-144.btcentralplus.com. [86.144.13.94])
 by smtp.gmail.com with ESMTPSA id q25sm27295010wra.3.2019.11.05.15.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 15:41:23 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] target/arm: Support for Data Cache Clean up to PoP
Date: Tue,  5 Nov 2019 23:40:56 +0000
Message-Id: <20191105234100.22052-1-beata.michalska@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

 exec.c                  | 43 +++++++++++++++++++++++++++++++++++++
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
 util/cutils.c           | 47 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 193 insertions(+), 4 deletions(-)

-- 
2.7.4


