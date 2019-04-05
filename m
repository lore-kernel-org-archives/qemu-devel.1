Received: from eggs.gnu.org ([209.51.188.92]:43402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCOJv-00048U-Pj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCOJu-0006wS-UB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:51:47 -0400
Date: Fri, 5 Apr 2019 14:51:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190405125140.GB4597@linux.fritz.box>
References: <20190405114513.3141-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405114513.3141-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] hmp: Fix drive_add ... format=help
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

Am 05.04.2019 um 13:45 hat Markus Armbruster geschrieben:
> drive_new() returns null without setting an error when it provided
> help.  add_init_drive() assumes null means failure, and crashes trying
> to report a null error.
> 
> Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

We should probably have a test case for this.

Kevin
