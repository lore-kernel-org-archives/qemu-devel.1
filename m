Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D402E204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZL7J0RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D402E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFSg-0006Yv-G0
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kEFRz-0005RP-Hc; Fri, 04 Sep 2020 13:24:35 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c]:39067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kEFRx-0005At-QQ; Fri, 04 Sep 2020 13:24:35 -0400
Received: by mail-qk1-x72c.google.com with SMTP id w12so7020171qki.6;
 Fri, 04 Sep 2020 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ioPF2xjxWz+fRYUfPk4cN/IvhOdPaHrWHpRLGdcB5H4=;
 b=AZL7J0RKY7GV7/bhlaamhjzVSzarxC685nBUbYJfu3C6zzju91/sP0x2AFWvc+sUaP
 MeL3cPuJUHo/nHQo/iGIhPxq/VHPpNyMcaSUUPCHbCLv6+wMH1y4bG+xJW5PeL9eSPm6
 wbeoPysw6R7scNGUNwsO6qrxiXG+PnTjRgDSynb38Dlb9McvgAX99VE/+1RLpaQ88XFq
 k7a4V6wIFHNtPIBpIi013BRWe9mO+kKgjBuRCN+oblnL/IALB7lWSBbcj/ghbUIHbzSc
 oDc5GUwcrVeQw3Vi3IdF8hjVyY8DRL/3rruogbrDOAPayjk3ZdoP24rPVKVF8TJoOD2o
 I4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ioPF2xjxWz+fRYUfPk4cN/IvhOdPaHrWHpRLGdcB5H4=;
 b=HZooZPHP4gq2LVfd0HISEKYWiL+Y3F5As5QSzSHuPtFUTLyRXApUhsP//6ZnVje6Ku
 5QZOn+oyHHytcftiqKSdeM3V9tgu4TtZmTaxtVsXDLw9A0YxASjLoHaNvG8j7Nt+C9Uy
 kSPdx+ZlKTT1TaXDFjiOuKUAlKn4HSS1/QgJIaJ7iWR62JHOYp3+Q7H66wPJnCMcFi1b
 kPlkzzNoGJEX9aXjp2xa0QV4kZ1jFoaYwO1niIWlSCud0qd6SsRZr8DaSX5quYEHdQvL
 J9KFgckHOaTaG/ikYEeiG7CY1EzLcsgICk222M4iPsCArJWx3Hz8htM1hcXqvg9Sfl32
 J/jA==
X-Gm-Message-State: AOAM530FM43R9Fv2Utxj4Ha/NkiEVg6s6sWmWhQtS9u/xYHbsYZYzyY0
 vUDpYEzHxxh9jB+wgkEaT5S7oijgsi8=
X-Google-Smtp-Source: ABdhPJwXxjki1EovpyyrCVDq1WfGyEchwVR4eStrJuiN/WtmG8cYZpHs38qKDzNtDKhzw/Z5xf+d8w==
X-Received: by 2002:a37:6393:: with SMTP id x141mr8820051qkb.238.1599240272276; 
 Fri, 04 Sep 2020 10:24:32 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id s192sm3269245qke.50.2020.09.04.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 10:24:31 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/3] pseries NUMA distance rework
Date: Fri,  4 Sep 2020 14:24:19 -0300
Message-Id: <20200904172422.617460-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x72c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

changes from v5, all suggested by Greg:
- patch 2:
    * changed g_malloc() to g_new()
    * removed the unneeded g_assert()
- all patches: added Greg's R-b

v5 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg01978.html

Daniel Henrique Barboza (3):
  spapr: move h_home_node_associativity to spapr_numa.c
  spapr_numa: create a vcpu associativity helper
  spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall

 hw/ppc/spapr_hcall.c   |  40 ----------------
 hw/ppc/spapr_numa.c    | 101 +++++++++++++++++++++++++++++++++++------
 include/hw/ppc/spapr.h |   7 ++-
 3 files changed, 94 insertions(+), 54 deletions(-)

-- 
2.26.2


