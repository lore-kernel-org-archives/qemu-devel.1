Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ABCC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FBE20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FBE20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6Wh-00027H-83
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1is6Uv-0008UF-Ua
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1is6Us-0002q2-9X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:51:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41810
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1is6Us-0002nx-3q; Thu, 16 Jan 2020 09:51:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00GEiugt138782; Thu, 16 Jan 2020 09:51:42 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xjmynjjqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 09:51:42 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00GEj1g4139439;
 Thu, 16 Jan 2020 09:51:41 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xjmynjjqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 09:51:41 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00GEpFbP017025;
 Thu, 16 Jan 2020 14:51:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 2xhmfa05fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 14:51:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00GEpdKr51446184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2020 14:51:39 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73E937805E;
 Thu, 16 Jan 2020 14:51:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7281B7805F;
 Thu, 16 Jan 2020 14:51:38 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.80.227.51])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2020 14:51:38 +0000 (GMT)
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption suppression
 again
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200116122026.5804-1-thuth@redhat.com>
 <20200116135038.2c8cf3c6.cohuck@redhat.com>
 <20b2df78-8d5c-3508-cc80-06cf127ca635@redhat.com>
 <1e181d83-98ec-a8dd-2b43-0371b8eb65af@de.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <bc3edeb0-8c32-f750-7ccb-ae51eeadd5b3@linux.ibm.com>
Date: Thu, 16 Jan 2020 09:51:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1e181d83-98ec-a8dd-2b43-0371b8eb65af@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-16_04:2020-01-16,
 2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 8:22 AM, Christian Borntraeger wrote:
> 
> 
> On 16.01.20 13:55, Thomas Huth wrote:
>> On 16/01/2020 13.50, Cornelia Huck wrote:
>>> On Thu, 16 Jan 2020 13:20:26 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> The AIS feature has been disabled late in the v2.10 development
>>>> cycle since there were some issues with migration (see commit
>>>> 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
>>>> facility"). We originally wanted to enable it again for newer
>>>> machine types, but apparently we forgot to do this so far. Let's
>>>> do it for the new s390-ccw-virtio-5.0 machine now.
>>>>
>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   hw/s390x/s390-virtio-ccw.c         |  4 ++++
>>>>   include/hw/s390x/s390-virtio-ccw.h |  4 ++++
>>>>   target/s390x/kvm.c                 | 11 ++++++++---
>>>>   3 files changed, 16 insertions(+), 3 deletions(-)
>>>>
>>>
>>>> @@ -365,10 +367,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>>       /*
>>>>        * The migration interface for ais was introduced with kernel 4.13
>>>>        * but the capability itself had been active since 4.12. As migration
>>>> -     * support is considered necessary let's disable ais in the 2.10
>>>> -     * machine.
>>>> +     * support is considered necessary we only enable this for newer
>>>
>>> s/necessary we only enable this/necessary, we only try to enable this/
>>>
>>>> +     * machine types and if KVM_CAP_S390_AIS_MIGRATION is available.
>>>
>>> maybe s/and if/if/
>>
>> Sure ... could you fix it up when picking up the patch (in case I don't
>> have to respin), or do you want me to send a v2?
>>
>>>>        */
>>>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>>>> +    if (smc->kvm_ais_allowed &&
>>>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>>>> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>>>> +    }
>>>>   
>>>>       kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>>>>       return 0;
>>>
>>> Looks good.
>>>
>>> Remind me again: ais only made a difference for pci devices, right? Is
>>> it enough to give this a quick whirl with virtio-pci devices?
>>
>> I don't remember the details, Christian, could you please answer this
>> question?
> 
> Yes, IIRC AIS was there for PCI, but not for Crypto or virtio.

This matches my understanding as well.

> The patch looks sane, but it would be good if someone could try
> the AIS stuff.
> 
> Matt, can you have a look?

Sure.  But my PCI environment is currently down for a maintenance 
window, will try again later today.


