Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D004C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA9920663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA9920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdY7Z-0002RA-Br
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6o-0001KG-99
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6n-0004kf-Ff
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04QBWI95072540; Tue, 26 May 2020 07:50:26 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3170032434-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 07:50:25 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QBoNE8010094;
 Tue, 26 May 2020 11:50:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 316uf82brw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 11:50:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04QBoLKE11206730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2020 11:50:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E0D85204E;
 Tue, 26 May 2020 11:50:21 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id D198052050;
 Tue, 26 May 2020 11:50:20 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-63-64.uk.ibm.com [9.145.63.64])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 3634C22003E;
 Tue, 26 May 2020 13:50:20 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] 9p patches 2020-05-26
Date: Tue, 26 May 2020 13:49:27 +0200
Message-Id: <20200526114931.391049-1-groug@kaod.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-26_01:2020-05-26,
 2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 cotscore=-2147483648 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=986 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 clxscore=1034 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260083
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:50:51
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fea8f3ed739536fca027cf56af7f5576f37ef9=
cd:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20=
200522' into staging (2020-05-22 18:54:47 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/9p-next-2020-05-26

for you to fetch changes up to 84af75577cceb195b044e2d5ba6d940206b169ca:

  xen/9pfs: increase max ring order to 9 (2020-05-25 11:45:40 +0200)

----------------------------------------------------------------
- fix build with musl libc
- fix potential deadlock of QEMU main event loop (cannot be hit with linu=
x
  client)
- revert 9pfs reply truncation (LP 1877688)
- xen backend waits for client to free space on the reply ring instead of
  truncating or disconnecting

----------------------------------------------------------------
Dan Robertson (1):
  9pfs: include linux/limits.h for XATTR_SIZE_MAX

Greg Kurz (1):
  9p: Lock directory streams with a CoMutex

Stefano Stabellini (3):
  Revert "9p: init_in_iov_from_pdu can truncate the size"
  xen/9pfs: yield when there isn't enough room on the ring
  xen/9pfs: increase max ring order to 9

 hw/9pfs/9p.c               | 34 ++++++++++++--------------------
 hw/9pfs/9p.h               | 10 +++++-----
 hw/9pfs/virtio-9p-device.c | 11 ++++-------
 hw/9pfs/xen-9p-backend.c   | 40 ++++++++++++++++++++++++++------------
 4 files changed, 49 insertions(+), 46 deletions(-)

--=20
2.21.3


