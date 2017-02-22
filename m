Received: from eggs.gnu.org ([2001:4830:134:3::10]:38746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cgNJW-0000wB-1F
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cgNJS-0001WQ-SQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:09:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cgNJS-0001WL-Mc
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:09:54 -0500
References: <1487645041-28919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<58ACEDCA.3070404@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63feb0fc-76f7-91ab-d877-5b21dd48a253@redhat.com>
Date: Wed, 22 Feb 2017 11:09:48 +0800
MIME-Version: 1.0
In-Reply-To: <58ACEDCA.3070404@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare: Fix memory free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: xuquan8@huawei.com



On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 09:47, Hailiang Zhang wrote:
> On 2017/2/21 10:44, Zhang Chen wrote:
>> We use g_queue_init() to init s->conn_list, so we should use=20
>> g_queue_clear()
>> to instead of g_queue_free().
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>

Applied, thanks.

>> ---
>>   net/colo-compare.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 162fd6a..cf8c4c9 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -715,7 +715,7 @@ static void colo_compare_finalize(Object *obj)
>>       qemu_chr_fe_deinit(&s->chr_sec_in);
>>       qemu_chr_fe_deinit(&s->chr_out);
>>
>> -    g_queue_free(&s->conn_list);
>> +    g_queue_clear(&s->conn_list);
>>
>>       if (qemu_thread_is_self(&s->thread)) {
>>           /* compare connection */
>>
>
