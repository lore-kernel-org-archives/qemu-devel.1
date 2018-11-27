Received: from eggs.gnu.org ([2001:4830:134:3::10]:59441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRYlc-0001Ef-N9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRYlZ-0006kU-Ia
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:30:48 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRYlZ-0006iv-Br
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:30:45 -0500
Received: by mail-pf1-x441.google.com with SMTP id c73so7979763pfe.13
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 00:30:45 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181123110239.GC2373@work-vm>
	<e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
	<20181126185504.GB6688@flamenco>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <ebd5a6d4-22fa-4b2a-f9c2-cbbf5d97ff0d@gmail.com>
Date: Tue, 27 Nov 2018 16:30:37 +0800
MIME-Version: 1.0
In-Reply-To: <20181126185504.GB6688@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/27/18 2:55 AM, Emilio G. Cota wrote:
> On Mon, Nov 26, 2018 at 15:57:25 +0800, Xiao Guangrong wrote:
>>
>>
>> On 11/23/18 7:02 PM, Dr. David Alan Gilbert wrote:
>>
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/bitmap.h"
>>>> +#include "qemu/threaded-workqueue.h"
>>>> +
>>>> +#define SMP_CACHE_BYTES 64
>>>
>>> That's architecture dependent isn't it?
>>>
>>
>> Yes, it's arch dependent indeed.
>>
>> I just used 64 for simplification and i think it is <= 64 on most CPU arch-es
>> so that can work.
>>
>> Should i introduce statically defined CACHE LINE SIZE for all arch-es? :(
> 
> No, at compile-time this is impossible to know.
> 
> We do query this info at run-time though (see util/cacheinfo.c),
> but using that info here would complicate things too much.

I see.

> 
> You can just give it a different name, and perhaps add a comment.
> See for instance what we do in qht.c with QHT_BUCKET_ALIGN.

That's really a good lesson to me, will follow it. :)
