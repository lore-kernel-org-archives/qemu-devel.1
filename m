Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dadTm-00055F-Mj
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dadTi-0006Y3-Tw
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:45:06 -0400
Received: from [59.151.112.132] (port=49983 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dadTi-0006UT-HE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:45:02 -0400
References: <201707250902596770211@zte.com.cn>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <f53aa34f-5ca0-c38e-a303-4688698a2d42@cn.fujitsu.com>
Date: Thu, 27 Jul 2017 15:47:40 +0800
MIME-Version: 1.0
In-Reply-To: <201707250902596770211@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCHv2 02/04] colo-compare: Processpactkets in
 the IOThreadofthe primary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn, pbonzini@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, stefanha@redhat.com, jasowang@redhat.com, marcandre.lureau@gmail.com, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

CC. Fam and David.

Any idea about it?


Thanks

Zhang Chen


On 07/25/2017 09:02 AM, wang.yong155@zte.com.cn wrote:
>
> >On 24/07/2017 12:38, wang.yong155@zte.com.cn wrote:
>
> >> finally use g_main_loop_run to replace aio_poll  in the
>
> >> iothread_run function.
>
> >
>
> >That would make the performance of virtio-blk with iothreads worse,
>
> >unfortunately.  aio_poll is much more optimized than g_main_loop_run.
>
> Hi Paolo,
>
> Any other good idea to achieve this?
>
>
> Thanks
>
>
> >
>
> >Paolo
>
> >
>
> >> After that IOThread
>
> >> runs the GMainContext event loop,chardev and IOThread can work 
> together.
>
> >>
>
> >> How about it? If feasible, I will try to submit
>
>
>
>
> 原始邮件
> *发件人：*<pbonzini@redhat.com>;
> *收件人：*王勇10170530;<stefanha@redhat.com>;<jasowang@redhat.com>;<marcandre.lureau@gmail.com>;
> *抄送人：*<zhang.zhanghailiang@huawei.com>;<zhangchen.fnst@cn.fujitsu.com>;<lizhijian@cn.fujitsu.com>;<qemu-devel@nongnu.org>;王广10165992;
> *日 期 ：*2017年07月24日 19:59
> *主 题 ：**Re: [PATCHv2 02/04] colo-compare: Processpactkets in the 
> IOThreadofthe primary*
>
>
> On 24/07/2017 12:38, wang.yong155@zte.com.cn wrote:
> > finally use g_main_loop_run to replace aio_poll  in the
> > iothread_run function.
>
> That would make the performance of virtio-blk with iothreads worse,
> unfortunately.  aio_poll is much more optimized than g_main_loop_run.
>
> Paolo
>
> > After that IOThread
> > runs the GMainContext event loop,chardev and IOThread can work together.
> >
> > How about it? If feasible, I will try to submit a patch.
>
>
>

-- 
Thanks
Zhang Chen
