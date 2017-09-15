Received: from eggs.gnu.org ([2001:4830:134:3::10]:40122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dsqMn-0007cp-S5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dsqMj-0007dk-Pp
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dsqMj-0007dc-Iy
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:09:05 -0400
References: <20170915101406.27823-1-cohuck@redhat.com>
	<20170915101406.27823-2-cohuck@redhat.com>
	<37791e7b-c096-3e88-4121-4f1739615367@redhat.com>
	<20170915150705.359a5356.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cdd8e227-c7c6-2753-5ae7-b667d6e63280@redhat.com>
Date: Fri, 15 Sep 2017 15:09:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170915150705.359a5356.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] s390x/ccw: create s390 phb for
 compat reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 15.09.2017 15:07, Cornelia Huck wrote:
> On Fri, 15 Sep 2017 13:57:40 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> As an alternative, simply
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 0f28ebd162..0f22efc3b6 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -195,6 +195,8 @@ bool s390_has_feat(S390Feat feat)
>>                  return true;
>>              }
>>          }
>> +        if (feat == S390_FEAT_ZPCI)
>> +            return true;
> 
> Move that out of the CONFIG_KVM #ifdef?
> 

Should not make a difference I think, cpu models are not shielded off
for TCG I think (maybe we should fix that, but doesn't look that easy -
they have no host model which would allow cpu->model = NULL).

> (Also, we still have the issue with pci support :/ - depend on
> pci_available?)

hm ....

> 
>>  #endif
>>          return 0;
>>      }
>>
>>
>> (this is also the way we handle other features without cpu model support
>> -especially if cpu model support is disabled for older machines)
> 
> Now that you mention cpu models (which are disabled on old machines),
> the failure starts to look plausible :)
> 


-- 

Thanks,

David
