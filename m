Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0286C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9051F20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXUeSdP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9051F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecOK-0008Ip-OQ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecMw-00073a-Q8
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21367
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecMt-0004vd-Ux
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590748562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w5QU3dm+E4lREZi4gSYBHz9q5eJEyWQOVW75L/8JP44=;
 b=cXUeSdP3IuEFwZTi8hOqJi33SBr83cDD2iiKaD9+hmUfy6jaO9HaeVqE4km4yCeLnj/WqZ
 Ot6sHOBqvmnKKzUYMuh1yh+NGWJJuhjIrZyqoMnmOQzMtmHTI7iZtRR+ZuaFmMatkmNuHG
 XpW1aw2enqJClpKLe7ixu4aWfPsHgMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-adSl-41UPiCKlBFTk29b0w-1; Fri, 29 May 2020 06:35:59 -0400
X-MC-Unique: adSl-41UPiCKlBFTk29b0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60624872FE0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 10:35:58 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86F262B6EB;
 Fri, 29 May 2020 10:35:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Qcrypto next patches
Date: Fri, 29 May 2020 11:35:50 +0100
Message-Id: <20200529103555.2759928-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b8bee16e94df0fcd03bdad9969c30894418b0e6e=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200528-pull-reque=
st=3D=0D
' into staging (2020-05-28 18:13:20 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/berrange/qemu tags/qcrypto-next-pull-request=0D
=0D
for you to fetch changes up to efd6cd2328064b569a7a92ad4aea1dc985d98601:=0D
=0D
  crypto: Remove use of GCRYPT_VERSION macro. (2020-05-29 11:33:19 +0100)=
=0D
=0D
----------------------------------------------------------------=0D
Misc crypto subsystem fixes=0D
=0D
* Add support for fetching secret from Linux keyring=0D
* Remove redundant version check in gcrypt initialization=0D
* Allow for RNG provider to be disabled at build time=0D
=0D
----------------------------------------------------------------=0D
=0D
Alexey Krasikov (3):=0D
  crypto/secret: move main logic from 'secret' to 'secret_common'.=0D
  crypto/linux_keyring: add 'secret_keyring' secret object.=0D
  test-crypto-secret: add 'secret_keyring' object tests.=0D
=0D
Marek Marczykowski-G=3DC3=3DB3recki (1):=0D
  crypto: add "none" random provider=0D
=0D
Richard W.M. Jones (1):=0D
  crypto: Remove use of GCRYPT_VERSION macro.=0D
=0D
 configure                       |  73 ++++++=0D
 crypto/Makefile.objs            |   5 +-=0D
 crypto/init.c                   |   2 +-=0D
 crypto/random-none.c            |  38 +++=0D
 crypto/secret.c                 | 347 +--------------------------=0D
 crypto/secret_common.c          | 403 ++++++++++++++++++++++++++++++++=0D
 crypto/secret_keyring.c         | 148 ++++++++++++=0D
 include/crypto/secret.h         |  20 +-=0D
 include/crypto/secret_common.h  |  68 ++++++=0D
 include/crypto/secret_keyring.h |  52 +++++=0D
 tests/Makefile.include          |   4 +=0D
 tests/test-crypto-secret.c      | 158 +++++++++++++=0D
 12 files changed, 959 insertions(+), 359 deletions(-)=0D
 create mode 100644 crypto/random-none.c=0D
 create mode 100644 crypto/secret_common.c=0D
 create mode 100644 crypto/secret_keyring.c=0D
 create mode 100644 include/crypto/secret_common.h=0D
 create mode 100644 include/crypto/secret_keyring.h=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


