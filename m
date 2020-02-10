Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CCDC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF4F20661
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF4F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Eoz-0007Xm-1B
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j1Eo6-00077w-GD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j1Eo4-0005WK-IR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:33:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j1Eo4-0005RK-99
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:33:20 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01AJWhTn103084
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:33:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u5693x8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:33:15 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 10 Feb 2020 19:33:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Feb 2020 19:33:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01AJX8ib25428200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2020 19:33:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2FBAAE051;
 Mon, 10 Feb 2020 19:33:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A114DAE053;
 Mon, 10 Feb 2020 19:33:08 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.20])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 10 Feb 2020 19:33:08 +0000 (GMT)
Date: Mon, 10 Feb 2020 20:33:06 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 38/80] s390x/s390-virtio-ccw: use memdev for RAM
In-Reply-To: <20200206141553.706bc17b@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-39-git-send-email-imammedo@redhat.com>
 <20200205211123.43914b0c.pasic@linux.ibm.com>
 <20200206141553.706bc17b@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021019-0008-0000-0000-000003519CE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021019-0009-0000-0000-00004A723BCC
Message-Id: <20200210203306.44a6696a.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-10_07:2020-02-10,
 2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=876 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 14:15:53 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> > Tested-by: Halil Pasic <pasic@linux.ibm.com>
> > Acked-by: Halil Pasic <pasic@linux.ibm.com>  
> Thanks,
> 
> Could you also take a look at patches 3-7/8o that makes this possible?
> (it never hurts to have second pair of eyes on a code that affects
> everyone).

Sorry, I'm in the middle of debugging something, and it does not look
like I will be able to do a proper review on this soon. I did a quick
scan through the code and I did not see anything fishy.

Regards,
Halil


