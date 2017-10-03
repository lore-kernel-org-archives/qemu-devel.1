Received: from eggs.gnu.org ([2001:4830:134:3::10]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dzINC-0007zN-BP
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dzIN7-0004zJ-AD
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dzIN7-0004t2-2N
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:16:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 847E64A6F4
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 08:16:05 +0000 (UTC)
References: <20171002191521.15748-1-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <34f828b3-1bd6-0dae-83c3-29b40a794100@redhat.com>
Date: Tue, 3 Oct 2017 10:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <20171002191521.15748-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Small vhost-user fixes and tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com

Hi David,

On 10/02/2017 09:15 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>    This set has a small set of fixes for vhost-user and also
>    enables the SET_SLAVE_REQ_FD feature in libvhost-user.
>    (Where it just stashes the fd).
> 
> Dave
> 
> Dr. David Alan Gilbert (4):
>    libvhost-user: vu_queue_started
>    vhost-user-bridge: Only process received packets on started queues
>    libvhost-user: Update and fix feature and request lists
>    libvhost-user: Support VHOST_USER_SET_SLAVE_REQ_FD
> 
>   contrib/libvhost-user/libvhost-user.c | 43 ++++++++++++++++++++++++++++++-----
>   contrib/libvhost-user/libvhost-user.h | 19 +++++++++++++++-
>   tests/vhost-user-bridge.c             |  1 +
>   3 files changed, 56 insertions(+), 7 deletions(-)
> 

For the series:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
