Received: from eggs.gnu.org ([2001:4830:134:3::10]:40202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePVtC-0001ZK-4t
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePVtB-0001IA-EC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:57:38 -0500
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-4-jsnow@redhat.com>
	<7804bd5f-b3f7-aa13-9510-0bc6d54995aa@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <81c88b81-e9a4-d308-e709-b753ae33094b@redhat.com>
Date: Thu, 14 Dec 2017 10:57:30 -0500
MIME-Version: 1.0
In-Reply-To: <7804bd5f-b3f7-aa13-9510-0bc6d54995aa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] blockjob: create block_job_throttle
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



On 12/14/2017 03:39 AM, Paolo Bonzini wrote:
> On 14/12/2017 01:59, John Snow wrote:
>> + * Yield if it has been SLICE_TIME nanoseconds since the last yield.
>> + * Otherwise, check if we need to pause (and update the yield counter).
> 
> What is the yield counter?
> 
> Thanks,
> 
> Paolo
> 

Fuzzy brain talk.

I mean to refer to the last_yield_ns field, which gets updated by both
pause and sleep commands. I'm trying to document that no matter what
happens when you call this function (either a scheduled 0ns sleep, the
sleep requested, or a pause was requested) that it will update the
last_yield_ns variable.
