Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B4C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7873A206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7873A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYSQ-0004E4-4d
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIYKq-00028C-GW
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIYKo-0002wM-EU
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIYKn-0002u6-7C
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9ADHZwE074002
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vj26kpq8t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:21 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 10 Oct 2019 14:18:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Oct 2019 14:18:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9ADIEwt41156742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 13:18:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C55F4C058;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57C234C059;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from bahia.tls.ibm.com (bahia.tls.ibm.com [9.101.4.41])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 1B81D22006B;
 Thu, 10 Oct 2019 15:18:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/8] 9p patches 2019-10-10
Date: Thu, 10 Oct 2019 15:18:01 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101013-0008-0000-0000-00000320DF18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101013-0009-0000-0000-00004A3FE843
Message-Id: <20191010131809.1284004-1-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-10_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100125
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/9p-next-2019-10-10

for you to fetch changes up to e410bbc52a7a246858af54ce1842fadf26f39ff7:

  MAINTAINERS: Downgrade status of virtio-9p to "Odd Fixes" (2019-10-10 12:36:28 +0200)

----------------------------------------------------------------
The most notable change is that we now detect cross-device setups in the
host since it may cause inode number collision and mayhem in the guest.
A new fsdev property is added for the user to choose the appropriate
policy to handle that: either remap all inode numbers or fail I/Os to
another host device or just print out a warning (default behaviour).

This is also my last PR as _active_ maintainer of 9pfs.

----------------------------------------------------------------
Antonios Motakis (4):
      9p: unsigned type for type, version, path
      9p: Treat multiple devices on one export as an error
      9p: Added virtfs option 'multidevs=remap|forbid|warn'
      9p: stat_to_qid: implement slow path

Christian Schoenebeck (1):
      9p: Use variable length suffixes for inode remapping

Greg Kurz (3):
      9p: Simplify error path of v9fs_device_realize_common()
      fsdev: Add return value to fsdev_throttle_parse_opts()
      MAINTAINERS: Downgrade status of virtio-9p to "Odd Fixes"

 MAINTAINERS                 |   2 +-
 fsdev/9p-marshal.h          |   6 +-
 fsdev/file-op-9p.h          |   5 +
 fsdev/qemu-fsdev-opts.c     |   7 +-
 fsdev/qemu-fsdev-throttle.c |   4 +-
 fsdev/qemu-fsdev-throttle.h |   2 +-
 fsdev/qemu-fsdev.c          |   1 +
 hw/9pfs/9p-local.c          |  28 ++-
 hw/9pfs/9p-proxy.c          |   4 +
 hw/9pfs/9p.c                | 534 ++++++++++++++++++++++++++++++++++++++++----
 hw/9pfs/9p.h                |  60 +++++
 hw/9pfs/trace-events        |  14 +-
 qemu-options.hx             |  26 ++-
 vl.c                        |   7 +-
 14 files changed, 639 insertions(+), 61 deletions(-)
-- 
2.21.0


