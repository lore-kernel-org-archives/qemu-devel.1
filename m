Received: from eggs.gnu.org ([2001:4830:134:3::10]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1coVSX-0001Ec-3U
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1coVST-0004pD-V3
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1coVST-0004oJ-Pc
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:28:49 -0400
References: <20170130131517.8092-1-sw@weilnetz.de>
	<c16d6c6a-96b8-01fd-ca20-978e9c1a2367@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d09ccce8-9ac4-66f5-36e1-132c9cffd9f7@redhat.com>
Date: Thu, 16 Mar 2017 14:28:44 +0100
MIME-Version: 1.0
In-Reply-To: <c16d6c6a-96b8-01fd-ca20-978e9c1a2367@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>

On 02.03.2017 20:56, David Hildenbrand wrote:
> Am 30.01.2017 um 14:15 schrieb Stefan Weil:
>> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>
>> v2: Re-sent as v1 was damaged by my mailer.
>>
>> This is also broken in Debian.
>>
>> In addition, there is no default CPU ("any"), so binfmt and related
>> actions currently don't work. I hacked my local installation by
>> duplicating the "qemu" cpu definition for "any", but maybe there is
>> a better solution.
> 
> That should then already work.
> 
>>
>> Regards
>> Stefan
>>
>>  target/s390x/cpu_models.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 2a894ee..6e34763 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel *max_model,
>>  
>>  static S390CPUModel *get_max_cpu_model(Error **errp)
>>  {
>> -#ifndef CONFIG_USER_ONLY
>>      static S390CPUModel max_model;
>>      static bool cached;
>>  
>> @@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>>          cached = true;
>>          return &max_model;
>>      }
>> -#endif
>>      return NULL;
>>  }
>>  
>>
> 
> I thought this was already picked up for stable...
> But looks like only the "any" model fixup got.
> 
> So
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Ping, can somebody please pick this up?

-- 

Thanks,

David
