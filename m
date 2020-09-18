Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B8C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1D920DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/+lwV9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1D920DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOSH-0001vr-Cp
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNIi-0002xN-JB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNIg-0006NE-Uq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vD4uv2CLFfZfF55iSNE77AAkZ0m3c0TvLgIicvrlJqE=;
 b=Y/+lwV9swOttcRI/gBJiDgNEcCuSHqtl8dmIt4BSqhiY3tjKsWni+xxICpsP1Bq2xpiKU0
 WNN3FGgirWCiMunK/3Eq4WmCImGbrpSDYRbWoeR3HegaUIEv5GARf6IaAJccx9JRqPF2ag
 tgfpt5NbXThC5Fpowjmr32r5YU9/cb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-AGtMvomuM5S5Ua8C5kAiUg-1; Fri, 18 Sep 2020 16:48:07 -0400
X-MC-Unique: AGtMvomuM5S5Ua8C5kAiUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4874873159;
 Fri, 18 Sep 2020 20:48:06 +0000 (UTC)
Received: from localhost (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C97EE61177;
 Fri, 18 Sep 2020 20:48:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] Convert pc-bios Makefiles to meson
Date: Sat, 19 Sep 2020 00:47:53 +0400
Message-Id: <20200918204759.225810-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
Here is a series of patches to convert the remaining Makefile in pc-bios/ t=
o=0D
meson. I have done various tests to check that the resulting binaries are=
=0D
working as expected, but I didn't cover it all, and I am not sure the test =
su=3D=0D
ite=0D
covers them all either.=0D
=0D
Please review,=0D
=0D
Marc-Andr=3DC3=3DA9 Lureau (6):=0D
  meson: convert pc-bios/s390-ccw=0D
  optionrom: make kvmapic.S compile with clang=0D
  meson: convert pc-bios/optionrom=0D
  build-sys: remove no longer needed ROMS variable=0D
  build-sys: remove recurse-* rules=0D
  meson: replace pc-bios/Makefile=0D
=0D
 Makefile                      |  16 +--=0D
 configure                     |  21 ----=0D
 pc-bios/Makefile              |  19 ----=0D
 pc-bios/meson.build           |  20 ++++=0D
 pc-bios/optionrom/Makefile    |  73 --------------=0D
 pc-bios/optionrom/kvmvapic.S  |   4 +-=0D
 pc-bios/optionrom/meson.build |  73 ++++++++++++++=0D
 pc-bios/s390-ccw/Makefile     |  62 ------------=0D
 pc-bios/s390-ccw/meson.build  | 177 ++++++++++++++++++++++++++++++++++=0D
 pc-bios/s390-ccw/netboot.mak  |  62 ------------=0D
 subprojects/optionrom         |   1 +=0D
 subprojects/s390-ccw          |   1 +=0D
 12 files changed, 276 insertions(+), 253 deletions(-)=0D
 delete mode 100644 pc-bios/Makefile=0D
 delete mode 100644 pc-bios/optionrom/Makefile=0D
 create mode 100644 pc-bios/optionrom/meson.build=0D
 delete mode 100644 pc-bios/s390-ccw/Makefile=0D
 create mode 100644 pc-bios/s390-ccw/meson.build=0D
 delete mode 100644 pc-bios/s390-ccw/netboot.mak=0D
 create mode 120000 subprojects/optionrom=0D
 create mode 120000 subprojects/s390-ccw=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


