Received: from eggs.gnu.org ([2001:4830:134:3::10]:41561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fZwgA-00080K-EF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fZwg7-0000aU-Oe
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:07:34 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com
	([40.107.7.98]:26496
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fZwg6-0000Zi-Qq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:07:31 -0400
References: <33183CC9F5247A488A2544077AF19020DB03024F@dggeml511-mbx.china.huawei.com>
	<20180702105325.GN2455@xz-mi>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <b498e409-5753-38a5-ae92-bb48dc2f4806@virtuozzo.com>
Date: Mon, 2 Jul 2018 14:07:20 +0300
MIME-Version: 1.0
In-Reply-To: <20180702105325.GN2455@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] about live memory snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 02.07.2018 13:53, Peter Xu wrote:
> On Sat, Jun 30, 2018 at 01:45:29AM +0000, Gonglei (Arei) wrote:
>> Hi Peter,
>>
>> As we discussed in LC3 China, the current scheme of "migration to file"
>> can't fit on production environment, which will cause the snapshot file bigger
>> and bigger when the guest is under enough memory pressure. We can't
>> assume what size the snapshot file is.
>>   
>> Pls have a look if we have a simple method to resolve the problem. :)
> 
> Yeah, it seems that the requirement of this live snapshot feature is
> there for a long time but we haven't yet figured out a good way to
> solve it.
> 
>>
>> PS: the below link is zhanghailiang's scheme based on userfaultfd.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg00664.html
> 
> Thanks for the pointer!
> 
> Just to mention that there is another ongoing work from Denis that
> implemented similar feature but with mprotect() and a new
> (to-be-proposed?) kvm interface:
> 
I recently emailed the patch set with of my approach to the mainstream.
The patch set is called "Background snapshots".

Please, feel free to review it.

Denis

> http://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08684.html
> 
> Hopefully we can figure something out soon on the list.
> 
> Regards,
> 
