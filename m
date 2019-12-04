Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C3C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D68206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb76EICz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D68206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icX0b-0004G1-1g
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icWrN-0007MJ-Ap
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icWrL-0008Rb-I8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icWrL-0008QZ-DZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uAY0ML2pCQEDKcoFdAWTT5Pb0tF+6Wiqv/yJWxgHCKA=;
 b=eb76EICzBJ40bUWAM8IcTjuAD+ETnautzD/oK3AO3puDBldyfyGDR/nkqf5uT+RUuU1TeN
 LIryyPc2llGBCWItP+adEBV0v/yFj1OD3iIaMt8CbWzIQBOdBAL/E21FcrSMNnmEsEevdr
 PNokpHxn+eCGCVqgyCiQLGM//g2UsNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-ggpQZeIVM0KWT9PmLJdROg-1; Wed, 04 Dec 2019 10:46:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E32051005509;
 Wed,  4 Dec 2019 15:46:30 +0000 (UTC)
Received: from thuth.com (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8F3600C8;
 Wed,  4 Dec 2019 15:46:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] Enable Travis builds on arm64, ppc64le and s390x
Date: Wed,  4 Dec 2019 16:46:11 +0100
Message-Id: <20191204154618.23560-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ggpQZeIVM0KWT9PmLJdROg-1
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
Cc: qemu-block@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Travis recently added build hosts for arm64, ppc64le and s390x, so
this is a welcome addition to our Travis testing matrix.

Unfortunately, the builds are running in quite restricted LXD containers
there, for example it is not possible to create huge files there (even
if they are just sparse), and certain system calls are blocked. So we
have to change some tests first to stop them failing in such environments.

v2:
 - Added "make check-tcg" and Alex' patch to disable cross-containers
 - Explicitely set "dist: xenial" for arm64 and ppc64le since some
   iotests are crashing on bionic on these hosts.
 - Dropped "libcap-dev" from the package list since it will be replaced
   by libcapng-dev soon.

Alex Benn=C3=A9e (1):
  configure: allow disable of cross compilation containers

Thomas Huth (6):
  iotests: Provide a function for checking the creation of huge files
  iotests: Skip test 060 if it is not possible to create large files
  iotests: Skip test 079 if it is not possible to create large files
  tests/hd-geo-test: Skip test when images can not be created
  tests/test-util-filemonitor: Skip test on non-x86 Travis containers
  travis.yml: Enable builds on arm64, ppc64le and s390x

 .travis.yml                   | 86 +++++++++++++++++++++++++++++++++++
 configure                     |  8 +++-
 tests/hd-geo-test.c           | 12 ++++-
 tests/qemu-iotests/005        |  5 +-
 tests/qemu-iotests/060        |  3 ++
 tests/qemu-iotests/079        |  3 ++
 tests/qemu-iotests/220        |  6 +--
 tests/qemu-iotests/common.rc  | 10 ++++
 tests/tcg/configure.sh        |  6 ++-
 tests/test-util-filemonitor.c | 11 +++++
 10 files changed, 138 insertions(+), 12 deletions(-)

--=20
2.18.1


