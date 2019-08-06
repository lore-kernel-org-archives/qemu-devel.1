Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B0FC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482A21880
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482A21880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv7Tt-00037h-0q
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 17:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hv7TU-0002jE-Vm
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hv7TT-0006Gm-RE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:58:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hv7TT-0006E9-K0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:58:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x76Lq7as143629; Tue, 6 Aug 2019 17:58:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7hf80ud5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2019 17:58:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x76LsnVM011843;
 Tue, 6 Aug 2019 21:58:27 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 2u51w739uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2019 21:58:27 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x76LwPKr25821472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2019 21:58:26 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D71BD78060;
 Tue,  6 Aug 2019 21:58:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BABB37805F;
 Tue,  6 Aug 2019 21:58:25 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  6 Aug 2019 21:58:25 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <156512870031.29966.16531381196882979571@sif>
Date: Tue, 06 Aug 2019 16:58:20 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060188
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel]  [ANNOUNCE] QEMU 4.1.0-rc4 is now available
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 4.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.1.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-4.1.0-rc4.tar.xz.sig

A note from the maintainer:

  We found a handful of release-critical bugs after we tagged rc3,
  so we've had to make an rc4. Unless we find any further absolute
  showstopper bugs, we will make the final 4.1.0 release next week
  on the 13th August.

You can help improve the quality of the QEMU 4.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.1

Please add entries to the ChangeLog for the 4.1 release below:

  http://wiki.qemu.org/ChangeLog/4.1

Thank you to everyone involved!

Changes since rc3:

864ab314f1: Update version for v4.1.0-rc4 release (Peter Maydell)
bb15791166: compat: disable edid on virtio-gpu base device (Cornelia Huck)
110571be4e: block/backup: disable copy_range for compressed backup (Vladimi=
r Sementsov-Ogievskiy)
19ba4651fe: iotests: Test unaligned blocking mirror write (Max Reitz)
9adc1cb49a: mirror: Only mirror granularity-aligned chunks (Max Reitz)
8a9cb86408: iotests: Test incremental backup after truncation (Max Reitz)
4e4de22279: util/hbitmap: update orig_size on truncate (Vladimir Sementsov-=
Ogievskiy)
5f594a2e99: iotests: Test backup job with two guest writes (Max Reitz)
4a5b91ca02: backup: Copy only dirty areas (Max Reitz)
177cd674d6: Makefile: remove DESTDIR from firmware file content (Olaf Herin=
g)
02ac2f7f61: target/arm: Avoid bogus NSACR traps on M-profile without Securi=
ty Extension (Peter Maydell)
e1a4a24d26: slirp: update with CVE-2019-14378 fix (Marc-Andr=C3=A9 Lureau)

