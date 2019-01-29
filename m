Received: from eggs.gnu.org ([209.51.188.92]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goQ5b-0005D0-QV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goQ5b-0003hN-6I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:53:55 -0500
Date: Tue, 29 Jan 2019 10:53:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190129095349.GB4467@dhcp-200-176.str.redhat.com>
References: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548705688-1027522-3-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548705688-1027522-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 2/2] qemu-img info: bitmaps extension
 new test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Am 28.01.2019 um 21:01 hat Andrey Shinkevich geschrieben:
> A new test file 239 added to the qemu-iotests set. It checks
> the output format of 'qemu-img info' for bitmaps extension of
> qcow2 specific information.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Can you add human output to the test, too?

Patch 1 changes a few reference outputs that change, including human
output, but they are all without bitmaps. I think we want at least one
test that tests human output with a non-empty list.

Kevin
