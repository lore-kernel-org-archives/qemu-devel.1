Received: from eggs.gnu.org ([2001:4830:134:3::10]:43668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEP76-00017H-Eu
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEP75-0001BQ-Mr
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:30:04 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-10-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ec302e00-8efc-2cee-e8f2-4ac53e025ea4@redhat.com>
Date: Mon, 13 Nov 2017 19:29:46 -0500
MIME-Version: 1.0
In-Reply-To: <20171030163309.75770-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 09/14] migration: add is_active_iterate
 handler
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



On 10/30/2017 12:33 PM, Vladimir Sementsov-Ogievskiy wrote:
> Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
> to disable them and stop transporting empty sections there is a new
> savevm handler.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>


Reviewed-by: John Snow <jsnow@redhat.com>
