Received: from eggs.gnu.org ([209.51.188.92]:36087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjl1p-0001bc-S4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjl1l-0002bV-KF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:14:43 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190108170655.29766-6-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
	<20190108170655.29766-6-vsementsov@virtuozzo.com>
Date: Wed, 16 Jan 2019 14:14:36 +0100
Message-ID: <w51won4wxqb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/9] qcow2-threads: split out generic
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, den@openvz.org, pbonzini@redhat.com

On Tue 08 Jan 2019 06:06:51 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Move generic part out of qcow2_co_do_compress, to reuse it for
> encryption and rename things that would be shared with encryption path.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
