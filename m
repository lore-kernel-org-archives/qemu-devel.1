Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04787C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AE4206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHY+QdK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AE4206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUQ3X-0007ZL-PW
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUPtx-0005T0-Q8
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUPtv-0000RO-7z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUPtu-0000QV-Uj
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573541022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2JGYuofF4h69cK4L2SEC9qNj1+PE8yPomU6gW4c6KpQ=;
 b=XHY+QdK91EuH0oMS4y3k6MSddYHODPPxMn8ZAhJeNCFe0J0Gkr2vPH8ocePSR8alQzYx/4
 AtsM1ooMNbMi1SZZcAWUMqhT2ZxxlOdKtHZ/ooR+jcUAgmMzAa62evfL8qr4z4r8nz3gum
 viTCwk+vUC09JXTyA9wUJSX3lyWDsy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-r-9u1cCEMOGCw4BTyh1CBg-1; Tue, 12 Nov 2019 01:43:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDEE3107ACC8;
 Tue, 12 Nov 2019 06:43:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D72EB18373;
 Tue, 12 Nov 2019 06:43:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] qtest and misc patches
Date: Tue, 12 Nov 2019 07:43:26 +0100
Message-Id: <20191112064332.5074-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: r-9u1cCEMOGCw4BTyh1CBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 654efcb511d394c1d3f5292c28503d1d19e5b1d3=
:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-branch-pull-reques=
t' into staging (2019-11-11 09:23:46 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-11-12

for you to fetch changes up to 623ef637a2e42e023e7436d4bfbdc5159fb36684:

  configure: Check bzip2 is available (2019-11-11 14:35:41 +0100)

----------------------------------------------------------------
- Fix memory leaks for QTESTS
- Update MAINTAINERS file
- Check for the availability of bzip2 in "configure"
----------------------------------------------------------------

Dr. David Alan Gilbert (1):
      tests/migration: Print some debug on bad status

Jan Kiszka (1):
      MAINTAINERS: slirp: Remove myself as maintainer

Marc-Andr=C3=A9 Lureau (2):
      qtest: fix qtest_qmp_device_add leak
      cpu-plug-test: fix leaks

Philippe Mathieu-Daud=C3=A9 (2):
      configure: Only decompress EDK2 blobs for X86/ARM targets
      configure: Check bzip2 is available

 MAINTAINERS            |  2 --
 Makefile               |  2 ++
 configure              | 17 +++++++++++++++++
 tests/cpu-plug-test.c  |  2 ++
 tests/libqtest.c       |  1 +
 tests/migration-test.c |  9 +++++++--
 6 files changed, 29 insertions(+), 4 deletions(-)


