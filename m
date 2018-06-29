Received: from eggs.gnu.org ([2001:4830:134:3::10]:50309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYo55-0002x4-Kt
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYo52-0007Jp-Hc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:44:35 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:46383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYo52-0007Iy-Bn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:44:32 -0400
Received: by mail-io0-x244.google.com with SMTP id u23-v6so7631702ioc.13
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 00:44:32 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
	<20180629072313-mutt-send-email-mst@kernel.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <c6066241-d693-57f3-96dd-c7300ce3818d@gmail.com>
Date: Fri, 29 Jun 2018 15:44:25 +0800
MIME-Version: 1.0
In-Reply-To: <20180629072313-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/29/2018 12:23 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 28, 2018 at 09:36:00PM +0800, Jason Wang wrote:
>>
>>
>> On 2018年06月04日 17:55, guangrong.xiao@gmail.com wrote:
>>> From: Xiao Guangrong<xiaoguangrong@tencent.com>
>>>

>>> Memory barrier is omitted here, please refer to the comment in the code.
>>>
>>> (1)https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
>>> (2)http://dpdk.org/doc/api/rte__ring_8h.html
>>>
>>> Signed-off-by: Xiao Guangrong<xiaoguangrong@tencent.com>
>>> ---
>>
>> May I ask why you need a MPSC ring here? Can we just use N SPSC ring for
>> submitting pages and another N SPSC ring for passing back results?
>>
>> Thanks
> 
> Or just an SPSC ring + a lock.
> How big of a gain is lockless access to a trivial structure
> like the ring?
> 

Okay, i will give a try.

BTW, we tried to use a global ring + lock for input and lockless ring for input,
the former did not show better performance. But we haven't tried to use global
ring + lock for out yet.
