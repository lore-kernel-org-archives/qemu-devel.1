Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000A220809
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000A220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAOR-0003HR-03
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1kcANI-00027i-9l
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:50:36 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:36577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1kcANG-0000nL-Cp
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:50:35 -0500
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N17gy-1kA9wP0VUg-012a7g; Mon, 09 Nov 2020 17:50:27 +0100
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/1] tricore: added triboard with tc27x_soc
Date: Mon,  9 Nov 2020 17:50:54 +0100
Message-Id: <20201109165055.10508-1-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
X-Provags-ID: V03:K1:GQ445xMyMWw1XqYpuWDc3bo9qyS31iYs0UYyk5PvwfexYnbp87x
 lBaCLE3KbKXbI5zw70mO25DarZMo37u7HGzKdCLReTXFHw5MQnlbEsC7U7e3fCYci+qTUyO
 3Zmp3Qlykalb0M0HTe16Eggasld35NvDTJVfa4bdRjBH693NTfiJaYTDJswRaiCgwnasQlm
 rYVfjwwFjGYnHoMssUzEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZecxGkSw99g=:tydT+z6hn4zSpKYOqEq8fO
 NT3VmCl3jrq+EJY1G8qRnc+urcPrqfEDaE+dSkN9os+x+oJQMVyx1ZHgcHj3sYm0HLNekIfK1
 FVHP8cayhAWFejZn5krLnc+Ceh3YLEhsM7xzNfLfuTVnjeZIcMLpKqU4csV+/PrXM5ehI5qlu
 Wj5o2SVx0XMl0NU5I2t8MZScJaxICN4XNSX4oNE+39TwxCqBrThTK+Q+qA9q9mRB+NJtcKv7w
 G8uMwNtYVkqUrG6qgKzmldlqL8cKYZoZDMfCJ97eqM9YrBgFmDGgLulHKPsJPhtIImqobLrAC
 XAa698qaDLYLDF+7AC/P7YeAh4moHYQicH50GU0voluJhf8jnvCfXHQP18/Iqgt3zkYeh+NQV
 ug2GVj/6T+SExhy2zl1rODUq/Has14rTJbsDNgVpMf4XClop0c7u0uWhRmjdvQOpkPFhCVWYt
 hN+ea20OCQ==
Received-SPF: none client-ip=212.227.17.10;
 envelope-from=david.brenken@efs-auto.org; helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:50:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
reintroduced more readable memory sizes. `make check` failed for v4, so
v5 fixed the machine and soc layout to pass the tests.

Andreas Konopik (1):
  tricore: added triboard with tc27x_soc

 default-configs/devices/tricore-softmmu.mak |   2 +-
 hw/tricore/Kconfig                          |   8 +
 hw/tricore/meson.build                      |   2 +
 hw/tricore/tc27x_soc.c                      | 246 ++++++++++++++++++++
 hw/tricore/triboard.c                       |  98 ++++++++
 include/hw/tricore/tc27x_soc.h              | 129 ++++++++++
 include/hw/tricore/triboard.h               |  50 ++++
 7 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 hw/tricore/tc27x_soc.c
 create mode 100644 hw/tricore/triboard.c
 create mode 100644 include/hw/tricore/tc27x_soc.h
 create mode 100644 include/hw/tricore/triboard.h

-- 
2.28.0


