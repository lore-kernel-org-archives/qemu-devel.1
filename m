Received: from eggs.gnu.org ([2001:4830:134:3::10]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eCuON-0001rf-Ue
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eCuON-0004HK-6L
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:29:43 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <32123081-9a79-fcfc-d754-7c5a48e6f1c5@redhat.com>
Date: Thu, 9 Nov 2017 16:29:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171109141631.25688-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 11/09/2017 09:16 AM, Vladimir Sementsov-Ogievskiy wrote:
> What was the reason to abandon non-root nodes?

Eric had it correct: we were never convinced it work would properly, so
we went with a smaller set.
