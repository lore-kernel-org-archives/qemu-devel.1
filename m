Received: from eggs.gnu.org ([2001:4830:134:3::10]:54881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPMO-0002m7-7v
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPMK-0001Mm-3m
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnPMJ-0001LB-Td
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:18:12 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-6-david@redhat.com>
	<98048e5d-fa10-76a3-ce11-36a78212c259@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <21f4d734-8d7c-5ee9-33e2-0cc829d7d8ca@redhat.com>
Date: Thu, 31 Aug 2017 15:18:08 +0200
MIME-Version: 1.0
In-Reply-To: <98048e5d-fa10-76a3-ce11-36a78212c259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/11] s390x: rename s390-virtio.h to
 s390-virtio-hcall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 31.08.2017 11:29, Thomas Huth wrote:
> On 30.08.2017 19:05, David Hildenbrand wrote:
>> The only interface left, so let's properly rename it.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c                      | 2 +-
>>  hw/s390x/s390-virtio-hcall.c                    | 2 +-
>>  hw/s390x/{s390-virtio.h => s390-virtio-hcall.h} | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>  rename hw/s390x/{s390-virtio.h => s390-virtio-hcall.h} (92%)
> [...]
>> diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio-hcall.h
>> similarity index 92%
>> rename from hw/s390x/s390-virtio.h
>> rename to hw/s390x/s390-virtio-hcall.h
>> index d984cd4115..64c5bbd827 100644
>> --- a/hw/s390x/s390-virtio.h
>> +++ b/hw/s390x/s390-virtio-hcall.h
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Virtio interfaces for s390
>> + * Support for virtio hypercalls on s390x
>>   *
>>   * Copyright 2012 IBM Corp.
>>   * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
>>
> 
> Maybe also rename the HW_S390_VIRTIO_H header guard? Anyway:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Sure, will do. Is HW_S390_VIRTIO_HCALL_H okay?

(HW_S390X_S390_VIRTIO_HCALL_H doesn't sound necessary)

-- 

Thanks,

David
