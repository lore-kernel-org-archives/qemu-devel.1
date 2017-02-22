Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgP9b-0003ce-3L
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgP9X-0004Pg-5o
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:07:51 -0500
Received: from [59.151.112.132] (port=24455 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgP9W-0004Od-Gm
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:07:47 -0500
References: <1487645041-28919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<58ACEDCA.3070404@huawei.com>
	<63feb0fc-76f7-91ab-d877-5b21dd48a253@redhat.com>
	<3ee2a276-57f3-1d0b-b284-1895cef817b6@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <793674ad-6127-4d4b-b86e-e765f2f40a58@cn.fujitsu.com>
Date: Wed, 22 Feb 2017 13:06:54 +0800
MIME-Version: 1.0
In-Reply-To: <3ee2a276-57f3-1d0b-b284-1895cef817b6@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare: Fix memory free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com



On 02/22/2017 11:15 AM, Jason Wang wrote:
>
>
> On 2017年02月22日 11:09, Jason Wang wrote:
>>
>>
>> On 2017年02月22日 09:47, Hailiang Zhang wrote:
>>> On 2017/2/21 10:44, Zhang Chen wrote:
>>>> We use g_queue_init() to init s->conn_list, so we should use 
>>>> g_queue_clear()
>>>> to instead of g_queue_free().
>>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>
>>> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>>
>>
>> Applied, thanks.
>
> Actually reverted. The patch does not apply cleanly on -net.
>
> Please re-send the patch on top of 
> https://github.com/jasowang/qemu.git net

OK~~

Thanks
Zhang Chen

>
> Thanks
>
>>
>>>> ---
>>>>   net/colo-compare.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>>> index 162fd6a..cf8c4c9 100644
>>>> --- a/net/colo-compare.c
>>>> +++ b/net/colo-compare.c
>>>> @@ -715,7 +715,7 @@ static void colo_compare_finalize(Object *obj)
>>>>       qemu_chr_fe_deinit(&s->chr_sec_in);
>>>>       qemu_chr_fe_deinit(&s->chr_out);
>>>>
>>>> -    g_queue_free(&s->conn_list);
>>>> +    g_queue_clear(&s->conn_list);
>>>>
>>>>       if (qemu_thread_is_self(&s->thread)) {
>>>>           /* compare connection */
>>>>
>>>
>>
>>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
