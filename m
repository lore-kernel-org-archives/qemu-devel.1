Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00705C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BCA2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BCA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvzW-0005Ln-Kq
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlvz2-0003gD-D5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlvz0-0001aS-3m
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlvyv-0001W7-Ha; Fri, 12 Jul 2019 09:53:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0DA4DF26;
 Fri, 12 Jul 2019 13:53:00 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4A2B5D739;
 Fri, 12 Jul 2019 13:52:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 15:52:52 +0200
Message-Id: <20190712135253.9410-2-kwolf@redhat.com>
In-Reply-To: <20190712135253.9410-1-kwolf@redhat.com>
References: <20190712135253.9410-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 12 Jul 2019 13:53:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] iotests: Update 082 expected output
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

A recent tweak to the '-o help' output for qemu-img needs to be
reflected into the iotests expected outputs.

Fixes: f7077c98
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/082.out | 54 +++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 58de358b38..9d4ed4dc9d 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -47,7 +47,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -70,7 +70,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -93,7 +93,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -116,7 +116,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -139,7 +139,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -162,7 +162,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -185,7 +185,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -208,7 +208,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -246,7 +246,7 @@ Supported qcow2 options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -327,7 +327,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -350,7 +350,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -373,7 +373,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -396,7 +396,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -419,7 +419,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -442,7 +442,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -465,7 +465,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -488,7 +488,7 @@ Supported options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -526,7 +526,7 @@ Supported qcow2 options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -618,7 +618,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -642,7 +642,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -666,7 +666,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -690,7 +690,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -714,7 +714,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -738,7 +738,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -762,7 +762,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -786,7 +786,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
@@ -827,7 +827,7 @@ Creation options for 'qcow2':
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
-  compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  compat=3D<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=3D<str>        - File name of an external data file
   data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
--=20
2.20.1


