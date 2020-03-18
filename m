Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E257FC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C3020663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA6lTzTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C3020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMSV-0005ZN-OQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEMR0-00042B-Lr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEMQz-0006Df-Ll
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEMQz-0006Ag-Hn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584490785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pVwdpjT2pmm/+g/EmwZsm20jaqg48Rh1wjbJR9p4gaU=;
 b=UA6lTzTVt7tryLg7PX7WYTsOJi5RV7sLuv9LMfuiT58eiMIlezKNQDj5MlgpjoG843MCdb
 kn1RpZvQMXY2NWgE7s54kRHm8kUrz/YDwIzoU+yi+UJfgxhAdgnZHQrONevSjFGGQ1Eu5j
 SXrcbIzYH7wrox1W6nvMf2kbZlA9QT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-zzd3G_fMPsuUaFNdMxqDDw-1; Tue, 17 Mar 2020 20:19:41 -0400
X-MC-Unique: zzd3G_fMPsuUaFNdMxqDDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C400A800D50;
 Wed, 18 Mar 2020 00:19:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-2.rdu2.redhat.com
 [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB8B91001B07;
 Wed, 18 Mar 2020 00:19:34 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] Python and tests (mostly acceptance) patches 2020-03-17
Date: Tue, 17 Mar 2020 20:19:26 -0400
Message-Id: <20200318001932.180617-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17=
:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2020-03-17 18:33:05 +0000)

are available in the Git repository at:

  git://github.com/clebergnu/qemu.git tags/python-next-pull-request

for you to fetch changes up to a51d6a549361fd1a20dd2ac1d6a42ac0a4c708c7:

  tests/docker: make "buildah bud" output similar to "docker build" (2020-0=
3-17 19:16:16 -0400)

----------------------------------------------------------------
Python and tests (mostly acceptance) patches 2020-03-17

----------------------------------------------------------------

Cleber Rosa (5):
  Acceptance tests: introduce BUILD_DIR and SOURCE_DIR
  Acceptance test: add "boot_linux" tests
  Acceptance tests: add make targets to download images
  tests/docker: add CentOS 8 Dockerfile
  tests/docker: make "buildah bud" output similar to "docker build"

Oksana Vohchana (1):
  python/qemu/qmp.py: QMP debug with VM label

 .travis.yml                                   |   2 +-
 python/qemu/machine.py                        |   3 +-
 python/qemu/qmp.py                            |   5 +-
 tests/Makefile.include                        |  20 +-
 tests/acceptance/avocado_qemu/__init__.py     |  25 +-
 tests/acceptance/boot_linux.py                | 222 ++++++++++++++++++
 tests/docker/dockerfiles/centos8.docker       |  32 +++
 .../dockerfiles/debian-win32-cross.docker     |   2 +-
 tests/requirements.txt                        |   1 +
 9 files changed, 300 insertions(+), 12 deletions(-)
 create mode 100644 tests/acceptance/boot_linux.py
 create mode 100644 tests/docker/dockerfiles/centos8.docker

--=20
2.25.1


