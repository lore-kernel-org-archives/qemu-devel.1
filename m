Received: from eggs.gnu.org ([2001:4830:134:3::10]:53129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAB0B-00022H-Ai
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAB06-0001Kq-Ou
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:05:11 -0400
Received: from [59.151.112.132] (port=49397 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAB06-0001KL-DD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:05:06 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-12-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<037d77db-9ba1-bd06-8789-9759400ae57b@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <f8cd780f-c82f-1ae1-05c6-7f38965186ea@cn.fujitsu.com>
Date: Mon, 15 May 2017 16:05:15 +0800
MIME-Version: 1.0
In-Reply-To: <037d77db-9ba1-bd06-8789-9759400ae57b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 11/12] net/filter-rewriter.c: Add new
 option to enable vnet support for filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 05/15/2017 12:12 PM, Jason Wang wrote:
>
>
> On 2017年05月12日 09:41, Zhang Chen wrote:
>> We add the vnet_hdr option for filter-rewriter, default is disable.
>> If you use virtio-net-pci net driver, please enable it.
>> You can use it for example:
>> -object filter-rewriter,id=rew0,netdev=hn0,queue=all,vnet_hdr=on
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>
> As has been pointed out, let's squash this into patch 12.

OK~

Thanks
Zhang Chen

>
> Thanks
>
>
>
>

-- 
Thanks
Zhang Chen
