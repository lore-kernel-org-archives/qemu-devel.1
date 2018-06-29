Received: from eggs.gnu.org ([2001:4830:134:3::10]:44331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYxEw-0002pt-PC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYxEv-0002Yf-Qj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:31:22 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7323f68b-dbb1-d50e-49a1-6e488b9cfbc5@redhat.com>
Date: Fri, 29 Jun 2018 13:31:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180629151524.138542-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] blockdev-backup: enable non-root
 nodes for backup source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is needed to implement image-fleecing scheme, when we create
> a temporary node, mark our active node to be backing for the temp,
> and start backup(sync=none) from active node to the temp node.
> Temp node then represents a kind of snapshot and may be used
> for external backup through NBD.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

A hair more comprehensive than my recent patch which did the same thing, so:

Reviewed-by: John Snow <jsnow@redhat.com>
