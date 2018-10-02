Received: from eggs.gnu.org ([2001:4830:134:3::10]:46813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7Ln5-0005JH-LL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7LZj-0002Tj-Rv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:23:00 -0400
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
Date: Tue, 2 Oct 2018 09:22:49 -0500
MIME-Version: 1.0
In-Reply-To: <20181002113325.12911-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support device id for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

On 10/2/18 6:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> Support modern way of device selecting.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json | 6 ++++--
>   blockdev.c           | 8 +++++---
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ac3b48ee54..4efd60d8ab 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -489,7 +489,9 @@
>   # If only @device parameter is specified, remove all present latency histograms
>   # for the device. Otherwise, add/reset some of (or all) latency histograms.
>   #
> -# @device: device name to set latency histogram for.
> +# @device: device name to set latency histogram for (better use @id).
> +#
> +# @id: The name or QOM path of the guest device.

As long as we are renaming the command, there's no need to keep a legacy 
parameter around. Just get rid of device and replace it by id, rather 
than worrying about both.  The introduction of the stable command does 
not have to carry any baggage left over from the x- preliminary version.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
