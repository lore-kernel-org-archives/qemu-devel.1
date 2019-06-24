Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06358C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4B72083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4B72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfJAh-0001qZ-52
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 03:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50273)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ6G-0006zm-Vl
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ6F-0007ex-TL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hfJ6F-0007du-Ik
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:11 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIMXE-1hkkWy3Ew8-00EL1U; Mon, 24 Jun 2019 09:04:00 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 09:03:34 +0200
Message-Id: <20190624070339.4408-1-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
X-Provags-ID: V03:K1:dAC/+7feklQbpuTL+vIAYwysSkPEU+3EdO7UBUAtMQDje700H37
 1dYO2/Sw/Gn1t0FvnSxeLTS1WxuhQiTUEsG+BDqehlePs8Gloh3Wckdo6WuNP08oe0oiK9r
 dzarTyigGebsn/VMLt2go5As5iIuOqRQcsIlX90auq2aFoT5qyNvxoXS7tcGnPibNONy/4v
 qeluAXGjPPpZUdg3i0+rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQPK480QSog=:BNXN5zmF9yebmi0vyuhZ/T
 joHVw7w0F7UM6XKUsT3r1DPsJZ4AlKPxjpTND/PCj1vHaakk1nra795RGVfTuAoE/vd7frYAG
 JMsViN36GaZFZdIGL34jlWaZDvHYu8kL3dRHB4EPsEXlki6WIcxAGMkmjqdSyGVFB23hUO7eE
 kOio9YHMM8qvDbmTThzKjkwD79GGU5djmsnrh+bDP0lDtmjuOK1JS647kjXzaZ1+MVl+yRHIc
 Y9s8sE5CmZgpd3yh1Dx+ZBy/DIsJK02uO+/AK9sTJFMx11aLHOggrRdmt2Xov74y+LSzF5Lcu
 AbTF4IedFwWqpQbeivTjDrfo1ezd4saUNNblPORmMx8xGZfMmgKUBMbuHnqybRErZSCFlHPc5
 5lxr49X6XYFE/+wc2scbV/u/k0zNXEkx/34zPSbzc75Um4yDonDnDEZjUf82UzrkXgFgxi34R
 ug92PprFgGoTUbUQgDNU8YV37/PHNQHfpDNUiIsTK+1FOVY88l/iFg8WO6CIZl+MZue/ySf+U
 jdBn/fbwca5mDGG7wo0TCPP+uFBS6oWjWR0CIBWEMuJMvnyY0ml5t+6yub7PZEqHHOEMCDWVQ
 kH5LTYbi1WmETBxzWV8IeA1PkeIDEfCA9YM2MvS8+fsqbf3V1J/M2ZaB4GnotyyrA9UnqLkw6
 MKvMcZzWuR4TWQXLv8F33Kov9xIcsT6m69G4RbryPDtrZ/7dTkOevGb1w1N8KAb+tLqtM/hrB
 zgOChC58DuAKMZWX08QRsLvDhyg+LGdV2MXCY8Db0Px7DRgnAkrkR/0Rlus=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PATCH v3 0/5] tricore: adding new instructions and
 fixing
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
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Brenken <david.brenken@efs-auto.de>


Hello everyone,

as discussed here is the third version of the patchset.
- We finalized the implementation of QSEED according to Bastians
annotations.
- We do only sync ctx.hflags with tb->flags.

Best regards

David

Andreas Konopik (1):
  tricore: add QSEED instruction

David Brenken (3):
  tricore: add FTOIZ instruction
  tricore: add UTOF instruction
  tricore: fix RRPW_INSERT instruction

Georg Hofstetter (1):
  tricore: sync ctx.hflags with tb->flags

 target/tricore/fpu_helper.c | 125 ++++++++++++++++++++++++++++++++++++
 target/tricore/helper.h     |   3 +
 target/tricore/translate.c  |  13 +++-
 3 files changed, 139 insertions(+), 2 deletions(-)

-- 
2.22.0.windows.1


