Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejV8W-0001WT-FT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejV8T-00006x-96
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:12:04 -0500
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
	<b4c61e4f-4bbd-39d6-0e72-57e9ae1694fe@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <770c4e4f-ed2b-8fd5-8344-4b920b0273a1@redhat.com>
Date: Wed, 7 Feb 2018 13:11:43 -0600
MIME-Version: 1.0
In-Reply-To: <b4c61e4f-4bbd-39d6-0e72-57e9ae1694fe@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On 02/07/2018 12:44 PM, Christian Borntraeger wrote:

>> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_S390) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, " on cpu %d: %s\n"
>> +                          "PSW: 0x%016" PRIx64 " 0x%016" PRIx64"\n",
>> +                          info->u.s390.core,
>> +                          qapi_enum_lookup(&S390CrashReason_lookup,
>> +                                           info->u.s390.reason),
> 
> Question for the qapi people. Would you prefer S390CrashReason_str instead?

Yes, S390CrashReason_str(info->u.s390.reason) is a more legible way to 
spell this same lookup, and leaves the door open if we later change how 
the internal &S390CrashReason_lookup[] behaves.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
