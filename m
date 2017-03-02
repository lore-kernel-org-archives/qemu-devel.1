Received: from eggs.gnu.org ([2001:4830:134:3::10]:38127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjN95-0003N8-Er
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjN92-0004wc-4t
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:35:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjN91-0004wH-VI
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:35:32 -0500
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1488259090-30034-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<958bdddd-003c-c785-e7e6-f700f1d87bc0@redhat.com>
	<64fa3338-3771-4f19-7882-8a028aac87a4@cn.fujitsu.com>
	<01b98ebb-feb2-c0f6-62ed-8b3d1712a028@redhat.com>
	<ed10fde2-e7bb-36f2-f277-dcc107a0090b@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d49db5c6-09e9-3249-730a-0c4a584b1782@redhat.com>
Date: Thu, 2 Mar 2017 17:35:22 +0800
MIME-Version: 1.0
In-Reply-To: <ed10fde2-e7bb-36f2-f277-dcc107a0090b@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B403=E6=9C=8802=E6=97=A5 16:15, Zhang Chen wrote:
>
>
> On 03/02/2017 03:51 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B402=E6=9C=8828=E6=97=A5 14:11, Zhang Chen wrote:
>>>>
>>>
>>> OK, How about this?
>>>
>>> +    /*
>>> +     * Because of ppkt and spkt are both in the same connection,
>>> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all a=
re
>>> +     * same with spkt. In addition, IP header's Identification is a=20
>>> random
>>> +     * field, we can handle it in IP fragmentation function later.
>>> +     * So we just compare the ip payload here. we ignored all IP=20
>>> header
>>> +     * include other field like TOS,TTL,IP Checksum.
>>> +     */
>>>
>>> Thanks
>>> Zhang Chen
>>
>> But this does not explain why we can ignore those fields.
>
> +    /*
> +     * Because of ppkt and spkt are both in the same connection,
> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
> +     * same with spkt. In addition, IP header's Identification is a=20
> random
> +     * field, we can handle it in IP fragmentation function later.
> +     * COLO just concern the response net packet payload from primary=20
> guest
> +     * and secondary guest are same or not, So we ignored all IP=20
> header include
> +     * other field like TOS,TTL,IP Checksum. we only need to compare
> +     * the ip payload here.
> +     */
>
> How about this fixed comments?
>
> Thanks
> Zhang Chen
>
>

Looks ok.

Thanks

>>
>> Thanks
>>
>>
>>
>
