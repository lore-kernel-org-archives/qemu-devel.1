Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC48C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BEF2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BEF2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iALNd-0001WW-Vd
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1iALMP-0000JM-Qw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1iALMO-0001XC-NT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:50:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24774
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1iALMK-0001Uz-OU; Tue, 17 Sep 2019 17:50:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HLSkP3050642; Tue, 17 Sep 2019 17:49:56 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v34ta6ner-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 17:49:56 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8HLjIcX029654;
 Tue, 17 Sep 2019 21:49:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 2v37jw0277-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 21:49:55 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8HLnspl8913368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 21:49:54 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEA3B7805F;
 Tue, 17 Sep 2019 21:49:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F4CF78066;
 Tue, 17 Sep 2019 21:49:53 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.70.45])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Sep 2019 21:49:53 +0000 (GMT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1568653336-16819-1-git-send-email-pc@us.ibm.com>
 <a561c80e-68b0-bd56-2718-6c3325d27716@linaro.org>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <2d8e94cc-71c9-c888-3816-728149539a77@us.ibm.com>
Date: Tue, 17 Sep 2019 16:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a561c80e-68b0-bd56-2718-6c3325d27716@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170199
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
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

On 9/17/19 3:45 PM, Richard Henderson wrote:
> On 9/16/19 1:02 PM, Paul A. Clarke wrote:
>> +#define FP_DRN2         (1ull << FPSCR_DRN2)
>> +#define FP_DRN1         (1ull << FPSCR_DRN1)
>> +#define FP_DRN0         (1ull << FPSCR_DRN0)
>> +#define FP_DRN          (FP_DRN2 | FP_DRN1 | FP_DRN0)
> 
> Why not just 7ull << FPSCR_DRN?
> Are the individual DRN bits separately useful?
> They don't appear to be...

I was just following what was done with RN:
#define FPSCR_RN1    1
#define FPSCR_RN0    0  /* Floating-point rounding control                   */
...
#define FP_RN1          (1ull << FPSCR_RN1)
#define FP_RN0          (1ull << FPSCR_RN0)
#define FP_RN           (FP_RN1 | FP_RN0)

>> -#define FP_MODE         FP_RN
>> +#define FP_MODE         (FP_DRN | FP_RN)
> 
> This, I think, isn't helpful.
> 
>> +static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
>> +{
>> +    TCGv_i64 t0 = tcg_temp_new_i64();
>> +    TCGv_i32 mask = tcg_const_i32(0x0001);
>> +
>> +    gen_reset_fpstatus();
>> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>> +    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_ENABLES);
>> +    set_fpr(rD(ctx->opcode), t0);
>> +
>> +    /* Mask FPSCR value to clear RN.  */
>> +    tcg_gen_andi_i64(t0, t0, ~FP_MODE);
> 
> Because here,
> 
>> +static void gen_mffscrn(DisasContext *ctx)
>> +{
>> +    TCGv_i64 t1;
>> +
>> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
>> +        return gen_mffs(ctx);
>> +    }
>> +
>> +    if (unlikely(!ctx->fpu_enabled)) {
>> +        gen_exception(ctx, POWERPC_EXCP_FPU);
>> +        return;
>> +    }
>> +
>> +    t1 = tcg_temp_new_i64();
>> +    get_fpr(t1, rB(ctx->opcode));
>> +    /* Mask FRB to get just RN.  */
>> +    tcg_gen_andi_i64(t1, t1, FP_MODE);
> 
> and here, we're only interested in RN, not DRN.

Oh, you're right, of course.

> Possibly FP_MODE should itself be removed.  It's used
> exactly once, in mffsl, which could just as easily
> reference FP_RN | FP_DRN.

I will do, and then send an updated version.

PC

