Received: from eggs.gnu.org ([2001:4830:134:3::10]:43105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnQNr-0007Ia-Sh
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnQNo-0007JR-24
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:23:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnQNn-0007JF-RR
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:23:47 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-4-david@redhat.com>
	<09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <55b99307-b817-1cb2-f5c8-901b877735cc@redhat.com>
Date: Thu, 31 Aug 2017 16:23:44 +0200
MIME-Version: 1.0
In-Reply-To: <09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/11] s390x: store cpu states inside
 machine state
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


>> +struct S390CPU;
> 
> You define a "struct S390CPU" here ...
> 
>>  typedef struct S390CcwMachineState {
>>      /*< private >*/
>>      MachineState parent_obj;
>>  
>>      /*< public >*/
>> +    S390CPU **cpus;
> 
> ... but use the typedef'ed S390CPU here ... looks somewhat suspicious, I
> wonder whether the typedef is really in the right place?

General question: how much do we care about headers that are not consistent?

E.g. shall I forward declare or simply ignore if compilers don't bite me?


> 
>>      bool aes_key_wrap;
>>      bool dea_key_wrap;
>>      uint8_t loadparm[8];
> 
> Anyway, that were just nits, I'm also fine with the patch as it is, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


-- 

Thanks,

David
