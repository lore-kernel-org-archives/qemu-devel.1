Received: from eggs.gnu.org ([2001:4830:134:3::10]:33210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dddvJ-0000p3-Ak
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dddv7-0002dK-2w
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:49:57 -0400
Date: Fri, 4 Aug 2017 10:35:14 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170804143514.GD1525@localhost.localdomain>
References: <871sorijkp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sorijkp.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Is the use of bdrv_getlength() in vhdx*.c kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri, Aug 04, 2017 at 02:49:42PM +0200, Markus Armbruster wrote:
> bdrv_getlength() can fail.  There are several calls in vhdx*.c that
> don't seem to check.  Bug or not?


Most definitely a bug.  Shall I queue up some patches, or do you already
have some?
