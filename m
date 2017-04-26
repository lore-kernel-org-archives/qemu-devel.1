Received: from eggs.gnu.org ([2001:4830:134:3::10]:36492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3MQv-0005CC-UW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3MQv-00053p-9x
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:52:38 -0400
Date: Wed, 26 Apr 2017 14:52:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426125227.GF4538@noname.str.redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-19-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426033413.17192-19-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 18/21] block: Reuse bs as backing hd
 for drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

The commit message is a bit terse. :-)

So I think this means that instead of opening the backing file of the
backup (which is probably the active file of the VM) a second time, we
instead take a reference on the existing node. Very good idea.

In fact, my question is: How did this ever work? Did we just neglect to
test this? The backup backing file will use stale qcow2 metadata when we
continue to write to the source.

Unless I'm missing something, I'd propose this for qemu-stable.

Also, mirror with MIRROR_OPEN_BACKING_CHAIN probably has a similar
problem with opening the images in the backing chain a second time.

Kevin
