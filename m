Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBA12073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBA12073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCk1c-0001hA-70
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwY-0001JF-Ti
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwX-00076N-07
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54158
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwW-000756-Pr
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCw0pL021103
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqx4dsk58-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:36 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:34 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DD1WM853411974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE4C2A405F;
 Fri, 13 Mar 2020 13:01:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563BCA4068;
 Fri, 13 Mar 2020 13:01:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:31 +0000 (GMT)
Date: Fri, 13 Mar 2020 13:57:42 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 12/15] s390x: protvirt: Move IO control structures
 over SIDA
In-Reply-To: <20200311132151.172389-13-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-13-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0008-0000-0000-0000035CA141
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0009-0000-0000-00004A7DEE5A
Message-Id: <20200313135742.37a78d26@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130066
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

On Wed, 11 Mar 2020 09:21:48 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> For protected guests, we need to put the IO emulation results into the
> SIDA, so SIE will write them into the guest at the next entry.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/ioinst.c | 87
> ++++++++++++++++++++++++++++++------------- 1 file changed, 61
> insertions(+), 26 deletions(-)
> 
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index 481d789de9e09a04..61095bdc9ffef436 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -136,9 +136,13 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t
> reg1, uint32_t ipb, uintptr_t ra) s390_program_interrupt(env,
> PGM_SPECIFICATION, ra); return;
>      }
> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib,
> sizeof(schib))) {
> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
> -        return;
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_read(cpu, addr, &schib, sizeof(schib));
> +    } else {
> +        if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib,
> sizeof(schib))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>      }
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid,
> &schid) || !ioinst_schib_valid(&schib)) {
> @@ -193,9 +197,13 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t
> reg1, uint32_t ipb, uintptr_t ra) s390_program_interrupt(env,
> PGM_SPECIFICATION, ra); return;
>      }
> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb,
> sizeof(orb))) {
> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
> -        return;
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_read(cpu, addr, &orig_orb, sizeof(orb));
> +    } else {
> +        if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb,
> sizeof(orb))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>      }
>      copy_orb_from_guest(&orb, &orig_orb);
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid,
> &schid) || @@ -229,14 +237,19 @@ void ioinst_handle_stcrw(S390CPU
> *cpu, uint32_t ipb, uintptr_t ra) cc = css_do_stcrw(&crw);
>      /* 0 - crw stored, 1 - zeroes stored */
>  
> -    if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) ==
> 0) {
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_write(cpu, addr, &crw, sizeof(crw));
>          setcc(cpu, cc);
>      } else {
> -        if (cc == 0) {
> -            /* Write failed: requeue CRW since STCRW is suppressing
> */
> -            css_undo_stcrw(&crw);
> +        if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw,
> sizeof(crw)) == 0) {
> +            setcc(cpu, cc);
> +        } else {
> +            if (cc == 0) {
> +                /* Write failed: requeue CRW since STCRW is
> suppressing */
> +                css_undo_stcrw(&crw);
> +            }
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>          }
> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
>      }
>  }
>  
> @@ -258,6 +271,9 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t
> reg1, uint32_t ipb, }
>  
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid,
> &schid)) {
> +        if (s390_is_pv()) {
> +            return;
> +        }

If the operand is invalid, should we not inject an operand exception?

If instead the Ultravisor or KVM make sure that we don't end up here,
then, why handle this at all?

>          /*
>           * As operand exceptions have a lower priority than access
> exceptions,
>           * we check whether the memory area is writeable (injecting
> the @@ -290,14 +306,19 @@ void ioinst_handle_stsch(S390CPU *cpu,
> uint64_t reg1, uint32_t ipb, }
>      }
>      if (cc != 3) {
> -        if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
> -                                    sizeof(schib)) != 0) {
> -            s390_cpu_virt_mem_handle_exc(cpu, ra);
> -            return;
> +        if (s390_is_pv()) {
> +            s390_cpu_pv_mem_write(cpu, addr, &schib, sizeof(schib));
> +        } else {
> +            if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
> +                                        sizeof(schib)) != 0) {
> +                s390_cpu_virt_mem_handle_exc(cpu, ra);
> +                return;
> +            }
>          }
>      } else {
>          /* Access exceptions have a higher priority than cc3 */
> -        if (s390_cpu_virt_mem_check_write(cpu, addr, ar,
> sizeof(schib)) != 0) {
> +        if (!s390_is_pv() &&
> +            s390_cpu_virt_mem_check_write(cpu, addr, ar,
> sizeof(schib)) != 0) { s390_cpu_virt_mem_handle_exc(cpu, ra);
>              return;
>          }
> @@ -334,15 +355,20 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t
> reg1, uint32_t ipb, uintptr_t ra) }
>      /* 0 - status pending, 1 - not status pending, 3 - not
> operational */ if (cc != 3) {
> -        if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) !=
> 0) {
> -            s390_cpu_virt_mem_handle_exc(cpu, ra);
> -            return -EFAULT;
> +        if (s390_is_pv()) {
> +            s390_cpu_pv_mem_write(cpu, addr, &irb, irb_len);
> +        } else {
> +            if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb,
> irb_len) != 0) {
> +                s390_cpu_virt_mem_handle_exc(cpu, ra);
> +                return -EFAULT;
> +            }
>          }
>          css_do_tsch_update_subch(sch);
>      } else {
>          irb_len = sizeof(irb) - sizeof(irb.emw);
>          /* Access exceptions have a higher priority than cc3 */
> -        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) !=
> 0) {
> +        if (!s390_is_pv() &&
> +            s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) !=
> 0) { s390_cpu_virt_mem_handle_exc(cpu, ra);
>              return -EFAULT;
>          }
> @@ -640,9 +666,13 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t
> ipb, uintptr_t ra)
>       * present CHSC sub-handlers ... if we ever need more, we should
> take
>       * care of req->len here first.
>       */
> -    if (s390_cpu_virt_mem_read(cpu, addr, reg, buf,
> sizeof(ChscReq))) {
> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
> -        return;
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_read(cpu, addr, buf, sizeof(ChscReq));
> +    } else {
> +        if (s390_cpu_virt_mem_read(cpu, addr, reg, buf,
> sizeof(ChscReq))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>      }
>      req = (ChscReq *)buf;
>      len = be16_to_cpu(req->len);
> @@ -673,11 +703,16 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t
> ipb, uintptr_t ra) break;
>      }
>  
> -    if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
> -                                 be16_to_cpu(res->len))) {
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_write(cpu, addr + len, res,
> be16_to_cpu(res->len)); setcc(cpu, 0);    /* Command execution
> complete */ } else {
> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
> +                                     be16_to_cpu(res->len))) {
> +            setcc(cpu, 0);    /* Command execution complete */
> +        } else {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        }
>      }
>  }
>  


