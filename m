Received: from eggs.gnu.org ([209.51.188.92]:49807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxerz-0007pZ-2E
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxerw-0005BU-H9
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:30:02 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1213529-58d2-0a12-febb-a8a2f7cce3ce@redhat.com>
Date: Sat, 23 Feb 2019 15:29:33 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/10] nbd: change error checking order
 for bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> Check that the bitmap is not in use prior to it checking if it is
> not enabled/recording guest writes. The bitmap being busy was likely
> at the behest of the user, so this error has a greater chance of being
> understood by the user.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  nbd/server.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
