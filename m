Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19C3C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBE02070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OepezHMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBE02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mrX-000895-K2
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 15:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j3moa-0004iv-5S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j3moZ-00041f-70
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j3moZ-00040J-2o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581970582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmNLkF828GOUPF42Pc+E/LHyKJEHDiIv+2IbmhJ4n0I=;
 b=OepezHMHQczFGDA2Od8Q42QTHZaATiIkbwXCuVpnmlkVB2IGwnftXvZQJb2/sXC+KoI2wJ
 X+0oahSAHk/QDEIeNuddKdmc/Mwwn5MS4ayIbYr4fjwwbSCDNoJDnOa7LQ9yXwcVAu9NbM
 lf5seQS1mzWNqY5e93sF2eWbfWqbimk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-YkxroyfRNGaAsFABRa2OKQ-1; Mon, 17 Feb 2020 15:16:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D400107ACC4;
 Mon, 17 Feb 2020 20:16:18 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 882215D9E2;
 Mon, 17 Feb 2020 20:16:17 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/6] travis.yml: Run '[aarch64] GCC check-tcg' job on
 Ubuntu Bionic
Date: Mon, 17 Feb 2020 15:16:09 -0500
Message-Id: <20200217201609.788825-7-wainersm@redhat.com>
In-Reply-To: <20200217201609.788825-1-wainersm@redhat.com>
References: <20200217201609.788825-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YkxroyfRNGaAsFABRa2OKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Converted the '[aarch64] GCC check-tcg' job to run on Ubuntu
18.04 (Bionic).

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c6465ae807..e0d2475899 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -418,32 +418,6 @@ matrix:
=20
     - name: "[aarch64] GCC check-tcg"
       arch: arm64
-      dist: xenial
-      addons:
-        apt_packages:
-          - libaio-dev
-          - libattr1-dev
-          - libbrlapi-dev
-          - libcap-ng-dev
-          - libgcrypt20-dev
-          - libgnutls28-dev
-          - libgtk-3-dev
-          - libiscsi-dev
-          - liblttng-ust-dev
-          - libncurses5-dev
-          - libnfs-dev
-          - libnss3-dev
-          - libpixman-1-dev
-          - libpng-dev
-          - librados-dev
-          - libsdl2-dev
-          - libseccomp-dev
-          - liburcu-dev
-          - libusb-1.0-0-dev
-          - libvdeplug-dev
-          - libvte-2.91-dev
-          # Tests dependencies
-          - genisoimage
       env:
         - TEST_CMD=3D"make check check-tcg V=3D1"
         - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_TA=
RGETS}"
--=20
2.24.1


