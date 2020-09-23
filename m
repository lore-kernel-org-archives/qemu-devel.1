Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3E5235FD
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/KMYdpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3E5235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAZJ-00044d-Uv
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXn-0002X0-Cr; Wed, 23 Sep 2020 15:35:11 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:43340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXl-0008UQ-I3; Wed, 23 Sep 2020 15:35:11 -0400
Received: by mail-qv1-xf44.google.com with SMTP id cr8so589344qvb.10;
 Wed, 23 Sep 2020 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t5KFR6tivFfBv67ze4q62VptCBp6KR6G1kHGNM1ZOwE=;
 b=O/KMYdptFJeMX7oGh+A0KPSUaUlBj58Rn732/nGGUD1Ht6xPzu9o4z8QRi1+GwWSbc
 tiI68+/22CnRkkV8Sh6J0nSBcoIDs37tP97v8g8vLF+LfByxN79FkptxoZ5fOKKa3S3Y
 If0MI0sM8ldAd/XmldoQ9Q9PWMC1BUxXeITCgsKmwiZIFBr40YAVfZMQiAU34Kzp9Dwt
 fOl8TladeRcCT+6WLDUjX713+OKLe+7jHyJ2vQZ6RoCf2Oqa+EEX2NLTh958WMlv0Nij
 tw1arbRN/ouE3IAaljWuNKJKi48DjOWeV3bJQlCrMm7CADQQJCe/d/iRGf/Pjjt4Sr1l
 WN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t5KFR6tivFfBv67ze4q62VptCBp6KR6G1kHGNM1ZOwE=;
 b=TTx2t/MjW7q7GBt6wJK/hB+boodwkFBaq2w+hk4XJ5PhFxOJjIghTu71JRmU5jje1i
 W2ZGxiy6TNXLt20kToncmqkOI9M1fD4FOQ9Qj9ZIYw90S0VK/WXAB4u6b8Y0mH4W1VRb
 CWnCy/snMjW5aknBu3bijH+5/QRPyYdvryMQnexqmWL3GIUKcGjSzKERnF1awxz/JDEO
 RDiOdjOfn0omeVRqsbCqUuTGZysI78+uDcKgPouKJnwUkN7jcmNGCoH14Qgx6BnCYyjD
 hUryZbjx6m/UNujwah7EbXhYBPjEoDTlFHy1oxxZkKXTQnVuyDrrpmXVXBg83n1/xAbe
 grEQ==
X-Gm-Message-State: AOAM532MIvr6nzTRB72XeA/PIt33IujZnqighRMq6AOpfvE8pN5un0aA
 vajW9wHSJ0Gr+gs11LOHRThryXIf9De4Rg==
X-Google-Smtp-Source: ABdhPJxkxeOhIuQdAscoIcYGEMYjeRFsM8yRUvBMm68oPnOHJY7P7LKxK2C6wIEOvpZzOcgGQviBFQ==
X-Received: by 2002:a0c:f194:: with SMTP id m20mr1680819qvl.9.1600889707285;
 Wed, 23 Sep 2020 12:35:07 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:06 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] pseries NUMA distance calculation
Date: Wed, 23 Sep 2020 16:34:52 -0300
Message-Id: <20200923193458.203186-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf44.google.com
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

Hi,

This series is a follow-up of the reworked pSeries NUMA
code that is already merged upstream. It contains some of
the patches that were presented in the first version of this
work [1], some of them changed based on the reviews made
back there. 

With this series, we're able to take user input into consideration
when setting up the NUMA topology of the guest. It is still an
approximation, but at least user input is not completely ignored.

The changes will only be effective with pseries-5.2 and newer
machines, and if more than one NUMA node is declared by the user.
The idea is that we don't want to tamper with legacy guest behavior.
Patch 6 has examples of how we are approximating NUMA distance
via user input.

The series was rebased using David's ppc-for-5.2 at
4cca31df828.


Changes carried over from [1]:
- patch 1 (former 4): same patch, added David's r-b
- patch 2 (former 2): the check for asymetrical NUMA was moved
to spapr code as requested in the review
- patch 4 is a merge of former patches 5 and 6
- patch 5 (former 9): reworked
- patch 6 (former 10): same patch

Patch 3 is new in the series.



[1] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03169.html



Daniel Henrique Barboza (6):
  spapr: add spapr_machine_using_legacy_numa() helper
  spapr_numa: forbid asymmetrical NUMA setups
  spapr_numa: translate regular NUMA distance to PAPR distance
  spapr_numa: change reference-points and maxdomain settings
  spapr_numa: consider user input when defining associativity
  specs/ppc-spapr-numa: update with new NUMA support

 docs/specs/ppc-spapr-numa.rst | 213 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c                |  12 ++
 hw/ppc/spapr_numa.c           | 184 +++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h        |   2 +
 4 files changed, 402 insertions(+), 9 deletions(-)

-- 
2.26.2


