Received: from eggs.gnu.org ([2001:4830:134:3::10]:34397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEOnt-0004NA-AO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEOns-0005W4-J8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:10:13 -0500
References: <20171030163309.75770-6-vsementsov@virtuozzo.com>
	<20171030181939.130103-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <da6cc3d7-49a6-922c-fb02-74a07707d099@redhat.com>
Date: Mon, 13 Nov 2017 19:09:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171030181939.130103-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8.1 05/14] migration: introduce
 postcopy-only pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 10/30/2017 02:19 PM, Vladimir Sementsov-Ogievskiy wrote:
> There would be savevm states (dirty-bitmap) which can migrate only in
> postcopy stage. The corresponding pending is introduced here.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
> 
> 8.1: add new version for cmma_save_pending too.

I love "8.1" :)

With this fixup applied to fix the s390x build issue,

Reviewed-by: John Snow <jsnow@redhat.com>
