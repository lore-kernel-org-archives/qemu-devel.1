Received: from eggs.gnu.org ([2001:4830:134:3::10]:50468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eHKXm-0003zb-TV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eHKXh-0001Sr-Vp
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:13:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34493
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eHKXh-0001Qk-Gm
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:13:37 -0500
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
	<7f98890b-ee32-d539-0823-06544849457a@redhat.com>
	<20171110142506.GE5466@localhost.localdomain>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <653ca7ec-0d6f-b688-2e5a-2e5ead55b2fc@cn.fujitsu.com>
Date: Wed, 22 Nov 2017 10:09:22 +0800
MIME-Version: 1.0
In-Reply-To: <20171110142506.GE5466@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Convert to realize and improve
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi, Kevin

On 11/10/2017 10:25 PM, Kevin Wolf wrote:
> Am 19.09.2017 um 01:59 hat John Snow geschrieben:
>> On 09/18/2017 10:05 AM, Mao Zhongyi wrote:
>>> This series mainly implements the conversions of ide, floppy and nvme
>>> device to realize. Add some error handling messages and remove the local
>>> variable local_err, use errp to propagate the error directly. Also
>>> fix the unusual function name.
>>
>> I've staged patches one and two here for my IDE pull request.
>>
>> I think patches 3-6 here would belong to Kevin.
>
> Sorry, I completely missed this.

That's all right.

> Thanks, applied patch 3 (nvme) to the block-next branch. I did not take
> patches 4 and 5 because patch 5 doesn't apply cleanly any more, and
> honestly I think the result is uglier than before.

I will rebase the patches right away.

Thanks,
Mao

> Patch 6 is for Gerd.
> Kevin
>
