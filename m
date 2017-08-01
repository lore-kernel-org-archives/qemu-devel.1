Received: from eggs.gnu.org ([2001:4830:134:3::10]:55004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcUMl-0001GL-Sc
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcUMi-00058R-Ju
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcUMi-00057B-DO
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:25:28 -0400
References: <201707250902596770211@zte.com.cn>
	<f53aa34f-5ca0-c38e-a303-4688698a2d42@cn.fujitsu.com>
	<20170728002501.GM5117@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ca67be4-4398-853a-4e4a-36bfc3591fd0@redhat.com>
Date: Tue, 1 Aug 2017 12:25:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170728002501.GM5117@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Fam Zheng <famz@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: wang.yong155@zte.com.cn, lizhijian@cn.fujitsu.com, wang.guang55@zte.com.cn, jasowang@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, marcandre.lureau@gmail.com, stefanha@redhat.com, zhang.zhanghailiang@huawei.com

On 28/07/2017 02:25, Fam Zheng wrote:
> On Thu, 07/27 15:47, Zhang Chen wrote:
>> CC. Fam and David.
>>
>> Any idea about it?
> 
> Is it possible to use g_main_context_{push,pop}_thread_default to "move" chardev
> GSources to IOThread's context, then use g_main_context_query like main thread
> and poll the fds in aio_poll?

How would you do that without making aio_poll performance worse for
everyone?

Paolo
