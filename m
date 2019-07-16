Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE317C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B367206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v+R61IMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B367206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVEE-000259-D0
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.kanda@oracle.com>) id 1hnVDz-0001Ox-2W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.kanda@oracle.com>) id 1hnVDy-00056m-5m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:43:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
 id 1hnVDx-00055d-SH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:43:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GL9EmZ065425;
 Tue, 16 Jul 2019 21:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=1bn498BSQc0ycn8wu+eOTBWzWO5+aZja1h2ZyLYBXAs=;
 b=v+R61IMcGnd2uSihUtAjKt5LwJOAFZdFOYYGZ2bo+o71HTyp8Jvcqc4zBh5o3drWOw+s
 Wcin/rd1CoS5gpqGWZsI/fZFOiqWm4zIhloExiAvGWwUeEZYUqdCmaGlz1/H4jyQmS6G
 GUCJa1gzlC8LX+0foUbb8ifymtNCdpV6nmbXAjuoF3t2TQNnM2vu05J3Ke/jcMM1dlkY
 xhh4GgfQjZ1yHEOJL4at+xjhiBRSWKARPpdsDUpSFU7v88kzU5W9/fhQ9AqQ/UDNL1I/
 EZc2fSpQYnF+EE3rKiVuFZ+pekZBJq7eL0SkjaXjnvXZVvIgZ9BZC2vZYWw+DYfoduCa pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2tq7xqy0nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 21:43:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GL8OBZ122287;
 Tue, 16 Jul 2019 21:42:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2tq5bcn3w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 21:42:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GLgwxP004387;
 Tue, 16 Jul 2019 21:42:58 GMT
Received: from mhkanda-aus-1.us.oracle.com (/10.135.188.192)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 16 Jul 2019 21:42:58 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 16:44:10 -0500
Message-Id: <1563313451-19861-1-git-send-email-mark.kanda@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160259
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=828 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160259
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH-for-4.2 0/1] Only enable the halt poll control
 MSR if it is supported by the host
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch addresses an issue with the 'queued, but not yet applied' halt
polling MSR patch. With this patch, halt polling is enabled 'by default';
this causes issues with hosts which don't support halt polling. The fix is
to only enable halt polling if it is supported by the host.

Mark Kanda (1):
  Only enable the halt poll control MSR if it is supported by the host

 target/i386/cpu.c     | 8 +++++++-
 target/i386/kvm.c     | 2 --
 target/i386/machine.c | 1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.21.0


