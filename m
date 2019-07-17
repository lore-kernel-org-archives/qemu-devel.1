Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1DAC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930F32173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJRHsDil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930F32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncfw-0002ED-DK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncfh-0001Uy-T4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncfh-00057N-1n
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncff-000536-50; Wed, 17 Jul 2019 01:40:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id r1so10237443pfq.12;
 Tue, 16 Jul 2019 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W0rA03HU631KZnI2JAXN5qkOfvFkjS2UXdBozSlCk4c=;
 b=RJRHsDilUsK6WE5c7qo4xFYWty4rI37zbDWC8Z6fI+h1FL1O8Zcy8uZiBp5wU4h5qi
 adSZbwVxU51LJG++4M+MC3ZVPH+Jhd4Nfy6W5FIniHLkOp/+or5h1VdQvQGDLwhc2iZD
 Rk+G0y6lyH9if572Z9Sw4pnJosceQVIxkPbHK7Pbvtc28vxfa+nNrx8Q50mI36/ufnSm
 coUNlI9xXyIPbcCg59Cxs2MBHey/z1DbmyQNsPyDs7hbUt/UPOISrZRq6kQFUKSh9YFX
 eT5DLI+xr1dpVa8Ia8BD8S5WL9Zi4+7CGl8030FKPTIzTZdjEiKuDALre9ZU5gf2AOzQ
 3Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W0rA03HU631KZnI2JAXN5qkOfvFkjS2UXdBozSlCk4c=;
 b=eLWvteB+4mzRLW8tgmteon2ZVb08WxqDh7BscZExwmr+8yOcd6/TBUZvdKG8kKOsCC
 oo8PZJvAdxGnjeBNBfPEawIXPwjO2RGLeC1P89Ltq9/RNR1kiNFnLzJcF3/NFd7FG3Wa
 7L9+hcTOznL0Y4QUxmFJ8d6SC09OwKxLglpf7NrxbCtlezw4Xd2JcZN1/qJDOFSv3r/9
 PEUfyhwOcKhFBX/VWh/PFF05DnzKmLSDnEMaKTYpOHr9lDMVGKuwlTTsIT49tIiHavCf
 ZLoJ/7hthJ6zpkJQhZCl/egjrN6ka2HGLIRu6oenGoVf85uCH/I3GB3cI4xXoBZhn11/
 S/tw==
X-Gm-Message-State: APjAAAUqbRMAvDxLlXw2Q7HL3eBdJHd3cMzC0Yl3SIycnF/Jn6XeDZC7
 ihxn34TJBwBZIUsy8qCL+ao=
X-Google-Smtp-Source: APXvYqwPl1Vr7QDBE8z4PwjO/QHN+TsBs/okze/r9JOrsrAW7LrGaVfIEPKVwB41AR0+laLsSxOyNg==
X-Received: by 2002:a65:50cb:: with SMTP id s11mr38830414pgp.371.1563342004824; 
 Tue, 16 Jul 2019 22:40:04 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id g18sm39322656pgm.9.2019.07.16.22.40.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:40:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jul 2019 15:39:48 +1000
Message-Id: <20190717053952.13729-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v5 0/4] spapr: implement dispatch and suspend
 calls
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the last post I tried to account for feedback, fix style, add
comments, fixed a bug or two in migration etc, more testing, and
dropped the rtas ibm,suspend-me patch for now pending some reworking.

Thanks,
Nick

Nicholas Piggin (4):
  spapr: Implement VPA dispatch counter and prod bit on tcg
  spapr: Implement H_PROD
  spapr: Implement H_CONFER
  spapr: Implement H_JOIN

 hw/ppc/spapr.c                  |  42 +++++++++
 hw/ppc/spapr_cpu_core.c         |   4 +-
 hw/ppc/spapr_hcall.c            | 147 ++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h          |   7 ++
 include/hw/ppc/spapr_cpu_core.h |   1 +
 target/ppc/cpu.h                |   2 +
 target/ppc/translate_init.inc.c |  25 ++++++
 7 files changed, 222 insertions(+), 6 deletions(-)

-- 
2.20.1


