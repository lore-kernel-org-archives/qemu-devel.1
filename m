Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g70T2-00046q-AQ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g70Sy-0003FQ-WB
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g70Sy-0003Ex-PW
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:50:36 -0400
Date: Mon, 1 Oct 2018 12:50:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181001155033.GV5738@habkost.net>
References: <1538403190-27146-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538403190-27146-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: Remove entries
 for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Mon, Oct 01, 2018 at 04:13:10PM +0200, Thomas Huth wrote:
> The problem with the various serial devices has been fixed a while
> ago in commit 47c4f85a0c27888e12af827471cfef87deb49821 ("hw/char/serial:
> Allow disconnected chardevs") already, so we can remove these entries
> from the "ignore" list in the device-crash-test script now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, queued on python-next.

-- 
Eduardo
