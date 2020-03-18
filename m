Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E4AC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABCF20767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABCF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEPzC-000422-GT
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 00:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mahesh@linux.ibm.com>) id 1jEPyZ-0003TS-I1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mahesh@linux.ibm.com>) id 1jEPyY-0007SA-8b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:06:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49054
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mahesh@linux.ibm.com>)
 id 1jEPyY-0007P2-2U
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:06:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02I42VfL067514
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 00:06:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yu98sn6mq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 00:06:36 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mahesh@linux.ibm.com>;
 Wed, 18 Mar 2020 04:06:35 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 04:06:32 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02I46Vx452559940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 04:06:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B3C011C04C;
 Wed, 18 Mar 2020 04:06:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D366E11C05B;
 Wed, 18 Mar 2020 04:06:29 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.55.186])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 18 Mar 2020 04:06:29 +0000 (GMT)
Date: Wed, 18 Mar 2020 09:36:27 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc/spapr: Set the effective address provided flag in mc
 error log.
References: <158444819283.31599.12155058652686614304.stgit@jupiter>
 <158446030854.25100.12364998990821380964@39012742ff91>
 <20200317171122.21c49c15@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317171122.21c49c15@bahia.lan>
X-TM-AS-GCONF: 00
x-cbid: 20031804-0016-0000-0000-000002F2EED7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031804-0017-0000-0000-000033567229
Message-Id: <20200318040627.ywedm5aay3cllfzc@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_10:2020-03-17,
 2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180018
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Reply-To: mahesh@linux.ibm.com
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com,
 ganeshgr@linux.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-03-17 17:11:22 Tue, Greg Kurz wrote:
> On Tue, 17 Mar 2020 08:51:50 -0700 (PDT)
> no-reply@patchew.org wrote:
> 
> > Patchew URL: https://patchew.org/QEMU/158444819283.31599.12155058652686614304.stgit@jupiter/
> > 
> > 
> > 
> > Hi,
> > 
> > This series seems to have some coding style problems. See output below for
> > more information:
> > 
> > Subject: [PATCH] ppc/spapr: Set the effective address provided flag in mc error log.
> > Message-id: 158444819283.31599.12155058652686614304.stgit@jupiter
> > Type: series
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > === TEST SCRIPT END ===
> > 
> > Switched to a new branch 'test'
> > 62d8ada ppc/spapr: Set the effective address provided flag in mc error log.
> > 
> > === OUTPUT BEGIN ===
> > ERROR: code indent should never use tabs
> > #57: FILE: hw/ppc/spapr_events.c:739:
> > +^Iswitch (ext_elog->mc.error_type) {$
> > 
> 
> Yeah no tabs allowed in the QEMU code (see CODING_STYLE.rst).
> 
> If your editor is emacs, you can consider setting these:
> 
>   (setq indent-tabs-mode nil)
>   (setq c-basic-offset 4))

My bad. Will fix it and respin v2.

Thanks,
-Mahesh.


