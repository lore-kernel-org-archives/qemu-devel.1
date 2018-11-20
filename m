Received: from eggs.gnu.org ([2001:4830:134:3::10]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOuZG-0007DZ-SI
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOuZG-0000hG-6o
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:11:06 -0500
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-22-maozhongyi@cmss.chinamobile.com>
	<20181119132527.0e7c26c9.cohuck@redhat.com>
	<a290c35d-3332-2650-af55-2e29660b67fc@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <bdd63f41-4e05-7f0d-13ee-806e3b81b808@cmss.chinamobile.com>
Date: Tue, 20 Nov 2018 09:10:46 +0800
MIME-Version: 1.0
In-Reply-To: <a290c35d-3332-2650-af55-2e29660b67fc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 21/22] event-facility:
 ChangeSysBusDeviceClass *sbdc to SysBusDeviceClass *sbc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>, rth@twiddle.net



On 11/19/18 10:10 PM, Thomas Huth wrote:
> On 2018-11-19 13:25, Cornelia Huck wrote:
>> On Mon, 19 Nov 2018 20:08:19 +0800
>> Mao Zhongyi <maozhongyi@cmss.chinamobile.com> wrote:
>>
>>> Most of the SysBusDeviceClass variables are named sbc,
>>> and sbdc here is a bit weird, so changing sbdc to keep
>>> it consistent with others might look good.
>>
>> A quick git grep also gives sbd and k as variable names, and it is used
>> in a total of two lines which have not been touched since 2013, so...
>> meh. If others like the change, I'm not opposed to merging, though.
> 
> I think I agree with Cornelia, just changing the variable name because
> it's named differently in a couple of other places is just unnecessary
> code churn, which makes "git blame" output harder to read later. I'd
> suggest to drop this patch, too.
> 

Ok, I got it. :)

Thanks,
Mao

>   Thomas
> 
