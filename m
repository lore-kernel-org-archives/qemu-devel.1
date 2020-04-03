Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31A1C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6369620737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhVSvNfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6369620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQAG-0001Ad-CN
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8K-0007ql-PZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8J-0006Yo-0O
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8H-0006XM-CX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R3GkLnBVrlygAh564ijQ2XeDEBB+bc8f6Pu1+Pf2bBI=;
 b=NhVSvNfeC/Fd2usg1wiwbySnsPRX1w/UzDvJvHpQNpHM20zKIG8v7ur+2d/s7CYabhAqpV
 ds/vhZOqbthWOYB2YGcmxp6VRRQXgNDTFupSkg0JgvJ4dwMUFO9auIy/Ib25nPzsw7CXNh
 DmHFJwLRfVXE/1YNYdCagVb+yzIzvmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-iZHomVdsNDu2yDBEI4NcCQ-1; Fri, 03 Apr 2020 13:29:24 -0400
X-MC-Unique: iZHomVdsNDu2yDBEI4NcCQ-1
Received: by mail-wr1-f69.google.com with SMTP id 88so763626wrq.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GpI5xzk/jCg0uIJw2Hn3RlhyjeM4huSMz4ugb5HgNa0=;
 b=TbnmsoaPqqnmco1QvFme+SbZAQqM0PyGM2C/STxwrmHSoN3fp7UidUyj5LkHbRXZ9A
 c1R81SI9j7XMHTWTs6ctYvquYoCg0I2PCoE/ejISUgxqaGpCJdTqAH1S2aeegyDUkAd1
 Cf9lcv6vA4RFuHmPcR39NvYqww4dyUrYyXdAvTDUwZhl8TugQ0lkQNZTdKc6GeDs3sg0
 sxCxdh/Pgb3Z+zuH72VPwXWgtGU6Itpyzgq760zz/k4Tx4Eo1Vx5Awi2XQXMnaLPPeZy
 Z970p+e/oDtz0QQFxodgqr3Hs2tMAqaRcUDEfW7BAmw2kNkgK1yHrowXyIeKDz4qj/SH
 zeSA==
X-Gm-Message-State: AGi0Pubq+jCtgHEzFlNbs1hcRLSstzwXu0PWk+fsDYBN3W5DJo5W4f7j
 h1C2vp7n1m2Wa4dzlOGOAI2S+WnwlalpGuLlvj8GeCRyjXqMtvFFoyOaTKDJo81hjoao1LACv++
 Q/8lQqq5jcY2tbEo=
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr9698540wma.35.1585934962960; 
 Fri, 03 Apr 2020 10:29:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypLtmjZw7w0GY+KaNNR8UBc1AJk3+nny6WQpgnahAwRjky7F8NOee4gz1H/tcY9Zn2n5kG+u1Q==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr9698523wma.35.1585934962724; 
 Fri, 03 Apr 2020 10:29:22 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a7sm11740330wmm.34.2020.04.03.10.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 0/8] Acceptance tests queue
Date: Fri,  3 Apr 2020 19:29:11 +0200
Message-Id: <20200403172919.24621-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm planning to send the first 5 patches as
This series contains acceptance test fixes, and Travis-CI
improvements. I plan to send a pull request with the first
6 patches for v5.0-rc2. The last 3 patches helped debugging
painfully the Travis failures, but can not be used because
Avocado 78.0 is not released yet.

Patches 3 and 5 are not reviewed.

Up-to-patch 5 job:
https://travis-ci.org/github/philmd/qemu/jobs/670645531

All patches job:
https://travis-ci.org/github/philmd/qemu/jobs/670645611

Oksana Vohchana (1):
  Acceptance test: Fix to EXEC migration

Philippe Mathieu-Daud=C3=A9 (7):
  tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
  tests/acceptance/ppc_prep_40p: Use mirror for ftp.software.ibm.com
  tests/acceptance/machine_sparc_leon3: Disable HelenOS test
  .travis.yml: Cache acceptance-test assets
  tests/Makefile: Add fetch-acceptance-assets rule
  .travis.yml: Run fetch-acceptance-assets before check-acceptance
  NOTFORMERGE Kludge for Avocado issue #3661

 .travis.yml                             | 4 +++-
 tests/Makefile.include                  | 7 +++++++
 tests/acceptance/machine_sparc_leon3.py | 4 ++++
 tests/acceptance/migration.py           | 6 +++---
 tests/acceptance/ppc_prep_40p.py        | 7 ++++---
 tests/requirements.txt                  | 2 +-
 6 files changed, 22 insertions(+), 8 deletions(-)

--=20
2.21.1


