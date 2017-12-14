Received: from eggs.gnu.org ([2001:4830:134:3::10]:39034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePVr7-0000AR-Dt
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePVr6-0008Hs-KC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:55:29 -0500
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-2-jsnow@redhat.com>
	<fad7ac35-e2be-a7b0-078c-4aa4c3dd2905@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cba92745-25c7-0838-8df4-1d8b3881ad93@redhat.com>
Date: Thu, 14 Dec 2017 10:55:22 -0500
MIME-Version: 1.0
In-Reply-To: <fad7ac35-e2be-a7b0-078c-4aa4c3dd2905@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] blockjob: record time of last yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com



On 12/14/2017 03:38 AM, Paolo Bonzini wrote:
> On 14/12/2017 01:59, John Snow wrote:
>>      qemu_coroutine_yield();
>> +    job->last_yield_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> 
> This is not the time the job has yielded control, but the time the job
> has gotten it back.  Is it intended?
> 
> Thanks,
> 
> Paolo
> 

Yes, since that matches how mirror recorded last_sleep_ns, except for
where it records the 0ns sleep, then it records it beforehand (close
enough.)

I intended for this valuable to count how long we haven't yielded,
basically. Thought being that any time we are yielded, we're being
cooperative.

This is the selfishness counter :)
