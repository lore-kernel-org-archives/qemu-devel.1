Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C29C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A16820724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A16820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCk2c-0003DY-Ir
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwn-0001nE-N8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwi-0007Wo-L8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwi-0007Uy-9e
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCvhGo073805
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqxhsehwm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:47 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:41 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DD1dbc46465260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6C97A4065;
 Fri, 13 Mar 2020 13:01:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59D54A4054;
 Fri, 13 Mar 2020 13:01:39 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:39 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:19 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 03/15] s390x: protvirt: Add migration blocker
In-Reply-To: <20200311132151.172389-4-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-4-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0028-0000-0000-000003E42D9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0029-0000-0000-000024A978E4
Message-Id: <20200313135719.26dd7837@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=809 lowpriorityscore=0 suspectscore=2
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130067
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

On Wed, 11 Mar 2020 09:21:39 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Migration is not yet supported.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 9569b777a0e1abd6..deb31e060052d279 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -42,6 +42,9 @@
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/s390x/pv.h"
> +#include "migration/blocker.h"
> +
> +static Error *pv_mig_blocker;
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -321,15 +324,30 @@ static void
> s390_machine_unprotect(S390CcwMachineState *ms) {
>      s390_pv_vm_disable();
>      ms->pv = false;
> +    migrate_del_blocker(pv_mig_blocker);
> +    error_free_or_abort(&pv_mig_blocker);
>  }
>  
>  static int s390_machine_protect(S390CcwMachineState *ms)
>  {
> +    Error *local_err = NULL;
>      int rc;
>  
> +    error_setg(&pv_mig_blocker,
> +               "protected VMs are currently not migrateable.");
> +    rc = migrate_add_blocker(pv_mig_blocker, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        error_free_or_abort(&pv_mig_blocker);
> +        return rc;
> +    }
> +
>      /* Create SE VM */
>      rc = s390_pv_vm_enable();
>      if (rc) {
> +        error_report_err(local_err);
> +        migrate_del_blocker(pv_mig_blocker);
> +        error_free_or_abort(&pv_mig_blocker);
>          return rc;
>      }
>  

looks rather straightforward

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


