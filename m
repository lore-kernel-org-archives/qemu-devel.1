Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095C0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D248F214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D248F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if27s-0002st-VP
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1if26r-0002H6-W9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1if26q-0002jg-HM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:32:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1if26q-0002gw-82
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:32:56 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBDR9QT128480
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:32:53 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8kywauf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:32:53 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 11 Dec 2019 13:32:47 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Dec 2019 13:32:43 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBBDWg8A47906944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 13:32:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FC01AE045;
 Wed, 11 Dec 2019 13:32:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32352AE04D;
 Wed, 11 Dec 2019 13:32:42 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.152.115])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 13:32:42 +0000 (GMT)
Subject: [PATCH] object: Improve documentation of interfaces
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Dec 2019 14:32:41 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121113-0020-0000-0000-00000397277E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121113-0021-0000-0000-000021EE2BC5
Message-Id: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1034 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110115
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QOM interfaces allow a limited form of multiple inheritance, at the
condition of being stateless. That is, they cannot be instantiated
and a pointer to an interface shouldn't be dereferenceable in any way.
This is achieved by making the QOM instance type an incomplete type,
which is, as mentioned by Markus Armbruster, the closest you can get
to abstract class in C.

Incomplete types are widely used to hide implementation details, but
people usually expect to find at least one place where the type is
fully defined. The fact that it doesn't happen with QOM interfaces is
quite disturbing, especially since it isn't documented anywhere as
recently discussed in this thread:

https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html

Amend the documentation in the object.h header file to provide more
details about why and how to implement QOM interfaces using incomplete
types.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/qom/object.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 128d00c77fd6..5cf98d2c4350 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * Interfaces allow a limited form of multiple inheritance.  Instances are
  * similar to normal types except for the fact that are only defined by
- * their classes and never carry any state.  You can dynamically cast an object
- * to one of its #Interface types and vice versa.
+ * their classes and never carry any state.  As a consequence, a pointer to
+ * an interface instance should always be of incomplete type in order to be
+ * sure it cannot be dereferenced.  That is, you should define the
+ * 'typedef struct SomethingIf SomethingIf' so that you can pass around
+ * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { ... }'.
+ * The only things you can validly do with a 'SomethingIf *' are to pass it as
+ * an argument to a method on its corresponding SomethingIfClass, or to
+ * dynamically cast it to an object that implements the interface.
  *
  * # Methods #
  *


