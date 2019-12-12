Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59F7206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59F7206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifX5f-0001am-Ag
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifX4K-0000Qf-JV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifX4J-0008J2-7D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifX4I-0008F2-UV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCMWcmS050552
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:20 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuq3wpy0r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:19 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 12 Dec 2019 22:36:17 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Dec 2019 22:36:15 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCMaEoM38469674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 22:36:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7401A52063;
 Thu, 12 Dec 2019 22:36:14 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 60D595206C;
 Thu, 12 Dec 2019 22:36:14 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-185-241.de.ibm.com [9.145.185.241])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id E3F2B220110;
 Thu, 12 Dec 2019 23:36:13 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] 9pfs patches for QEMU 5.0
Date: Thu, 12 Dec 2019 23:35:55 +0100
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121222-0016-0000-0000-000002D441B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121222-0017-0000-0000-000033366A47
Message-Id: <20191212223601.309245-1-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1034
 mlxlogscore=993 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120172
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fb2246882a2c8d7f084ebe0617e97ac78467d156:

  .travis.yml: drop xcode9.4 from build matrix (2019-11-29 15:51:52 +0000)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/9p-next-2019-12-12

for you to fetch changes up to b3e2bb9458af556cb8aa0558f59222f462b81069:

  virtfs: Remove the deprecated "-virtfs_synth" option (2019-12-09 18:00:35 +0100)

----------------------------------------------------------------
- conversion of virtfs-proxy-helper from libcap to libcap-ng
- removal of libcap-dev from docker, travis and gitlab CI
- removal of deprecate "-virtfs_synth" option

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      ci: Use libcap-ng

Greg Kurz (1):
      travis.yml: Drop libcap-dev

Paolo Bonzini (2):
      virtfs-proxy-helper: switch from libcap to libcap-ng
      docker: remove libcap development packages

Thomas Huth (1):
      virtfs: Remove the deprecated "-virtfs_synth" option

 .gitlab-ci.yml                             |   2 +-
 .travis.yml                                |   1 -
 Makefile                                   |   1 -
 configure                                  |  20 +-----
 fsdev/virtfs-proxy-helper.c                | 100 +++++++++++++----------------
 qemu-deprecated.texi                       |   5 --
 qemu-options.hx                            |  10 ---
 tests/docker/dockerfiles/fedora.docker     |   1 -
 tests/docker/dockerfiles/ubuntu.docker     |   1 -
 tests/docker/dockerfiles/ubuntu1804.docker |   1 -
 vl.c                                       |  23 -------
 11 files changed, 48 insertions(+), 117 deletions(-)
-- 
2.21.0


