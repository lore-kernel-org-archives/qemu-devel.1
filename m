Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1EC49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8512082C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8512082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8CrW-00082K-8D
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 20:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i8Cmw-0002e9-9u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i8Cmv-0006Hi-Cd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i8Cms-0006GK-W0; Wed, 11 Sep 2019 20:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4945C3084288;
 Thu, 12 Sep 2019 00:16:38 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A647D5D6A5;
 Thu, 12 Sep 2019 00:16:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 20:16:31 -0400
Message-Id: <20190912001633.11372-3-jsnow@redhat.com>
In-Reply-To: <20190912001633.11372-1-jsnow@redhat.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 12 Sep 2019 00:16:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 2/4] iotest 258: use script_main
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since this one is nicely factored to use a single entry point,
use script_main to run the tests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/258 | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
index b84cf02254..1372522c7a 100755
--- a/tests/qemu-iotests/258
+++ b/tests/qemu-iotests/258
@@ -23,11 +23,6 @@ import iotests
 from iotests import log, qemu_img, qemu_io_silent, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
-# Need backing file and change-backing-file support
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
-iotests.verify_platform(['linux'])
-
-
 # Returns a node for blockdev-add
 def node(node_name, path, backing=3DNone, fmt=3DNone, throttle=3DNone):
     if fmt is None:
@@ -160,4 +155,5 @@ def main():
     test_concurrent_finish(False)
=20
 if __name__ =3D=3D '__main__':
-    main()
+    # Need backing file and change-backing-file support
+    iotests.script_main(main, supported_fmts=3D['qcow2', 'qed'])
--=20
2.21.0


