Received: from eggs.gnu.org ([209.51.188.92]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1goAn5-0006KM-Ck
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1goAn1-0006YE-Rp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:33:46 -0500
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
	<20190128153750.GE5756@localhost.localdomain>
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <38a62331-591c-9188-650e-b9b06b9a4551@yandex-team.ru>
Date: Mon, 28 Jan 2019 20:33:25 +0300
MIME-Version: 1.0
In-Reply-To: <20190128153750.GE5756@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qmp: Deprecate query-nodes option of
 query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, nsoffer@redhat.com, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>


On 28/01/2019 18:37, Kevin Wolf wrote:
> Am 28.01.2019 um 16:15 hat Anton Kuchin geschrieben:
>> This option is broken since a6baa60807 in v2.9 and returns mostly
>> zeroes instead of real stats because actual querring of BlockStats
>> that resides in blk is missing.
>>
>> And it makes no sense because with this option BlockDriverState-s
>> are iterated but BlockAcctStats belong to BlockBackend and not BDS
>> since 7f0e9da6f13 in v2.5
>>
>> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> Isn't query-nodes the only way to get wr_highest_offset for the protocol
> layer? oVirt depends on this, as far as I know.

Isn't it reported without query-nodes parameter as "wr_highest_offset" 
of "parent" stats entry?

What we get with query-nodes is essentially the same output, but without 
correct data from backend and with one more copy of almost empty data 
from protocol layer.

I'll try to find usages of this option in oVirt code.

>
> Kevin
>
