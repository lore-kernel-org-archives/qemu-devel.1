Received: from eggs.gnu.org ([209.51.188.92]:48114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDWRU-0005WC-OV
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDWRT-0006lR-IP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:44:16 -0400
Date: Mon, 8 Apr 2019 17:44:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190408154409.GD11997@linux.fritz.box>
References: <20190408153003.20596-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408153003.20596-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: Fix drive_add ... format=help crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, qemu-stable@nongnu.org

Am 08.04.2019 um 17:30 hat Markus Armbruster geschrieben:
> drive_new() returns null without setting an error when it provided
> help.  add_init_drive() assumes null means failure, and crashes trying
> to report a null error.
> 
> Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks, applied to the block branch.

Kevin
