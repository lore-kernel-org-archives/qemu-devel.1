Received: from eggs.gnu.org ([2001:4830:134:3::10]:52368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eLuug-0004jH-7Q
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eLuuc-00031H-8m
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:52:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1eLuuc-0002zm-3B
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:52:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4HoFgM104206
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 12:52:10 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2en946fncv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 12:52:10 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 12:52:09 -0500
References: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
	<20171201151538.6844-2-farman@linux.vnet.ibm.com>
	<77147a49-b8b3-d94d-80ab-5ab279fbc8b9@redhat.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 12:52:05 -0500
MIME-Version: 1.0
In-Reply-To: <77147a49-b8b3-d94d-80ab-5ab279fbc8b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4f6e5359-2aee-64c3-332f-b60bb1c9af1f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] vhost-scsi: add missing virtqueue_size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-devel@nongnu.org, Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>, Peter Maydell <peter.maydell@linaro.org>



On 12/01/2017 10:16 AM, Paolo Bonzini wrote:
> On 01/12/2017 16:15, Eric Farman wrote:
>> Commit 5c0919d02066 ("virtio-scsi: Add virtqueue_size parameter allowing
>> virtqueue size to be set.") introduced a new parameter to virtio-scsi.
>> Later, commit 920036106044 ("vhost-user-scsi: add missing virtqueue_size
>> param") added that parameter to the new vhost-user-scsi interface but
>> neglected the existing vhost-scsi interface it was built on.
>>
>> Apply the same change to vhost-scsi, so that we can boot a guest with
>> a device defined.  This also avoids crashing a guest when hotplugging
>> a vhost-scsi device.
>>
>> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
>> ---
>>   hw/scsi/vhost-scsi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index cd4ab05233..9c1bea8ff3 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -233,6 +233,8 @@ static Property vhost_scsi_properties[] = {
>>       DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
>>       DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
>>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
>> +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
>> +                       128),
>>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>>                          0xFFFF),
>>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
>>
> 
> Queued, thanks.
> 
> Paolo
> 

Wow, super quick, thank you!  Seeing conversations today, is this queued 
for -rc4, or 2.12 and backport to qemu-stable?

  - Eric
