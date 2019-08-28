Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF70C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4152022DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4152022DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31ZU-0007wc-C6
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1i31R5-0007KV-Vr
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1i31R4-0001jL-Oe
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:08:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61350
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1i31Qz-0001gC-LI; Wed, 28 Aug 2019 13:08:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7SH7Iw5116835; Wed, 28 Aug 2019 13:08:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2unvck3gba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Aug 2019 13:08:20 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SH8Jht120096;
 Wed, 28 Aug 2019 13:08:19 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2unvck3gaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Aug 2019 13:08:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SH5Rm1032510;
 Wed, 28 Aug 2019 17:08:19 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma05wdc.us.ibm.com with ESMTP id 2ujvv77460-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Aug 2019 17:08:19 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7SH8Ieu59310378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 17:08:18 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E87FBE054;
 Wed, 28 Aug 2019 17:08:18 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 171D1BE04F;
 Wed, 28 Aug 2019 17:08:17 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.85.139.120])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 28 Aug 2019 17:08:16 +0000 (GMT)
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
 <20190702060857.3926-42-david@gibson.dropbear.id.au>
 <5478fc0a-19ad-5d70-3253-e66037afc2ac@redhat.com>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <d58ec703-086b-5bc9-2e42-2a63082831fe@us.ibm.com>
Date: Wed, 28 Aug 2019 12:08:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5478fc0a-19ad-5d70-3253-e66037afc2ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-28_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280168
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 41/49] target/ppc: improve
 VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/28/19 10:50 AM, Laurent Vivier wrote:
> On 02/07/2019 08:08, David Gibson wrote:
>> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Introduce a new GEN_VSX_HELPER_VSX_MADD macro for the generator function which
>> enables the source and destination registers to be decoded at translation time.
>>
>> This enables the determination of a or m form to be made at translation time so
>> that a single helper function can now be used for both variants.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20190616123751.781-16-mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  target/ppc/fpu_helper.c             | 68 ++++++++----------------
>>  target/ppc/helper.h                 | 48 ++++++-----------
>>  target/ppc/translate/vsx-impl.inc.c | 81 +++++++++++++++++------------
>>  target/ppc/translate/vsx-ops.inc.c  | 70 +++++++++++++------------
>>  4 files changed, 122 insertions(+), 145 deletions(-)
>>
> 
> This patch breaks something with python/libm and RHEL8.
> 
> # dnf update 
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault (core dumped)
> 
> # gdb
> ...
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x0000004000d09acc in __exp1 () from /lib64/libm.so.6
> Missing separate debuginfos, use: yum debuginfo-install platform-python-3.6.8-14.el8.ppc64le
> (gdb) bt
> #0  0x0000004000d09acc in __exp1 () from /lib64/libm.so.6
> #1  0x0000004000d0dcb4 in __pow_finite () from /lib64/libm.so.6
> #2  0x0000004000cd3c8c in powf64 () from /lib64/libm.so.6
> #3  0x00000040009d5c5c in float_pow () from /lib64/libpython3.6m.so.1.0
> 
> If I revert it, it works fine.
> 
> My first guess is the opcode decoding is not correct to replace the afrm 
> field.
> 
> I'm not sure to understand correctly the code, but this seems to fix the 
> problem:
> 
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1308,7 +1308,7 @@ static void gen_##name(DisasContext *ctx)                                     \
>      }                                                                         \
>      xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
>      xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
> -    if (ctx->opcode & PPC_BIT(25)) {                                          \
> +    if (ctx->opcode & PPC_BIT32(25)) {                                        \
>          /*                                                                    \
>           * AxT + B                                                            \
>           */                                                                   \


This same patch was just posted a week ago (by me).  https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg04344.html

David Gibson "Applied to ppc-for-4.2" the same day.  Can you try that?

PC

