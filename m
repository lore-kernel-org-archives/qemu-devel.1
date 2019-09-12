Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED55C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 23:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552BC2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 23:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552BC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8YHu-0002qr-D8
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 19:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1i8YGY-0001o8-GW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1i8YGX-0000yh-17
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:12:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51660
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1i8YGW-0000yT-TG; Thu, 12 Sep 2019 19:12:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8CNCX7I192813; Thu, 12 Sep 2019 19:12:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uywkvu66q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 19:12:39 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8CNCciX192996;
 Thu, 12 Sep 2019 19:12:38 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uywkvu66k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 19:12:38 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8CNAI6b020060;
 Thu, 12 Sep 2019 23:12:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03wdc.us.ibm.com with ESMTP id 2uytdx27xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 23:12:38 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8CNCbq951839482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2019 23:12:37 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55F1A112061;
 Thu, 12 Sep 2019 23:12:37 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43CC6112067;
 Thu, 12 Sep 2019 23:12:37 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2019 23:12:37 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 18:12:01 -0500
Message-Id: <20190912231202.12327-2-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
References: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-12_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909120237
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 1/2] make-release: pull in edk2 submodules so
 we can build it from tarballs
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
Cc: lersek@redhat.com, qemu-stable@nongnu.org, brogers@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Reported-by: Bruce Rogers <brogers@suse.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org # v4.1.0
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
+# Fetch edk2 submodule's submodules, since it won't have access to them via
+# the tarball later.
+#
+# A more uniform way to handle this sort of situation would be nice, but we
+# don't necessarily have much control over how a submodule handles its
+# submodule dependencies, so we continue to handle these on a case-by-case
+# basis for now.
+(cd roms/edk2 && git submodule update --init)
 popd
 tar --exclude=.git -cjf ${destination}.tar.bz2 ${destination}
 rm -rf ${destination}
-- 
2.17.1


