Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihuc-0005oZ-O6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihuc-0000FV-0k
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:33:54 -0500
Date: Tue, 28 Feb 2017 14:33:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228133346.GC4090@noname.redhat.com>
References: <1488200143-2140-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488200143-2140-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] option: Tweak invalid size error message
 and unbreak iotest 049
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, thuth@redhat.com

Am 27.02.2017 um 13:55 hat Markus Armbruster geschrieben:
> Commit 75cdcd1 neglected to update tests/qemu-iotests/049.out, and
> made the error message for negative size worse.  Fix that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks, applied to the block branch.

Kevin
