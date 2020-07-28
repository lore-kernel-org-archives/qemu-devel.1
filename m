Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA05C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A272070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A272070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QNr-0000F9-Ts
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1k0QMp-0007ar-BG; Tue, 28 Jul 2020 10:14:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1k0QMn-0007Cu-AE; Tue, 28 Jul 2020 10:14:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06SE44dB149426; Tue, 28 Jul 2020 10:14:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32jkw53t3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 10:14:03 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SE4KkN150244;
 Tue, 28 Jul 2020 10:14:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32jkw53t2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 10:14:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SE5pJ7018110;
 Tue, 28 Jul 2020 14:14:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 32gcpx3vjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 14:14:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06SEDwrN32702950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 14:13:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BA07AE051;
 Tue, 28 Jul 2020 14:13:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6335EAE04D;
 Tue, 28 Jul 2020 14:13:57 +0000 (GMT)
Received: from oc5500677777.ibm.com (unknown [9.145.68.234])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2020 14:13:57 +0000 (GMT)
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
To: Alex Williamson <alex.williamson@redhat.com>
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
 <20200723102916.7cf15b43@w520.home>
 <0481c77e-f71f-886b-9b0a-41529eb139ee@linux.ibm.com>
 <20200727104754.4337818c@x1.home>
 <f152965e-ed8c-a34b-e13d-7859c06afd85@linux.ibm.com>
 <20200728065215.21a7f5af@x1.home>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <2f3cd133-e0bc-8923-3016-db2414acef90@linux.ibm.com>
Date: Tue, 28 Jul 2020 16:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728065215.21a7f5af@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-28_11:2020-07-28,
 2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007280103
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schnelle@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:14:03
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pierre Morel <pmorel@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/28/20 2:52 PM, Alex Williamson wrote:
> On Tue, 28 Jul 2020 11:33:55 +0200
> Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> 
>> On 7/27/20 6:47 PM, Alex Williamson wrote:
>>> On Mon, 27 Jul 2020 17:40:39 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>   
>>>> On 2020-07-23 18:29, Alex Williamson wrote:  
>>>>> On Thu, 23 Jul 2020 11:13:55 -0400
>>>>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>>>>     
>>>>>> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
>>>>>> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
>>>>>> fails spectacularly, with errors in qemu like:  
>> ... snip ...
>>>>
>>>> Alex, Matt,
>>>>
>>>> in s390 we have the possibility to assign a virtual function to a 
>>>> logical partition as function 0.
>>>> In this case it can not be treated as a virtual function but must be 
>>>> treated as a physical function.
>>>> This is currently working very well.
>>>> However, these functions do not set PCI_COMMAND_MEMORY as we need.  
>>>
>>> Where is the vendor and device ID virtualization done for these
>>> devices, we can't have a PF with IDs 0000:0000.  
>> Pierre doesn't mean the Device/Vendor IDs he means it has devfn == 0
>> so it is the mandatory function zero on it's PCI bus, where until recently
>> we always had only one function per bus but with the recent multi-function
>> support it can act more like on other platforms with several PCI functions
>> sharing the same Bus e.g. a PF and the VFs created through sriov_numvfs.
>> That's why I'm saying that having devfn == 0 should not be very special for a VF
>> passed to a VM and I really don't see where it would not act like a VF passed
>> from any other Hypervisor.
> 
> My question is relative to other registers on VFs that are not
> implemented in hardware, not the device address.  In addition to the
> memory bit of the command register, SR-IOV VFs do not implement the
> vendor and device IDs, these are to be virtualized from the values
> provided in the PF SR-IOV capability.  It wouldn't make much sense to
> expose a device with no PCI vendor or device ID, so I assume the z/VM
> hypervisor is virtualizing these, but not the memory bit.
Ahh, yes I see. On Z these are actually already virtualized at the LPAR
level as part of the firmware based scanning I mentioned that is the
reason for pdev->no_vf_scan. This is true even for VFs created
through sriov_numvfs in the host which is why I did not realize these
don't come from hardware, even though looking at drivers/pci/iov.c it's
pretty obvious and I did touch that code before. Sorry for the confusion.
>  
>> The only really tricky part in my opinion is where during the "probing"
>> we do set is_virtfn so it happens both for VFs passed-through from z/VM
>> or LPAR and VFs created through sriov_numvfs which unlike on other platforms
>> are also scanned by Firmware (pdev->no_vf_scan disables the Linux side scanning).
>> With the fix I'm currently testing I had to do this in pcibios_enable_device()
>> because I also create sysfs links between VFs and their parent PFs and those
>> need the sysfs entries to be already created, which makes the more apropriately
>> sound pcibios_bus_add_device() too early.
> 
> 
> I don't think it would be wise to set is_virtfn without a physfn being
> present in the OS view.  I believe pci_dev.is_virtfn implies
> pci_dev.physfn points to the PF device.  Thanks> 
> Alex
Thank you a lot for that hint, you're absolutely right, while the
drivers do work with is_virtfn == 1 && physffn == NULL
vfio-pci gets very confused. And sorry Pierre for doubting
your is_virtfn_detached idea, this thing really is confusing.
> 
>>>> Shouldn't we fix this inside the kernel, to keep older QMEU working?
>>>>
>>>> Then would it be OK to add a new bit/boolean inside the 
>>>> pci_dev/vfio_pci_device like, is_detached_vfn, that we could set during 
>>>> enumeration and test inside __vfio_pci_memory_enabled() to return true?  
>>>
>>> Probably each instance of is_virtfn in vfio-pci should be looked at to
>>> see if it applies to s390.  If we're going to recognize this as a VF,
>>> I'd rather we complete the emulation that the lower level hypervisor
>>> has missed.  If we can enable all the is_virtfn code on s390, then we
>>> should probably cache is_virtfn on the vfio_pci_device object and allow
>>> s390 a place to set it once at probe or enable time.
>>>   
>>>> In the enumeration we have the possibility to know if the function is a 
>>>> HW/Firmware virtual function on devfn 0 or if it is created by SRIOV.
>>>>
>>>> It seems an easy fix without side effects.
>>>>
>>>> What do you think?  
>>>
>>> It sure seems preferable to recognize that it is a VF in the kernel
>>> than to require userspace to have arch specific hacks.  Thanks,
>>>
>>> Alex
>>>   
>>
> 

