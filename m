Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D72EC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AE22087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AE22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6m9-0008PE-B1
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5qb-0002ml-K5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5qa-0003B3-6a
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:54:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56974
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5qa-0003Ao-1c; Tue, 05 Nov 2019 15:54:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KsbZ3009146; Tue, 5 Nov 2019 15:54:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3dex64r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:54:39 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KsceN009241;
 Tue, 5 Nov 2019 15:54:38 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3dex64ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:54:38 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnvSs031300;
 Tue, 5 Nov 2019 20:53:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01dal.us.ibm.com with ESMTP id 2w11e7hh9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:09 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kr8nl52953412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:08 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3923B12405E;
 Tue,  5 Nov 2019 20:53:08 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 175EC124052;
 Tue,  5 Nov 2019 20:53:08 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:08 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/55] roms/Makefile.edk2: don't pull in submodules when
 building from tarball
Date: Tue,  5 Nov 2019 14:52:25 -0600
Message-Id: <20191105205243.3766-38-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xA5KsbZ3009146
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
 Laszlo Ersek <lersek@redhat.com>, qemu-stable@nongnu.org,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the `make efi` target pulls submodules nested under the
roms/edk2 submodule as dependencies. However, when we attempt to build
from a tarball this fails since we are no longer in a git tree.

A preceding patch will pre-populate these submodules in the tarball,
so assume this build dependency is only needed when building from a
git tree.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org # v4.1.0
Reported-by: Bruce Rogers <brogers@suse.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-Id: <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(cherry picked from commit f3e330e3c319160ac04954399b5a10afc965098c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 roms/Makefile.edk2 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index c2f2ff59d5..33a074d3a4 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -46,8 +46,13 @@ all: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$=
(flashdev).fd.bz2) \
 # files.
 .INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashde=
v).fd)
=20
+# Fetch edk2 submodule's submodules. If it is not in a git tree, assume
+# we're building from a tarball and that they've already been fetched by
+# make-release/tarball scripts.
 submodules:
-	cd edk2 && git submodule update --init --force
+	if test -d edk2/.git; then \
+		cd edk2 && git submodule update --init --force; \
+	fi
=20
 # See notes on the ".NOTPARALLEL" target and the "+" indicator in
 # "tests/uefi-test-tools/Makefile".
--=20
2.17.1


