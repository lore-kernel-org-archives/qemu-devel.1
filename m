Received: from eggs.gnu.org ([2001:4830:134:3::10]:46934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpBrx-0005qz-3V
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpBrs-0000Z7-0x
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:18:13 -0400
Date: Tue, 5 Sep 2017 13:17:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905111744.GH4633@localhost.localdomain>
References: <cover.1504111803.git.jcody@redhat.com>
	<9b840c1229f3e25cf8ccf0d27bfabf37c751d5e1.1504111803.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b840c1229f3e25cf8ccf0d27bfabf37c751d5e1.1504111803.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qemu-iotests: remove file cleanup
 from bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, eblake@redhat.com

Am 30.08.2017 um 18:52 hat Jeff Cody geschrieben:
> All files for a given test are now self-contained in a subdirectory,
> and therefore the "./check" script can do all file-related cleanup
> without any help.
> 
> This removes file cleanups from the bash tests.  The only cleanup left
> is whatever is needed to kill any spawned processes; e.g. _cleanup_qemu.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>

What about non-file protocols? _cleanup_test_img() does more than just a
few 'rm' commands. For NBD and vxhs it also kills the server process and
for sheepdog and rbd it uses their specific tools to delete the image
from the cluster because it's not simply a local file.

Kevin
