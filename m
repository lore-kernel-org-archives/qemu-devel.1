Received: from eggs.gnu.org ([2001:4830:134:3::10]:49009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emGV5-0006nl-Ja
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emGV0-0002mG-LG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:10:47 -0500
References: <20180214173102.9363-1-david@redhat.com>
	<a3b2029e-a092-e7f7-8953-12d59b874736@twiddle.net>
	<4c8b5c14-bef0-ef8a-1237-5146c3ee37b1@redhat.com>
	<20180215104953.1fa574ba.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c0b33436-0ec6-fe3c-ea5c-ac9bba0fb692@redhat.com>
Date: Thu, 15 Feb 2018 11:10:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180215104953.1fa574ba.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] s390x/tcg: add various
 alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 15.02.2018 10:49, Cornelia Huck wrote:
> On Thu, 15 Feb 2018 10:47:45 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.02.2018 20:04, Richard Henderson wrote:
>>> On 02/14/2018 09:31 AM, David Hildenbrand wrote:  
>>>> Let's add proper alignment checks for a handful of instructions that
>>>> require a SPECIFICATION exception in case alignment is violated.
>>>>
>>>> Introduce new wout/in functions. Declare them as "static inline" to avoid
>>>> warnings about not being used for CONFIG_USER_ONLY (as we are right
>>>> now only using them for privileged instructions).  
>>>
>>> Annoyingly, clang will still warn for this.
>>>   
>>
>> Hm, so the only solution is to add nasty idfefs then :(
> 
> Yup, very annoying indeed, but probably the only way to shut clang up...
> 

Will resend soon!

-- 

Thanks,

David / dhildenb
