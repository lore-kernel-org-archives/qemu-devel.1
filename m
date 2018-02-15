Received: from eggs.gnu.org ([2001:4830:134:3::10]:60092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emKNu-0004Qf-Qg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emKNq-0006u7-Rv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:19:38 -0500
References: <20180214173102.9363-1-david@redhat.com>
	<a3b2029e-a092-e7f7-8953-12d59b874736@twiddle.net>
	<4c8b5c14-bef0-ef8a-1237-5146c3ee37b1@redhat.com>
	<20180215104953.1fa574ba.cohuck@redhat.com>
	<3145074e-025a-d1a0-8446-6e62010b970f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a208690f-6ab6-f2dd-f07e-620112420e32@redhat.com>
Date: Thu, 15 Feb 2018 15:19:16 +0100
MIME-Version: 1.0
In-Reply-To: <3145074e-025a-d1a0-8446-6e62010b970f@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 15.02.2018 15:13, Eric Blake wrote:
> On 02/15/2018 03:49 AM, Cornelia Huck wrote:
>> On Thu, 15 Feb 2018 10:47:45 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 14.02.2018 20:04, Richard Henderson wrote:
>>>> On 02/14/2018 09:31 AM, David Hildenbrand wrote:
>>>>> Let's add proper alignment checks for a handful of instructions that
>>>>> require a SPECIFICATION exception in case alignment is violated.
>>>>>
>>>>> Introduce new wout/in functions. Declare them as "static inline" to avoid
>>>>> warnings about not being used for CONFIG_USER_ONLY (as we are right
>>>>> now only using them for privileged instructions).
>>>>
>>>> Annoyingly, clang will still warn for this.
>>>>    
>>>
>>> Hm, so the only solution is to add nasty idfefs then :(
>>
>> Yup, very annoying indeed, but probably the only way to shut clang up...
> 
> Does marking the function __attribute__((unused)) shut up clang?
> 

Guess so, seems to be used in tcg/tcg.c. But I don't think that's a
major improvement, as these warnings can actually point you at bugs.

-- 

Thanks,

David / dhildenb
