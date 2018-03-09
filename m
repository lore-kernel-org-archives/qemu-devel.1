Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euK86-0000ye-6y
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euK83-00014G-2z
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:40:22 -0500
References: <20180309153347.62552-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <adfa3a5c-0e8e-ff2d-216c-1d73fbb223cc@redhat.com>
Date: Fri, 9 Mar 2018 09:40:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180309153347.62552-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] block latency histogram
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

On 03/09/2018 09:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> v4:
> 
> Move block_latency_histogram_set from block/accounting.c to
> blockdev.c, as it uses qapi type uint64List and this fact breaks
> build.

Was the cross file motion necessary, or could you just fix the #includes 
according to the recent qapi header refactoring?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
