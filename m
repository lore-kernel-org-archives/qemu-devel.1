Received: from eggs.gnu.org ([2001:4830:134:3::10]:59481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMV66-0004gu-68
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMV5x-0002V9-3n
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:35:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gMV5w-0002QY-Tg
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:34:53 -0500
Date: Tue, 13 Nov 2018 10:34:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181113103446.454fad01.cohuck@redhat.com>
In-Reply-To: <20181113071336.6242-20-yuval.shaia@oracle.com>
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-20-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 19/23] vl: Introduce shutdown_notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

On Tue, 13 Nov 2018 09:13:08 +0200
Yuval Shaia <yuval.shaia@oracle.com> wrote:

> Notifier will be used for signaling shutdown event to inform system is
> shutdown. This will allow devices and other component to run some
> cleanup code needed before VM is shutdown.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  include/sysemu/sysemu.h |  1 +
>  vl.c                    | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
