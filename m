Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F55C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECC42171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECC42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iALNe-0001WU-3w
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1iALMP-0000JE-Mw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1iALMO-0001X7-MR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:50:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3792
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1iALMK-0001V3-OU; Tue, 17 Sep 2019 17:50:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HLSiZ0050530; Tue, 17 Sep 2019 17:50:00 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v34ta6nfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 17:49:59 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8HLnwai017888;
 Tue, 17 Sep 2019 21:49:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 2v37jw826x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 21:49:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8HLnvnQ51052960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 21:49:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F9578064;
 Tue, 17 Sep 2019 21:49:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45EF478060;
 Tue, 17 Sep 2019 21:49:57 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.70.45])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Sep 2019 21:49:57 +0000 (GMT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1568653344-16881-1-git-send-email-pc@us.ibm.com>
 <77049b6d-92cd-014f-6151-fb8dc4b032c9@linaro.org>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <d38484cb-8a78-c58c-6ab4-921c9450a346@us.ibm.com>
Date: Tue, 17 Sep 2019 16:49:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <77049b6d-92cd-014f-6151-fb8dc4b032c9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170199
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ppc: Add support for 'mffsce'
 instruction
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

On 9/17/19 3:46 PM, Richard Henderson wrote:
> On 9/16/19 1:02 PM, Paul A. Clarke wrote:
>> From: "Paul A. Clarke" <pc@us.ibm.com>
>>
>> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
>> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
>> This patch adds support for 'mffsce' instruction.
>>
>> 'mffsce' is identical to 'mffs', except that it also clears the exception
>> enable bits in the FPSCR.
>>
>> On CPUs without support for 'mffsce' (below ISA 3.0), the
>> instruction will execute identically to 'mffs'.
>>
>> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>> ---
>> v2: no changes.
>>
>>  target/ppc/translate/fp-impl.inc.c | 30 ++++++++++++++++++++++++++++++
>>  target/ppc/translate/fp-ops.inc.c  |  2 ++
>>  2 files changed, 32 insertions(+)
> 
> Didn't I already give a
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> for this?

You did.  Sorry for the confusion.  I wasn't sure whether to resend or not, given the dependence on the other patch and David said he would be waiting for the respin.

PC

