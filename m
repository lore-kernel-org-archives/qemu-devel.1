Received: from eggs.gnu.org ([2001:4830:134:3::10]:44581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEU7s-0006WL-Io
	for qemu-devel@nongnu.org; Sat, 27 May 2017 01:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEU7o-00004z-0A
	for qemu-devel@nongnu.org; Sat, 27 May 2017 01:18:56 -0400
Received: from [59.151.112.132] (port=48659 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEU7n-0008Vy-Kj
	for qemu-devel@nongnu.org; Sat, 27 May 2017 01:18:51 -0400
References: <19feea44a3f4010645a1b829b504481f1b574b9a.1495797845.git.maozy.fnst@cn.fujitsu.com>
	<caf34cd4-a2cd-395b-f95f-d2588ba1672a@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <6bf5b7a2-62e0-4484-c754-fd8de6d5f2cd@cn.fujitsu.com>
Date: Sat, 27 May 2017 13:17:34 +0800
MIME-Version: 1.0
In-Reply-To: <caf34cd4-a2cd-395b-f95f-d2588ba1672a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] pci: Set err to errp directly rather
 than through error_porpagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, imammedo@redhat.com, armbru@redhat.com, mst@redhat.com



On 05/26/2017 09:33 PM, Eric Blake wrote:
> On 05/26/2017 06:58 AM, Mao Zhongyi wrote:
>
> In the subject: s/porpagate/propagate/
>
>> ioh3420_interrupts_init() and its callers rp_realize() fill error
>> message to local_err, then propagate it to errp by error_porpagate(),
>
> and again

OK, I see.
Thanks

>
>> which's not necessary. So eliminate it and pass errp directly instead
>
> s/which's/which is/ (English does not have the abbreviation which's)

Thanks for your kindly remind. I think that this problem will not
happen again. :)

>
>> of local_err. Of course, error_propagate() also has been removed.
>>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>> v2:
>> * Drop the part of wrong handling that ignored the fact that if
>>   pci_qdev_realize()'s caller pass errp = NULL.
>>
>
> The code portion is fine, so with the commit message fixed (which a
> maintainer might do without needing you to send a v3),
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

I am very glad to hear that.
I will fix it again in the v3. After all, it's not good to bother
others.

Thanks a lot.
Mao
