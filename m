Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPSP-0006c5-Uz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPSM-0003ya-0P
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:24:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnPSL-0003yN-QK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:24:25 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-9-david@redhat.com>
	<8a7e8d96-0d32-97cd-0e5a-335aff4d9d39@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6482075e-082e-f04c-317b-2d83775b1848@redhat.com>
Date: Thu, 31 Aug 2017 15:24:18 +0200
MIME-Version: 1.0
In-Reply-To: <8a7e8d96-0d32-97cd-0e5a-335aff4d9d39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/11] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 21:06, Thomas Huth wrote:
> On 30.08.2017 19:05, David Hildenbrand wrote:
>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
>> guest tries to bring these CPUs up but fails), because we don't support
>> multiple CPUs on s390x under TCG.
>>
>> Let's bail out if more than 1 are specified, so we don't raise people's
>> hope.
> 
> Aurelien recently posted a patch to add that basic SIGP support:
> 
>  https://patchwork.kernel.org/patch/9717489/
> 
> I think it would make more sense to get that included instead.
> 
>  Thomas
> 

Even then, it doesn't work reliably:

- "*very rough* SMP support"
- "this patch is nothing more than a way to determine what needs to
   be implemented"
- "It should be rewritten from scratch before reaching in an acceptable
   state."

Such broken feature should not be exposed to the user. Once we have
properly fixed that we can enable and announce it "s390x now supports
more than 1 VCPU under TCG". At this point, this is just wrong, even
with this patch included.

So I'd suggest including this now and reverting it once we have actual
support. "so we don't raise people's hope."

-- 

Thanks,

David
