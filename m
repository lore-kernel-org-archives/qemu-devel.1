Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d1VKU-0000AH-7j
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d1VKQ-0003sm-CQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:58:18 -0400
Received: from mail-db5eur01on0106.outbound.protection.outlook.com
	([104.47.2.106]:26817
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1d1VKP-0003sZ-Pw
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:58:14 -0400
References: <1492511251-16720-1-git-send-email-den@openvz.org>
	<8f297f9f-8aa2-bca8-d99e-dc9fc767abf2@kamp.de>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <8d45e88c-f19e-65fc-937e-d1547b50c63c@virtuozzo.com>
Date: Fri, 21 Apr 2017 12:43:35 +0300
MIME-Version: 1.0
In-Reply-To: <8f297f9f-8aa2-bca8-d99e-dc9fc767abf2@kamp.de>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-img: wait for convert coroutines
 to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

On 04/21/2017 12:18 PM, Peter Lieven wrote:
> Am 18.04.2017 um 12:27 schrieb Denis V. Lunev:
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>
>> We should wait for other coroutines on error path, i.e. one of coroutines
>> terminates with i/o error, before cleaning the common structures. In the
>> other case we would crash in a lot of different places. This behaviour
>> was introduced by commit 2d9187bc65.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Peter Lieven <pl@kamp.de>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>
> Cc: qemu-stable@nongnu.org
>
> This should go into 2.9.1
>
> Peter
>

Actually I'm afraid the patch is incorrect.. The erroneous coroutine 
bails out without reentering its possible dependent coroutine so it (and 
the following dependents) will never finish.

I'll send out the 2nd version soon

/Anton
