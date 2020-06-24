Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A2EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59772085B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59772085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0FL-0000Ps-Ry
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 03:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo0D6-0004T3-FZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:52:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10974
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo0D3-0006eA-KL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:52:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05O7WBBs036597
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31uwyxqcn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:38 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05O7WGdE036879
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:38 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31uwyxqcm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 03:52:37 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05O7nmj6013664;
 Wed, 24 Jun 2020 07:52:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma01fra.de.ibm.com with ESMTP id 31uurur6mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 07:52:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05O7qX0Z4718990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 07:52:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D00B6A404D;
 Wed, 24 Jun 2020 07:52:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11360A405D;
 Wed, 24 Jun 2020 07:52:33 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2020 07:52:32 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/12] pc-bios: s390x: Cleanup part 1
Date: Wed, 24 Jun 2020 03:52:14 -0400
Message-Id: <20200624075226.92728-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_04:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 mlxlogscore=602
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240051
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:52:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bios is in dire need for a cleanup as there are still a lot of
magic constants being used throughout as well as duplicated code.

In the first part of this series we consolidate constants and
functions, as well as doing some minor cleanups and fixes.

The patches are available here:
https://github.com/frankjaa/qemu/pull/new/cleanup_bios

v5:
	* Fixed whitespace damage
	* Removed reset PSW mask changes in dasd-ipl.c
	* Added jump2ipl.c cleanup patches

v4:
	* Renamed time.h to s390-time.h
	* Fixed function names in sleep()
	* Changed order of sense_id_ccw initialization
	* Added missing include before sleep()

v3:
	* Dropped 0x00 to 0x0/0 patch
	* Moved some timing functions into helper.h instead of time.h
	* Fixed IPL psw manipulation in dasd-ipl.c
 	* Minor cosmetic fixes found by review

v2:
	* Included cio fixup to get rid of compile errors...
	* Minor cosmetic fixes found by review


Janosch Frank (12):
  pc-bios: s390x: cio.c cleanup and compile fix
  pc-bios: s390x: Consolidate timing functions into time.h
  pc-bios: s390x: Move sleep and yield to helper.h
  pc-bios: s390x: Get rid of magic offsets into the lowcore
  pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw mask changes
  pc-bios: s390x: Rename PSW_MASK_ZMODE to PSW_MASK_64
  pc-bios: s390x: Use PSW masks where possible and introduce
    PSW_MASK_SHORT_ADDR
  pc-bios: s390x: Move panic() into header and add infinite loop
  pc-bios: s390x: Use ebcdic2ascii table
  pc-bios: s390x: Make u32 ptr check explicit
  pc-bios: s390x: Fix bootmap.c passing PSWs as addresses
  pc-bios: s390x: Cleanup jump to ipl code

 pc-bios/s390-ccw/bootmap.c     |  9 ++++----
 pc-bios/s390-ccw/bootmap.h     |  2 +-
 pc-bios/s390-ccw/cio.c         | 40 +++++++++++++++++++---------------
 pc-bios/s390-ccw/cio.h         | 17 ++++++++++-----
 pc-bios/s390-ccw/dasd-ipl.c    |  3 ---
 pc-bios/s390-ccw/helper.h      | 19 +++++++++++++++-
 pc-bios/s390-ccw/jump2ipl.c    | 35 ++++++++++++-----------------
 pc-bios/s390-ccw/main.c        | 15 +++----------
 pc-bios/s390-ccw/menu.c        |  1 +
 pc-bios/s390-ccw/netmain.c     | 23 +++----------------
 pc-bios/s390-ccw/s390-arch.h   |  4 +++-
 pc-bios/s390-ccw/s390-ccw.h    | 27 ++++++-----------------
 pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++
 pc-bios/s390-ccw/start.S       |  5 +++--
 pc-bios/s390-ccw/virtio-net.c  |  2 ++
 pc-bios/s390-ccw/virtio-scsi.c |  2 ++
 pc-bios/s390-ccw/virtio.c      | 18 +++------------
 17 files changed, 120 insertions(+), 125 deletions(-)
 create mode 100644 pc-bios/s390-ccw/s390-time.h

-- 
2.25.1


