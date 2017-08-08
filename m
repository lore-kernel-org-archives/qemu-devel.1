Received: from eggs.gnu.org ([2001:4830:134:3::10]:37072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9YM-0008DB-OE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9YL-0001q5-Ns
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:48:30 -0400
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-4-jsnow@redhat.com>
	<1429674390.2509647.1502217270165.JavaMail.zimbra@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1a1779b9-2624-9808-288c-7288b269bc7f@redhat.com>
Date: Tue, 8 Aug 2017 14:48:14 -0400
MIME-Version: 1.0
In-Reply-To: <1429674390.2509647.1502217270165.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] block-backend: shift in-flight counter
 to BB from BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pjp@redhat.com



On 08/08/2017 02:34 PM, Paolo Bonzini wrote:
> 
> 
> ----- Original Message -----
>> From: "John Snow" <jsnow@redhat.com>
>> To: qemu-block@nongnu.org
>> Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
>> pjp@redhat.com, "John Snow" <jsnow@redhat.com>
>> Sent: Tuesday, August 8, 2017 7:57:10 PM
>> Subject: [PATCH 3/4] block-backend: shift in-flight counter to BB from BDS
>>
>> From: Kevin Wolf <kwolf@redhat.com>
>>
>> This allows us to detect errors in cache flushing (ENOMEDIUM)
>> without choking on a null dereference because we assume that
>> blk_bs(bb) is always defined.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> This is not enough, as discussed in the thread.
> 
> Paolo
> 

Sure, I amended Kevin's later fix and rolled it into one patch and split
the tests out. The cover letter states that this is busted, but I wanted
it on the list instead of buried in a now-unrelated thread.

So now it's here as a patch, can we keep discussion here instead of on
the other thread?

--John
