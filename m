Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0086DC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1423207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gKP9/Tn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1423207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEHR-0003Zj-W0
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBEGQ-0002HA-Ma
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBEGN-0004UD-QY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:32:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07R93H7n190733
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bykdKesFZ7qoAwsDkF/5GNjz1u3vYto13y+9bLAAg30=;
 b=gKP9/Tn3m/CdWM7SYxh4XL2YR33YGygsVDMz+MjJ6MqVviuQOYk0Pv8l+2IdrNSM6Mhb
 quR8KERRUINnRA6MSnJSJpZ59l0qxCP/0Ryk86L7tF4Ft71PEXTiG/aWA2WlLI3Uq7gv
 WiPh0n2QjYPuZm7xzBpfx6JjSGAPWwnMWpUEessz7vjO3gqevIordexNhgVq6mGRzAI3
 8vpaBKc7pvWNfW6Fwlfqs0z1SNqyEOfjdooop8GMXmhWUSHWUXctKZ9bq6Q+9Zh0xoV3
 czxpeKwtjI6+y0ykthwwxbws0g28ehs02SWkEr4SmSGy07nqKDB9sydQ1zhbcyRd4Ki3 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3368aqky9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:05 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07R93Mt6191380
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:32:04 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3368aqky8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2020 05:32:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R9IAeX029591;
 Thu, 27 Aug 2020 09:32:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04fra.de.ibm.com with ESMTP id 332ujjuch7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2020 09:32:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07R9VxUt23920990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 09:32:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0A9542054;
 Thu, 27 Aug 2020 09:31:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22BD742049;
 Thu, 27 Aug 2020 09:31:59 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2020 09:31:59 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] pc-bios: s390x: Cleanup part 2
Date: Thu, 27 Aug 2020 05:31:48 -0400
Message-Id: <20200827093152.3026-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-27_02:2020-08-27,
 2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=967 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:32:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

So, here are a few more cleanup patches mostly cleaning up ipl code
and some of the assembly.

The patches are available here:
https://github.com/frankjaa/qemu/pull/new/cleanup_bios2


v2:
	* Fixed psw saving in use reset psw patch (thanks Jason)
	* Dropped a lot of patches which weren't strictly necessary
	* Added disabled wait patch
	* Added RFC PSW save patch

Janosch Frank (4):
  pc-bios: s390x: Fix bootmap.c zipl component entry data handling
  pc-bios: s390x: Use reset PSW if avaliable
  pc-bios: s390x: Save io and external new PSWs before overwriting them
  pc-bios: s390x: Go into disabled wait when encountering a PGM
    exception

 pc-bios/s390-ccw/bootmap.c  |  6 ++--
 pc-bios/s390-ccw/bootmap.h  |  7 +++-
 pc-bios/s390-ccw/jump2ipl.c | 51 ++++++++++++++++++-----------
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 pc-bios/s390-ccw/start.S    | 65 +++++++++++++++++++++++++++----------
 5 files changed, 91 insertions(+), 39 deletions(-)

-- 
2.25.1


