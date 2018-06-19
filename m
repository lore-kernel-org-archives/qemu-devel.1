Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVF7p-0008Gs-17
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVF7n-0003ea-At
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:48:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVF7n-0003eL-68
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:48:39 -0400
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-3-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <216e8a49-f5d9-102a-bb8c-a98d76b11553@redhat.com>
Date: Tue, 19 Jun 2018 06:48:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180619053426.13065-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] monitor: rename *_pop_one to
 *_pop_any
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 06/19/2018 12:34 AM, Peter Xu wrote:
> The old names are confusing since both of the old functions are poping

s/poping/popping/

> an item from multiple queues rather than a single queue.  In that
> sense, *_pop_any() suites better than *_pop_one().
> 
> Since at it, touch up the function monitor_qmp_response_pop_any() a bit
> to let the callers pass in a QMPResponse struct instead of returning a
> struct.  Change the return value to boolean to mark whether we have
> poped a valid response instead.

s/poped/popped/

> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
