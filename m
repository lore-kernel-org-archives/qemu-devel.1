Received: from eggs.gnu.org ([209.51.188.92]:58007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hBIl6-00080F-T4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hBIl4-0007wC-Tf
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:43:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1554120365-39119-3-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554120365-39119-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Tue, 02 Apr 2019 14:43:08 +0200
Message-ID: <w51tvfgo9wj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/stream: refactor stream_run:
 drop goto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Mon 01 Apr 2019 02:06:04 PM CEST, Andrey Shinkevich wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

You can also say in the log message that the goto is not necessary since
the common exit code was removed in commit eb23654dbe43b549ea2a9ebff9d8e

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
