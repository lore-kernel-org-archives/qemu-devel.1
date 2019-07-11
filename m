Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA7C74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 03:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744B2214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 03:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744B2214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlPSL-0007Ke-I2
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 23:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bharata@linux.ibm.com>) id 1hlPRl-0006oE-AK
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 23:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1hlPRk-0005ll-5U
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 23:08:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1hlPRj-0005kn-Pp
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 23:08:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6B37U5o017121
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 23:08:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tnvb68yd0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 23:08:31 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Thu, 11 Jul 2019 04:08:29 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Jul 2019 04:08:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x6B38QiT40763752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2019 03:08:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4278911C064;
 Thu, 11 Jul 2019 03:08:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6005A11C05E;
 Thu, 11 Jul 2019 03:08:25 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.85.188])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 11 Jul 2019 03:08:25 +0000 (GMT)
Date: Thu, 11 Jul 2019 08:38:23 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190710060621.16430-1-bharata@linux.ibm.com>
 <20190711013100.GC13271@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711013100.GC13271@umbus.fritz.box>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-TM-AS-GCONF: 00
x-cbid: 19071103-0028-0000-0000-00000382FD60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071103-0029-0000-0000-000024430FC6
Message-Id: <20190711030823.GA12321@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110035
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v0] ppc/spapr: Support reboot of secure
 pseries guest
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
Reply-To: bharata@linux.ibm.com
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 11:31:00AM +1000, David Gibson wrote:
> On Wed, Jul 10, 2019 at 11:36:21AM +0530, Bharata B Rao wrote:
> > A pseries guest can be run as a secure guest on Ultravisor-enabled
> > POWER platforms. When such a secure guest is reset, we need to
> > release/reset a few resources both on ultravisor and hypervisor side.
> > This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> > machine reset path.
> > 
> > As part of this ioctl, the secure guest is essentially transitioned
> > back to normal mode so that it can reboot like a regular guest and
> > become secure again.
> > 
> > This ioctl has no effect when invoked for a normal guest.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> > * The ioctl implementation in the kernel can be found as part of this patchset:
> >   https://www.spinics.net/lists/linux-mm/msg184366.html
> > * Updated linux-headers/linux/kvm.h here for completeness as the
> >   definition of KVM_PPC_SVM_OFF isn't yet part of upstream kernel.
> 
> The qemu change looks good to me.  To actually merge this, the support
> will need to go upstream in the kernel first, then we'll need an
> update-kernel-headers as a separate patch.

Sure, Thanks. Will post again once ioctl support is included in the
kernel.

Regards,
Bharata.


