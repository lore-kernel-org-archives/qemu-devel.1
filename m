Received: from eggs.gnu.org ([2001:4830:134:3::10]:39994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eQpgh-0002dx-7P
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eQpgd-0006N8-8T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:18:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2054 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhaoshenglong@huawei.com>)
	id 1eQpgc-0006Hp-Rx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:18:07 -0500
Message-ID: <5A376B8D.5080008@huawei.com>
Date: Mon, 18 Dec 2017 15:17:33 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual>
	<5A253EF5.6040300@huawei.com>
	<20171205060047.GA4102@yangzhon-Virtual>
	<024fd897-a16a-f69e-94dc-07affb3ef724@redhat.com>
	<20171206092625.GA19639@yangzhon-Virtual>
	<6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
	<20171207150629.GA7387@yangzhon-Virtual>
	<af4a7e59-ac0a-1d5f-3cc5-458dd5fc6fc9@redhat.com>
	<20171212065419.GB26607@yangzhon-Virtual>
In-Reply-To: <20171212065419.GB26607@yangzhon-Virtual>
Content-Type: text/plain; charset="ISO-8859-1"
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
To: Yang Zhong <yang.zhong@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com



On 2017/12/12 14:54, Yang Zhong wrote:
>> > 2) what effect it has on boot time in Shannon's case.
>   Hello Shannon,
> 
>   It's hard for me to reproduce your commands in my x86 enviornment, as a compare test,
>   would you please help me use above two TEMP patches to verify VM bootup time again?
> 
>   Those data can help Paolo to decide which patch will be used or how to adjust delta
>   parameter.  Many thanks!
We have tested these two patches. Both don't increase the VM bootup time
in my case.

Thanks,
-- 
Shannon
