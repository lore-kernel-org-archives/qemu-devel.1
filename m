Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E994C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEED2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEaPLa8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEED2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXo1-0007AP-9B
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioXOM-0004Wt-KQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioXOL-000378-CW
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42504
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioXOL-00036K-9K
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578336376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cBzxJ5oh2h7k39kQnMmICQKGGT9UnikVOsmJa/Vs2wo=;
 b=CEaPLa8MEXtodDJ+tUoRMflefYbHxTQhUAsb8xtRodmGZWGq6yV19YF3XpX87/Yjy/C6aE
 WgPQwPjeF1f0ietsrhEuNjXsF10lfT9SJfkyicMZevs2ov6fmsGH/YY/p1yqmLpSArK62s
 ff8toFSGJTpN5KZWHaB3k8PTsCmQdHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-EZvrP9ASO66S2JVOIO8teA-1; Mon, 06 Jan 2020 13:46:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F102C802B8E;
 Mon,  6 Jan 2020 18:46:11 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC6E19530A;
 Mon,  6 Jan 2020 18:46:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] gitlab-ci: Add a job to build EDK2 firmware binaries
Date: Mon,  6 Jan 2020 19:45:58 +0100
Message-Id: <20200106184601.25453-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EZvrP9ASO66S2JVOIO8teA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We provide the EDK2 firmware binaries in pc-bios/. When we
update the roms/edk2/ submodule, we need to rebuild the
firmware binaries.
To avoid the burden on a single developer, this series add
a GitLab job to generate reproducible EDK2 firmware binaries.

The job is only on specific conditions:
- roms/edk2/ is updated
- the branch or tag start with 'edk2'
- 'edk2' appears in last commit description

Using ccache this job takes 32minutes on a GitLab free runner.

The proposed procedure to update the EDK2 submodule is:

- add a commit to update roms/edk2/ submodule
- push to gitlab
- download generated artifacts (only available if job succeed)
- unzip the firmware binaries from the artifacts archive
- test the binaries
- add a commit with the binaries, referencing the ci job url.

Example of job that built the edk2-stable201905 firmwares:
https://gitlab.com/philmd/qemu/-/jobs/395017298

The first patch is already reviewed, but is a prerequisite to
use the Ubuntu docker image to build, so I included it.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  roms/edk2-funcs: Force softfloat ARM toolchain prefix on Debian
  gitlab-ci.yml: Add a job to build EDK2 firmware binaries
  gitlab-ci-edk2.yml: Use ccache

 .gitlab-ci-edk2.yml | 48 +++++++++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml      |  3 +++
 MAINTAINERS         |  3 ++-
 roms/edk2-funcs.sh  |  3 +++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci-edk2.yml

--=20
2.21.1


