Received: from eggs.gnu.org ([2001:4830:134:3::10]:39759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cH6Mz-0005Q8-0w
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cH6Mt-0005fk-AU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:01:05 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-21-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7639ae3c-46ab-65f4-030f-0eb6f27ec33d@redhat.com>
Date: Wed, 14 Dec 2016 11:00:49 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-21-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/21] qcow2-refcount: rename
 inc_refcounts() and make it public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

On 2016-11-22 at 18:26, Vladimir Sementsov-Ogievskiy wrote:
> This is needed for the following patch, which will introduce refcounts
> checking for qcow2 bitmaps.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 53 ++++++++++++++++++++++++++------------------------
>  block/qcow2.h          |  4 ++++
>  2 files changed, 32 insertions(+), 25 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>
