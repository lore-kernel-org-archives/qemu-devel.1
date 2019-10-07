Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8474ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A23206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A23206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTDI-0005nn-MX
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHTB1-0003ef-1Q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHTAz-0007IJ-VV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iHTAz-0007Hz-Pf; Mon, 07 Oct 2019 09:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07AB7C04FFE0;
 Mon,  7 Oct 2019 13:35:49 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B62060127;
 Mon,  7 Oct 2019 13:35:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] make-release: pull in edk2 submodules so we can build it
 from tarballs
Date: Mon,  7 Oct 2019 15:35:36 +0200
Message-Id: <20191007133540.30623-2-philmd@redhat.com>
In-Reply-To: <20191007133540.30623-1-philmd@redhat.com>
References: <20191007133540.30623-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 07 Oct 2019 13:35:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 qemu-stable@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

The `make efi` target added by 536d2173 is built from the roms/edk2
submodule, which in turn relies on additional submodules nested under
roms/edk2.

The make-release script currently only pulls in top-level submodules,
so these nested submodules are missing in the resulting tarball.

We could try to address this situation more generally by recursively
pulling in all submodules, but this doesn't necessarily ensure the
end-result will build properly (this case also required other changes).

Additionally, due to the nature of submodules, we may not always have
control over how these sorts of things are dealt with, so for now we
continue to handle it on a case-by-case in the make-release script.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org # v4.1.0
Reported-by: Bruce Rogers <brogers@suse.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-Id: <20190912231202.12327-2-mdroth@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/make-release | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/make-release b/scripts/make-release
index b4af9c9e52..a2a8cda33c 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -20,6 +20,14 @@ git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
 (cd roms/skiboot && ./make_version.sh > .version)
+# Fetch edk2 submodule's submodules, since it won't have access to them =
via
+# the tarball later.
+#
+# A more uniform way to handle this sort of situation would be nice, but=
 we
+# don't necessarily have much control over how a submodule handles its
+# submodule dependencies, so we continue to handle these on a case-by-ca=
se
+# basis for now.
+(cd roms/edk2 && git submodule update --init)
 popd
 tar --exclude=3D.git -cjf ${destination}.tar.bz2 ${destination}
 rm -rf ${destination}
--=20
2.21.0


