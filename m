Received: from eggs.gnu.org ([2001:4830:134:3::10]:33815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVBa0-0006RA-Vu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVBZw-0000Bo-4S
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVBZv-0000B9-To
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:56:56 -0400
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<1499781397-19749-8-git-send-email-thuth@redhat.com>
	<20170711162326.4b34d8da@dhcp-192-215.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f65b053f-ecb0-4697-47d2-3191b6128c88@redhat.com>
Date: Wed, 12 Jul 2017 08:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170711162326.4b34d8da@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/11] pc-bios/s390-ccw: Add code for
 virtio feature negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 11.07.2017 16:23, Cornelia Huck wrote:
> On Tue, 11 Jul 2017 15:56:33 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The upcoming virtio-net driver needs to negotiate some features,
>> so we need the possibility to do this in the core virtio code.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/s390-ccw.h |  2 ++
>>  pc-bios/s390-ccw/virtio.c   | 23 +++++++++++++++++------
>>  pc-bios/s390-ccw/virtio.h   |  1 +
>>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> 
>> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
>> index d733780..a00a320 100644
>> --- a/pc-bios/s390-ccw/virtio.h
>> +++ b/pc-bios/s390-ccw/virtio.h
>> @@ -251,6 +251,7 @@ struct VDev {
>>      ScsiDevice selected_scsi_device;
>>      uint64_t netboot_start_addr;
>>      uint32_t max_transfer;
>> +    uint32_t guest_features[2];
> 
> Just 'features' might have been a better name, but:

I think it's clearer to call it guest_features ... in case we ever want
to store the host features, too.

>>  };
>>  typedef struct VDev VDev;
>>  
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

 Thomas
