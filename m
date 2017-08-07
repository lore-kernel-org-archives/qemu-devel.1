Received: from eggs.gnu.org ([2001:4830:134:3::10]:39321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dekd3-00065Y-5w
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dekcy-0000V2-5v
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:11:41 -0400
Date: Mon, 7 Aug 2017 18:11:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807161119.GJ6578@localhost.localdomain>
References: <20170804151013.13057-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804151013.13057-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] respect bdrv_getlength() error code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 04.08.2017 um 17:10 hat Denis V. Lunev geschrieben:
> These cases were reported by Markus Armbruster <armbru@redhat.com>
> Patches add error checking of the bdrv_getlength() call or remove
> the call of that function.

Thanks, applied to the block branch.

Kevin
