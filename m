Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F18D206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F18D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joaVo-0003J7-KF
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 18:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1joaVF-0002qs-C2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:37:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1joaVD-0007zW-Is
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:37:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PMX0Fu075589
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 18:37:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vx91c0hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 18:37:49 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PMXHP3077165
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 18:37:49 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vx91c0ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 18:37:49 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PMTgLF021031;
 Thu, 25 Jun 2020 22:37:48 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 31uurqbcg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 22:37:48 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PMbl9U53805528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 22:37:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A7CE112076;
 Thu, 25 Jun 2020 22:37:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 722B0112074;
 Thu, 25 Jun 2020 22:37:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 22:37:47 +0000 (GMT)
Subject: Re: [PATCH v4 0/8] tpm: Enable usage of TPM TIS with interrupts
To: Auger Eric <eric.auger@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <c6824bc7-209b-f264-a5b0-2dbc6119773c@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a61ab9dd-e357-8c1b-0098-1eb33e274be0@linux.ibm.com>
Date: Thu, 25 Jun 2020 18:37:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c6824bc7-209b-f264-a5b0-2dbc6119773c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_19:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=930 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250133
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 17:13:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, philmd@redhat.com, mkedzier@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 3:27 AM, Auger Eric wrote:

I have to defer this series since there are some things that don't work 
on the Linux level with IRQ 13 (edge) while they do work fine on the old 
IRQ 5 (festeoi). I know which changes to make to Linux so that it works 
on IRQ 13 as well, but I am not sure whether those changes are 
acceptable. So now we could upstream this one here:

[PATCH v4 4/8] tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and 
TPM_TIS_SYSBUS_IRQ


    Stefan

> Hi Stefan,
>
> On 6/17/20 4:22 PM, Stefan Berger wrote:
>> This series of patches enables the usage of the TPM TIS with interrupts.
>> We use the unused IRQ 13, which is the only one accepted by Windows.
>>
>>      Stefan
>>
>> v3->v4:
>>   - Changed TPM_IRQ_DISABLED from -1 to ~0
>>
>> v2->v3:
>>   - Extended series to disable IRQ for TIS on sysbus
>>
>> v1->v2:
>>   - Added updated DSDT
>>
>> Stefan Berger (8):
>>    tpm_tis: Allow lowering of IRQ also when locality is not active
>>    tpm: Extend TPMIfClass with get_irqnum() function
>>    tests: Temporarily ignore DSDT table differences
>>    tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS_IRQ
>>    acpi: Enable TPM IRQ
>>    tests: Add updated DSDT
>>    tpm: Guard irq related ops in case interrupts are disabled
>>    tpm: Disable interrupt support for TIS on sysbus
>>
>>   hw/i386/acpi-build.c         |  11 +++++------
>>   hw/tpm/tpm_tis_common.c      |  12 +++++++++---
>>   hw/tpm/tpm_tis_isa.c         |  17 ++++++++++++++---
>>   hw/tpm/tpm_tis_sysbus.c      |  12 +++++++++++-
>>   include/hw/acpi/tpm.h        |   3 ++-
>>   include/sysemu/tpm.h         |  12 ++++++++++++
>>   tests/data/acpi/q35/DSDT.tis | Bin 8357 -> 8360 bytes
>>   7 files changed, 53 insertions(+), 14 deletions(-)
>>
> I checked this series does not bring any regression on ARM TPM-TIS
> device. So if useful/relevant, feel free to add my T-b from the ARM pov.
>
> Tested-by: Eric Auger <eric.auger@redhat.com>
>
> Thanks
>
> Eric
>


