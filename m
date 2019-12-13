Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0BBC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 04:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AEB2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 04:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AEB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifcCy-0007xP-2N
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 23:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ifcCA-0007Qf-MV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 23:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ifcC9-0004pk-MZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 23:04:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ifcC9-0004oD-Ef
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 23:04:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBD42BM7023040
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 23:04:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuswnengj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 23:04:47 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Fri, 13 Dec 2019 04:04:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 04:04:42 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBD44fpa42532986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 04:04:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B796E4C04A;
 Fri, 13 Dec 2019 04:04:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65D9C4C040;
 Fri, 13 Dec 2019 04:04:40 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.92.59])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Dec 2019 04:04:40 +0000 (GMT)
Date: Fri, 13 Dec 2019 09:34:38 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
References: <20191212055059.9399-1-bharata@linux.ibm.com>
 <20191212055059.9399-3-bharata@linux.ibm.com>
 <20191212132723.5fdfee47@bahia.tlslab.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212132723.5fdfee47@bahia.tlslab.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 19121304-0012-0000-0000-000003745172
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121304-0013-0000-0000-000021B02F9F
Message-Id: <20191213040438.GC28362@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130032
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxram@us.ibm.com,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 01:27:23PM +0100, Greg Kurz wrote:
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f11422fc41..25e1a3446e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1597,6 +1597,21 @@ static void spapr_machine_reset(MachineState *machine)
> >      void *fdt;
> >      int rc;
> >  
> > +    /*
> > +     * KVM_PPC_SVM_OFF ioctl can fail for secure guests, check and
> > +     * exit in that case. However check for -ENOTTY explicitly
> > +     * to ensure that we don't terminate normal guests that are
> > +     * running on kernels which don't support this ioctl.
> > +     *
> > +     * Also, this ioctl returns 0 for normal guests on kernels where
> > +     * this ioctl is supported.
> > +     */
> > +    rc = kvmppc_svm_off();
> > +    if (rc && rc != -ENOTTY) {
> 
> This ioctl can also return -EINVAL if the ultravisor actually failed to move
> the guest back to non-secure mode or -EBUSY if a vCPU is still running. I
> agree that the former deserve the VM to be terminated. What about the latter ?
> Can this happen and if yes, why ? Should we try again as suggested by Alexey ?
> Could this reveal a bug in QEMU, in which case we should maybe abort ?

We are in machine reset path, so all vcpus are already paused. So we don't
expect any vcpus to be running to handle -EBUSY here. Neither do I see any
sane recovery path from here.

As Alexey mentioned earlier, may be we can just stop the VM?
Do vm_stop() with RUN_STATE_PAUSED or some such reason?

Regards,
Bharata.


