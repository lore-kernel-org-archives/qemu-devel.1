Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61C9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B28320715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B28320715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsQRg-00020Q-Og
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 08:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jsQQX-0000a2-CR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:40:53 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jsQQV-0003wr-AI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:40:53 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mc02T-1kUE9E2DMN-00dTyU; Mon, 06 Jul 2020 14:40:43 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/1] tricore: added triboard with tc27x_soc
Date: Mon,  6 Jul 2020 14:40:29 +0200
Message-Id: <20200706124030.7280-1-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
X-Provags-ID: V03:K1:dZUnKO8a9B+0b38QnwE6Z3KhYGvI9iUaOhTRn0iEP6h+b4h+c+H
 RHx0ce8cEyoOjPdnys8VJO6hLw/tJS1hPxNT8zInjCIM/OsxJIWQwcwNGYcs+wR12XnxXjf
 mHm7NYHMzi53Isz0b9u5ic1bePhoaaNrQpppj8L8fj4Wjw9vwhw8P8F4FJuXn4Tqkgj77FU
 j8ZhuFqx1u0W4nENgFBfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:44Rd3ucvs4A=:pVr7EYg2Naa+NW1hTT+g3q
 yWn8HvHi9uhPLA2fK6r/L4TaWSAxPr3wY6EyQbPDtxo5jhbcDdoFwA+KdWy8UHY7x/chDOvNR
 tlOX9fESL9jazaSHXpDpt68WrMRYs2yFzCZvKj6NcJz3v80lwvYFDoBQ/hMxOsvVpc/dpl0Jo
 /IRmrk3xK6JlCy9qOxbalugI6ZpJOfFlEFl9wk8zkRRGMdiFvHU4w9ZKYrMGquEFJRuhpCkzf
 LhI/eBYuYoF5sQ2PZZF59cpSgQaZzH7yAaVtX9bb7UISsHcuVvw3DN/Yu97YkIdoq9o584N/C
 RucWYGoQIkwH5Mm95Q4x2XU9l5tI6EFq5dBnjfgKqEzkGbNDsBgnsdIdaj4dED7fP4ZJ/zE9i
 vcJfUsBp7Hzxvn5i4Y09gzp578dTUdOmT8YyTs1L9bcxaxEe0a4d0QZ9oa/srdoTWJ5ai+mnP
 YExJMUuDQz01JxynnLXAUjaoWt1TuC8MUEV8M6ps+MTyFlVDRsIb+1VDG4s/N3881mjEyRzIa
 DEN1/b0su2FnhlcxqV3W5rERxfl3LipLZYLn/1Dgw/Ofaw+knsGPIv82UR5G83VDTuaGCzM1r
 Ff12a8X3zmYOoROfY58p1m2BkC90bB3HTPcJGk5m8y1xHHsbVYdku5h/QayYcduobwq0J1J4D
 hnnoKr6DdlfJ5Ank1uT+u7j8h+A9SDKRo+e115dLJOcEHk5562JMtTd3zze4G1LJoXfjk6Cag
 1aaA7321c0CxRNZbDJ0XYlJERY7XsvCfs5NBDXn7pqr0Bd/QSIRdU7k2Oo+xdNe1G/A7fcjty
 pe41MYj0CKV2wcBbTfcgS2OJe6WslrhKjY/Fh1XVMXo1YSS7xKDOnXkqUYV7fJq6JOME0gB
Received-SPF: none client-ip=217.72.192.73;
 envelope-from=david.brenken@efs-auto.org; helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 08:40:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: kbastian@mail.uni-paderborn.de,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.de>

Hello everyone,

this patch adds the AURIX TC277 D-Step TriBoard as QEMU machine
(-M AURIX_TriBoard_TC277D). Memory maps are implemented according to the
"AURIX TC27x D-Step User's Manual V2.2 2014-12". AURIX memory layouts
are specified by the processor, that is why this patch has been reworked as a
SoC-implementation for v2. Patch v3 added sizes to memory mappings and v4
reintroduced more readable memory sizes.

Andreas Konopik (1):
  tricore: added triboard with tc27x_soc

 hw/tricore/Kconfig             |   8 ++
 hw/tricore/Makefile.objs       |   2 +
 hw/tricore/tc27x_soc.c         | 247 +++++++++++++++++++++++++++++++++
 hw/tricore/triboard.c          | 102 ++++++++++++++
 include/hw/tricore/tc27x_soc.h | 139 +++++++++++++++++++
 include/hw/tricore/triboard.h  |  53 +++++++
 6 files changed, 551 insertions(+)
 create mode 100644 hw/tricore/tc27x_soc.c
 create mode 100644 hw/tricore/triboard.c
 create mode 100644 include/hw/tricore/tc27x_soc.h
 create mode 100644 include/hw/tricore/triboard.h

-- 
2.27.0


