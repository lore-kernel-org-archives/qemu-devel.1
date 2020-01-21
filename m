Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D47721569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2hOlK49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D47721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvJq-0000lZ-Dd
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itvG6-0006xE-Jb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itvG1-00056Z-Um
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:16:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itvG1-00056E-RP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579619757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6xob2Bqgtv32Y1fHiV6BxgHmDWMcEJY8tXeggrGGF04=;
 b=T2hOlK49lnk3pX2bzjs+2JBQ1d6WU7i4seRw/2SByJEMAcG8/Zz5eHy+szjP/buMIbwlQm
 Z4Izf+hsv58wtItKNcuSei52QFb7txSVovyhoIoTnJs44RumiNk1gvcfFV1SsdtaOQ3zws
 tn5tWKs/1IXk4J6oR5fuoJFSjd21lJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-H5a7am_QP1y5UKOg3ZSWuA-1; Tue, 21 Jan 2020 10:15:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFB3818AAFA1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:15:53 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-38.brq.redhat.com [10.40.205.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43E0A60FC1;
 Tue, 21 Jan 2020 15:15:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] EDK2 firmware patches
Date: Tue, 21 Jan 2020 16:15:41 +0100
Message-Id: <20200121151543.18538-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: H5a7am_QP1y5UKOg3ZSWuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 43d1455cf84283466e5c22a217db5ef4b8197b14=
:

  qapi: Fix code generation with Python 3.5 (2020-01-20 12:17:38 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/edk2-next-20200121

for you to fetch changes up to 71920809ceabedf7dbec67dda4d649bcbb11f55c:

  gitlab-ci.yml: Add jobs to build EDK2 firmware binaries (2020-01-21 14:15=
:48 +0100)

----------------------------------------------------------------

Another set of build-sys patches, to help building the firmware
binaries we use for testing. We almost have reproducible builds.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (2):
  roms/edk2-funcs: Force softfloat ARM toolchain prefix on Debian
  gitlab-ci.yml: Add jobs to build EDK2 firmware binaries

 .gitlab-ci-edk2.yml          | 49 ++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/edk2/Dockerfile | 27 ++++++++++++++++++++
 .gitlab-ci.yml               |  3 +++
 MAINTAINERS                  |  2 ++
 roms/edk2-funcs.sh           |  3 +++
 5 files changed, 84 insertions(+)
 create mode 100644 .gitlab-ci-edk2.yml
 create mode 100644 .gitlab-ci.d/edk2/Dockerfile

--=20
2.21.1


