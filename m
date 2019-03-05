Received: from eggs.gnu.org ([209.51.188.92]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h17KP-0004ZC-0J
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h17KO-0000ZQ-A2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:29:40 -0500
Date: Tue, 5 Mar 2019 11:29:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190305102934.GD5280@dhcp-200-226.str.redhat.com>
References: <20190304162103.18912-1-ndevos@redhat.com>
	<20190304162103.18912-3-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304162103.18912-3-ndevos@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] gluster: the glfs_io_cbk
 callback function pointer adds pre/post stat args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

Am 04.03.2019 um 17:21 hat Niels de Vos geschrieben:
> The glfs_*_async() functions do a callback once finished. This callback
> has changed its arguments, pre- and post-stat structures have been
> added. This makes it possible to improve cashing, which is useful for

Did you mean "caching"?

> Samba and NFS-Ganesha, but not so much for QEMU. Gluster 6 is the first
> release that includes these new arguments.
> 
> With an additional detection in ./configure, the new arguments can
> conditionally get included in the glfs_io_cbk handler.
> 
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

Kevin
