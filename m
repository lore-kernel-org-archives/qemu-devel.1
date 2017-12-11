Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQzj-0002VI-Il
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQzg-0001AB-CB
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:31:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOQzg-00019W-5D
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:31:52 -0500
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
	<5A1A5C6E.9060409@huawei.com> <20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual> <5A253EF5.6040300@huawei.com>
	<20171205060047.GA4102@yangzhon-Virtual>
	<024fd897-a16a-f69e-94dc-07affb3ef724@redhat.com>
	<20171206092625.GA19639@yangzhon-Virtual>
	<6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
	<20171207150629.GA7387@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af4a7e59-ac0a-1d5f-3cc5-458dd5fc6fc9@redhat.com>
Date: Mon, 11 Dec 2017 17:31:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171207150629.GA7387@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhaoshenglong@huawei.com

On 07/12/2017 16:06, Yang Zhong wrote:
>  Which show trim cost time less than 1ms and call_rcu_thread() do 10 times batch free, the trim also 10 times.
> 
>  I also did below changes: 
>     delta=1000,  and 
>     next_trim_time = qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta * last_trim_time
> 
>  The whole VM bootup will trim 3 times.

For any adaptive mechanism (either this one or the simple "if (n == 0)"
one), the question is:

1) what effect it has on RSS in your case

2) what effect it has on boot time in Shannon's case.

Either patch is okay if you can justify it with these two performance
indices.

Thanks,

Paolo
