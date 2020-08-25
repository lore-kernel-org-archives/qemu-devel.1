Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25589C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16F22071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPyV0Owd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16F22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgy2-0004AB-5s
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgx8-0002Ga-3F; Tue, 25 Aug 2020 17:58:02 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836]:41896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgx6-0000Xn-Ba; Tue, 25 Aug 2020 17:58:01 -0400
Received: by mail-qt1-x836.google.com with SMTP id t20so12877qtr.8;
 Tue, 25 Aug 2020 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FEigj0tks3uCXSAIXp/Z8YnpMQG37caq+pO/8EeIF+I=;
 b=BPyV0OwdeuqoJ0E4Cc3TFOKfFD1mC5vfHEsDzIMrAyTTBKNF5hYixFWfbReQIJPsdi
 eN1zxHCA7yFvxHQRkY1raTc9TX83VUnqN1ri7/1y91S54ILabJAZHhBEEKUn0YyI/s+z
 QKgFcUwfftbDpuZxVD5XxNrBvdqPafFjlBsMOTI6ySMd1+1nQU3BuMIbeFW0DwAbTTdU
 LYgupnlQWD9+l2P/6MeBJdAT4B6yrKC0eM8L1P51uDPAGLB99weKy4qzsL5ERU7Eg+YB
 YUVbqJShFVVOZZVkEwfcIxZyk5FhdtkQd5fb9XaA0cFbTK/fG9Hu46KL0ncJ1zEU1giE
 mpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FEigj0tks3uCXSAIXp/Z8YnpMQG37caq+pO/8EeIF+I=;
 b=Dc2eymSXYDVdT1InZhOS7ZqR77emRMHYNtJ3FvLRBpcLKBw3HeR6zd/qxMKmWHqaAd
 Hb+hSdehsLEQjruMhsoCcEM5F/sMcc1pnQpgG0ZotDxcQRPZwaDPetZAQL1RgsD4dM4E
 9rz95jWS4BEVwY9IThIUbWLCW9DG+ys8Z1z6EgWTlQxup0AcDOWvNee9aHZOyVEkqqi9
 QNjhxqhwq+Q1QZ56OEzK/auFXnzWagEC23l6zs/IrYj59mMAjLaJG8QIUtn6RxNWTfZi
 BAmtXeCSE6u1zpIWtLpSYYx3qTD5fhOgHY3HTk/6TWfSi+nU9Rg3KOH9p3sRy6xk4/l8
 gBsw==
X-Gm-Message-State: AOAM530ARzIlbm7ZfbCpxB7JGs3Q+0CjJDjV+z6tpFzU8AiqyZujP9w1
 E0tEXgXulYfB6p9rRR2oxPq+nvBsj4o=
X-Google-Smtp-Source: ABdhPJwacyXXNLaSYSGtRgMlwsiJq8VIx1h6rX+RiltksMu15xZ0NeL7czfxFiuhZW6jea4d7+m+0g==
X-Received: by 2002:ac8:3568:: with SMTP id z37mr2466535qtb.59.1598392678046; 
 Tue, 25 Aug 2020 14:57:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id z2sm347362qtu.11.2020.08.25.14.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:57:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] spapr NVDIMM: consider 'nvdimm' machine option
Date: Tue, 25 Aug 2020 18:57:46 -0300
Message-Id: <20200825215749.213536-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x836.google.com
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
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series aims to solve bug [1].

First patch is a trivial cleanup, feel free to squash into
patch 02. Patch 02 attempts a code simplification to put
all NVDIMM related logic in the same function.

Patch 03 is where the actual fix is implemented. My initial
approach here was to make the handling of '-machine nvdimm' for
pSeries similar to how it is handled elsewhere, but I wasn't
able to accomplish that without either (1) breaking up existing
pseries-5.1 guests that didn't care about this option or (2)
make pseries-5.1 and pseries-5.2+ machines to have different
semantics for it.

I ended up doing what I was sure was sensible: if the user puts
'-machine nvdimm=off', we must comply to that.


[1] https://bugzilla.redhat.com/show_bug.cgi?id=1848887

Daniel Henrique Barboza (3):
  ppc/spapr_nvdimm: use g_autofree in spapr_nvdimm_validate_opts()
  spapr, spapr_nvdimm: fold NVDIMM validation in the same place
  ppc/spapr_nvdimm: do not enable support with 'nvdimm=off'

 hw/ppc/spapr.c                | 18 ++++++------------
 hw/ppc/spapr_nvdimm.c         | 31 +++++++++++++++++++++++++++----
 include/hw/ppc/spapr_nvdimm.h |  4 ++--
 3 files changed, 35 insertions(+), 18 deletions(-)

-- 
2.26.2


