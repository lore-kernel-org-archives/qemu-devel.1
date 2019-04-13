Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90DC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 15:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46522084D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 15:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46522084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFKUI-0008L5-4E
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 11:22:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKSV-0006fI-W5
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKSU-0000bo-UR
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hFKSQ-0000WY-J6; Sat, 13 Apr 2019 11:20:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF56366C4A;
	Sat, 13 Apr 2019 15:20:41 +0000 (UTC)
Received: from localhost (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 678A060852;
	Sat, 13 Apr 2019 15:20:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Sat, 13 Apr 2019 17:20:36 +0200
Message-Id: <20190413152037.6817-2-mreitz@redhat.com>
In-Reply-To: <20190413152037.6817-1-mreitz@redhat.com>
References: <20190413152037.6817-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sat, 13 Apr 2019 15:20:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-next 1/2] iotests: Perform the correct test
 in 082
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413152036.8Rt63vp81qxRcdeAV3bxhS5oczV4V-ACFSwWsXwbOOg@z>

In the "amend" section of 082, we perform a single "convert" test
(namely "convert -o help").  That does not make sense, especially
because we have done exactly that "convert" test earlier in 082 already.

Replacing "convert" by "amend" yields an error, which is correct because
there is no point in "amend" having a default format.  The user has to
either specify the format, or give a file for qemu-img to probe.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/082     | 5 ++++-
 tests/qemu-iotests/082.out | 5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d0afa46e9a..278511dba4 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -212,7 +212,10 @@ run_qemu_img amend -f $IMGFMT -o backing_file=3D"$TE=
ST_IMG" -o ,, -o help "$TEST_I
=20
 # Leave out everything that isn't needed
 run_qemu_img amend -f $IMGFMT -o help
-run_qemu_img convert -o help
+
+# amend requires specifying either a format explicitly, or a file
+# which it can probe
+run_qemu_img amend -o help
=20
 # Try help option for a format that does not support amendment
 run_qemu_img amend -f bochs -o help
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index d36938da9b..9a23b68511 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -831,9 +831,8 @@ Creation options for 'qcow2':
=20
 Note that not all of these options may be amendable.
=20
-Testing: convert -o help
-Supported options:
-  size=3D<size>            - Virtual disk size
+Testing: amend -o help
+qemu-img: Expecting one image file name
=20
 Testing: amend -f bochs -o help
 qemu-img: Format driver 'bochs' does not support option amendment
--=20
2.20.1


