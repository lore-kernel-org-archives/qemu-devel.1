Received: from eggs.gnu.org ([2001:4830:134:3::10]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqH8g-00059j-Dy
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqH8b-00043d-P5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:07:58 -0400
Date: Fri, 8 Sep 2017 13:07:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908110737.GE3283@localhost.localdomain>
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905151614.31303-2-cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests: use -ccw on s390x for 040, 139,
 and 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com

Am 05.09.2017 um 17:16 hat Cornelia Huck geschrieben:
> The default cpu model on s390x does not provide zPCI, which is
> not yet wired up on tcg. Moreover, virtio-ccw is the standard
> on s390x, so use the -ccw instead of the -pci versions of virtio
> devices on s390x.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
