Received: from eggs.gnu.org ([2001:4830:134:3::10]:52078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cdNF9-0007YX-6A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cdNF6-0005JN-3K
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:29:03 -0500
Received: from mail.kernel.org ([198.145.29.136]:56770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cdNF5-0005Is-SS
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:29:00 -0500
Date: Mon, 13 Feb 2017 12:28:54 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
Message-ID: <alpine.DEB.2.10.1702131228110.6418@sstabellini-ThinkPad-X260>
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Wed, 8 Feb 2017, Eric Blake wrote:
> On 02/07/2017 11:24 PM, Zhang Chen wrote:
> > We can call this qmp command to do checkpoint outside of qemu.
> > Xen colo will need this function.
> > 
> > Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> > Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> > ---
> >  migration/colo.c | 17 ++++++++++++++++
> >  qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> > 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Given that the series is all acked, are you going to take care of the
pull request?
