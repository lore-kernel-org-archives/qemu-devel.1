Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D91DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEFD20644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQO042dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEFD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlee-0007ku-DA
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLldi-0006KC-Ll
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLldh-0003bd-Al
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLldh-0003b0-7G
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586255968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zXccNtyJvSSfmNuK/smApcKIAnMqAlYg2fStNricR54=;
 b=RQO042dOjMJ6Xkhum5UxZYX8Zmy7v4RSqVHo8TjIVMDd9Jyu320lvKhHJkcD/WPgE4c2uW
 KPubOzExRMr4KUWQppwk8HIyRbnbJeQBIKc8/koFTKMErBbnXBAMPG70SFoYjY6YkbSIfi
 oh+v4/l6eulS1v4uLXXIZvpqHf5a/e8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Lk_ZQ5rcMZKcmBFSnd_ooA-1; Tue, 07 Apr 2020 06:39:25 -0400
X-MC-Unique: Lk_ZQ5rcMZKcmBFSnd_ooA-1
Received: by mail-wm1-f70.google.com with SMTP id e16so536535wmh.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 03:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z7ht7sUyvJ0yZvgeQteqQtXj/MQfa7Hr+mhEF52Hot8=;
 b=JuYV9sMOQdJax8HBhV4wrMf/ukHIXL+eAZUPCd6Zvxp1d0otPN23uUBb7q+P1GUYZz
 54enupN13apeUVSPj6mNEgaBbId64uQ8TqNeu8RE0acW1o09y4j2gCaNU0gnx3J7fBNQ
 RGosqVftzau9hCc4RF8RL3xkyuC/bo2L96IKifs9j1xiULfA97IohUZfjC3cHAJhu33V
 +uvb2s6GhUIhpAi4+MpYU2W+e/SoLkO1xpv0WEjhKNDFT72SaMcecleoN+KQDE4jX09Z
 8VxVTZPZLztphBie0sq9upWNbECIW6OLgtGgFoT69mZv7L9rNVg137v2NOhSLZX36qVg
 8PVQ==
X-Gm-Message-State: AGi0PuZhkrm9cZ/5OvpdAGcTFoEbDs1ss+v3Vb9FkOVQ0WM3bKM0dNuX
 l1adaUr3H+gXAMmBk3vLVLiYxIL4oPqU1PekdcA/9KE53OBAIb14JgNElZNpPCCByzbCB5m7LBF
 9lV7zTljB/DaLDfc=
X-Received: by 2002:adf:a343:: with SMTP id d3mr2021606wrb.163.1586255963716; 
 Tue, 07 Apr 2020 03:39:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypJioYH3mIIOAFgZWsxnpnHARoZj5r9FR9v1SXOxBNdCkxo7rQaVH18hVGW5xGCrsjECKswXpQ==
X-Received: by 2002:adf:a343:: with SMTP id d3mr2021580wrb.163.1586255963370; 
 Tue, 07 Apr 2020 03:39:23 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o9sm29851225wrx.48.2020.04.07.03.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 03:39:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Acceptance tests fixes for 5.0-rc2
Date: Tue,  7 Apr 2020 12:39:15 +0200
Message-Id: <20200407103920.32558-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another pull request on behalf of Eduardo and Cleber.

The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
40=3D
6' into staging (2020-04-06 12:36:45 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/acceptance-fixes-20200407

for you to fetch changes up to a41f167547ec4e4752795572193d1cbb889c4885:

  .travis.yml: Cache acceptance-test assets (2020-04-06 20:03:14 +0200)

----------------------------------------------------------------
Acceptance tests patches

- Fixed EXEC migration
- Reduce PReP/40p artifacts download failures,
- Disable Leon3 HelenOS
- Speed up Travis-CI job by using a specific cache bucket

CI jobs results:
  https://gitlab.com/philmd/qemu/pipelines/133379305
  https://travis-ci.org/github/philmd/qemu/builds/671762970
----------------------------------------------------------------

Oksana Vohchana (1):
  Acceptance test: Fix to EXEC migration

Philippe Mathieu-Daud=3DC3=3DA9 (4):
  tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
  tests/acceptance/ppc_prep_40p: Use mirror for ftp.software.ibm.com
  tests/acceptance/machine_sparc_leon3: Disable HelenOS test
  .travis.yml: Cache acceptance-test assets

 .travis.yml                             | 2 ++
 tests/acceptance/machine_sparc_leon3.py | 4 ++++
 tests/acceptance/migration.py           | 6 +++---
 tests/acceptance/ppc_prep_40p.py        | 7 ++++---
 4 files changed, 13 insertions(+), 6 deletions(-)

--=3D20
2.21.1


