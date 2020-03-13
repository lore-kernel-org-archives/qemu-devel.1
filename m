Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E10C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60BE20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60BE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCjxQ-0002Rm-T0
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwQ-00019e-DH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwP-0006oW-3L
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48348
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwO-0006lV-VB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCovFQ079458
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqyhtf6v2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:27 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DD1NdJ23068826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B38BA405F;
 Fri, 13 Mar 2020 13:01:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AD50A4068;
 Fri, 13 Mar 2020 13:01:22 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:22 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:32 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 08/15] s390x: protvirt: SCLP interpretation
In-Reply-To: <20200311132151.172389-9-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-9-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0012-0000-0000-000003907723
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0013-0000-0000-000021CD4CA8
Message-Id: <20200313135732.3429bab9@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
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

On Wed, 11 Mar 2020 09:21:44 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> SCLP for a protected guest is done over the SIDAD, so we need to use
> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
> memory when reading/writing SCBs.
> 
> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
> since the function that injects the sclp external interrupt would
> reject a zero sccb address.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/sclp.c         | 30 ++++++++++++++++++++++++++++++
>  include/hw/s390x/sclp.h |  2 ++
>  target/s390x/kvm.c      | 24 +++++++++++++++++++-----
>  3 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index af0bfbc2eca74767..5f3aa30d6283dce5 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -193,6 +193,36 @@ static void sclp_execute(SCLPDevice *sclp, SCCB
> *sccb, uint32_t code) }
>  }
>  
> +/*
> + * We only need the address to have something valid for the
> + * service_interrupt call.
> + */
> +#define SCLP_PV_DUMMY_ADDR 0x4000
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code)
> +{
> +    SCLPDevice *sclp = get_sclp_device();
> +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> +    SCCB work_sccb;
> +    hwaddr sccb_len = sizeof(SCCB);
> +
> +    /*
> +     * Only a very limited amount of calls is permitted by the
> +     * Ultravisor and we support all of them, so we don't check for
> +     * them. All other specification exceptions are also interpreted
> +     * by the Ultravisor and hence never cause an exit we need to
> +     * handle.
> +     *
> +     * Setting the CC is also done by the Ultravisor.
> +     */
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> +    sclp_c->execute(sclp, &work_sccb, code);
> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> +                          be16_to_cpu(work_sccb.h.length));
> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
> +    return 0;
> +}
> +
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t
> code) {
>      SCLPDevice *sclp = get_sclp_device();
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index c54413b78cf01b27..c0a3faa37d730453 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>  void sclp_service_interrupt(uint32_t sccb);
>  void raise_irq_cpu_hotplug(void);
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t
> code); +int sclp_service_call_protected(CPUS390XState *env, uint64_t
> sccb,
> +                                uint32_t code);
>  
>  #endif
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8085d5030e7c6454..ff6027036ec2f14a 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1227,12 +1227,26 @@ static void kvm_sclp_service_call(S390CPU
> *cpu, struct kvm_run *run, sccb = env->regs[ipbh0 & 0xf];
>      code = env->regs[(ipbh0 & 0xf0) >> 4];
>  
> -    r = sclp_service_call(env, sccb, code);
> -    if (r < 0) {
> -        kvm_s390_program_interrupt(cpu, -r);
> -        return;
> +    switch (run->s390_sieic.icptcode) {
> +    case ICPT_PV_INSTR_NOTIFICATION:
> +        g_assert(s390_is_pv());
> +        /* The notification intercepts are currently handled by KVM
> */
> +        error_report("unexpected SCLP PV notification");
> +        exit(1);
> +        break;
> +    case ICPT_PV_INSTR:
> +        g_assert(s390_is_pv());
> +        sclp_service_call_protected(env, sccb, code);
> +        break;
> +    case ICPT_INSTRUCTION:
> +        g_assert(!s390_is_pv());
> +        r = sclp_service_call(env, sccb, code);
> +        if (r < 0) {
> +            kvm_s390_program_interrupt(cpu, -r);
> +            return;
> +        }
> +        setcc(cpu, r);
>      }
> -    setcc(cpu, r);
>  }
>  
>  static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)


Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


