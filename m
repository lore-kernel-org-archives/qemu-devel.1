Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16D82073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16D82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCk0P-0008EH-VK
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwX-0001G2-DH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwV-00072p-O4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwV-000715-E4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCpRE2135729
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqwbyv2kb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:34 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:32 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:30 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02DD0Sxe49480168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:00:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E58EA4067;
 Fri, 13 Mar 2020 13:01:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24080A4065;
 Fri, 13 Mar 2020 13:01:28 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:28 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:44 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 13/15] s390x: protvirt: Handle SIGP store status
 correctly
In-Reply-To: <20200311132151.172389-14-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-14-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-4275-0000-0000-000003ABB309
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-4276-0000-0000-000038C0D4A0
Message-Id: <20200313135744.3799d55a@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003130067
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

On Wed, 11 Mar 2020 09:21:49 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> For protected VMs status storing is not done by QEMU anymore.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index ed726849114f2f35..5022df8812d406c9 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -25,6 +25,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/qemu-print.h"
>  #include "hw/s390x/ioinst.h"
> +#include "hw/s390x/pv.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/runstate.h"
>  #ifndef CONFIG_USER_ONLY
> @@ -246,6 +247,11 @@ int s390_store_status(S390CPU *cpu, hwaddr addr,
> bool store_arch) hwaddr len = sizeof(*sa);
>      int i;
>  
> +    /* Storing will occur on next SIE entry for protected VMs */
> +    if (s390_is_pv()) {
> +        return 0;
> +    }
> +
>      sa = cpu_physical_memory_map(addr, &len, true);
>      if (!sa) {
>          return -EFAULT;

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


