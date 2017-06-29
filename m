Received: from eggs.gnu.org ([2001:4830:134:3::10]:46751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQWo0-0007Dc-Tj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQWnz-00072y-TC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQWnz-00072f-Ml
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:36:11 -0400
Date: Thu, 29 Jun 2017 11:36:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170629103604.GB2399@work-vm>
References: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH V3 0/3] COLO-compare: Make COLO-compare
 support remote COLO-frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

* Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
> This series focus on COLO-proxy remote colo-frame support.
> Xen COLO-frame is the first user. We add a new chardev socket
> in colo-compare as the way of communicate with remote COLO-frame.
> And remote COLO-frame notify colo-proxy part depend on this serise:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03904.html

Can you explain a bit more about how the 'remote colo-frame' works?
Is this the comparison that's separate or what?

Dave

> I will send another part of this series after depend patchset have
> been merged.
> 
> V3:
>  - Fix codestyle.
> 
> V2:
>  - Rename this series.
>  - Change communication way to remote colo-frame.
>  - Some bugfix.
>  - Split the main function, anther part wait depend patchset.
> 
> 
> Zhang Chen (3):
>   COLO-compare: Add new parameter for communicate with remote colo-frame
>   COLO-compare: Add remote checkpoint notify chardev socket handler
>     frame
>   COLO-compare: Add remote initialization and checkpoint notification
> 
>  net/colo-compare.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  qemu-options.hx    | 41 ++++++++++++++++++++----
>  2 files changed, 124 insertions(+), 8 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
