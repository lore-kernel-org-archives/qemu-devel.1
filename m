Received: from eggs.gnu.org ([2001:4830:134:3::10]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVjAw-0005WY-79
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVjAv-0002B1-F9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:49:22 -0400
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-15-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6559006f-9b07-a969-aca0-036477dc52c6@redhat.com>
Date: Thu, 13 Jul 2017 14:49:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170713010555.6769-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 14/18] qcow2: Switch qcow2_measure() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/12/2017 09:05 PM, Eric Blake wrote:
> This is new code, but it is easier to read if it makes passes over
> the image using bytes rather than sectors (and will get easier in
> the future when bdrv_get_block_status is converted to byte-based).
> 
> While at it, fix a bug in the computation of nb_sectors using MAX
> rather than MIN and thus always passing INT_MAX (thankfully, the
> bug was harmless, as bdrv_get_block_status_above() clamps its
> answers according to image size).
> 

Well, unless ssize was >= 2^40, and then it wouldn't have chosen
INT_MAX, right!?

> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
