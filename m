Received: from eggs.gnu.org ([2001:4830:134:3::10]:57506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gD2Ac-0008Kt-U3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gD2AZ-0003bN-OK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:52:34 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gD2AZ-0003OB-9H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:52:31 -0400
Received: by mail-pl1-x643.google.com with SMTP id f8-v6so13890514plb.2
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 23:52:24 -0700 (PDT)
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-2-xiaoguangrong@tencent.com>
	<20181016164019.GA5666@flamenco>
	<40c0df2a-5a3e-5296-0894-efadf47f3d56@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <a37a8ddb-e6f3-083c-1251-cba835a214f8@gmail.com>
Date: Thu, 18 Oct 2018 14:52:17 +0800
MIME-Version: 1.0
In-Reply-To: <40c0df2a-5a3e-5296-0894-efadf47f3d56@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ptr_ring: port ptr_ring from linux
 kernel to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>
Cc: mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn



On 10/17/2018 04:14 PM, Paolo Bonzini wrote:
> On 16/10/2018 18:40, Emilio G. Cota wrote:
>>> +#define SMP_CACHE_BYTES      64
>>> +#define ____cacheline_aligned_in_smp \
>>> +        __attribute__((__aligned__(SMP_CACHE_BYTES)))
>> You could use QEMU_ALIGNED() here.

Yes, you are right.

>>
>>> +
>>> +#define WRITE_ONCE(ptr, val) \
>>> +    (*((volatile typeof(ptr) *)(&(ptr))) = (val))
>>> +#define READ_ONCE(ptr) (*((volatile typeof(ptr) *)(&(ptr))))
>> Why not atomic_read/set, like in the rest of the QEMU code base?
> 
> Or even atomic_rcu_read/atomic_rcu_set, which includes the necessary
> barriers.
> 

Okay, will fix it, thank you and Emilio for pointing the
issue out.

> Also, please do not use __ identifiers in QEMU code.
> ____cacheline_aligned_in_smp can become just QEMU_ALIGNED(SMP_CACHE_BYTES).
> 

Sure, will keep that in my mind. :)
