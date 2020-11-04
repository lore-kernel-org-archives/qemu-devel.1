Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F911C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B8B2222C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjW5gfcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B8B2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIr0-0001Uo-7P
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaIiB-00032g-C2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaIi9-00004x-My
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604496025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/nNkKO36OG1hHzEJRPEg2fILgwszrI3Pm3B64rVsR2o=;
 b=fjW5gfcp4VgY/mO6taMNqkvw7jqGD+DMzf9QBwWwV1GP67GpeyIGQbh75uF3udJKvecCrm
 QkXztlHAbhAi82FLgHvPHaUjp4dVBb74fiyybjPtHxJyMumTDbRcfEti+EuMWIBnyzoLEn
 xPVP4mEnwEDi2CBF1hmt53BYlfIbQUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-jhCR0nUqPs-H-Fb9-P0tgQ-1; Wed, 04 Nov 2020 08:19:31 -0500
X-MC-Unique: jhCR0nUqPs-H-Fb9-P0tgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54CD380B720;
 Wed,  4 Nov 2020 13:19:30 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26F4775136;
 Wed,  4 Nov 2020 13:19:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Some cleanups to build deps
Date: Wed,  4 Nov 2020 13:19:21 +0000
Message-Id: <20201104131924.593522-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In looking at using libvirt-ci to generate the docker files I noticed=0D
some wierd build deps in current package lists. This cleans them up.=0D
=0D
Daniel P. Berrang=C3=A9 (3):=0D
  hw/usb/ccid: remove references to NSS=0D
  tests: remove "bc" from package listing=0D
  docker: remove libblockdev-mpath-devel package=0D
=0D
 .travis.yml                                       | 14 +++++++-------=0D
 docs/ccid.txt                                     | 15 +++++++--------=0D
 scripts/coverity-scan/coverity-scan.docker        |  3 ---=0D
 tests/docker/dockerfiles/centos7.docker           |  1 +=0D
 tests/docker/dockerfiles/centos8.docker           |  1 +=0D
 tests/docker/dockerfiles/debian10.docker          |  1 -=0D
 .../docker/dockerfiles/fedora-win32-cross.docker  |  1 -=0D
 .../docker/dockerfiles/fedora-win64-cross.docker  |  1 -=0D
 tests/docker/dockerfiles/fedora.docker            |  4 +---=0D
 9 files changed, 17 insertions(+), 24 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D


