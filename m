Received: from eggs.gnu.org ([2001:4830:134:3::10]:43429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fTSAi-0008Ux-WC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fTSAe-00035k-2W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:20:16 -0400
References: <20180608192027.284601-1-vsementsov@virtuozzo.com>
	<20180608192027.284601-4-vsementsov@virtuozzo.com>
	<20180614131652.GF8564@localhost.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a1365d50-b830-b342-953f-2ad8a56b1d23@openvz.org>
Date: Thu, 14 Jun 2018 16:19:52 +0300
MIME-Version: 1.0
In-Reply-To: <20180614131652.GF8564@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/3] qcow2: add compress threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@gmail.com, pl@kamp.de

On 06/14/2018 04:16 PM, Kevin Wolf wrote:
> Am 08.06.2018 um 21:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Do data compression in separate threads. This significantly improve
>> performance for qemu-img convert with -W (allow async writes) and -c
>> (compressed) options.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Looks correct to me, but why do we introduce a separate
> MAX_COMPRESS_THREADS? Can't we simply leave the maximum number of
> threads to the thread poll?
>
> I see that you chose a much smaller number here (4 vs. 64), but is there
> actually a good reason for this?
>
> Kevin
yes. In the other case the guest will suffer much more from this increased
activity and load on the host.

Den
