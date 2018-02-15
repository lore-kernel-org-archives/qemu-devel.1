Received: from eggs.gnu.org ([2001:4830:134:3::10]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emG9A-0006V4-6V
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emG95-0005YZ-EC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:48:08 -0500
References: <20180214173102.9363-1-david@redhat.com>
	<a3b2029e-a092-e7f7-8953-12d59b874736@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4c8b5c14-bef0-ef8a-1237-5146c3ee37b1@redhat.com>
Date: Thu, 15 Feb 2018 10:47:45 +0100
MIME-Version: 1.0
In-Reply-To: <a3b2029e-a092-e7f7-8953-12d59b874736@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 14.02.2018 20:04, Richard Henderson wrote:
> On 02/14/2018 09:31 AM, David Hildenbrand wrote:
>> Let's add proper alignment checks for a handful of instructions that
>> require a SPECIFICATION exception in case alignment is violated.
>>
>> Introduce new wout/in functions. Declare them as "static inline" to avoid
>> warnings about not being used for CONFIG_USER_ONLY (as we are right
>> now only using them for privileged instructions).
> 
> Annoyingly, clang will still warn for this.
> 

Hm, so the only solution is to add nasty idfefs then :(

Thanks!

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
