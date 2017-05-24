Received: from eggs.gnu.org ([2001:4830:134:3::10]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dDNl5-0008Nk-Vt
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dDNl1-0007MR-FY
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:18:52 -0400
Received: from [59.151.112.132] (port=42608 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dDNl1-0007Jg-35
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:18:47 -0400
References: <20170524025718.2287-1-maozy.fnst@cn.fujitsu.com>
	<657927de-43e1-e622-208b-3008f22b4d8f@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <c2e9cfa5-a018-6ea9-fe19-902e4fda7fcc@cn.fujitsu.com>
Date: Wed, 24 May 2017 12:17:51 +0800
MIME-Version: 1.0
In-Reply-To: <657927de-43e1-e622-208b-3008f22b4d8f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] net/rocker: Cleanup the useless return
 value check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: jiri@resnulli.us, armbru@redhat.com



On 05/24/2017 11:31 AM, Jason Wang wrote:
>
>
> On 2017年05月24日 10:57, Mao Zhongyi wrote:
>> None of pci_dma_read()'s callers check the return value except
>> rocker. There is no need to check it because it always return
>> 0. So the check work is useless. Remove it entirely.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
[...]
>
> Applied, thanks.

Thanks:)
