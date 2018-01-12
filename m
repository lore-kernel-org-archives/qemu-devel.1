Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZvTl-0005s2-KE
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZvTh-0000SU-JT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:18:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eZvTh-0000Rz-D9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:18:21 -0500
Date: Fri, 12 Jan 2018 10:18:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180112101814.44254492@redhat.com>
In-Reply-To: <20180111221307-mutt-send-email-mst@kernel.org>
References: <1515515942-33692-1-git-send-email-jianjay.zhou@huawei.com>
	<20180111140057.61f36a8f@redhat.com>
	<20180111221307-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/4] vhost: two fixes and used_memslots
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, liuzhe13@huawei.com

On Thu, 11 Jan 2018 22:13:25 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 11, 2018 at 02:05:20PM +0100, Igor Mammedov wrote:
> > On Wed, 10 Jan 2018 00:39:02 +0800
> > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > 
> > Jay,
> > considering how non trivial touched code is, would you mind
> > first adding 'make check' testcases for success/failure paths
> > that you are touching?
> > It would help with merging and ensure that future changes to
> > vhost won't break memslots handling.  
> 
> Which tests would you like this to be added to?
At least a test for, so it won't regress unnoticed in future
 1st: [PATCH v5 3/4] vhost: fix memslot limit check
 2nd: limit check failure triggered when DIMM module hotplugged

PS:
It's fine if tests will be another series on top of this one.

> 
> > > v4 -> v5:
> > >   Making the followed up device_add to fall back to userspace
> > >   virtio when netdev_add fails if vhost force flag does not set.
> > > 
> > > Jay Zhou (4):
> > >   vhost: remove assertion to prevent crash
> > >   tap: do not close fd if only vhost failed to initialize
> > >   vhost: fix memslot limit check
> > >   vhost: used_memslots refactoring
> > > 
> > >  hw/virtio/vhost-backend.c         | 15 +++++++-
> > >  hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++------------
> > >  hw/virtio/vhost.c                 | 30 +++++++++-------
> > >  include/hw/virtio/vhost-backend.h |  6 ++--
> > >  net/tap.c                         | 25 +++++++++----
> > >  5 files changed, 104 insertions(+), 46 deletions(-)
> > > 
> > > --
> > > 1.8.3.1
> > > 
> > >   
