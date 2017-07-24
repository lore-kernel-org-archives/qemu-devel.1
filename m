Received: from eggs.gnu.org ([2001:4830:134:3::10]:43326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZheY-0008LO-2E
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZheT-0001Jq-8n
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:00:22 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZheT-0001JP-4R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:00:17 -0400
Received: by mail-qt0-x241.google.com with SMTP id d10so990114qtb.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:00:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-5-david@redhat.com>
	<f1c1a29b-c249-0cb1-98a4-78c91147c405@twiddle.net>
	<41378209-643c-b76a-4f7d-c3843f3fb95e@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2fea3168-1789-b22b-c3c5-f2be8512809e@twiddle.net>
Date: Mon, 24 Jul 2017 11:00:09 -0700
MIME-Version: 1.0
In-Reply-To: <41378209-643c-b76a-4f7d-c3843f3fb95e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/6] target/s390x: move wrap_address to
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 07/24/2017 10:38 AM, David Hildenbrand wrote:
> On 24.07.2017 06:40, Richard Henderson wrote:
>> On 07/21/2017 05:56 AM, David Hildenbrand wrote:
>>> Signed-off-by: David Hildenbrand<david@redhat.com>
>>> ---
>>>    target/s390x/cpu.h        | 14 ++++++++++++++
>>>    target/s390x/mem_helper.c | 14 --------------
>>>    2 files changed, 14 insertions(+), 14 deletions(-)
>>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>
>> Although another header, private to the helpers, might be better...
>>
> 
> Question is if we should have a new header for stuff really only used
> locally in target/s390x - in contrast to say cpu.h, which is included
> from various other places. So not only a header for helpers, but also
> used for e.g. kvm.c.
> 
> This header could e.g. be called cpu_helper.h and would not included in
> cpu.h

C.f. target/arm/internals.h, which is a bit better as a name, I think.
Perhaps something to wait for 2.11 tree though, and we'll do it proper.


r~
