Received: from eggs.gnu.org ([2001:4830:134:3::10]:33694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSP0B-0004ze-2r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSP0A-0004og-8J
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:40:31 -0400
Date: Tue, 4 Jul 2017 16:40:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704144021.GG4253@noname.str.redhat.com>
References: <1494585229-9119-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494585229-9119-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: Print a warning for legacy
 drive options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 12.05.2017 um 12:33 hat Thomas Huth geschrieben:
> We likely do not want to carry these legacy -drive options along forever.
> Let's emit a deprecation warning for the -drive options that have a
> replacement with the -device option, so that the (hopefully few) remaining
> users are aware of this and can adapt their scripts / behaviour accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Check for !qtest_enabled() since tests/hd-geo-test still uses these
>  - Added "addr" to the list, too
>  - Also mark the options as deprecated in the documentation

Thanks, added the missing deprecation note for 'serial' in the
documentation and applied to the block branch.

Kevin
