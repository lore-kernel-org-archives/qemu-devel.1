Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE181C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893EC20663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+k8lhQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893EC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmWc-0005YH-Qn
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jkmTq-0000a5-9x
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:36:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jkmTo-0007RQ-Gd
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592217399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WQhkqdS6EaGMQv+B05yQexMyipgFg0KRPPWB3xIi5G0=;
 b=D+k8lhQ5pjVNtSXY96Tx/FhKLeKiumPUJJVxx98PUj+qBgzJrF0mjSC7yUoGOm9U4fo5kZ
 55ar3sCFPQ33wKASb/zPVWcoS8JWdSH05+oBoHvDVSbhaeZy4t5dNmN6MUgYruxuMvnLGW
 t1KUsusDu7f8v8QpFoJebHw43IPTFAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-F8wV5614PnS3Vp_i7bq_9w-1; Mon, 15 Jun 2020 06:36:36 -0400
X-MC-Unique: F8wV5614PnS3Vp_i7bq_9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9557E1009442
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:36:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA5835D9CC;
 Mon, 15 Jun 2020 10:36:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/5] Qcrypto next patches
Date: Mon, 15 Jun 2020 11:36:28 +0100
Message-Id: <20200615103633.300208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb=
:=0D
=0D
  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
gi=3D=0D
ng (2020-06-12 23:06:22 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/berrange/qemu tags/qcrypto-next-pull-request=0D
=0D
for you to fetch changes up to d6cca8e111696fbbd7c233dc53f9c80b6a43359d:=0D
=0D
  crypto: Remove use of GCRYPT_VERSION macro. (2020-06-15 11:33:51 +0100)=0D
=0D
----------------------------------------------------------------=0D
Misc crypto subsystem fixes=0D
=0D
* Improve error message for large files when creating LUKS volumes=0D
* Expand crypto hash benchmark coverage=0D
* Misc code refactoring with no functional change=0D
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
 configure                       |  80 +++++++=0D
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
 12 files changed, 966 insertions(+), 359 deletions(-)=0D
 create mode 100644 crypto/random-none.c=0D
 create mode 100644 crypto/secret_common.c=0D
 create mode 100644 crypto/secret_keyring.c=0D
 create mode 100644 include/crypto/secret_common.h=0D
 create mode 100644 include/crypto/secret_keyring.h=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


