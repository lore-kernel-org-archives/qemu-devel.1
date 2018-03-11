Received: from eggs.gnu.org ([2001:4830:134:3::10]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eurNb-0002DU-LL
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eurNa-0004UW-Pf
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:10:35 -0500
References: <20180309165212.97144-1-vsementsov@virtuozzo.com>
	<20180309165212.97144-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1431d36d-2789-6fd7-0dc9-d2c2080e93e3@redhat.com>
Date: Sat, 10 Mar 2018 21:10:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180309165212.97144-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/2] block/accounting: introduce latency
 histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

On 03/09/2018 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> Introduce latency histogram statics for block devices.
> For each accounted operation type latency region [0, +inf) is

Hard to read; I suggest: s/type latency/type, the latency/

> divided into subregions by several points. Then, calculate
> hits for each subregion.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/accounting.h | 35 ++++++++++++++++++
>   block/accounting.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 126 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
