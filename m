Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B8A20715
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hqkuHbZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B8A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyW3-0003VB-9f
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kZyDL-0000fE-60; Tue, 03 Nov 2020 10:27:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kZyDI-0007K9-6d; Tue, 03 Nov 2020 10:27:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A3F2sQ2147410; Tue, 3 Nov 2020 10:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u8oXUg7oV+bsfYrYXEEcCt/+21XEDa4cLqTgbUtA1Rs=;
 b=hqkuHbZC5Al8GmujaGI3rSZ8dj2+yiR6Pyu9UnlJDMxJH+nQoZm7MCxOxFWRas36jsXK
 Bpq0cYcrMZf9HuiYRQysaJqEsEnLZL2F5e4fhT1ncimQ1bQE5RbCJ2i1x+caADloN9oR
 DLxjszNJWOHH8bT5FL5FJ5SxWLpKJWnkBEjSL/eUAhFnFV07zCmT5GHO8oT0TMMZ7rHt
 LvGierduLl6C2djzjE7KHlVRn5pu1jHYH1wSoH0sBR72UOXzGR8hweIC7+ozK0ptQ7gL
 E0uILbWiHFc/sBgxLIt3Tjs9QqsD/m5+xD1bryAWv9K37xkK8tMHmbwdT1gw6h2IJqWb tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34k999hux9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 10:27:04 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3F2uIL000991;
 Tue, 3 Nov 2020 10:27:04 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34k999hut8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 10:27:02 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3FJVub019054;
 Tue, 3 Nov 2020 15:26:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 34j6j40y7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 15:26:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A3FQv6F8979008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2020 15:26:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04B1952054;
 Tue,  3 Nov 2020 15:26:57 +0000 (GMT)
Received: from [9.160.83.122] (unknown [9.160.83.122])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CEB1052050;
 Tue,  3 Nov 2020 15:26:53 +0000 (GMT)
Subject: Re: [PATCH-for-5.2 0/4] misc: Trivial format string fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201103112558.2554390-1-philmd@redhat.com>
 <64132d34-dbd9-03ee-6f11-a6908df025bf@linux.vnet.ibm.com>
 <ddd49883-7c97-966b-1f62-52f39f4952ad@linux.vnet.ibm.com>
 <e2ae5627-a55d-909b-8591-f7c0400cd57c@redhat.com>
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
Message-ID: <adbc0493-9ecb-97ad-a342-3e9bab6b07c0@linux.vnet.ibm.com>
Date: Tue, 3 Nov 2020 17:26:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e2ae5627-a55d-909b-8591-f7c0400cd57c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-03_08:2020-11-03,
 2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011030102
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 05:07:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 03/11/2020 16:28, Philippe Mathieu-Daudé wrote:
> On 11/3/20 3:03 PM, Dov Murik wrote:
>>
>> On 03/11/2020 15:58, Dov Murik wrote:
>>> On 03/11/2020 13:25, Philippe Mathieu-Daudé wrote:
>>>> IIUC qemu-trivial@ doesn't queue patches during freeze,
>>>>
>>>> so it might be easier if patches are queued by respective
>>>>
>>>> subsystem maintainers.
>>>>
>>>>
>>>>
>>>> Philippe Mathieu-Daudé (4):
>>>>
>>>>     hw/display/cirrus_vga: Remove debugging code commented out
>>>>
>>>>     hw/display/cirrus_vga: Fix hexadecimal format string specifier
>>>>
>>>>     hw/ppc/spapr_tpm_proxy: Fix hexadecimal format string specifier
>>>>
>>>>     migration/ram: Fix hexadecimal format string specifier
>>>>
>>>>
>>>>
>>>>    hw/display/cirrus_vga.c | 20 +-------------------
>>>>
>>>>    migration/ram.c         |  2 +-
>>>>
>>>>    hw/ppc/trace-events     |  2 +-
>>>>
>>>>    3 files changed, 3 insertions(+), 21 deletions(-)
>>>>
>>>>
>>>>
>>>
>>>
>>> There's at least one more easy fix:
>>>
>>> hw/misc/trace-events:106:mos6522_get_next_irq_time(uint16_t latch,
>>> int64_t d, int64_t delta) "latch=%d counter=0x%"PRId64 "
>>> delta_next=0x%"PRId64
> 
> Indeed.
> 
>>>
>>> but I have no idea how to test this.
>>>
>>> -Dov
>>>
>>
>> ... and one more in hw/usb/u2f-passthru.c:348 :
>>
>>          error_report("%s: Bad written size (req 0x%zu, val 0x%zd)",
>>                       TYPE_U2F_PASSTHRU, sizeof(host_packet), written);
> 
> 'written' is signed, so this format looks correct...
> 

If we keep the %zu and %zd format specifiers, then I suggest removing 
the "0x" literal prefixes.


>>
>> Again, I have no idea how to test/trigger these areas in the code.
>>
>> -Dov
>>
> 
> 

