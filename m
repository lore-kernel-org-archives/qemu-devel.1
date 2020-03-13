Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31638C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FE020724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FE020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58525 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCk3r-00058J-9I
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwg-0001Ww-Nb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwf-0007PP-Br
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwf-0007M4-2N
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCojWh143439
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yr17j5cbp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:43 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:38 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DD1a3066584792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E7D5A4068;
 Fri, 13 Mar 2020 13:01:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27D62A4067;
 Fri, 13 Mar 2020 13:01:36 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:36 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:22 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 04/15] s390x: protvirt: Inhibit balloon when
 switching to protected mode
In-Reply-To: <20200311132151.172389-5-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-5-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0028-0000-0000-000003E42D9B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0029-0000-0000-000024A978E0
Message-Id: <20200313135722.684a462e@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=2 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130066
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 09:21:40 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Ballooning in protected VMs can only be done when the guest shares the
> pages it gives to the host. If pages are not shared, the integrity
> checks will fail once those pages have been altered and are given back
> to the guest.
> 
> As we currently do not yet have a solution for this we will continue
> like this:
> 
> 1. We block ballooning now in QEMU (with this patch)
> 
> 2. Later we will provide a change to virtio that removes the blocker
> and adds VIRTIO_F_IOMMU_PLATFORM automatically by QEMU when doing the
> protvirt switch. This is ok as the guest balloon driver will reject to
> work with the IOMMU change
> 
> 3. Later we can fix the guest balloon driver to accept the IOMMU
> feature bit and correctly exercise sharing and unsharing of balloon
> pages
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index deb31e060052d279..066e01f303c35671 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/balloon.h"
>  #include "hw/s390x/pv.h"
>  #include "migration/blocker.h"
>  
> @@ -326,6 +327,7 @@ static void
> s390_machine_unprotect(S390CcwMachineState *ms) ms->pv = false;
>      migrate_del_blocker(pv_mig_blocker);
>      error_free_or_abort(&pv_mig_blocker);
> +    qemu_balloon_inhibit(false);
>  }
>  
>  static int s390_machine_protect(S390CcwMachineState *ms)
> @@ -333,10 +335,12 @@ static int
> s390_machine_protect(S390CcwMachineState *ms) Error *local_err = NULL;
>      int rc;
>  
> +    qemu_balloon_inhibit(true);
>      error_setg(&pv_mig_blocker,
>                 "protected VMs are currently not migrateable.");
>      rc = migrate_add_blocker(pv_mig_blocker, &local_err);
>      if (local_err) {
> +        qemu_balloon_inhibit(false);
>          error_report_err(local_err);
>          error_free_or_abort(&pv_mig_blocker);
>          return rc;
> @@ -345,6 +349,7 @@ static int
> s390_machine_protect(S390CcwMachineState *ms) /* Create SE VM */
>      rc = s390_pv_vm_enable();
>      if (rc) {
> +        qemu_balloon_inhibit(false);
>          error_report_err(local_err);
>          migrate_del_blocker(pv_mig_blocker);
>          error_free_or_abort(&pv_mig_blocker);

looks straightforward

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


