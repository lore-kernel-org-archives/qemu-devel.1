Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9462FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 03:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7EF20726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 03:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7EF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieWYr-0001On-Et
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 22:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ieWXz-0000J8-O1
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ieWXy-00076A-D3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:50:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ieWXy-00075F-4q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:50:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBA3gQZ2070129
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2019 22:50:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3nqjxx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 22:50:48 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Tue, 10 Dec 2019 03:50:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Dec 2019 03:50:43 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBA3ogF136044826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2019 03:50:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6939411C04C;
 Tue, 10 Dec 2019 03:50:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1B211C052;
 Tue, 10 Dec 2019 03:50:41 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.37.168])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Dec 2019 03:50:41 +0000 (GMT)
Date: Tue, 10 Dec 2019 09:20:38 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v1 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
References: <20191209070012.14766-1-bharata@linux.ibm.com>
 <20191209070012.14766-3-bharata@linux.ibm.com>
 <20191210032851.GC207300@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210032851.GC207300@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 19121003-0008-0000-0000-0000033F515C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121003-0009-0000-0000-00004A5E8094
Message-Id: <20191210035038.GB17552@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_05:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100033
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
Reply-To: bharata@linux.ibm.com
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 02:28:51PM +1100, David Gibson wrote:
> On Mon, Dec 09, 2019 at 12:30:12PM +0530, Bharata B Rao wrote:
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
> >  hw/ppc/spapr.c       | 1 +
> >  target/ppc/kvm.c     | 7 +++++++
> >  target/ppc/kvm_ppc.h | 6 ++++++
> >  3 files changed, 14 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f11422fc41..4c7ad3400d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *machine)
> >      void *fdt;
> >      int rc;
> >  
> > +    kvmppc_svm_off();
> 
> If you're going to have this return an error value, you should really
> check it here.

I could, by spapr_machine_reset() and the callers don't propagate the
errors up. So may be I could print a warning instead when ioctl fails?

Regards,
Bharata.


