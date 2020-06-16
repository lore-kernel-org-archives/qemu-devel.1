Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FCB206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FCB206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCDr-0003hd-CM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jlCD7-00034S-TD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:05:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jlCD5-0004Wd-Sg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:05:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05GE3M9c180348
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:05:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31pbmhxevw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:05:04 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GE42qY184275
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:05:03 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31pbmhxev9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 10:05:03 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GDxHK4022055;
 Tue, 16 Jun 2020 14:05:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 31pf70v7vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 14:05:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05GE526s16057332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2020 14:05:02 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BC50124052;
 Tue, 16 Jun 2020 14:05:02 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED1F8124055;
 Tue, 16 Jun 2020 14:05:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2020 14:05:01 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] acpi: Enable TPM IRQ
To: Auger Eric <eric.auger@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-5-stefanb@linux.vnet.ibm.com>
 <CAMxuvaxm+5Nuv2_1UTXY+-kK1CYMkxqU2pfLOxMgeDEqOjhgZA@mail.gmail.com>
 <8e11e2d6-5e02-89c0-759f-d74189421eec@linux.ibm.com>
 <ab78ab4a-a3e3-64bb-ff81-413c17c21f24@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <dd1175fb-a3af-8c33-c7d5-02dd1e29e2dd@linux.ibm.com>
Date: Tue, 16 Jun 2020 10:05:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ab78ab4a-a3e3-64bb-ff81-413c17c21f24@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-16_04:2020-06-16,
 2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 10:05:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 9:01 AM, Auger Eric wrote:
> Hi Stefan,
>
> On 6/15/20 7:11 PM, Stefan Berger wrote:
>> On 6/15/20 11:13 AM, Marc-André Lureau wrote:
>>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>>> index 1a2a57a21f..063a9eb42a 100644
>>>> --- a/include/hw/acpi/tpm.h
>>>> +++ b/include/hw/acpi/tpm.h
>>>> @@ -24,7 +24,7 @@
>>>>    #define TPM_TIS_ADDR_BASE           0xFED40000
>>>>    #define TPM_TIS_ADDR_SIZE           0x5000
>>>>
>>>> -#define TPM_TIS_IRQ                 5
>>>> +#define TPM_TIS_IRQ                 13
>>
>> Eric,
>>
>>   does this change have any negative side effects on ARM? If you prefer,
>> we can split this part here up into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS
>> IRQ and leave the latter at '5' because we know that this is working.
> The IRQ is not advertised in dt nor ACPI on ARM. However it is
> advertised in the capability reg and in the vector. reg So I think this
> should be fixed? I guess on ARM we will pick up a completely different
> IRQ num, allocated from the platform bus slot.


The specification

https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p04_r0p37_pub-1.pdf

declares several fields in the Interface Capability Register (table 23, 
pdf page 89) to be mandatory and they must be set to '1'. So I would not 
want to touch those. We can set the interrupt vector register to '0' in 
case interrupts are not supported. Following the spec 0 means that no 
interrupts are supported. I will now split TPM_TIS_IRQ into 
TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS_IRQ and will in the end set 
TPM_TIS_SYSBUS_IRQ to 'disabled', indicating that IRQs are not 
supported, though they should work even though on ARM there may not be a 
driver to test this with. Does this sound ok?


    Stefan


>
> Thanks
>
> Eric
>>     Stefan
>>
>>
>>>>    #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>>>>    #define TPM_TIS_LOCALITY_SHIFT      12
>>>> -- 
>>>> 2.24.1
>>>>


