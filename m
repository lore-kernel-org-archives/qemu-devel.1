Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E29DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8A320724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8A320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnivT-0001Qu-8X
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jnitx-00088M-6O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:23:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jnitv-0003Yg-71
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:23:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NCa7Uc044333
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:23:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31udkcj93d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:23:45 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NDJAMx057320
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:23:45 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31udkcj92w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 09:23:44 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NDK5Vm016062;
 Tue, 23 Jun 2020 13:23:43 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma05wdc.us.ibm.com with ESMTP id 31sa38qeb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 13:23:43 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NDNewO28442928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 13:23:40 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1C226A054;
 Tue, 23 Jun 2020 13:23:42 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DABC6A047;
 Tue, 23 Jun 2020 13:23:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 13:23:41 +0000 (GMT)
Subject: Re: [PATCH v4 0/8] tpm: Enable usage of TPM TIS with interrupts
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200623090840-mutt-send-email-mst@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <5262d4c8-84df-e5a9-a383-c3f8f5cdbc81@linux.ibm.com>
Date: Tue, 23 Jun 2020 09:23:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200623090840-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-23_06:2020-06-23,
 2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=642
 cotscore=-2147483648 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 07:29:31
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
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, philmd@redhat.com, mkedzier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 9:09 AM, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 10:22:57AM -0400, Stefan Berger wrote:
>> This series of patches enables the usage of the TPM TIS with interrupts.
>> We use the unused IRQ 13, which is the only one accepted by Windows.
>>
>>      Stefan
>
> ACPI parts:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> How do we want this merged? TPM tree or mine?

Queued it here: https://github.com/stefanberger/qemu-tpm/commits/tpm-next

Was going to send a PR later this week with this part. Will add your Rb-s.


    Stefan


>
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
>> -- 
>> 2.24.1
>>
>>


