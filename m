Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cjLuX-0003qw-UN
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cjLuU-0007wr-Q3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:16:29 -0500
Received: from [59.151.112.132] (port=26879 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cjLuU-0007vD-Bd
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:16:26 -0500
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1488259090-30034-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<958bdddd-003c-c785-e7e6-f700f1d87bc0@redhat.com>
	<64fa3338-3771-4f19-7882-8a028aac87a4@cn.fujitsu.com>
	<01b98ebb-feb2-c0f6-62ed-8b3d1712a028@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <ed10fde2-e7bb-36f2-f277-dcc107a0090b@cn.fujitsu.com>
Date: Thu, 2 Mar 2017 16:15:44 +0800
MIME-Version: 1.0
In-Reply-To: <01b98ebb-feb2-c0f6-62ed-8b3d1712a028@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2 2/3] COLO-compare: Optimize
 compare_common and compare_tcp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 03/02/2017 03:51 PM, Jason Wang wrote:
>
>
> On 2017年02月28日 14:11, Zhang Chen wrote:
>>>
>>
>> OK, How about this?
>>
>> +    /*
>> +     * Because of ppkt and spkt are both in the same connection,
>> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
>> +     * same with spkt. In addition, IP header's Identification is a 
>> random
>> +     * field, we can handle it in IP fragmentation function later.
>> +     * So we just compare the ip payload here. we ignored all IP header
>> +     * include other field like TOS,TTL,IP Checksum.
>> +     */
>>
>> Thanks
>> Zhang Chen
>
> But this does not explain why we can ignore those fields.

+    /*
+     * Because of ppkt and spkt are both in the same connection,
+     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
+     * same with spkt. In addition, IP header's Identification is a random
+     * field, we can handle it in IP fragmentation function later.
+     * COLO just concern the response net packet payload from primary guest
+     * and secondary guest are same or not, So we ignored all IP header 
include
+     * other field like TOS,TTL,IP Checksum. we only need to compare
+     * the ip payload here.
+     */

How about this fixed comments?

Thanks
Zhang Chen


>
> Thanks
>
>
>

-- 
Thanks
Zhang Chen
