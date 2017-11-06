Received: from eggs.gnu.org ([2001:4830:134:3::10]:36750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eBW1F-0007RR-4E
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eBW1C-0008Q1-0K
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:16:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31455
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eBW1B-0008Ni-Ib
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:16:01 -0500
References: <2896466deb1ff8d832e39ce389ce268ee38e4e4f.1504935362.git.maozy.fnst@cn.fujitsu.com>
	<20170912101629.GE6123@stefanha-x1.localdomain>
	<b3ee14cb-9d20-156b-2f68-f069ccd89f1d@cn.fujitsu.com>
	<20171103151021.GA10959@stefanha-x1.localdomain>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <b1316664-8e2e-98f9-48ee-042cfb345eb7@cn.fujitsu.com>
Date: Mon, 6 Nov 2017 09:12:10 +0800
MIME-Version: 1.0
In-Reply-To: <20171103151021.GA10959@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] pci: Set err to errp directly rather
 than through error_propagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org



On 11/03/2017 11:10 PM, Stefan Hajnoczi wrote:
> On Thu, Oct 12, 2017 at 10:44:26AM +0800, Mao Zhongyi wrote:
>> On 09/12/2017 06:16 PM, Stefan Hajnoczi wrote:
>>> On Sat, Sep 09, 2017 at 02:22:26PM +0800, Mao Zhongyi wrote:
>>>> ioh3420_interrupts_init() pass error message to local_err, then
>>>> propagate it to errp by error_propagate(), which is not necessary.
>>>> So eliminate it and pass errp directly instead of local_err.
>>>>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>> v4:
>>>> it not apply clearly on HEAD, so rebase it and modify the commit
>>>> message.
>>>> ---
>>>>
>>>>  hw/pci-bridge/ioh3420.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Hi,
>>
>> Long time no news. Ping...
>
> This patch should go through Michael Tsirkin's tree.

Hi, Stefan

Thanks for the info. This patch has merged by Michael S. Tsirkin.


>
> Stefan
>
