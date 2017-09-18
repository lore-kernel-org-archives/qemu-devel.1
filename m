Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtpp3-00049Q-Sp
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 02:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtpp3-0003vp-5f
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 02:46:25 -0400
Date: Mon, 18 Sep 2017 14:46:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918064613.GG15551@lemon.lan>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-18-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-18-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/18] qemu-io: Add background write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, 09/13 20:19, Max Reitz wrote:
> Add a new parameter -B to qemu-io's write command.  When used, qemu-io
> will not wait for the result of the operation and instead execute it in
> the background.

Cannot aio_write be used for this purpose?

Fam
