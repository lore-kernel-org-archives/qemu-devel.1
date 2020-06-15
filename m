Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF5C206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF5C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrBF-0004wt-Lx
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jkr9K-0003Ds-Ir
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:35:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jkr9I-0004Nw-4y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:35:50 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FFWEJf100123
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:35:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31p5eukp80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:35:46 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FFWpT1101913
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:35:26 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31p5euknuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 11:35:26 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FFQN95031910;
 Mon, 15 Jun 2020 15:35:05 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04wdc.us.ibm.com with ESMTP id 31mpe8bhcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 15:35:05 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FFZ5ed43385326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 15:35:05 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 034DD28065;
 Mon, 15 Jun 2020 15:35:05 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A9962805C;
 Mon, 15 Jun 2020 15:35:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2020 15:35:04 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] tpm_tis: Allow lowering of IRQ also when locality
 is not active
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-2-stefanb@linux.vnet.ibm.com>
 <CAMxuvazRHiZq+Qe36vpsTsKJqH7kdK6KGSF8SFiW35cj9TO2ew@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <93a70a60-219a-d7c6-cf28-fe7c68a52fbf@linux.ibm.com>
Date: Mon, 15 Jun 2020 11:35:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvazRHiZq+Qe36vpsTsKJqH7kdK6KGSF8SFiW35cj9TO2ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_06:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Marek Kedzierski <mkedzier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Bonzini, Paolo" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 11:06 AM, Marc-André Lureau wrote:
> Hi
>
> On Mon, Jun 15, 2020 at 6:23 PM Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> This patch fixes a bug that occurs when using interrupts. It
>> allows to lower the IRQ also when a locality is not active.
>>
> Can you quote the specification, or is it purely based on testing
> (Windows & Linux) or checking expected behaviour from Linux code?

There's no spec for this detail. It's purely based on testing.

also: Linux 5.x had interrupt support for a short while but this was 
removed due to some laptops receiving an interrupt storm following 
enablement: https://www.spinics.net/lists/linux-integrity/msg11870.html  
[ reason seems to be misconfiguration of some GPIO pin]

I tested it with this patch: https://lkml.org/lkml/2019/8/20/421

5.4 kernel: 
https://elixir.bootlin.com/linux/v5.4/source/drivers/char/tpm/tpm_tis_core.c#L983


    Stefan




>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   hw/tpm/tpm_tis_common.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
>> index 1af4bce139..0f42696f1f 100644
>> --- a/hw/tpm/tpm_tis_common.c
>> +++ b/hw/tpm/tpm_tis_common.c
>> @@ -601,10 +601,6 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>>           /* hard wired -- ignore */
>>           break;
>>       case TPM_TIS_REG_INT_STATUS:
>> -        if (s->active_locty != locty) {
>> -            break;
>> -        }
>> -
>>           /* clearing of interrupt flags */
>>           if (((val & TPM_TIS_INTERRUPTS_SUPPORTED)) &&
>>               (s->loc[locty].ints & TPM_TIS_INTERRUPTS_SUPPORTED)) {
>> --
>> 2.24.1
>>


