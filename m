Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C596CC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA752073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA752073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCjzG-0005Tc-Q4
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwq-0001uL-TU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwp-0007nR-MO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5548
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwp-0007P2-Gt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DD1dvQ013845
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yr0c0df65-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:44 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:39 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DD1cfo54984842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 474F8A4066;
 Fri, 13 Mar 2020 13:01:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C18B8A4054;
 Fri, 13 Mar 2020 13:01:37 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:37 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:35 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 10/15] s390x: protvirt: Move diag 308 data over SIDA
In-Reply-To: <20200311132151.172389-11-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-11-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0008-0000-0000-0000035CA144
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0009-0000-0000-00004A7DEE5D
Message-Id: <20200313135735.6ddff579@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Wed, 11 Mar 2020 09:21:46 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> For protected guests the IPIB is written/read to/from the SIDA, so we
> need those accesses to go through s390_cpu_pv_mem_read/write().
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/diag.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index b245e557037ded06..a733485caf162111 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -88,6 +88,7 @@ static int diag308_parm_check(CPUS390XState *env,
> uint64_t r1, uint64_t addr, void handle_diag_308(CPUS390XState *env,
> uint64_t r1, uint64_t r3, uintptr_t ra) {
>      CPUState *cs = env_cpu(env);
> +    S390CPU *cpu = S390_CPU(cs);
>      uint64_t addr =  env->regs[r1];
>      uint64_t subcode = env->regs[r3];
>      IplParameterBlock *iplb;
> @@ -124,13 +125,22 @@ void handle_diag_308(CPUS390XState *env,
> uint64_t r1, uint64_t r3, uintptr_t ra) return;
>          }
>          iplb = g_new0(IplParameterBlock, 1);
> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        if (!s390_is_pv()) {
> +            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        } else {
> +            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
> +        }
> +
>          if (!iplb_valid_len(iplb)) {
>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>              goto out;
>          }
>  
> -        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> +        if (!s390_is_pv()) {
> +            cpu_physical_memory_read(addr, iplb,
> be32_to_cpu(iplb->len));
> +        } else {
> +            s390_cpu_pv_mem_read(cpu, 0, iplb,
> be32_to_cpu(iplb->len));
> +        }
>  
>          if (!iplb_valid(iplb)) {
>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
> @@ -152,12 +162,17 @@ out:
>          } else {
>              iplb = s390_ipl_get_iplb();
>          }
> -        if (iplb) {
> -            cpu_physical_memory_write(addr, iplb,
> be32_to_cpu(iplb->len));
> -            env->regs[r1 + 1] = DIAG_308_RC_OK;
> -        } else {
> +        if (!iplb) {
>              env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
> +            return;
>          }
> +
> +        if (!s390_is_pv()) {
> +            cpu_physical_memory_write(addr, iplb,
> be32_to_cpu(iplb->len));
> +        } else {
> +            s390_cpu_pv_mem_write(cpu, 0, iplb,
> be32_to_cpu(iplb->len));
> +        }
> +        env->regs[r1 + 1] = DIAG_308_RC_OK;
>          return;
>      case DIAG308_PV_START:
>          iplb = s390_ipl_get_iplb_pv();

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


