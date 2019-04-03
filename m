Received: from eggs.gnu.org ([209.51.188.92]:52163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBUJc-0007UQ-Q6
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBUJb-0001oE-Mp
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:03:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:9272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hBUJb-0001mR-AR
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:03:43 -0400
Date: Wed, 3 Apr 2019 09:03:21 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190403010321.GA4098@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190402025728.5636-1-richardw.yang@linux.intel.com>
	<20190402184423.GJ2861@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402184423.GJ2861@work-vm>
Subject: Re: [Qemu-devel] [PATCH] vmstate: check subsection_found is enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, quintela@redhat.com

On Tue, Apr 02, 2019 at 07:44:23PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> subsection_found is true implies vmdesc is not NULL.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/vmstate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index e2bbb7b5f7..8327179eea 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -533,7 +533,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>>          sub++;
>>      }
>>  
>> -    if (vmdesc && subsection_found) {
>> +    if (subsection_found) {
>
>That's true, however it's not obvious from the names; I think
>we should probably rename 'subsection_found' to something like
>'vmdesc_has_subsections'  then it's more obvious that subsection_found
>is more specialised in this routine.

Reasonable, let me change it :-)

>
>Dave
>
>
>>          json_end_array(vmdesc);
>>      }
>>  
>> -- 
>> 2.19.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me
