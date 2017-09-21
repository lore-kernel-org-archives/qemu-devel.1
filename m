Received: from eggs.gnu.org ([2001:4830:134:3::10]:43905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dv55t-0006Fb-IA
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dv55p-00031C-Je
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:16:57 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <f27a04c3-f4ac-3220-4a6a-9aca0c36aebb@virtuozzo.com>
Date: Thu, 21 Sep 2017 20:16:38 +0300
MIME-Version: 1.0
In-Reply-To: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/15] qcow2: space preallocation and
 COW improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com


On 1/8/2017 5:18 PM, Anton Nefedov wrote:
> 
> This pull request is to address a few performance problems of qcow2 format:
> 
>    1. non cluster-aligned write requests (to unallocated clusters) explicitly
>      pad data with zeroes if there is no backing data. This can be avoided
>      and the whole clusters are preallocated and zeroed in a single
>      efficient write_zeroes() operation, also providing better host file
>      continuity
> 
>    2. moreover, efficient write_zeroes() operation can be used to preallocate
>      space megabytes ahead which gives noticeable improvement on some storage
>      types (e.g. distributed storages where space allocation operation is
>      expensive)
> 

ping?
I'd send the rebased series but there are no real conflicts so

/thanks,
Anton
