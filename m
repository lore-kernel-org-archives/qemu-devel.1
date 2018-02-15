Received: from eggs.gnu.org ([2001:4830:134:3::10]:34239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emFzm-0007Ag-RR
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emFzm-0006y6-4Z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:38:26 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a285b2b0-f4e4-54bb-2d23-7f415450decd@virtuozzo.com>
Date: Thu, 15 Feb 2018 12:38:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180207125037.13510-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] ping Re: [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

ping
07.02.2018 15:50, Vladimir Sementsov-Ogievskiy wrote:
> v2:
>
> 01: add block_latency_histogram_clear()
> 02: fix spelling (sorry =()
>      some rewordings
>      remove histogram if latency parameter unspecified
>
> Vladimir Sementsov-Ogievskiy (2):
>    block/accounting: introduce latency histogram
>    qapi: add block latency histogram interface
>
>   qapi/block-core.json       | 73 +++++++++++++++++++++++++++++++++-
>   include/block/accounting.h |  9 +++++
>   block/accounting.c         | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>   block/qapi.c               | 31 +++++++++++++++
>   blockdev.c                 | 19 +++++++++
>   5 files changed, 228 insertions(+), 1 deletion(-)
>


-- 
Best regards,
Vladimir
