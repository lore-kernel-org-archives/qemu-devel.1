Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNP1Z-0007Bq-1I
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNP1Y-0006SU-7s
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:13:33 -0500
References: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <79b1b330-74b2-980a-e2db-4c24f3a1f4fc@redhat.com>
Date: Fri, 8 Dec 2017 15:13:25 -0500
MIME-Version: 1.0
In-Reply-To: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] ide: abort TRIM operation for invalid
 range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 12/08/2017 07:10 AM, Anton Nefedov wrote:
> Started from the separate series discussion (trim statistics) , see
> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01059.html
> 
> There is no range check for IDE trim requests now.
> Such request will likely be rejected by the block layer and count as
> failed and not an invalid/aborted operation.
> 
> Anton Nefedov (3):
>   ide: pass IDEState to trim AIO callback
>   ide: move ide_sect_range_ok() up
>   ide: abort TRIM operation for invalid range
> 
>  hw/ide/core.c | 53 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js

(PR won't be sent until after the 2.12 tree opens.)
