Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDDC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CE62067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HY+4w06f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CE62067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cuW-0001Np-B0
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct0-0008P7-KH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i7csz-0002XS-8H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i7csz-0002WZ-33
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so6705501wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=64ABiwabwec/jyTMQAJqG7C3XJSwzw/xE4Vr+VwrIq0=;
 b=HY+4w06fNHu9p5eTBDH4d87As1kJdg76FLXuQIHE98gT3eXg/DmyN8qL4wYS+oBMcg
 k4hes7VfpHH4EB24sfS4VoUWEwlbv7A6nikbFbCGdwzlgK3oZXrjD2mzLi2OyCvjuYS8
 SZapcfZTiySy29M23mwTRbzcxQQTCciM23G7ulYzUTGzHKlB+3uUPqcZcfcSNiG9x8tr
 XtKuy+0Q6LhA647UIHNLSJW0lxUvVYA/190bNN/KG75rtbeKuIiqUjJJnTdTyw+mTt1K
 owmgiZZjQRJDHAUlygmIAyyifM0UPbzGXuNXJrmsGXebGEBpxkiZ1JPi6otEePMy+7is
 nfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=64ABiwabwec/jyTMQAJqG7C3XJSwzw/xE4Vr+VwrIq0=;
 b=bLtcjVUSvp50BLli+G9W1S1wF2K3uAv+jtd08dwawobj1r2RH1ncj4osg7cvrYbUXE
 WYg2C6JNNpXaJRbwur4n4mD34T1H3WshXqk9jLlniMEI+POEL7tMSQmu/hJuvqiFT/ir
 FselfVzvzWXTNSmyWJOyaKlSxWMiiNg7eDr2NFinFW7DwLlVr71zyTtIQj/v7bMT8UCc
 IYa6gpVBbfD7fSDMvXiuOomjGEZarER6wewJzG+7ZK6rzgP7vSQBvBfAmtnGkUXqL+t+
 cXeZx8caiUKnYil2Q0kfieFHc3ze7ZgKAT/mOtMlUttao28PU2jnKmHvHjnkjzJ0AIWJ
 QWHQ==
X-Gm-Message-State: APjAAAUEo2iqtVhG+jOwLvwZxlMi0JlK0H6q4XF/kyzh4y44SIwSbiOj
 Ap/NK2jqPVHvsmSVYFZ9YbL9mhf97IP01g==
X-Google-Smtp-Source: APXvYqxtf8XbZuKXoLr+kJxkZ9oAhQlOuvZQHftoytoQNxH1u0JIwm7Nt/ssO2oXmdEjFXtTu0Qeiw==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr24657511wrt.79.1568109391128; 
 Tue, 10 Sep 2019 02:56:31 -0700 (PDT)
Received: from moi-XPS-13-9350.arm.com
 (host86-144-13-57.range86-144.btcentralplus.com. [86.144.13.57])
 by smtp.gmail.com with ESMTPSA id e30sm32403540wra.48.2019.09.10.02.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:56:30 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 11:56:06 +0200
Message-Id: <20190910095610.4546-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Support for Data Cache Clean
 up to PoP
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
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


Beata Michalska (4):
  tcg: cputlb: Add probe_read
  Memory: Enable writeback for given memory region
  migration: ram: Switch to ram block writeback
  target/arm: Add support for DC CVAP & DC CVADP ins

 configure                  | 24 ++++++++++++++++++++++++
 exec.c                     | 38 ++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h    |  6 ++++++
 include/exec/memory.h      |  6 ++++++
 include/exec/ram_addr.h    |  6 ++++++
 linux-user/elfload.c       | 18 +++++++++++++++++-
 memory.c                   | 12 ++++++++++++
 migration/ram.c            |  5 +----
 target/arm/cpu.h           | 13 ++++++++++++-
 target/arm/cpu64.c         |  1 +
 target/arm/helper.c        | 24 ++++++++++++++++++++++++
 target/arm/helper.h        |  1 +
 target/arm/op_helper.c     | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  5 +++++
 14 files changed, 189 insertions(+), 6 deletions(-)

-- 
2.7.4


