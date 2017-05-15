Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA8cy-0004WU-Na
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA8cv-0007vw-Gt
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:33:04 -0400
Received: from [59.151.112.132] (port=12136 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA8cv-0007p7-3t
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:33:01 -0400
References: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494552955-30529-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9d3b85f2-fdb3-641a-96c9-4bb158a50856@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <5cf35772-f177-8bed-d913-aa84aa91a815@cn.fujitsu.com>
Date: Mon, 15 May 2017 13:32:57 +0800
MIME-Version: 1.0
In-Reply-To: <9d3b85f2-fdb3-641a-96c9-4bb158a50856@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] net/filter-rewriter: Remove unused
 option in filter-rewirter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 05/13/2017 01:43 AM, Eric Blake wrote:
> On 05/11/2017 08:35 PM, Zhang Chen wrote:
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> In the subject: s/rewirter/rewriter/

OK.

>> ---
>>   qemu-options.hx | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 70c0ded..f5e088e 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4038,7 +4038,8 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
>>   be the same. we can just use indev or outdev, but at least one of indev or outdev
>>   need to be specified.
>>   
>> -@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode}[,queue=@var{all|rx|tx}]
>> +@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},
>> +[,queue=@var{all|rx|tx}]
> Texinfo sources have restrictions on how line-wrapping works, and it's
> not always consistent.  It's probably best to stick with the long line,
> if you haven't actually validated that the rendered documentation is not
> broken when you split the line.

OK, I will change it to a long line.

Thanks
Zhang Chen


-- 
Thanks
Zhang Chen
