Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF2522527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF2522527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifX6C-0002TQ-Hf
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifX4m-0000v2-08
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifX4j-0000c2-Kl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5992
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifX4j-0000bV-Fz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:49 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCMX5kL080973
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wusmk10tk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:48 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 12 Dec 2019 22:36:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Dec 2019 22:36:45 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCMaihH58720464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 22:36:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F19611C054;
 Thu, 12 Dec 2019 22:36:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A77311C052;
 Thu, 12 Dec 2019 22:36:44 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 22:36:44 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-185-241.de.ibm.com [9.145.185.241])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 597B3220110;
 Thu, 12 Dec 2019 23:36:43 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/5] travis.yml: Drop libcap-dev
Date: Thu, 12 Dec 2019 23:35:59 +0100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212223601.309245-1-groug@kaod.org>
References: <20191212223601.309245-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19121222-0008-0000-0000-000003404458
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121222-0009-0000-0000-00004A60486D
Message-Id: <20191212223601.309245-5-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=2
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=879 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120172
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xBCMX5kL080973
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 7e46261368d1 converted virtfs-proxy-helper to using libcap-ng. The=
re
aren't any users of libcap anymore. No need to install libcap-dev.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 .travis.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 445b0646c18a..6cb8af6fa599 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -26,7 +26,6 @@ addons:
       - libaio-dev
       - libattr1-dev
       - libbrlapi-dev
-      - libcap-dev
       - libcap-ng-dev
       - libgcc-4.8-dev
       - libgnutls28-dev
--=20
2.21.0


