Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC58020724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC58020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCjxV-0002bB-MR
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwU-0001CD-Lk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwT-0006y2-28
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5446
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwS-0006x7-S8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCovFh079456
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqyhtf6yu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:32 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:30 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:28 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02DD1R6q46596378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03B4BA405C;
 Fri, 13 Mar 2020 13:01:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E88EA4065;
 Fri, 13 Mar 2020 13:01:26 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:26 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:30 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 07/15] s390x: protvirt: Move STSI data over SIDAD
In-Reply-To: <20200311132151.172389-8-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-8-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0008-0000-0000-0000035CA13E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0009-0000-0000-00004A7DEE57
Message-Id: <20200313135730.65009981@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130067
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 09:21:43 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> For protected guests, we need to put the STSI emulation results into
> the SIDA, so SIE will write them into the guest at the next entry.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index cdcd538b4f7fb318..8085d5030e7c6454 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -50,6 +50,7 @@
>  #include "exec/memattrs.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/s390-virtio-hcall.h"
> +#include "hw/s390x/pv.h"
>  
>  #ifndef DEBUG_KVM
>  #define DEBUG_KVM  0
> @@ -1800,7 +1801,9 @@ static void insert_stsi_3_2_2(S390CPU *cpu,
> __u64 addr, uint8_t ar) SysIB_322 sysib;
>      int del;
>  
> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib,
> sizeof(sysib))) {
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));
> +    } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib,
> sizeof(sysib))) { return;
>      }
>      /* Shift the stack of Extended Names to prepare for our own data
> */ @@ -1840,7 +1843,11 @@ static void insert_stsi_3_2_2(S390CPU *cpu,
> __u64 addr, uint8_t ar) /* Insert UUID */
>      memcpy(sysib.vm[0].uuid, &qemu_uuid, sizeof(sysib.vm[0].uuid));
>  
> -    s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, sizeof(sysib));
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_write(cpu, 0, &sysib, sizeof(sysib));
> +    } else {
> +        s390_cpu_virt_mem_write(cpu, addr, ar, &sysib,
> sizeof(sysib));
> +    }
>  }
>  
>  static int handle_stsi(S390CPU *cpu)

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


