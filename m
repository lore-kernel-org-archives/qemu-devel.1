Received: from eggs.gnu.org ([2001:4830:134:3::10]:39601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGN5q-0002hq-TR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGN5n-0000R2-Pa
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:12:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dGN5n-0000Qy-G2
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:12:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51A8uPM116130
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 06:12:34 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atdc0bhub-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 06:12:33 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 11:12:31 +0100
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-7-pasic@linux.vnet.ibm.com>
	<3695b34a-9181-4006-0e37-31749dc7e6d6@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 12:12:28 +0200
MIME-Version: 1.0
In-Reply-To: <3695b34a-9181-4006-0e37-31749dc7e6d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <360d58b2-de79-3186-cb6e-3a2c48f6df45@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>



On 06/01/2017 10:40 AM, Thomas Huth wrote:
> On 29.05.2017 15:55, Halil Pasic wrote:
>> Turn on migration for the channel subsystem for the next machine.  For
>> legacy machines we still have to do things the old way.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c             | 5 +++++
>>  hw/s390x/s390-virtio-ccw.c | 9 ++++-----
>>  hw/s390x/virtio-ccw.c      | 1 -
>>  include/hw/s390x/css.h     | 4 ++++
>>  4 files changed, 13 insertions(+), 6 deletions(-)
> [...]
>>  static void ccw_machine_2_10_class_options(MachineClass *mc)
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index a75eedeffb..4a0271b0be 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -1360,7 +1360,6 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
>>  
>>      sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
>>  
>> -
>>      css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>>                            d->hotplugged, 1);
>>  }
> 
> Unrelated white-space change?
> 
>  Thomas
> 


Indeed :-( Will remove for the next re-spin.

Thanks a lot!

Halil
