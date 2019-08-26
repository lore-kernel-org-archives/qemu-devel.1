Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25DC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E262F2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E262F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Lqx-0003hd-Rh
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1i2Lpx-00038a-VP
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1i2Lpw-0007Am-QS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:43:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25048
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1i2Lpr-00078G-HI; Mon, 26 Aug 2019 16:43:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7QKhL1O014148; Mon, 26 Aug 2019 16:43:22 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2umm1d5y9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2019 16:43:21 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7QKWTCD016547;
 Mon, 26 Aug 2019 20:43:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01wdc.us.ibm.com with ESMTP id 2ujvv670a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2019 20:43:09 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7QKh9QU42664446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Aug 2019 20:43:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E903AC05F;
 Mon, 26 Aug 2019 20:43:09 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F26EAC059;
 Mon, 26 Aug 2019 20:43:09 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.41.247.5])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Aug 2019 20:43:09 +0000 (GMT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190826165434.18403-1-richard.henderson@linaro.org>
 <20190826165434.18403-2-richard.henderson@linaro.org>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <3fd813d9-c7b9-da6d-7a4a-7650c01d5a1e@us.ibm.com>
Date: Mon, 26 Aug 2019 15:43:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826165434.18403-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-26_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908260194
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH 1/1] target/ppc: Fix do_float_check_status
 vs inexact
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 11:54 AM, Richard Henderson wrote:
> The underflow and inexact exceptions are not mutually exclusive.
> Check for both of them.  Tidy the reset of FPSCR[FI].
> 
> Fixes: https://bugs.launchpad.net/bugs/1841442
> Reported-by: Paul Clarke <pc@us.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Paul Clarke <pc@us.ibm.com>

Thanks, Richard!

There seems to be a similar problem with underflow.  I'll narrow down a test case, and I guess I'll just open a new bug report.

PC
> ---
>  target/ppc/fpu_helper.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 07bc9051b0..2e023c5204 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -630,19 +630,15 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
>  {
>      CPUState *cs = env_cpu(env);
>      int status = get_float_exception_flags(&env->fp_status);
> -    bool inexact_happened = false;
>  
>      if (status & float_flag_overflow) {
>          float_overflow_excp(env);
>      } else if (status & float_flag_underflow) {
>          float_underflow_excp(env);
> -    } else if (status & float_flag_inexact) {
> -        float_inexact_excp(env);
> -        inexact_happened = true;
>      }
> -
> -    /* if the inexact flag was not set */
> -    if (inexact_happened == false) {
> +    if (status & float_flag_inexact) {
> +        float_inexact_excp(env);
> +    } else {
>          env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
>      }
>  
> 

