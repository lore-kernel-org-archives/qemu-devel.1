Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DF621D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLtTtZIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DF621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYrj-0002Vy-5t
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kQYqX-0001B4-1x
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:32:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kQYqT-0000e7-1I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:32:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098GTVkH167619;
 Thu, 8 Oct 2020 16:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qaxshl0F4Xw8+q3ShSQ6mvNhy698i5SHhFTe0fz9o8g=;
 b=JLtTtZIbM/N1DclWHrP6Gl+fOiPr0OqfvNhYgqIek5ogFiaEXivjrOj7RcOJ3vnbXaWt
 NELL6Zd3Y1slwAwnb9msd2EZ/cNFzK5yY7HWXP1bosmyB2FOLC0r12ce2QqqFTQDAE9a
 Lqv9S12pjgYr79JuFjmkAfVkZ2hNkPOMjm39vIrj8oJ7n8Qydy02dH7rz93bga9Pg/Qe
 YVMjv4K3yIxiy8RDwdMt5x4XQY1wJFHpKwuf8ntFlIVbICsr9BFRViGW7tNi6OgKCYB9
 q2R7O19VfdpMKhPC6QubySCm4JmLPlbWmcKAr725/UItXy27eq/G95ckI3ceXFVc2Re9 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 33xhxn8n4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 08 Oct 2020 16:32:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098GUwsJ152879;
 Thu, 8 Oct 2020 16:32:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 3410k1cssm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Oct 2020 16:32:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 098GWbjl003271;
 Thu, 8 Oct 2020 16:32:37 GMT
Received: from [10.39.240.184] (/10.39.240.184)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 08 Oct 2020 09:32:37 -0700
Subject: Re: [PATCH V1 18/32] osdep: import MADV_DOEXEC
To: Alex Williamson <alex.williamson@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-19-git-send-email-steven.sistare@oracle.com>
 <51c859fb-3340-e361-1945-0ec2a393a34d@oracle.com>
 <20200817144856.16c703da@x1.home>
 <1750879d-70f8-72db-0eb3-86caa75ad3a0@oracle.com>
 <20200817154403.39ee42c6@x1.home> <20200817204242.6b384ef7@x1.home>
 <64d3c11a-dda4-a9ed-0bdd-621a0b4f6f75@oracle.com>
 <20200824163013.69f154ad@x1.home>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <894a2344-025f-572e-1120-7a14b08e6f39@oracle.com>
Date: Thu, 8 Oct 2020 12:32:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200824163013.69f154ad@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080124
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 12:32:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/2020 6:30 PM, Alex Williamson wrote:
> On Wed, 19 Aug 2020 17:52:26 -0400
> Steven Sistare <steven.sistare@oracle.com> wrote:
>> On 8/17/2020 10:42 PM, Alex Williamson wrote:
>>> On Mon, 17 Aug 2020 15:44:03 -0600
>>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>>> On Mon, 17 Aug 2020 17:20:57 -0400
>>>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>>>> On 8/17/2020 4:48 PM, Alex Williamson wrote:    
>>>>>> On Mon, 17 Aug 2020 14:30:51 -0400
>>>>>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>>>>>       
>>>>>>> On 7/30/2020 11:14 AM, Steve Sistare wrote:      
>>>>>>>> Anonymous memory segments used by the guest are preserved across a re-exec
>>>>>>>> of qemu, mapped at the same VA, via a proposed madvise(MADV_DOEXEC) option
>>>>>>>> in the Linux kernel. For the madvise patches, see:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
>>>>>>>>
>>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>> ---
>>>>>>>>  include/qemu/osdep.h | 7 +++++++
>>>>>>>>  1 file changed, 7 insertions(+)        
>>>>>>>
>>>>>>> Hi Alex,
>>>>>>>   The MADV_DOEXEC functionality, which is a pre-requisite for the entire qemu 
>>>>>>> live update series, is getting a chilly reception on lkml.  We could instead 
>>>>>>> create guest memory using memfd_create and preserve the fd across exec.  However, 
>>>>>>> the subsequent mmap(fd) will return a different VA than was used previously, 
>>>>>>> which  is a problem for memory that was registered with vfio, as the original VA 
>>>>>>> is remembered in the kernel struct vfio_dma and used in various kernel functions, 
>>>>>>> such as vfio_iommu_replay.
>>>>>>>
>>>>>>> To fix, we could provide a VFIO_IOMMU_REMAP_DMA ioctl taking iova, size, and
>>>>>>> new_vaddr.  The implementation finds an exact match for (iova, size) and replaces 
>>>>>>> vaddr with new_vaddr.  Flags cannot be changed.
>>>>>>>
>>>>>>> memfd_create plus VFIO_IOMMU_REMAP_DMA would replace MADV_DOEXEC.
>>>>>>> vfio on any form of shared memory (shm, dax, etc) could also be preserved across
>>>>>>> exec with shmat/mmap plus VFIO_IOMMU_REMAP_DMA.
>>>>>>>
>>>>>>> What do you think      
>>>>>>
>>>>>> Your new REMAP ioctl would have parameters identical to the MAP_DMA
>>>>>> ioctl, so I think we should just use one of the flag bits on the
>>>>>> existing MAP_DMA ioctl for this variant.      
>>>>>
>>>>> Sounds good.
>>>>>     
>>>>>> Reading through the discussion on the kernel side there seems to be
>>>>>> some confusion around why vfio needs the vaddr beyond the user call to
>>>>>> MAP_DMA though.  Originally this was used to test for virtually
>>>>>> contiguous mappings for merging and splitting purposes.  This is
>>>>>> defunct in the v2 interface, however the vaddr is now used largely for
>>>>>> mdev devices.  If an mdev device is not backed by an IOMMU device and
>>>>>> does not share a container with an IOMMU device, then a user MAP_DMA
>>>>>> ioctl essentially just registers the translation within the vfio
>>>>>> container.  The mdev vendor driver can then later either request pages
>>>>>> to be pinned for device DMA or can perform copy_to/from_user() to
>>>>>> simulate DMA via the CPU.
>>>>>>
>>>>>> Therefore I don't see that there's a simple re-architecture of the vfio
>>>>>> IOMMU backend that could drop vaddr use.        
>>>>>
>>>>> Yes.  I did not explain on lkml as you do here (thanks), but I reached the 
>>>>> same conclusion.
>>>>>     
>>>>>> I'm a bit concerned this new
>>>>>> remap proposal also raises the question of how do we prevent userspace
>>>>>> remapping vaddrs racing with asynchronous kernel use of the previous
>>>>>> vaddrs.        
>>>>>
>>>>> Agreed.  After a quick glance at the code, holding iommu->lock during 
>>>>> remap might be sufficient, but it needs more study.    
>>>>
>>>> Unless you're suggesting an extended hold of the lock across the entire
>>>> re-exec of QEMU, that's only going to prevent a race between a remap
>>>> and a vendor driver pin or access, the time between the previous vaddr
>>>> becoming invalid and the remap is unprotected.  
>>
>> OK.  What if we exclude mediated devices?  Its appears they are the only
>> ones where the kernel may async'ly use the vaddr, via call chains ending in 
>> vfio_iommu_type1_pin_pages or vfio_iommu_type1_dma_rw_chunk.
>>
>> The other functions that use dma->vaddr are
>>     vfio_dma_do_map 
>>     vfio_pin_map_dma 
>>     vfio_iommu_replay 
>>     vfio_pin_pages_remote
>> and they are all initiated via userland ioctl (if I have traced all the code 
>> paths correctly).  Thus iommu->lock would protect them.
>>
>> We would block live update in qemu if the config includes a mediated device.
>>
>> VFIO_IOMMU_REMAP_DMA would return EINVAL if the container has a mediated device.
> 
> That's not a solution I'd really be in favor of.  We're eliminating an
> entire class of devices because they _might_ make use of these
> interfaces, but anyone can add a vfio bus driver, even exposing the
> same device API, and maybe make use of some of these interfaces in that
> driver.  Maybe we'd even have reason to do it in vfio-pci if we had
> reason to virtualize some aspect of a device.  I think we're setting
> ourselves up for a very complicated support scenario if we just
> arbitrarily decide to deny drivers using certain interfaces.
> 
>>>>>> Are we expecting guest drivers/agents to quiesce the device,
>>>>>> or maybe relying on clearing bus-master, for PCI devices, to halt DMA?      
>>>>>
>>>>> No.  We want to support any guest, and the guest is not aware that qemu
>>>>> live update is occurring.
>>>>>     
>>>>>> The vfio migration interface we've developed does have a mechanism to
>>>>>> stop a device, would we need to use this here?  If we do have a
>>>>>> mechanism to quiesce the device, is the only reason we're not unmapping
>>>>>> everything and remapping it into the new address space the latency in
>>>>>> performing that operation?  Thanks,      
>>>>>
>>>>> Same answer - we don't require that the guest has vfio migration support.    
>>>>
>>>> QEMU toggling the runstate of the device via the vfio migration
>>>> interface could be done transparently to the guest, but if your
>>>> intention is to support any device (where none currently support the
>>>> migration interface) perhaps it's a moot point.    
>>
>> That sounds useful when devices support.  Can you give me some function names
>> or references so I can study this qemu-based "vfio migration interface".
> 
> The uAPI is documented in commit a8a24f3f6e38.  We're still waiting on
> the QEMU support or implementation in an mdev vendor driver.
> Essentially migration exposes a new region of the device which would be
> implemented by the vendor driver.  A register within that region
> manipulates the device state, so a device could be stopped by clearing
> the 'run' bit in that register.
> 
>>>> It seems like this
>>>> scheme only works with IOMMU backed devices where the device can
>>>> continue to operate against pinned pages, anything that might need to
>>>> dynamically pin pages against the process vaddr as it's running async
>>>> to the QEMU re-exec needs to be blocked or stopped.  Thanks,  
>>
>> Yes, true of this remap proposal.
>>
>> I wanted to unconditionally support all devices, which is why I think that
>>
>> MADV_DOEXEC is a nifty solution.  If you agree, please add your voice to the
>> lkml discussion.

Hi Alex, here is a modified proposal to remap vaddr in the face of async requests
from mediated device drivers.

Define a new flag VFIO_DMA_MAP_FLAG_REMAP for use with VFIO_IOMMU_UNMAP_DMA and
VFIO_IOMMU_MAP_DMA.

VFIO_IOMMU_UNMAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
  Discard vaddr on the existing dma region defined by (iova, size), but keep the
  struct vfio_dma.  Subsequent translation requests are blocked.
  The implementation sets a flag in struct vfio_dma.  vfio_pin_pages() and
  vfio_dma_rw() acquire iommu->lock, check the flag, and retry.
  Called before exec.

VFIO_IOMMU_MAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
  Remap the region (iova, size) to vaddr, and resume translation requests.
  Called after exec.

Unfortunately, remap as defined above has an undesirable side effect.  The mdev
driver may use kernel worker threads which serve requests from multiple clients
(eg i915/gvt workload_thread).  A process that fails to call MAP_DMA with REMAP,
or is tardy doing so, will delay other processes who are stuck waiting in
vfio_pin_pages or vfio_dma_rw.  This is unacceptable, and I mention this scheme in
case I am misinterpreting the code (maybe they do not share a single struct vfio_iommu
instance?), or in case you see a way to salvage it.

Here is a more robust implementation.  It only works for dma regions backed by
a file, such as memfd or shm.

VFIO_IOMMU_UNMAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
  Find the file and offset for iova, and save the struct file pointer in
  struct vfio_dma.  In vfio_pin_pages and vfio_dma_rw and their descendants,
  if file* is set, then call pagecache_get_page() to get the pfn, instead of
  get_user_pages.

VFIO_IOMMU_MAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
  Remap the region (iova, size) to vaddr and drop the file reference.

This begs the question of whether we can always use pagecache_get_page, and
eliminate the dependency on vaddr.  The translation performance could be
different, though.

I have not implemented this yet.  Any thoughts before I do?

- Steve

