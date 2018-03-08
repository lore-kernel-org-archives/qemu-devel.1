Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ettwX-0003en-1U
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ettwT-0005gv-VW
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:42:41 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180306160017.GM31045@stefanha-x1.localdomain>
	<20180306174918.GA22807@flamenco>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <482599db-65b7-ba5d-6784-72acf3486786@virtuozzo.com>
Date: Thu, 8 Mar 2018 14:42:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180306174918.GA22807@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

Hi Emilio!

Looked through qdist, if I understand correctly, it saves each added 
(with different value) element. It is not effective for disk io timing - 
we'll have too much elements. In my approach, histogram don't grow, it 
initially have several ranges and counts hits to each range.


06.03.2018 20:49, Emilio G. Cota wrote:
> On Tue, Mar 06, 2018 at 16:00:17 +0000, Stefan Hajnoczi wrote:
>> On Wed, Feb 07, 2018 at 03:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Vladimir Sementsov-Ogievskiy (2):
>>>    block/accounting: introduce latency histogram
>>>    qapi: add block latency histogram interface
> (snip)
>>>   5 files changed, 228 insertions(+), 1 deletion(-)
>> The feature looks good.  I posted documentation and code readability
>> suggestions.
> Hi Vladimir,
>
> Did you consider using qdist? For reference, see commit bf3afd5f419
> and/or grep 'qdist'.
>
> Thanks,
>
> 		Emilio


-- 
Best regards,
Vladimir
